-- Admin panel
EXEC dbo.admin_viewstats @AdminId = 'ADM1', @Password = '123456'

-- Patients for each doctor
SELECT Doctor.[Name] AS [Doctor Name], Patient.[Name] As [Patient Name], Appointment.date_of_appointment As [Appointment Date]
       FROM Doctor JOIN Appointment ON Appointment.DoctorId = Doctor.DoctorId JOIN Patient ON Appointment.PatientId = Patient.PatientId
       ORDER BY [Doctor Name]

-- View patient records
EXEC view_my_appointments_patient @PatientUserId = 'michael54', @Password = 'r7aoq';

--------------------------------------DATA EXTRACTION QUERIES--------------------------------------------

--1 Patients for each clinic
SELECT Clinic.[Name], Patient.[Name] AS [Patient Name], Appointment.date_of_appointment
       FROM Clinic JOIN Appointment ON Appointment.ClinicId = Clinic.ClinicId JOIN Patient ON Appointment.PatientId = Patient.PatientId;

--2 All patients with appointments related to a certain specialty on all clinics (weekly, monthly,daily).
SELECT *
FROM Appointment
WHERE Appointment.SpecialityID=(SELECT SpecialityID FROM Speciality WHERE speciality_name='ENT');

--3 All patient appointments with a certain set of doctors (weekly, monthly, daily)
SELECT * 
FROM Appointment
WHERE Appointment.DoctorID='DOC1' OR Appointment.DoctorID='DOC3' OR Appointment.DoctorID='DOC4' 

--4 All appointments or assignments on clinic(s) within a certain time.
SELECT * 
FROM Appointment app INNER JOIN Assignment ass ON (app.ClinicID=ass.ClinicID 
													and app.DoctorID=ass.DoctorID 
													and app.SpecialityID=ass.SpecialityID 
													and app.date_of_appointment=ass.date_of_assignment)
WHERE ass.start_time>'02:00:00' AND ass.end_time<'09:00:00';

--5 View doctors with same Speciality and overlapping assignments
SELECT DISTINCT D1.[Name] As [Doctor 1], A1.start_time As [Doctor 1 Starting hours],
                A1.end_time As [Doctor 1 Ending Hours],
                D2.[Name] As [Doctor 2], A2.start_time As [Doctor 2 Starting hours], A2.end_time As [Doctor 2 Ending Hours],
                Speciality.speciality_name As [Speciality],
                Clinic.[Name] As [Clinic Name]
       FROM (Doctor D1 JOIN Assignment A1 ON A1.DoctorId = D1.DoctorId), (Doctor D2 JOIN Assignment A2 ON A2.DoctorId = D2.DoctorId), Speciality, Clinic
       WHERE A1.SpecialityId = A2.SpecialityId
             AND A1.ClinicId = Clinic.ClinicId
             AND A1.ClinicId = A2.ClinicId
             AND D2.DoctorId != D1.DoctorId
             AND Speciality.SpecialityId = A1.SpecialityId
             AND (A1.date_of_assignment = A2.date_of_assignment)
             AND (
                 (A1.start_time >= A2.start_time AND A1.start_time <= A2.end_time)
                 OR
                 (A1.end_time >= A2.start_time AND A2.end_time <= A2.end_time)
                 OR (A2.start_time >= A1.start_time AND A2.start_time <= A1.end_time)
                 OR (A2.end_time >= A1.start_time AND A2.end_time <= A1.end_time)
                 )
            AND D1.DoctorId < D2.DoctorId -- workaround to avoid generating two tuples in different orders (D1, D2) and (D2, D1)


--6 Doctor with least number of appointments for clinic
SELECT Clinic.[Name] As [Clinic Name], MIN(Doctor.[Name]) As [Doctor Name], COUNT(*)
       FROM Doctor JOIN Appointment ON Appointment.DoctorId = Doctor.DoctorId
                   JOIN Clinic ON Clinic.ClinicId = Appointment.ClinicId
        GROUP BY Clinic.[Name]
        HAVING COUNT(*) <= (SELECT TOP 1 COUNT(*)
                            FROM Appointment A JOIN Clinic C ON A.ClinicId = C.ClinicId
                            WHERE Clinic.[Name] IN (SELECT Clinic.[Name] FROM Clinic CC WHERE CC.ClinicId = A.ClinicId)
                            ORDER BY COUNT(*) ASC)

