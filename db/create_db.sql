CREATE DATABASE cool_db;
CREATE USER 'student1'@'%' IDENTIFIED BY 'student1_password';
CREATE USER 'professor1'@'%' IDENTIFIED BY 'professor1_password';
CREATE USER 'advisor1'@'%' IDENTIFIED BY 'advisor1_password';
GRANT SELECT ON cool_db.* to 'student1'@'%';
GRANT SELECT ON cool_db.* to 'professor1'@'%';
GRANT ALL PRIVILEGES ON cool_db.student_section_table TO 'professor1'@'%';
GRANT ALL PRIVILEGES ON cool_db.professor_table to 'professor1'@'%';
GRANT ALL PRIVILEGES ON cool_db.* TO 'advisor1'@'%';
FLUSH PRIVILEGES;

USE cool_db;
CREATE TABLE department_table (

    DepartmentID INT NOT NULL CHECK (DepartmentID BETWEEN 0000000 AND 9999999),
    Name VARCHAR(40) NOT NULL,
    DepartmentHead INT,
    PRIMARY KEY(DepartmentID)
);

insert into department_table (DepartmentID, Name, DepartmentHead) values (9489821, 'Biology', 6262561);
insert into department_table (DepartmentID, Name, DepartmentHead) values (9140799, 'Cybersecurity', 1173779);
insert into department_table (DepartmentID, Name, DepartmentHead) values (9026051, 'Political Science', 7255478);
insert into department_table (DepartmentID, Name, DepartmentHead) values (2443492, 'Finance', 591316);
insert into department_table (DepartmentID, Name, DepartmentHead) values (9838005, 'Chemistry', 6665920);
insert into department_table (DepartmentID, Name, DepartmentHead) values (8930926, 'Zoology', 2447413);

CREATE TABLE professor_table (
    ProfessorID INT CHECK (ProfessorID BETWEEN 0000000 AND 9999999),
    FirstName VARCHAR(40) NOT NULL,
    LastName VARCHAR(40) NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY(ProfessorID),
        CONSTRAINT fk_01 FOREIGN KEY (DepartmentID)
        REFERENCES department_table (DepartmentID)
        ON UPDATE cascade ON DELETE restrict
);

insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (2447413, 'Arluene', 'Aleshintsev', 8930926);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (6665920, 'Romona', 'McBrearty',9838005);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (591316, 'Jacquetta', 'Bane', 2443492);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (7255478, 'Gina', 'Hymer', 9026051);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (1173779, 'Cordie', 'Churchyard', 9140799);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (6262561, 'Berni', 'Trayte', 9489821);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (3685053, 'Chickie', 'Maliffe', 9838005);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (2178558, 'Perceval', 'Tuckley', 9026051);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (2681293, 'Hilario', 'Braghini', 9140799);
insert into professor_table (ProfessorID, FirstName, LastName, DepartmentID) values (5284263, 'Laurice', 'McComish', 8930926);

ALTER TABLE department_table
ADD CONSTRAINT fk_00
FOREIGN KEY (DepartmentHead) REFERENCES professor_table (ProfessorID)
ON UPDATE cascade ON DELETE restrict;

