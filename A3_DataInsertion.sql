
INSERT INTO Administrator( 
			AdminID,
			UserID,
			Password,
			Name)
VALUES		(
			dbo.Make_ID('ADM',(SELECT COUNT(AdminID) FROM Administrator)+1),
			'PrimeAdmin',
			'123456',
			'ADMIN 1 (PrimeAdmin)'
			);

INSERT INTO Administrator
VALUES	(
			dbo.Make_ID('ADM',(SELECT COUNT(AdminID) FROM Administrator)+1),
			'SecondPrimeAdmin',
			'123456',
			'ADMIN 2 (SecondPrimeAdmin)'
			);
INSERT INTO Administrator VALUES (
			dbo.Make_ID('ADM',(SELECT COUNT(AdminID) FROM Administrator)+1),
			'NonPrimeAdmin',
			'123456',
			'ADMIN 3 (NonPrimeAdmin)'
			);


INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'Cardiology');
INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'ENT');
INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'Neurology');
INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'Dermatology');
INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'Opthamology');
INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'Pathology');
INSERT INTO Speciality VALUES (dbo.Make_ID('SPC', (SELECT Count(*) FROM Speciality)+1), 'Pediatrics');
INSERT INTO [Doctor] VALUES ('DOC1', 'combsmichael', '3u744', '643-40-8173', 'Eric Smith', '(871)772-1563x132', 'jay14@gmail.com');
INSERT INTO [Address] VALUES ('DOC1', '938 Cummings Greens', 'Tylerborough', 'Pennsylvania', 'South Africa');
INSERT INTO [DoctorSpeciality] VALUES ('DOC1', 'SPC2');
INSERT INTO [Doctor] VALUES ('DOC2', 'fritzcameron', 'oj17t', '500-28-1884', 'Robert Palmer', '(614)009-5904', 'bkeller@gmail.com');
INSERT INTO [Address] VALUES ('DOC2', '4769 Kim Stream', 'New Mckenzieshire', 'Pennsylvania', 'Indonesia');
INSERT INTO [DoctorSpeciality] VALUES ('DOC2', 'SPC4');
INSERT INTO [DoctorSpeciality] VALUES ('DOC2', 'SPC5');
INSERT INTO [DoctorSpeciality] VALUES ('DOC2', 'SPC6');
INSERT INTO [Doctor] VALUES ('DOC3', 'snelson', '6tera', '494-02-8026', 'Jennifer Owens', '776.688.7029', 'rjohnson@gmail.com');
INSERT INTO [Address] VALUES ('DOC3', '897 Melanie Coves Suite 278', 'Port Madelineburgh', 'Tennessee', 'Peru');
INSERT INTO [DoctorSpeciality] VALUES ('DOC3', 'SPC6');
INSERT INTO [Doctor] VALUES ('DOC4', 'villanuevakenneth', 'ng8uh', '133-43-7126', 'Amy Jones', '(714)706-9447x9081', 'ncuevas@yahoo.com');
INSERT INTO [Address] VALUES ('DOC4', '3088 Sarah Mission Suite 425', 'Port Pamelaville', 'Ohio', 'Zambia');
INSERT INTO [DoctorSpeciality] VALUES ('DOC4', 'SPC2');
INSERT INTO [Doctor] VALUES ('DOC5', 'montgomeryandrew', 'x4yes', '822-97-3599', 'Sandy Smith', '995-225-6977', 'martinbrandon@hotmail.com');
INSERT INTO [Address] VALUES ('DOC5', '607 Morris Dam', 'North Kathy', 'Oregon', 'Netherlands');
INSERT INTO [DoctorSpeciality] VALUES ('DOC5', 'SPC3');
INSERT INTO [Doctor] VALUES ('DOC6', 'petercole', 'jo5y0', '012-72-9394', 'Michael Stewart', '+1-024-196-5737', 'garymccormick@yahoo.com');
INSERT INTO [Address] VALUES ('DOC6', '3315 Jennifer Mountain', 'North Sonya', 'Virginia', 'Vietnam');
INSERT INTO [DoctorSpeciality] VALUES ('DOC6', 'SPC5');
INSERT INTO [Doctor] VALUES ('DOC7', 'allisonevans', 'f236m', '814-17-7866', 'Kristen Pearson', '(960)295-2842x926', 'gwilson@gmail.com');
INSERT INTO [Address] VALUES ('DOC7', '09452 Tara Way', 'East Aprilfort', 'Pennsylvania', 'South Georgia and the South Sandwich Islands');
INSERT INTO [DoctorSpeciality] VALUES ('DOC7', 'SPC5');
INSERT INTO [DoctorSpeciality] VALUES ('DOC7', 'SPC3');
INSERT INTO [Doctor] VALUES ('DOC8', 'ycoleman', 'bg3cr', '297-52-1309', 'Robin Stewart', '850.723.2022x73819', 'monicachurch@yahoo.com');
INSERT INTO [Address] VALUES ('DOC8', '894 Hernandez Port Suite 070', 'Sandraport', 'Hawaii', 'Seychelles');
INSERT INTO [DoctorSpeciality] VALUES ('DOC8', 'SPC6');
INSERT INTO [DoctorSpeciality] VALUES ('DOC8', 'SPC3');
INSERT INTO [Doctor] VALUES ('DOC9', 'john06', '18l6t', '054-33-5563', 'Michael Wheeler', '385-111-7377', 'michaelcabrera@gmail.com');
INSERT INTO [Address] VALUES ('DOC9', '54980 Whitney Curve Apt. 026', 'Port Nancy', 'New York', 'Japan');
INSERT INTO [DoctorSpeciality] VALUES ('DOC9', 'SPC4');
INSERT INTO [DoctorSpeciality] VALUES ('DOC9', 'SPC2');
INSERT INTO [Patient] VALUES ('PAT1', 'michael54', 'r7aoq', '629-58-9841', 'Ms. Sherry Brown', '046.069.9197', 'reginaldharvey@hotmail.com');
INSERT INTO [Address] VALUES ('PAT1', '54822 Angel Pass', 'Marksbury', 'Missouri', 'Montserrat');
INSERT INTO [Patient] VALUES ('PAT2', 'jensenbetty', '1wlf4', '270-01-1173', 'Terry Gutierrez', '(563)816-0886', 'lyonsmichelle@gmail.com');
INSERT INTO [Address] VALUES ('PAT2', '098 Charles Knolls Apt. 074', 'Mitchellton', 'New York', 'Heard Island and McDonald Islands');
INSERT INTO [Patient] VALUES ('PAT3', 'johnramirez', 'c9jav', '059-46-7490', 'Cassandra Pope', '339.984.1035', 'john26@yahoo.com');
INSERT INTO [Address] VALUES ('PAT3', '5168 Cody Lake Apt. 781', 'New Mark', 'Hawaii', 'Pitcairn Islands');
INSERT INTO [Patient] VALUES ('PAT4', 'iford', '4u9zn', '389-76-7240', 'Robert Bruce', '+1-171-964-6335', 'alanhughes@hotmail.com');
INSERT INTO [Address] VALUES ('PAT4', '37629 Spencer Alley', 'Port William', 'New Jersey', 'Czech Republic');
INSERT INTO [Patient] VALUES ('PAT5', 'sharonhoward', '9tkhu', '793-44-3743', 'Scott Mcclain', '(370)260-6449x09555', 'rmay@yahoo.com');
INSERT INTO [Address] VALUES ('PAT5', '100 Valerie Locks', 'Conniechester', 'New York', 'Angola');
INSERT INTO [Patient] VALUES ('PAT6', 'hernandezdaniel', 'nyk0b', '707-89-5575', 'Austin Tran', '+1-309-027-9904', 'annestephenson@hotmail.com');
INSERT INTO [Address] VALUES ('PAT6', '210 Evans Garden', 'Jessicahaven', 'Missouri', 'Ethiopia');
INSERT INTO [Patient] VALUES ('PAT7', 'wrightsean', 'yn62o', '349-81-4863', 'Jonathan Anderson', '497-828-5243', 'ksnyder@gmail.com');
INSERT INTO [Address] VALUES ('PAT7', '77390 Leonard Groves', 'Lake Donnafort', 'Alaska', 'Reunion');
INSERT INTO [Patient] VALUES ('PAT8', 'brandon90', 'x89qc', '791-12-4716', 'Savannah Stokes', '(247)898-3831', 'jennifermoore@yahoo.com');
INSERT INTO [Address] VALUES ('PAT8', '34889 Timothy Spring Suite 351', 'New Joshua', 'Rhode Island', 'Tuvalu');
INSERT INTO [Patient] VALUES ('PAT9', 'cpatton', '12xnc', '344-57-1891', 'Angela Williams', '113-696-4138x10709', 'larrymartinez@hotmail.com');
INSERT INTO [Address] VALUES ('PAT9', '3834 Elizabeth Loaf', 'Torresburgh', 'Indiana', 'Samoa');