--7 View doctors with most amount of appointments for a certain specialty
SELECT Speciality.Speciality_Name, Doctor.[Name], COUNT(*) AS [Appointments]
       FROM Doctor JOIN Appointment ON Appointment.DoctorId = Doctor.DoctorId
                   JOIN Speciality ON Speciality.SpecialityId = Appointment.SpecialityId

        GROUP BY Speciality.Speciality_Name, Doctor.[Name]
        ORDER BY COUNT(*) DESC

--8 Patient whose recurring appointment is with same doctor
SELECT Patient.[Name] As [Patient Name], Doctor.[Name] as [Doctor Name], COUNT(*) As [Recurring Appointments]
       FROM Patient, Doctor, Appointment A1, Appointment A2
       WHERE A1.PatientId = Patient.PatientId AND A2.PatientId = Patient.PatientId
             AND Doctor.DoctorId = A1.DoctorId AND Doctor.DoctorId = A2.DoctorId
             AND A2.date_of_appointment <> A1.date_of_appointment
             AND A1.starting_time = A2.starting_time AND A1.ending_time = A2.ending_time
        GROUP BY Patient.[Name], Doctor.[Name]

--9 Patient whose recurring appointment is with different doctor
SELECT Patient.[Name] As [Patient Name], D1.[Name] as [Doctor Name], D2.[Name] As [Doctor 2 Name],  COUNT(*) As [Recurring Appointments]
       FROM Patient, Doctor D1, Appointment A1, Appointment A2, Doctor D2
       WHERE A1.PatientId = Patient.PatientId AND A2.PatientId = Patient.PatientId
             AND D1.DoctorId = A1.DoctorId AND D2.DoctorId = A2.DoctorId
             AND D2.DoctorId <> D1.DoctorId
             AND D1.DoctorId < D2.DoctorId
             AND A1.SpecialityId = A2.SpecialityId
             AND A2.date_of_appointment <> A1.date_of_appointment
             AND A1.starting_time = A2.starting_time AND A1.ending_time = A2.ending_time
        GROUP BY Patient.[Name], D1.[Name], D2.[Name]
-- Custom queries:


--1 Show all the patients who went to a Clinic that was not in their State

Select DISTINCT Patient.[Name] As [Patient Name],
                PA.[state] As [Home State],
                CA.[state] As [Clinic State],
                Clinic.[Name] As [Clinic Name]
        FROM Patient JOIN Address PA ON Patient.PatientId = PA.ID, Clinic JOIN Address CA ON Clinic.ClinicId = CA.ID, Appointment
        WHERE Appointment.PatientId = Patient.PatientId AND Appointment.ClinicId = Clinic.ClinicId
        AND PA.[state] != CA.[state]


--2 Show number of patients from each state

SELECT Address.[state], COUNT(*) AS [Patients]
       FROM Address JOIN Patient ON Patient.PatientID = Address.ID
       GROUP BY Address.[state]
       ORDER BY COUNT(*) desc

--3 Show doctors who had to travel inter-city for their assignments in one week

SELECT DISTINCT Doctor.[Name], C1.[Name] As [Clinic 1], A1.[city] AS [Clinic 1 City], C2.[Name] As [Clinic 2], A2.[city] AS [Clinic 2 City]
    FROM Clinic C1 JOIN Address A1 ON A1.ID = C1.ClinicId, Clinic C2 JOIN Address A2 ON A2.ID = C2.ClinicId,
    Assignment As1,
    Assignment As2,
    Doctor
    WHERE As1.ClinicId = C1.ClinicId AND As1.DoctorId = Doctor.DoctorId
          AND As2.ClinicId = C2.ClinicId AND As2.DoctorId = Doctor.DoctorId
    AND DATEDIFF(day, As1.date_of_assignment, As2.date_of_assignment) <= 7