CREATE TABLE major_table (
    MajorID INT NOT NULL CHECK (MajorID BETWEEN 0000000 AND 9999999),
    Name VARCHAR(40) NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY(MajorID),
        CONSTRAINT fk_02 FOREIGN KEY (DepartmentID)
        REFERENCES department_table (DepartmentID)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE minor_table
(
    MinorID INT NOT NULL CHECK(MinorID BETWEEN 0000000 AND 9999999),
    Name VARCHAR(40),
    DepartmentID INT NOT NULL,
    PRIMARY KEY(MinorID),
    CONSTRAINT fk_03 FOREIGN KEY (DepartmentID)
        REFERENCES department_table(DepartmentID)
        ON UPDATE cascade ON DELETE restrict
);

CREATE TABLE advisor_table (

    AdvisorID INT NOT NULL CHECK (AdvisorID BETWEEN 0000000 AND 9999999),
    FirstName VARCHAR(40) NOT NULL,
    LastName VARCHAR(40) NOT NULL,
    DepartmentID INT NOT NULL,
    PRIMARY KEY(AdvisorID),
    CONSTRAINT fk_04 FOREIGN KEY (DepartmentID)
        REFERENCES department_table (DepartmentID)
        ON UPDATE cascade ON DELETE restrict

);


CREATE TABLE course_table (

    CourseID int NOT NULL CHECK (CourseID BETWEEN 0000000 AND 9999999),
    Name varchar(40) NOT NULL,
    DepartmentID int NOT NULL,
    Credits int NOT NULL,
    PRIMARY KEY (CourseID),
    CONSTRAINT fk_05 FOREIGN KEY (DepartmentID)
      REFERENCES department_table(DepartmentID)
      ON UPDATE cascade ON DELETE restrict

);

CREATE TABLE prerequisites_table (

    NextCourse INT NOT NULL,
    RequiredCourse INT NOT NULL,
    DateAdded DATE,
    CONSTRAINT fk_06 FOREIGN KEY (NextCourse)
        REFERENCES course_table (CourseID)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_07 FOREIGN KEY (RequiredCourse)
        REFERENCES course_table (COURSEID)
        ON UPDATE cascade ON DELETE restrict

);

CREATE TABLE corequisites_table (

    Course1 INT,
    Course2 INT,
    CONSTRAINT fk_08 FOREIGN KEY (Course1)
        REFERENCES course_table (CourseID)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_09 FOREIGN KEY (Course2)
        REFERENCES course_table (CourseID)
        ON UPDATE cascade ON DELETE restrict

);

CREATE TABLE section_table (

    SectionID int NOT NULL CHECK (SectionID BETWEEN 0000000 AND 9999999),
    Semester varchar(20) NOT NULL,
    ProfessorID int NOT NULL,
    CourseID int NOT NULL,
    SectionYear int NOT NULL,
    PRIMARY KEY (SectionID),
    CONSTRAINT fk_10 FOREIGN KEY (ProfessorID)
      REFERENCES professor_table(ProfessorID)
      ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_11 FOREIGN KEY (CourseID)
      REFERENCES course_table(CourseID)
      ON UPDATE cascade ON DELETE restrict

);



CREATE TABLE instruction_period (

    PeriodID INT NOT NULL CHECK(PeriodID BETWEEN 0000000 AND 9999999),

    InstructionalMethod VarChar(40),
    InstructionDate DATE,
    InstructionTime TIME,
    SectionID INT,
    PRIMARY KEY(PeriodID),
    CONSTRAINT fk_13 FOREIGN KEY (SectionID)
      REFERENCES section_table(SectionID)
      ON UPDATE cascade ON DELETE restrict

);



CREATE TABLE student_table
(
    StudentID INT NOT NULL CHECK(StudentID BETWEEN 000000000 AND 999999999),
    FirstName VARCHAR(40),
    LastName VARCHAR(40),
    MiddleInitial VARCHAR(1),
    GPA DOUBLE(5, 4) NOT NULL,
    StartYear YEAR NOT NULL,
    GraduationYear YEAR NOT NULL,
    BirthDate DATE NOT NULL,
    Age INT NOT NULL,
    MajorID INT NOT NULL,
    MinorID INT,
    AdvisorID INT NOT NULL,
    CreditsCompleted DOUBLE(4, 1) NOT NULL,
    Enrolled BOOLEAN NOT NULL,
    PRIMARY KEY(StudentID),
    CONSTRAINT fk_14 FOREIGN KEY (MajorID)
        REFERENCES major_table(MajorID)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_15 FOREIGN KEY (MinorID)
        REFERENCES minor_table(MinorID)
        ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_16 FOREIGN KEY (AdvisorID)
        REFERENCES advisor_table(AdvisorID)
        ON UPDATE cascade ON DELETE restrict
);


CREATE TABLE sectionta_table (

    EmploymentID int NOT NULL CHECK(EmploymentID BETWEEN 0000000 AND 9999999),
    StudentID int NOT NULL,
    SectionID int NOT NULL,
    TotalPay Decimal(2) NOT NULL,
    DollarPerHour Decimal(2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalHours Decimal(2) NOT NULL,
    PRIMARY KEY (EmploymentID),
    CONSTRAINT fk_17 FOREIGN KEY (StudentID)
      REFERENCES student_table(StudentID)
      ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_18 FOREIGN KEY (SectionID)
      REFERENCES section_table(SectionID)
      ON UPDATE cascade ON DELETE restrict

);

CREATE TABLE student_section_table (

    StudentID INT,
    SectionID INT,
    Grade DOUBLE(6, 4) NOT NULL,
    Passing BOOLEAN,
    PRIMARY KEY (StudentID, SectionID),
    CONSTRAINT fk_19 FOREIGN KEY (StudentID)
      REFERENCES student_table(StudentID)
      ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_20 FOREIGN KEY (SectionID)
      REFERENCES section_table(SectionID)
      ON UPDATE cascade ON DELETE restrict

);




CREATE TABLE weeklypayment_table (

    PaymentID int NOT NULL CHECK (PaymentID BETWEEN 0000000 AND 9999999),
    EmploymentID int NOT NULL,
    WeekHours Decimal(2) NOT NULL,
    WeekStartDate DATE NOT NULL,
    PRIMARY KEY (PaymentID),
    CONSTRAINT fk_21 FOREIGN KEY (EmploymentID)
      REFERENCES sectionta_table(EmploymentID)
      ON UPDATE cascade ON DELETE restrict

);

insert into major_table (MajorID, Name, DepartmentID) values (6729828, 'Finance', 2443492);
insert into major_table (MajorID, Name, DepartmentID) values (9677412, 'Actuarial Science', 2443492);
insert into major_table (MajorID, Name, DepartmentID) values (1517944, 'Cybersecurity', 9140799);
insert into major_table (MajorID, Name, DepartmentID) values (8879936, 'Political Science', 9026051);
insert into major_table (MajorID, Name, DepartmentID) values (2878849, 'Molecular Biology', 9489821);
insert into major_table (MajorID, Name, DepartmentID) values (4202563, 'Biology', 9489821);
insert into major_table (MajorID, Name, DepartmentID) values (2529314, 'Microbiology', 9489821);
insert into major_table (MajorID, Name, DepartmentID) values (9027164, 'Chemistry', 9838005);
insert into major_table (MajorID, Name, DepartmentID) values (1650644, 'Applied Chemistry', 9838005);
insert into major_table (MajorID, Name, DepartmentID) values (5363325, 'Zoology', 8930926);

insert into minor_table (MinorID, Name, DepartmentID) values (4272475, 'Finance', 2443492);
insert into minor_table (MinorID, Name, DepartmentID) values (2147769, 'Actuarial Science', 2443492);
insert into minor_table (MinorID, Name, DepartmentID) values (4710247, 'Cybersecurity', 9140799);
insert into minor_table (MinorID, Name, DepartmentID) values (9587329, 'Political Science', 9026051);
insert into minor_table (MinorID, Name, DepartmentID) values (1359361, 'Molecular Biology', 9489821);

insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (5913725, 'Aliza', 'Chapelhow', 9489821);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (9273126, 'Murdock', 'Tincey', 9489821);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (192595, 'Odele', 'Bradfield', 9838005);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (1109098, 'Andra', 'Vanyushkin', 9838005);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (2916282, 'Bobbee', 'Byrd', 9026051);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (6186641, 'Adams', 'Lutwyche', 9026051);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (7516941, 'Tally', 'Maunders', 9140799);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (5162667, 'Aldwin', 'Bondar', 2443492);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (5797291, 'Tan', 'Wakely', 2443492);
insert into advisor_table (AdvisorID, FirstName, LastName, DepartmentID) values (392286, 'Janel', 'Landrean', 8930926);

insert into course_table (CourseID, Name, DepartmentID, Credits) values (4766319, 'Introduction to Biology', 9489821, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (1156480, 'Medical Neurology', 9489821, 2);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (6518136, 'Genetics and Evolution', 9489821, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (5977492, 'Nutraceuticals', 9489821, 3);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (4865007, 'Introduction to Chemistry', 9838005, 4);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (4865008, 'Lab for Introduction to Chemistry', 9838005, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (7351954, 'Organic Chemistry', 9838005, 3);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (8386500, 'Interplanetary Composition', 9838005, 4);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (3169393, 'Political Science 1', 9026051, 4);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (4412004, 'Political Debate', 9026051, 4);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (1372233, 'Government Intervention in Military', 9026051, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (8299304, 'Politics and Media', 9026051, 3);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (1491026, 'Introduction to Cybersecurity', 9140799, 3);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (1491027, 'Recitation for Intro to Cyber', 9140799, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (2484292, 'Cybersecurity Policy', 9140799, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (3475028, 'Financial Management', 2443492, 3);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (3145697, 'Investments', 2443492, 3);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (5878074, 'Blockchain Fundamentals', 2443492, 1);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (2592713, 'Portfolio Management', 2443492, 2);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (5378199, 'Introduction to Zoology', 8930926, 2);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (1481117, 'Animal Neuroscience', 8930926, 4);
insert into course_table (CourseID, Name, DepartmentID, Credits) values (7242042, 'Primate Studies', 8930926, 4);

insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (1481117, 5378199, '2013-12-11');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (7242042, 5378199, '2020-02-26');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (3145697, 3475028, '2018-10-28');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (2592713, 3475028, '2021-05-14');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (2484292, 1491026, '2016-01-13');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (4412004, 3169393, '2016-11-29');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (1372233, 3169393, '2019-01-14');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (7351954, 4865007, '2016-02-04');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (1156480, 4766319, '2020-11-14');
insert into prerequisites_table (NextCourse, RequiredCourse, DateAdded) values (5977492, 4766319, '2016-08-19');

insert into corequisites_table (Course1, Course2) values (4865007, 4865008);
insert into corequisites_table (Course1, Course2) values (1491026, 1491027);

insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (811299, 'Fall', 6262561, 4766319, 1987);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (9135305, 'Fall', 6262561, 1156480, 1994);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (6774539, 'Fall', 6262561, 6518136, 1996);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (8831489, 'Fall', 6262561, 5977492, 1998);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (9951836, 'Fall', 6665920, 4865007, 1991);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (7333728, 'Fall', 6665920, 4865008, 2006);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (6224357, 'Fall', 3685053, 7351954, 2004);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (6567602, 'Fall', 3685053, 8386500, 2010);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (258700, 'Fall', 7255478, 3169393, 2007);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (5676838, 'Fall', 7255478, 4412004, 2006);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (3228260, 'Fall', 2178558, 1372233, 1997);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (1495937, 'Fall', 2178558, 8299304, 1992);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (7659070, 'Fall', 1173779, 1491026, 2006);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (1288238, 'Fall', 2681293, 1491027, 2000);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (5830404, 'Fall', 2681293, 2484292, 2004);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (5699892, 'Fall', 591316, 3475028, 2006);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (2747425, 'Fall', 591316, 3145697, 2011);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (492398, 'Fall', 591316, 5878074, 1996);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (3592683, 'Fall', 591316, 2592713, 2002);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (9442868, 'Fall', 2447413, 5378199, 1970);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (9442869, 'Fall', 2447413, 1481117, 1970);
insert into section_table (SectionID, Semester, ProfessorID, CourseID, SectionYear) values (9452868, 'Fall', 5284263, 7242042, 1970);

insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (8426482, 'Virtual', '2021-10-09', '11:19:00', 811299);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (9538654, 'In-Person', '2021-10-09', '7:55:00', 9135305);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (0163967, 'Virtual', '2021-10-09', '6:04:00', 6774539);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (1296453, 'Virtual', '2021-10-09', '1:25:00', 8831489);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (5285928, 'Virtual', '2021-10-09', '1:09:00', 9951836);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (3975358, 'In-Person', '2021-10-09', '10:18:00', 7333728);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (2250794, 'Virtual', '2021-10-09', '1:22:00', 6224357);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (9193849,'In-Person', '2021-10-09', '2:55:00', 6567602);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (9375726, 'In-Person', '2021-10-09', '10:04:00', 258700);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (2496030, 'In-Person', '2021-10-09', '12:25:00', 5676838);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (1010847, 'In-Person', '2021-10-09', '11:11:00', 3228260);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (8173635, 'Virtual', '2021-10-09', '3:06:00', 1495937);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (1059382, 'In-Person', '2021-10-09', '10:31:00', 7659070);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (2305868, 'Virtual', '2021-10-09', '12:58:00', 1288238);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (9472284, 'Virtual', '2021-10-09', '12:23:00', 5830404);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (9287362, 'In-Person', '2021-10-09', '7:03:00', 5699892);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (1838495, 'In-Person', '2021-10-09', '7:03:00', 2747425);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (7462518, 'Virtual', '2021-10-09', '2:22:00', 492398);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (5389358, 'Virtual', '2021-10-09', '2:06:00', 3592683);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (1838593, 'In-Person', '2021-10-09', '1:56:00', 9442868);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (7343949, 'In-Person', '2021-10-09', '8:22:00', 9442869);
insert into instruction_period (PeriodID, InstructionalMethod, InstructionDate, InstructionTime, SectionID) values (1288593, 'Virtual', '2021-10-09', '4:56:00', 9452868);

insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (6351648, 'Lance', 'enzley', 'F', 1.7027, 2000, 2012, '2000-02-11', 22, 6729828, null, 5162667, 117.2, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (1887664, 'Brion', 'Jerrome', 'S', 2.1742, 2009, 2009, '2004-12-04', 18, 6729828, null, 5162667, 85.9, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (3337937, 'Nelie', 'Evangelinos', 'N', 3.2888, 2003, 1999, '2001-06-09', 21, 9677412, null, 5797291, 36.4, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (8553096, 'Teena', 'Lockey', 'C', 3.6734, 2013, 2010, '2003-06-14', 19, 9677412, 1359361, 5797291, 35.1, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (3667924, 'Desiree', 'Ouldred', 'U', 1.8208, 2001, 1995, '2003-12-26', 19, 1517944, null, 7516941, 7.5, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (7955470, 'Harrison', 'Adamides', 'U', 0.0037, 1985, 2006, '2000-05-21', 22, 1517944, null, 7516941, 196.9, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (5337897, 'Waite', 'Espinos', 'U', 2.6231, 2012, 1996, '2002-04-04', 20, 8879936, null, 2916282, 100.7, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (9526001, 'Darda', 'Norval', 'V', 3.2191, 1984, 1985, '2003-09-25', 19, 8879936, 4272475, 6186641, 44.3, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (4985710, 'Glyn', 'Clear', 'P', 0.5924, 2000, 2001, '2000-06-28', 22, 2878849, 4272475, 5913725, 21.2, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (3661085, 'Daryn', 'Diament', 'G', 3.8155, 1969, 1990, '2000-01-20', 22, 2878849, null, 5913725, 158.8, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (5822956, 'Reynard', 'Dales', 'U', 2.4314, 2000, 1993, '2001-07-08', 21, 2878849, null, 5913725, 46.7, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (7131034, 'Hillel', 'Waldron', 'U', 2.855, 1998, 1997, '2003-09-03', 19, 2878849, null, 9273126, 44.9, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (2638516, 'Blakelee', 'Paike', 'U', 3.2913, 2004, 2007, '2000-09-13', 22, 2529314, 2147769, 9273126, 85.9, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (6718756, 'Merrily', 'Faircloth', 'B', 1.7422, 2008, 1992, '2002-10-29', 20, 2529314, 2147769, 9273126, 94.4, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (4416407, 'Merrielle', 'MacGiffin', 'B', 1.2168, 1995, 2007, '2004-11-30', 18, 9027164, null, 192595, 56.2, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (7764538, 'Dion', 'Innwood', 'G', 2.6995, 2002, 2003, '2002-11-20', 20, 9027164, null, 192595, 107.7, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (1660685, 'Neilla', 'Timmens', 'G', 1.7615, 2001, 2003, '2003-10-25', 19, 1650644, 1359361, 1109098, 5.7, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (8552039, 'Egon', 'Westman', 'G', 2.8115, 2006, 2008, '2000-04-13', 22, 1650644, null, 1109098, 90.9, 1);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (5802529, 'Claire', 'Suttle', 'C', 2.1519, 1996, 2011, '2001-02-15', 21, 5363325, null, 392286, 84.4, 0);
insert into student_table (StudentID, FirstName, LastName, MiddleInitial, GPA, StartYear, GraduationYear, BirthDate, Age, MajorID, MinorID, AdvisorID, CreditsCompleted, Enrolled) values (6105055, 'Georgine', 'Keeping', 'U', 1.5213, 1993, 1996, '2001-07-06', 21, 5363325, null, 392286, 0.9, 1);

insert into sectionta_table (EmploymentID, StudentID, SectionID, TotalPay, DollarPerHour, StartDate, EndDate, TotalHours) values (1487894, 8552039, 9951836, 23.12, 16.67, '2022-10-17', '2021-10-09', 49.15);
insert into sectionta_table (EmploymentID, StudentID, SectionID, TotalPay, DollarPerHour, StartDate, EndDate, TotalHours) values (279534, 5802529, 9442868, 33.14, 15.08, '2022-01-02', '2022-03-18', 13.63);
insert into sectionta_table (EmploymentID, StudentID, SectionID, TotalPay, DollarPerHour, StartDate, EndDate, TotalHours) values (1254938, 6718756, 811299, 43.94, 19.17, '2022-09-15', '2022-01-26', 15.19);

insert into weeklypayment_table (PaymentID, EmploymentID, WeekHours, WeekStartDate) values (8817432, 1487894, 0.09, '2022-03-31');
insert into weeklypayment_table (PaymentID, EmploymentID, WeekHours, WeekStartDate) values (8678345, 279534, 3.36, '2022-02-21');
insert into weeklypayment_table (PaymentID, EmploymentID, WeekHours, WeekStartDate) values (615660, 1254938, 13.08, '2022-05-29');

insert into student_section_table (StudentID, SectionID, Grade, Passing) values (4416407, 9951836, 83.1735, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (7764538, 7333728, 81.9627, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (1660685, 6224357, 22.5288, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (4985710, 811299, 83.2489, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (3661085, 9135305, 53.5746, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (5822956, 8831489, 34.0853, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (5337897, 258700, 84.0228, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (9526001, 5676838, 15.7852, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (9526001, 3228260, 8.7557, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (6351648, 5699892, 86.3108, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (1887664, 492398, 25.9699, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (3337937, 3592683, 42.1657, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (3667924, 7659070, 38.8906, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (3667924, 5830404, 20.5856, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (7955470, 7659070, 81.7835, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (7955470, 5830404, 2.613, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (5802529, 9442868, 14.9213, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (5802529, 9442869, 11.6834, 0);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (6105055, 9442868, 19.33, 1);
insert into student_section_table (StudentID, SectionID, Grade, Passing) values (6105055, 9452868, 60.6207, 1);