INSERT INTO [Patient] VALUES ('PAT10', 'chaynes', '5u8n6', '512-20-5241', 'Monique Frye', '+1-319-211-3031', 'brandyball@yahoo.com');
INSERT INTO [Address] VALUES ('PAT10', '714 Bell Forges Suite 269', 'South Heather', 'Pennsylvania', 'Montserrat');
INSERT INTO [Patient] VALUES ('PAT11', 'waguilar', '42mqt', '247-03-7687', 'Ethan Hanson', '+1-055-850-6520', 'ronald01@hotmail.com');
INSERT INTO [Address] VALUES ('PAT11', '81974 Carlos Island', 'Leslieburgh', 'Kentucky', 'Iraq');
INSERT INTO [Patient] VALUES ('PAT12', 'sarah21', 'x9rok', '709-28-3695', 'Maria Lee', '262-687-4484', 'michelle95@gmail.com');
INSERT INTO [Address] VALUES ('PAT12', '8912 Merritt Corner Apt. 825', 'Robinsonborough', 'New Hampshire', 'Burundi');
INSERT INTO [Patient] VALUES ('PAT13', 'dmiller', 'o6mme', '187-68-8668', 'Paul Lewis MD', '(198)969-6682x4240', 'jennifercampbell@hotmail.com');
INSERT INTO [Address] VALUES ('PAT13', '55657 Bryant Valley', 'Lake Charles', 'South Dakota', 'Denmark');
INSERT INTO [Patient] VALUES ('PAT14', 'tylerwarren', '0pgiq', '643-65-7797', 'Christine Taylor', '098.811.2271x668', 'jeremymiller@yahoo.com');
INSERT INTO [Address] VALUES ('PAT14', '35093 David Lock', 'North Edward', 'West Virginia', 'Ecuador');
INSERT INTO [Patient] VALUES ('PAT15', 'william24', '6c51f', '783-88-7680', 'Christopher Williams', '(090)941-0002x7058', 'nicole54@hotmail.com');
INSERT INTO [Address] VALUES ('PAT15', '77362 Jeremy Cliffs', 'Lawrenceton', 'New Mexico', 'Turkey');
INSERT INTO [Patient] VALUES ('PAT16', 'xcarter', '5vsxa', '276-25-4111', 'Rebecca Ramirez', '001-333-862-0944', 'christine94@gmail.com');
INSERT INTO [Address] VALUES ('PAT16', '7620 Debra Islands', 'Deborahborough', 'Ohio', 'Egypt');
INSERT INTO [Patient] VALUES ('PAT17', 'omartin', 'l0ejo', '394-74-5772', 'Margaret Klein', '375-498-0203x676', 'shall@hotmail.com');
INSERT INTO [Address] VALUES ('PAT17', '53897 Smith Burgs', 'West Scott', 'Wisconsin', 'Botswana');
INSERT INTO [Patient] VALUES ('PAT18', 'enunez', '39com', '749-58-0304', 'Daniel Carr', '+1-839-097-6587x050', 'davisdavid@hotmail.com');
INSERT INTO [Address] VALUES ('PAT18', '69486 Maria Ways Apt. 338', 'Port John', 'Vermont', 'Sao Tome and Principe');
INSERT INTO [Patient] VALUES ('PAT19', 'clam', 'utl5n', '662-28-6617', 'Samantha Williams', '978.701.3599', 'perryrobert@hotmail.com');
INSERT INTO [Address] VALUES ('PAT19', '2658 Anthony Station Suite 467', 'Jimview', 'Missouri', 'Holy See (Vatican City State)');


