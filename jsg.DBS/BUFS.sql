-- 1. 학과별 참가비 테이블 생성 (학과 -> 참가비 종속성 분리)
CREATE TABLE Department_Fees (
    DeptName VARCHAR(50) PRIMARY KEY,
    Fee INT
);

-- 2. 학생 참여 테이블 생성
CREATE TABLE Student_Participation (
    StudentID VARCHAR(20),
    DeptName VARCHAR(50),
    IsParticipating CHAR(1), -- 'O' 또는 'X'
    PRIMARY KEY (StudentID, DeptName),
    FOREIGN KEY (DeptName) REFERENCES Department_Fees(DeptName)
);

-- 학과 비용 데이터 삽입
INSERT INTO Department_Fees VALUES ('경제학과', 4500);
INSERT INTO Department_Fees VALUES ('데이터경영학과', 2500);
INSERT INTO Department_Fees VALUES ('국제비서학과', 1500);
INSERT INTO Department_Fees VALUES ('무역학과', 3500);

-- 학생 데이터 삽입 (예시)
INSERT INTO Student_Participation VALUES ('08학번', '경제학과', 'O');
INSERT INTO Student_Participation VALUES ('13학번', '데이터경영학과', 'O');
INSERT INTO Student_Participation VALUES ('10학번', '국제비서학과', 'X');
INSERT INTO Student_Participation VALUES ('11학번', '경제학과', 'X');

SELECT 
    P.StudentID AS 학번,
    P.DeptName AS 학과,
    P.IsParticipating AS 참여여부,
    CASE 
        WHEN P.IsParticipating = 'O' THEN F.Fee 
        ELSE NULL 
    END AS 참가비
FROM Student_Participation P
JOIN Department_Fees F ON P.DeptName = F.DeptName;