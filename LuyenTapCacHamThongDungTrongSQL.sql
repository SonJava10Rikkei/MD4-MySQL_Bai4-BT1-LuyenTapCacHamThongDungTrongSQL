CREATE DATABASE Bai4QuanLySinhVien;
USE Bai4QuanLySinhVien;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    MarkPoint      FLOAT   DEFAULT 0 CHECK ( MarkPoint BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

insert into Class (ClassName, StartDate, Status) values
('Java10', '2022-10-25', 1),
('Java11', '2022-11-26', 0),
('Java12', '2022-12-25', 1);

insert into Student (StudentName, Address, Phone, Status, ClassId) values
('Nguyễn Danh Sơn', 'Hà Nội', '0399363868', 1, 1),
('Nguyễn Hữu Huy', 'Bắc Ninh', '0969222347', 0, 1),
('Nguyễn Mạnh Sơn', 'Hà Nội', '0985668313', 0, 2),
('Trương Minh Thu', 'Yên Bái', '0123456789', 1, 2),
('Nguyễn Minh Chiên', 'Thanh Hóa', '0987654321', 1, 3);
insert into Student (StudentName, Address, Phone, Status, ClassId) values
('Hoàng Thị Minh', 'TPHCM', '0973813597', 1, 3);

insert into Subject (SubName, Credit, Status) values
('CSS', 2, 0),
('Java', 3,default),
('C+', 3,1),
('PHP', 5, 0)
;
insert into Subject (SubName, Credit, Status) values
('JavaScript', 5, 0),
('Ruby', 5,0)
;



insert into Mark (SubId, StudentId, MarkPoint, ExamTimes) values
(1,1,90,60),
(2,1,95,60),
(3,1,90,60),
(1,2,95,60),
(2,2,90,60),
(3,2,95,60),
(1,3,100,60),
(2,3,95,60),
(3,3,100,60),
(1,4,90,60),
(2,4,100,60),
(3,4,85,60),
(1,5,85,60),
(2,5,90,60),
(3,5,85,60);

select * from Class;
select * from Student;
select * from Subject;
select * from Mark;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from Subject where Credit =(select max(Credit) From Subject);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select Subject.*, Mark.MarkPoint as "Max Point"
from Mark
    join Subject on Mark.SubId = Subject.SubID
    where Mark.MarkPoint = (select max(MarkPoint) from Mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select Student.*, avg(Mark.MarkPoint) as avg
from Mark
    join Student on Mark.StudentId = Student.StudentId
group by Mark.StudentId
order by avg(Mark.MarkPoint) desc;