INSERT INTO Clinic VALUES ('CLC1', 'Mayo Clinic', '+14803422000', 'help@mayoclinic.com', '9:00:00', '23:59:00', 'No')
INSERT INTO Address VALUES ('CLC1', '13400 E Shea Blvd', 'Scottsdale', 'Arizona', 'USA')
INSERT INTO Clinic VALUES ('CLC2', 'Johns Hopkins Medical Center', '+14105505299', 'appointment@hopkinsmedicine.org', '9:00:00', '23:59:00', 'Yes')
INSERT INTO Address VALUES ('CLC2', '3400 N. Charles Street', 'Baltimore', 'Maryland', 'USA')
INSERT INTO Clinic VALUES ('CLC3', 'Hadley Medical Center', '+12514441000', 'appointment@franlinprimary.org', '8:00:00', '22:59:00', 'Yes')
INSERT INTO Address VALUES ('CLC3', '572 Stanton Road', 'Mobile', 'Alabama', 'USA')
INSERT INTO Clinic VALUES ('CLC4', 'Mount Sinai Hospital', '+12122416500', 'appointment@mountsinai.org', '8:00:00', '22:59:00', 'Yes')
INSERT INTO Address VALUES ('CLC4', '1468 Madison Ave', 'New York', 'New York State', 'USA')

