-- 여기는 student 사용자 화면
-- student 사용자는 현재 DBA 권한을 가지고 있다.
-- DBA 권한은 테이블 생성, 수정, 삭제 데이터의 CRUB, COMMIT ROLLBACK 등 명령 수행가능.

-- 사용자 입장에서 데이터 저장소 생성하기
-- 실제 논리적인 데이터를 관리하는 객체
-- TABLE
/*
 RDBMS(Relation DateBase Managmaent System) 에서 데이터 취급하기

    1. 물리적인 저장소를 생성하기 : Table Space 만들기(관리자만 가능)
        CREATE TABLESPACE 
    2. Table 저장소 생성 : 논리적 개념 CREATE TABLE tbl_student
    3. CRUD 구현하기 

*/
-- 데이터를 추가 하기 전에 Table 생성 오류가 발견 되면 제거하고 재생산.
-- DROP TABLE tbl_student;
CREATE TABLE tbl_student (
    st_num	    VARCHAR2(10)		PRIMARY KEY,
    st_name 	nVARCHAR2(20)	    NOT NULL,	
    st_dept	    nVARCHAR2(20),		
    st_grade	NUMBER,		
    st_tel  	VARCHAR2(10)	    NOT NULL	
);

-- 이미 데이터가 추가 되었는데 Table 구조의 문제를 발견 했을시
-- Table 을 변경(수정) 하기 
-- st_tel 칼럼의 데이터 타입을 변경하기 
-- table 의 구조를 변경하는 명령은 비용이 매우크기 때문에
-- 사용시 주의 해야 한다.
-- 특히 칼럼의 크키(길이) 를 변경하거나 type을 변경할때는
-- 데이터 손상이 있을수 있으니 유의 해야 함.
ALTER TABLE tbl_student MODIFY(st_tel VARCHAR2(20));

--  < CRUD 실습 >

-- 1. 데이터 추가 (CREATE)
-- st_num 칼럼은 PK 로 선언 되어있기 때문에 데이터는 필수 이며 중복 불가.
-- = st_num 칼럼은 PK 이기 때문에 NOT NULL 과 UNIQE 성질을 가진다.
INSERT INTO tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
VALUES('230001','홍길동','정보통신','3','010-111-1111');

INSERT INTO tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
VALUES('230002','성춘향','법학과','2','010-222-2222');

INSERT INTO tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
VALUES('230003','이몽룡','행정학과','1','010-333-3333');


-- 2. 데이터 조회 하기 (READ)
-- 아무 조건 없이 모든 데이터 조회
SELECT * FROM tbl_student;

-- 조건을 부여하여(칼럼을 원하는 순서대로 나열) 데이터 조회 (projection)
SELECT st_num, st_name, st_dept, st_grade, st_tel
FROM tbl_student;

-- 전체 칼럼중 학번과 이름만 보여줘라.
SELECT st_num, st_name
FROM tbl_student;

-- 전체 데이터 중에 홍길동 학생만 보여라 
SELECT st_num, st_name, st_dept, st_grade, st_tel
FROM tbl_student
WHERE st_name = '홍길동';

-- 전체데이터 중에 학생이름 값을 기준으로 오름차순 정렬해서 보여줘라.
SELECT st_num, st_name, st_dept, st_grade, st_tel
FROM tbl_student
ORDER BY st_name;

-- 학생이름으로 정렬하고, 같은 이름이 있으면 그 범위 내에서
-- 전화번호로 한번더 정렬 하여 보여라.
SELECT st_num, st_name, st_dept, st_grade, st_tel
FROM tbl_student
ORDER BY st_name, st_tel;

-- 3. 업데이트(UPDATE)
-- 업데이트를 수행할시에는 내가 변경하는 데이터가 정말 변경하고자 하는 데이터인지 확인.
-- 홍길동 학생의 전화번호가 010-111-1234 로 변경 되었다. 이 데이터 수정하기

-- 일반적인 업데이트 명령은 다음과 같다 문법적 문제 없음
-- 그러나 결과적으로 동명이인데이터 중복수정 문제가 발생 할수 있다.
-- 이러한 현상을 ' 수정이상 ' or ' 변경 이상 ' 이라고 한다.
UPDATE tbl_student
SET st_tel = '010-111-1234'
WHERE st_name = '홍길동';

-- update 절자
-- 1. 변경하고자 하는 데이터를 조회하기(데이터 확인)
SELECT * FROM tbl_student
WHERE st_name = '홍길동';

-- 2. 조회된 데이터 중에서 변경하고자 하는 데이터의 PK가 뭔지 확인하기 (230001)
-- 3. PK를 기준으로 데이터 변경하기 
-- 이런식으로 해야 데이터 무결성이 위배 되지 않는다.
UPDATE tbl_student
SET st_tel = '010-111-1234'
WHERE st_num = '230001';


-- 4. 데이터 삭제(DELETE)
SELECT * FROM tbl_student;

-- 이몽룡(전화번호가 010-333-3333)학생의 데이터가 필요 없어 졌다.
-- 이몽룡 학생의 데이터를 table 에서 삭제하고자 한다.

-- 다음 코드는 학생 테이블에서 다수의 이몽룡 학생의 데이터가 삭제되는 문제가 있다.
-- 원하지 않는 데이터가 삭제되는 현상 : ' 삭제 이상 '
-- 이러한 코드는 신중히 사용해야 한다.
DELETE FROM tbl_student
WHERE st_name = '이몽룡';

-- 이몽룡 학생의 데이터를 삭제하는 절차
--  1. 내가 삭제 하고자 하는 이몽룡 데이터를 조회
SELECT * FROM tbl_student
WHERE st_name = '이몽룡';

--  2. 삭제하고자 하는 데이터의 PK확인 (230003)
--  3. PK를 기준으로 삭제를 실행
DELETE FROM tbl_student
WHERE st_num = '230003';


COMMIT;

SELECT * FROM tbl_student;

