--4 Rank Clinics according to Specialities they offer

SELECT Clinic.[Name], COUNT(*) AS [Specialities Offered]
       FROM Clinic JOIN ClinicSpeciality ON Clinic.ClinicID = ClinicSpeciality.ClinicID
       GROUP BY Clinic.[Name]
       ORDER BY COUNT(*) DESC

--5 Find the specialities that are most in demand based on appointments + Waiting List

SELECT temp.Speciality_Name, COUNT(*) AS [Patients on Waiting List Or Appointment]
       FROM (
        (SELECT Speciality.Speciality_Name, WaitingList.PatientId FROM
        Speciality JOIN WaitingList ON Speciality.SpecialityId = WaitingList.SpecialityId)
        UNION
        (SELECT DISTINCT Speciality.Speciality_Name, Appointment.PatientId
        FROM Appointment Join Speciality ON Speciality.SpecialityId = Appointment.SpecialityId)
      ) temp
	   GROUP BY temp.Speciality_Name
       ORDER BY COUNT(*) DESC

--6 Show the clinics with most amount of front desk staff
   SELECT Clinic.[Name], COUNT(*) AS [Front Desk Staff]
   FROM Clinic JOIN Front_Desk ON Front_Desk.ClinicId = Clinic.ClinicId
   GROUP BY Clinic.[Name]
   ORDER BY COUNT(*) DESC

--7 Which Clinic has most difference between number of appointments and patients on waiting list
SELECT C1.[Name], COUNT(Appointment.ClinicId) - COUNT(WaitingList.ClinicId) AS [Difference in Appointments - Waiting List]
       FROM (Clinic C1 JOIN Appointment ON Appointment.ClinicId = C1.ClinicId), (Clinic C2 JOIN WaitingList ON WaitingList.ClinicId = C2.ClinicId)
       WHERE C1.ClinicId = C2.ClinicId
       GROUP BY C1.[Name]

--8 Which patient has most variety of doctors for appointments
SELECT Patient.[Name], COUNT(DISTINCT Appointment.DoctorId) AS [Doctors this patient sees]
       FROM Appointment JOIN Patient ON Appointment.PatientId = Patient.PatientId
       GROUP BY Patient.[Name]
       ORDER BY COUNT(DISTINCT Appointment.DoctorId) DESC

--9 Show most utillized speciality of each doctor

SELECT Doctor.[Name], Speciality.[Speciality_Name] As [Speciality Name], COUNT(*) As [Assignments in one year]
       FROM Doctor JOIN DoctorSpeciality on Doctor.DoctorId = DoctorSpeciality.DoctorId
                    JOIN Speciality ON DoctorSpeciality.SpecialityId = Speciality.SpecialityId
                    JOIN Assignment ON Doctor.DoctorId = Assignment.DoctorId AND Speciality.SpecialityId = Assignment.SpecialityId
        GROUP BY Doctor.[Name], Speciality.[Speciality_Name]
        ORDER BY COUNT(*) DESC, Doctor.[Name] DESC

--10 Show common doctors between some patient1 and some patient2
SELECT Doctor.DoctorID,Doctor.[Name]
	FROM Doctor
	WHERE (Doctor.DoctorID IN (SELECT Appointment.DoctorID
								FROM Appointment
								WHERE Appointment.PatientID='PAT1'))
					AND
					(Doctor.DoctorID IN (SELECT Appointment.DoctorID
								FROM Appointment
								WHERE Appointment.PatientID='PAT3'));

--11 Show the state with the maximum number of clinics
SELECT Top 1 [state], count([state]) as Clinic_count
FROM [Address]
WHERE [Address].ID like 'CLC%'
GROUP BY [state]
ORDER BY Count([state]) DESC;

--12 Show the state with the most Doctors
SELECT Top 1 [state], count([state]) as Doc_count
FROM [Address]
WHERE [Address].ID like 'DOC%'
GROUP BY [state]
ORDER BY Count([state]) DESC;