INSERT INTO ClinicSpeciality VALUES ('CLC1', 'SPC1'), ('CLC1', 'SPC2'), ('CLC1', 'SPC3'), ('CLC1', 'SPC4'), ('CLC1', 'SPC5'), ('CLC1', 'SPC6'),
       ('CLC2', 'SPC2'), ('CLC2', 'SPC3'), ('CLC2', 'SPC4'), ('CLC2', 'SPC6'),
       ('CLC3', 'SPC4'), ('CLC2', 'SPC5'),
       ('CLC4', 'SPC1'), ('CLC4', 'SPC2'), ('CLC4', 'SPC3'), ('CLC4', 'SPC4'), ('CLC4', 'SPC5'), ('CLC4', 'SPC6');

INSERT INTO Front_Desk(
			Front_DeskID,
			UserID,
			Password,
			Name,
			ClinicID
			)
VALUES		(
			dbo.Make_ID('FRD',(SELECT COUNT(Front_DeskID) FROM Front_Desk)+1),
			'1FrontDesk',
			'123456',
			'Mayo Clinic Desk 1',
			'CLC1'
			);

INSERT INTO Front_Desk(
			Front_DeskID,
			UserID,
			Password,
			Name,
			ClinicID
			)
VALUES		(
			dbo.Make_ID('FRD',(SELECT COUNT(Front_DeskID) FROM Front_Desk)+1),
			'2FrontDesk',
			'123456',
			'Mayo Clinic Desk 2',
			'CLC1'
			);

INSERT INTO Front_Desk(
			Front_DeskID,
			UserID,
			Password,
			Name,
			ClinicID
			)
VALUES		(
			dbo.Make_ID('FRD',(SELECT COUNT(Front_DeskID) FROM Front_Desk)+1),
			'Hopkins',
			'1234567',
			'Johns Hopkins Reception',
			'CLC2'
			);

INSERT INTO Front_Desk(
			Front_DeskID,
			UserID,
			Password,
			Name,
			ClinicID
			)
VALUES		(
			dbo.Make_ID('FRD',(SELECT COUNT(Front_DeskID) FROM Front_Desk)+1),
			'hadley56',
			'abcd',
			'Hadley Medical Center',
			'CLC3'
			);

INSERT INTO Front_Desk
VALUES		(
			dbo.Make_ID('FRD',(SELECT COUNT(Front_DeskID) FROM Front_Desk)+1),
			'sinai78',
			'abcd',
			'Mount Sinai Hospital Desk',
			'CLC4'
			);

       EXEC frontdesk_assign @UserId = '1FrontDesk',
                             @Password = '123456',
                             @DoctorId = 'DOC1',
                             @SpecialityId = 'SPC2',
                             @date_assignment = '2020-01-01',
                             @start_time = '4:00:00',
                             @end_time = '8:00:00',
                             @recurring = 'Daily'
       EXEC frontdesk_assign @UserId = '1FrontDesk',
                             @Password = '123456',
                             @DoctorId = 'DOC9',
                             @SpecialityId = 'SPC2',
                             @date_assignment = '2020-01-01',
                             @start_time = '4:00:00',
                             @end_time = '8:00:00',
                             @recurring = 'Daily'

       EXEC frontdesk_assign @UserId = 'Hopkins',
                             @Password = '1234567',
                             @DoctorId = 'DOC2',
                             @SpecialityId = 'SPC4',
                             @date_assignment = '2020-01-02',
                             @start_time = '2:00:00',
                             @end_time = '4:00:00',
                             @recurring = 'Daily'

       EXEC frontdesk_assign @UserId = 'Hopkins',
                             @Password = '1234567',
                             @DoctorId = 'DOC2',
                             @SpecialityId = 'SPC5',
                             @date_assignment = '2020-02-02',
                             @start_time = '6:00:00',
                             @end_time = '8:00:00',
                             @recurring = 'Daily'

       EXEC frontdesk_assign @UserId = 'Hopkins',
                             @Password = '1234567',
                             @DoctorId = 'DOC8',
                             @SpecialityId = 'SPC6',
                             @date_assignment = '2020-01-02',
                             @start_time = '8:00:00',
                             @end_time = '14:00:00',
                             @recurring = 'Daily'

       EXEC frontdesk_assign @UserId = '1FrontDesk',
                             @Password = '123456',
                             @DoctorId = 'DOC4',
                             @SpecialityId = 'SPC2',
                             @date_assignment = '2020-01-01',
                             @start_time = '4:00:00',
                             @end_time = '9:00:00',
                             @recurring = 'Daily'
       EXEC frontdesk_assign @UserId = 'sinai78',
                             @Password = 'abcd',
                             @DoctorId = 'DOC9',
                             @SpecialityId = 'SPC4',
                             @date_assignment = '2020-01-01',
                             @start_time = '12:00:00',
                             @end_time = '18:00:00',
                             @recurring = 'Daily'
       EXEC frontdesk_assign @UserId = 'sinai78',
                             @Password = 'abcd',
                             @DoctorId = 'DOC8',
                             @SpecialityId = 'SPC6',
                             @date_assignment = '2020-01-01',
                             @start_time = '14:30:00',
                             @end_time = '16:00:00',
                             @recurring = 'Monthly'



