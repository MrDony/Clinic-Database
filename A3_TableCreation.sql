--Administrator( PK( AdminID ), UserID, Password, Name )
--Front_Desk( PK( Front_DeskID ), UserID, Password, Name)
--Doctor( PK( DoctorID ), UserID, Password, SSN, Name, PhoneNo, Email )
--Clinic( PK( ClinicID ), Name, PhoneNo, Email, opening_hours, closing_hours )
--Patient( PK( PatientID ), UserID, Password, SSN, Name, PhoneNo, Email )

--Address( PK( FK(ID), street_address ), city, state )
--Sepciality( PK( FK(ID) , SpecialityID ), speciality_name )

--Assignment ( PK( FK(DoctorID), FK(ClinicID) ), Date, starting_hours, ending_hours )
--Appointment ( PK( FK(DoctorID, ClinicID, FK(PatientID) ), Date, starting_time, ending_time, description )
DROP PROCEDURE IF EXISTS Admin_Viewstats
DROP PROCEDURE IF EXISTS frontdesk_waiting_list
DROP PROCEDURE IF EXISTS view_my_appointments_patient
DROP PROCEDURE IF EXISTS view_my_appointments_doctor
DROP PROCEDURE IF EXISTS frontdesk_appointment_speciality
DROP PROCEDURE IF EXISTS frontdesk_appointment_doctor
DROP PROCEDURE IF EXISTS frontdesk_assign
DROP PROCEDURE IF EXISTS admin_login
DROP PROCEDURE IF EXISTS frontdesk_login
DROP TABLE IF EXISTS Appointment

DROP FUNCTION IF EXISTS Valid_Appointment2
DROP FUNCTION IF EXISTS Valid_Appointment1
DROP TABLE IF EXISTS WaitingList
DROP TABLE IF EXISTS Assignment
DROP TABLE IF EXISTS [Address]
DROP TABLE IF EXISTS ClinicSpeciality
DROP TABLE IF EXISTS DoctorSpeciality
DROP TABLE IF EXISTS Speciality
DROP FUNCTION IF EXISTS Valid_Assignment

DROP FUNCTION IF EXISTS Make_ID
DROP TABLE IF EXISTS Administrator
DROP TABLE IF EXISTS Doctor
DROP TABLE IF EXISTS Front_Desk
DROP TABLE IF EXISTS Clinic
DROP TABLE IF EXISTS Patient
DROP FUNCTION IF EXISTS FK_Check_IDs_In_Tables
GO

CREATE FUNCTION Make_ID 
( 
	@prefix varchar(3),
	@postfix int
)
RETURNS varchar(255) 
BEGIN
	return (SELECT @prefix + CAST(@postfix AS nvarchar))
END;
GO

CREATE TABLE Administrator
(
	AdminID nchar(100) NOT NULL,
	UserID nchar(100) NOT NULL UNIQUE,
	Password nchar(25) NOT NULL,
	[Name] nchar(255) NOT NULL,
	PRIMARY KEY(AdminID)
);

CREATE TABLE Doctor
(
	DoctorID nchar(100) NOT NULL PRIMARY KEY,
	UserID nchar(100) NOT NULL UNIQUE,
	Password nchar(25) NOT NULL,
	SSN nchar(20) NOT NULL UNIQUE,
	[Name] nchar(255) NOT NULL,
	PhoneNo nchar(20) NOT NULL,
	Email nchar(255) NOT NULL
);
GO

CREATE TABLE Clinic
(
	ClinicID nchar(100) NOT NULL PRIMARY KEY,
	[Name] nchar(255) NOT NULL,
	PhoneNo nchar(20),
	Email nchar(255),
	Opening_Time time NOT NULL,
	Closing_Time time NOT NULL,
	Open_WeekEnds nchar(3) CHECK(Open_WeekEnds='Yes' OR Open_WeekEnds='No')--Yes/No
);
GO

CREATE TABLE Front_Desk
(
	Front_DeskID nchar(100) NOT NULL PRIMARY KEY,
	UserID nchar(100) NOT NULL UNIQUE,
	Password nchar(25) NOT NULL,
	[Name] nchar(255) NOT NULL,
	ClinicId nchar(100) FOREIGN KEY REFERENCES Clinic(ClinicId) NOT NULL
);


CREATE TABLE Patient
(
	PatientID nchar(100) NOT NULL PRIMARY KEY,
	UserID nchar(100) NOT NULL UNIQUE,
	Password nchar(25) NOT NULL,
	SSN nchar (20) NOT NULL UNIQUE,
	[Name] nchar(255) NOT NULL,
	PhoneNo nchar(20) NOT NULL,
	Email nchar(255) NOT NULL
);
GO

CREATE FUNCTION FK_Check_IDs_In_Tables (@ID nchar(100))
returns int
BEGIN
	return --returns total number of instances of an id in tables (Patient, Doctor, Clinic, Front_Desk, Administrator); *it should be 1
	(
		(SELECT COUNT(PatientID) FROM Patient WHERE PatientID=@ID) + 
		(SELECT COUNT(DoctorID) FROM Doctor WHERE DoctorID=@ID) + 
		(SELECT COUNT(ClinicID) FROM Clinic WHERE ClinicID=@ID) + 
		(SELECT COUNT(Front_DeskID) FROM Front_Desk WHERE Front_DeskID=@ID) + 
		(SELECT COUNT(AdminID) FROM Administrator WHERE AdminID=@ID)
	)
END;
GO

CREATE TABLE [Address]
(
	ID nchar(100) NOT NULL,-- REFERENCES Clinic(ClinicID) OR Doctor(DoctorID) OR Patient(PatientID) OR Front_Desk(Front_DeskID) OR Administrator(AdminID)
	street_address nchar(255) NOT NULL,
	city nchar(255) NOT NULL,
	[state] nchar(255) NOT NULL,
	[country] nchar(255) NOT NULL,
	PRIMARY KEY(street_address,ID),
	Constraint FK_ID_Address CHECK(dbo.FK_Check_IDs_In_Tables(ID)>0) --if the id is in one of the tables
);


CREATE TABLE Speciality
(

	SpecialityID nchar(100) NOT NULL,
	speciality_name nchar(255) NOT NULL,
	PRIMARY KEY(SpecialityID),
);


CREATE TABLE DoctorSpeciality
(
	DoctorID nchar(100) NOT NULL,
	SpecialityID nchar(100) FOREIGN KEY REFERENCES Speciality(SpecialityID),
	PRIMARY KEY(DoctorId, SpecialityID)
);

CREATE TABLE ClinicSpeciality (
	ClinicID nchar(100) NOT NULL,
	SpecialityID nchar(100) FOREIGN KEY REFERENCES Speciality(SpecialityID),
	PRIMARY KEY(ClinicID, SpecialityID)
);
CREATE TABLE Assignment
(
	DoctorID nchar(100) FOREIGN KEY REFERENCES Doctor(DoctorID),
	ClinicID nchar(100) FOREIGN KEY REFERENCES Clinic(ClinicID),
	SpecialityID nchar(100) FOREIGN KEY REFERENCES Speciality(SpecialityID),
	date_of_assignment Date,
	start_time time,
	end_time time,
	aux_key INTEGER IDENTITY(1, 1) NOT NULL,
	PRIMARY KEY (DoctorID , ClinicID, SpecialityID, date_of_assignment),
	FOREIGN KEY (DoctorID, SpecialityID) REFERENCES DoctorSpeciality(DoctorID, SpecialityID),
	FOREIGN KEY (ClinicID, SpecialityID) REFERENCES ClinicSpeciality(ClinicID, SpecialityID),
);


CREATE TABLE WaitingList
(
    ClinicId nchar(100) FOREIGN KEY REFERENCES Clinic(ClinicId),
    SpecialityId nchar(100) FOREIGN KEY REFERENCES Speciality(SpecialityId),
    PatientId nchar(100) FOREIGN KEY REFERENCES Patient(PatientId),

    PRIMARY KEY (ClinicId, SpecialityId, PatientId),
    FOREIGN KEY (ClinicId, SpecialityId) REFERENCES ClinicSpeciality
);

GO
--make sure
--1 no two assignments for a doctor on any clinic with overlapping times on same date
CREATE FUNCTION Valid_Assignment(@DID nchar(100), @DOA date, @STime time, @ETime time, @CID nchar(100), @Aux Integer)
returns int
BEGIN


	return (--count the number of assignments for a doctor (DID) on a date (DOA) which have their time overlapping with Stime-Etime
			SELECT Count(*)
			From(
				 SELECT * 
				 FROM Assignment 
				 WHERE(
						Assignment.aux_key <> @Aux
						AND
						(@DID=Assignment.DoctorID AND @DOA=Assignment.date_of_assignment)	--same doctor on same date on any clinic
						AND
						( (@STime>=Assignment.start_time AND @STime<=Assignment.end_time)	--starting time is in between
							OR
						  (@ETime>=Assignment.start_time AND @ETime<=Assignment.end_time)	--ending time is in between
						)
					  )
				) AS temp
		   )
END;
GO
ALTER TABLE Assignment
ADD CONSTRAINT Valid_Assignment_Entry CHECK(dbo.Valid_Assignment(DoctorID,date_of_assignment,start_time,end_time, ClinicID, aux_key)=0)
GO

--Appointment ( PK( FK(DoctorID, ClinicID, Date), FK(PatientID) ), starting_time, ending_time, description )
CREATE TABLE Appointment
(
	DoctorID nchar(100) NOT NULL,
	ClinicID nchar(100) NOT NULL,
	SpecialityID nchar(100) NOT NULL,
	date_of_appointment date NOT NULL,
	PatientID nchar(100) NOT NULL FOREIGN KEY REFERENCES Patient(PatientID),
	starting_time time NOT NULL,
	ending_time time NOT NULL,
	appointment_desc nchar(100) NOT NULL,
	aux_key INTEGER IDENTITY(1, 1) NOT NULL -- auxilliary key to handle constraints, to skip tuples that match this
	CONSTRAINT PK_Appointment PRIMARY KEY (DoctorID,ClinicID,PatientID, date_of_appointment)
);
GO
ALTER TABLE Appointment
ADD CONSTRAINT FK_Appointment_from_Assignment FOREIGN KEY (DoctorID,ClinicID, SpecialityID, date_of_appointment) REFERENCES Assignment(DoctorID,ClinicID, SpecialityID, date_of_assignment)
GO
--make sure
--1 appointment time is within assignment time and on assignment date
--2 no two appointments for a doctor on the same date have overlapping times
CREATE FUNCTION Valid_Appointment1(
		@DID nchar(100),--DoctorID
		@CID nchar(100),--ClinicID
		@DOApp date,--Date of Appointment
		@StimeApp time,--starting time of Appointment
		@EtimeApp time
		)--EndingTime of appointment
RETURNS INT
BEGIN
		
		--give the number of assignments which are
			--1.1 at the same clinic as CID
			--1.2 with the same doctor as DID
			--1.3 on the same date as the appointment DOApp
			--1.4 StimeApp and EtimeApp is within the time of the assignment 
		return --return at least 1 because there has to be an entry of an assignment which is valid for the aforestated checks
		(
			SELECT COUNT(*)
			FROM
			(
				SELECT *
				FROM Assignment
				WHERE Assignment.ClinicID=@CID AND
					  Assignment.DoctorID=@DID AND
					  Assignment.date_of_assignment=@DOApp AND
					  (
						(@StimeApp>=Assignment.start_time AND @EtimeApp<=Assignment.end_time)
					  )
			) AS temp
		)
END;
GO
CREATE FUNCTION Valid_Appointment2(
		@DID nchar(100),--DoctorID
		@CID nchar(100),--ClinicID
		@DOApp date,--Date of Appointment
		@StimeApp time,--starting time of Appointment
		@EtimeApp time,
		@Aux INTEGER)--EndingTime of appointment
RETURNS INT
BEGIN
			--2.1 on the same assignment
			--2.2 with overlapping times on same date
		return --should return 0 because if there are overlaps of the appointment with any other appointment in time then it is not valid
		(
			SELECT COUNT(*)
			FROM 
			(
				SELECT *
				FROM Appointment
				WHERE 
					Appointment.ClinicID=@CID AND
					Appointment.DoctorID=@DID AND
					Appointment.date_of_appointment=@DOApp AND
					(
						(@StimeApp>=Appointment.starting_time AND @StimeApp<=Appointment.ending_time)
						OR
						(@EtimeApp>=Appointment.starting_time AND @EtimeApp<=Appointment.ending_time)
					)
					AND (@Aux IS NULL OR (Appointment.aux_key <> @Aux))
			) AS temp
		)
END;
GO
ALTER TABLE Appointment
ADD CONSTRAINT Valid_Appointment_Check1 Check (dbo.Valid_Appointment1(DoctorID, ClinicID, date_of_appointment,starting_time,ending_time)>0)
ALTER TABLE Appointment
ADD CONSTRAINT Valid_Appointment_Check2 Check (dbo.Valid_Appointment2(DoctorID, ClinicID, date_of_appointment,starting_time,ending_time, aux_key)=0)
GO

GO
CREATE PROCEDURE admin_login @AdminId nchar(100), @Password nchar(100), @Result INTEGER OUTPUT
AS
BEGIN
	IF EXISTS(Select * from Administrator where Administrator.AdminId = @AdminId AND Administrator.Password = @Password)
		SET @Result = 1
	ELSE
		SET @Result = 0

END
GO

GO

CREATE PROCEDURE frontdesk_login @UserId nchar(100), @Password nchar(100), @Result INTEGER OUTPUT
AS
BEGIN
	IF EXISTS(Select * from Front_Desk where Front_Desk.UserID = @UserId AND Front_Desk.Password = @Password)
		SET @Result = 1
	ELSE
		SET @Result = 0
END

GO


GO
CREATE PROCEDURE frontdesk_assign(@UserId nchar(100),
	   							  @Password nchar(100),
								  @DoctorId nchar(100),
								  @SpecialityId nchar(100),
								  @date_assignment Date,
								  @start_time time,
								  @end_time time,
								  @recurring nchar(100)
								  )

AS
BEGIN
	DECLARE @Result INTEGER
	EXEC frontdesk_login @UserId, @Password, @Result = @Result OUTPUT;
    DECLARE @ClinicId nchar(100)
    SET @ClinicId = (SELECT TOP 1 Clinic.ClinicId FROM Clinic JOIN Front_Desk ON Clinic.ClinicId = Front_Desk.ClinicId AND Front_desk.UserId = @UserId)
	IF @Result = 1 BEGIN
		Print 'Login Successful';
		INSERT INTO Assignment VALUES (@DoctorId, @ClinicId, @SpecialityId, @date_assignment, @start_time, @end_time);
		DECLARE @counter INTEGER
		SET @counter = 1

		IF @recurring = 'Daily' BEGIN
		   WHILE (@counter < 365) BEGIN
		   		 INSERT INTO Assignment VALUES (@DoctorId, @ClinicId, @SpecialityId, DateAdd(day, @counter, @date_assignment), @start_time, @end_time);
				 SET @counter = @counter + 1
		   END
		END
		IF @recurring = 'Weekly' BEGIN
		   WHILE (@counter < 52) BEGIN
		   		 INSERT INTO Assignment VALUES (@DoctorId, @ClinicId, @SpecialityId, DateAdd(week, @counter, @date_assignment), @start_time, @end_time);
				 SET @counter = @counter + 1
		   END
		END
		IF @recurring = 'Monthly' BEGIN
		   WHILE (@counter < 12) BEGIN
		   		 INSERT INTO Assignment VALUES (@DoctorId, @ClinicId, @SpecialityId, DateAdd(month, @counter, @date_assignment), @start_time, @end_time);
				 SET @counter = @counter + 1
		   END
		END
	END
	ELSE
		Print 'Login Failed'

END

GO

CREATE PROCEDURE frontdesk_appointment_doctor(@UserId nchar(100), 
											@Password nchar(100), 
											@PatientId nchar(100),
											@SpecialityId nchar(100),
											@appointment_reason nchar(100),
											@DoctorId nchar(100), 
											@date_assignment Date, 
											@start_time time, 
											@end_time time,
											@recurring nchar(100))
AS
BEGIN
	DECLARE @Result INTEGER
	EXEC frontdesk_login @UserId, @Password, @Result = @Result OUTPUT;

    DECLARE @ClinicId nchar(100)
    SET @ClinicId = (SELECT TOP 1 Clinic.ClinicId FROM Clinic JOIN Front_Desk ON Clinic.ClinicId = Front_Desk.ClinicId AND Front_desk.UserId = @UserId)
	IF @Result = 1 BEGIN
		INSERT INTO Appointment VALUES (@DoctorId, @ClinicId, @SpecialityId, @date_assignment, @PatientId, @start_time, @end_time, @appointment_reason);
		DECLARE @counter INTEGER
	    SET @counter = 1
		IF @recurring = 'Daily' BEGIN
		   	  WHILE (@counter < 365) BEGIN
		   			 INSERT INTO Appointment VALUES (@DoctorId, @ClinicId, @SpecialityId, DATEADD(day, @counter, @date_assignment), @PatientId, @start_time, @end_time, @appointment_reason)
				 	 SET @counter = @counter + 1
		   	  END
		   END
		   IF @recurring = 'Weekly' BEGIN
		   	  WHILE (@counter < 52) BEGIN
		   	  	 INSERT INTO Appointment VALUES (@DoctorId, @ClinicId, @SpecialityId, DATEADD(week, @counter, @date_assignment), @PatientId, @start_time, @end_time, @appointment_reason)
				 SET @counter = @counter + 1
		   	  END
		   END
		   IF @recurring = 'Monthly' BEGIN
		   	  WHILE (@counter < 12) BEGIN
		   	  	 INSERT INTO Appointment VALUES (@DoctorId, @ClinicId, @SpecialityId, DATEADD(month, @counter, @date_assignment), @PatientId, @start_time, @end_time, @appointment_reason)
				 SET @counter = @counter + 1
		   	  END
		   END
	END
	ELSE 
		PRINT 'Failed'
END
GO
CREATE PROCEDURE frontdesk_appointment_speciality(@UserId nchar(100), 
                                            @Password nchar(100),
                                            @PatientId nchar(100),
                                            @appointment_reason nchar(100),
                                            @SpecialityId nchar(100),
                                            @date_assignment Date,
                                            @start_time time,
                                            @end_time time,
                                            @recurring nchar(100))
AS
BEGIN
	DECLARE @Result INTEGER
	EXEC frontdesk_login @UserId, @Password, @Result = @Result OUTPUT;
    DECLARE @ClinicId nchar(100)
    SET @ClinicId = (SELECT TOP 1 Clinic.ClinicId FROM Clinic JOIN Front_Desk ON Clinic.ClinicId = Front_Desk.ClinicId AND Front_desk.UserId = @UserId)
	
	DECLARE @DoctorAvailable nchar(100)
	SET @DoctorAvailable = (SELECT TOP 1 DoctorId From Assignment
							WHERE dbo.Valid_Appointment2(Assignment.DoctorId, @ClinicId, @date_assignment, @start_time, @end_time, NULL) = 0
							AND dbo.Valid_Appointment1(Assignment.DoctorId, @ClinicId, @date_assignment, @start_time, @end_time) > 0
							AND @SpecialityId in (SELECT SpecialityId FROM DoctorSpeciality WHERE Assignment.DoctorId = DoctorSpeciality.DoctorId)
							ORDER BY RAND())
	PRINT @DoctorAvailable
	IF @Result = 1 BEGIN
	       If @DoctorAvailable IS NOT NULL BEGIN
		   INSERT INTO Appointment VALUES (@DoctorAvailable, @ClinicId, @SpecialityId, @date_assignment, @PatientId, @start_time, @end_time, @appointment_reason)
		   DECLARE @counter INTEGER
		   SET @counter = 1
		   IF @recurring = 'Daily' BEGIN
		   	  WHILE (@counter < 365) BEGIN
		   			 INSERT INTO Appointment VALUES (@DoctorAvailable, @ClinicId, @SpecialityId, DATEADD(day, @counter, @date_assignment), @PatientId, @start_time, @end_time, @appointment_reason)
				 	     SET @counter = @counter + 1
		   	  END
		   END
		   IF @recurring = 'Weekly' BEGIN
		   	  WHILE (@counter < 52) BEGIN
		   	  	 INSERT INTO Appointment VALUES (@DoctorAvailable, @ClinicId, @SpecialityId, DATEADD(week, @counter, @date_assignment), @PatientId, @start_time, @end_time, @appointment_reason)
				     SET @counter = @counter + 1
		   	  END
		   END
		   IF @recurring = 'Monthly' BEGIN
		   	  WHILE (@counter < 12) BEGIN
		   	  	 INSERT INTO Appointment VALUES (@DoctorAvailable, @ClinicId, @SpecialityId, DATEADD(month, @counter, @date_assignment), @PatientId, @start_time, @end_time, @appointment_reason)
				     SET @counter = @counter + 1
		   	  END
		   END
		ELSE
		  Print 'Could not find doctor with this speciality at this time'
	 	END
	END
	ELSE
		Print 'Error'

END

-- add a patient to waiting list
GO
CREATE PROCEDURE frontdesk_waiting_list(@UserId nchar(100), @Password nchar(100), @PatientId nchar(100), @SpecialityId nchar(100))
AS
BEGIN
	DECLARE @Result INTEGER
	EXEC frontdesk_login @UserId, @Password, @Result = @Result OUTPUT;
    DECLARE @ClinicId nchar(100)
    SET @ClinicId = (SELECT TOP 1 Clinic.ClinicId FROM Clinic JOIN Front_Desk ON Clinic.ClinicId = Front_Desk.ClinicId AND Front_desk.UserId = @UserId)

    IF @Result = 1 BEGIN
        Print 'Frontdesk Login successful'
        INSERT INTO WaitingList Values (@ClinicId, @SpecialityId, @PatientId);
    END


END
GO
GO

CREATE PROCEDURE view_my_appointments_patient(@PatientUserId nchar(100), @Password nchar(25))
AS
BEGIN
	   DECLARE @Result INTEGER
	   SET @RESULT = (SELECT COUNT(*) FROM Patient WHERE Patient.UserId = @PatientUserId AND Password = @Password)
	   IF @Result = 1 BEGIN
	   	  Print 'Here are your appointments: '
	   	  SELECT Doctor.[Name] As [Doctor Name], Patient.[Name],
		  Appointment.date_of_appointment as [Date],
		  Appointment.starting_time AS [Start Time],
		  Appointment.ending_time as [End Time]
		  FROM Appointment JOIN PATIENT ON Patient.PatientId = Appointment.PatientId JOIN Doctor ON Doctor.DoctorId = Appointment.DoctorId
		  WHERE
		  	Patient.UserId = @PatientUserId
	  END
	  ELSE
		Print 'Login failed'
END

GO
CREATE PROCEDURE view_my_appointments_doctor(@DoctorUserId nchar(100), @Password nchar(25))
AS
BEGIN
	   DECLARE @Result INTEGER
	   SET @RESULT = (SELECT COUNT(*) FROM Doctor WHERE Doctor.UserId = @DoctorUserId AND Password = @Password)
	   IF @Result = 1 BEGIN
	   	  Print 'Here are your appointments: '
	   	  SELECT Doctor.[Name], Patient.[Name],
		  Appointment.date_of_appointment as [Date],
		  Appointment.starting_time AS [Start Time],
		  Appointment.ending_time as [End Time]
		  FROM Appointment JOIN PATIENT ON Patient.PatientId = Appointment.PatientId JOIN Doctor ON Doctor.DoctorId = Appointment.DoctorId
		  WHERE
		  	Doctor.UserId = @DoctorUserId
	  END
	  ELSE
		Print 'Login failed'
END


GO
CREATE PROCEDURE Admin_Viewstats(@AdminId nchar(100), @Password nchar(100))
AS
BEGIN
       DECLARE @Result nchar(100)
       SET @Result = null
       SET @Result = (SELECT TOP 1 Administrator.[Name] FROM Administrator
                     WHERE Administrator.AdminId = @AdminId AND Administrator.Password = @Password)

        IF @Result IS NOT NULL
        BEGIN
            Print 'Welcome '
            Print @Result
            Print 'Statistics: '
            SELECT Clinic.[Name] As [Clinic Name], COUNT(*) AS [Appointments]
                   FROM Clinic JOIN Appointment ON Clinic.ClinicId = Appointment.ClinicId
                   GROUP BY Clinic.[Name]
                   ORDER BY COUNT(*) DESC

        END
        ELSE
            Print 'Admin Login failed'
END
GO