EXEC dbo.frontdesk_waiting_list @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'Pat10', @SpecialityId = 'SPC1'
EXEC dbo.frontdesk_waiting_list @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'Pat11', @SpecialityId = 'SPC1'
EXEC dbo.frontdesk_waiting_list @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'Pat12', @SpecialityId = 'SPC1'


EXEC dbo.frontdesk_waiting_list @UserId = 'sinai78', @Password = 'abcd', @PatientId = 'Pat12', @SpecialityId = 'SPC1'
EXEC dbo.frontdesk_waiting_list @UserId = 'sinai78', @Password = 'abcd', @PatientId = 'Pat13', @SpecialityId = 'SPC2'
EXEC dbo.frontdesk_waiting_list @UserId = 'sinai78', @Password = 'abcd', @PatientId = 'Pat14', @SpecialityId = 'SPC2'


EXEC dbo.frontdesk_appointment_doctor @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'PAT1', @SpecialityId = 'SPC2',  @appointment_reason = 'Allergies', @DoctorId = 'DOC1',
	@date_assignment = '2020-01-01', 
	@start_time = '4:00:00', @end_time = '5:00:00', @recurring = 'Monthly'

EXEC dbo.frontdesk_appointment_doctor @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'PAT8', @SpecialityId = 'SPC2',  @appointment_reason = 'Allergies', @DoctorId = 'DOC1',
	@date_assignment = '2020-01-01',
	@start_time = '5:10:00', @end_time = '6:10:00', @recurring = null
EXEC dbo.frontdesk_appointment_doctor @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'PAT8', @SpecialityId = 'SPC2',  @appointment_reason = 'Allergies', @DoctorId = 'DOC9',
	@date_assignment = '2020-01-02',
	@start_time = '5:10:00', @end_time = '6:10:00', @recurring = null


EXEC dbo.frontdesk_appointment_speciality @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'PAT9', @appointment_reason = 'DNS', @SpecialityId = 'SPC2',
	@date_assignment = '2020-01-01', 
	@start_time = '4:00:00', @end_time = '5:00:00', @recurring = 'Monthly';
EXEC dbo.frontdesk_appointment_speciality @UserId = '1FrontDesk', @Password = '123456', @PatientId = 'PAT2', @appointment_reason = 'Ear infection', @SpecialityId = 'SPC2',
	@date_assignment = '2020-01-01',
	@start_time = '4:00:00', @end_time = '5:00:00', @recurring = NULL;

EXEC dbo.frontdesk_appointment_speciality @UserId = 'Hopkins',
                                          @Password = '1234567',
                                          @PatientId = 'PAT3',
                                          @appointment_reason = 'Cataracts',
                                          @SpecialityId = 'SPC5',
	@date_assignment = '2020-02-02',
	@start_time = '6:00:00', @end_time = '7:00:00', @recurring = 'Daily';

EXEC dbo.frontdesk_appointment_speciality @UserId = 'sinai78',
                                          @Password = 'abcd',
                                          @PatientId = 'PAT8',
                                          @appointment_reason = 'Cataracts',
                                          @SpecialityId = 'SPC4',
	@date_assignment = '2020-02-02',
	@start_time = '12:00:00', @end_time = '13:00:00', @recurring = 'Daily';
GO