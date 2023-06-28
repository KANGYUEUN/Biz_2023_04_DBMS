-- 여기는 MyUser SCHEME 화면
-- 여기는 MyUser 로 접속한 화면 

SHOW TABLES;

DESCRIBE tbl_buyer;

/*
< SELECT 명령어 >
SQL 의 DML  명령중에 가장 많이 사용 하는 명령
테이블에 보관 중인 데이터를 조회하는 명령

tbl_buyer TABLE 에 저장된 데이터를 아무조건 없이 모두 
조회하여 보여달라는 것.
*/
SELECT * FROM tbl_buyer;

-- tbl_buyer 테이블에 저장된 데이터를 아무 조건 없이 보이되
-- buid 와 buname 칼럼(속성) 만 보여달라는 것.
-- 저장된 데이터 중에서 선택된 항복만 보고 싶다.
SELECT buid, buname FROM tbl_buyer;
SELECT buname, butel FROM tbl_buyer;

-- tbl_buyer 테이블에 저장된 데이터 중에서 buname 항목의 데이터가 
-- 성춘향으로 되어 있는 데이터 들만 리스트로 보고싶다.
-- WHERE 절 : 조건을 부여할때 사용.
SELECT * FROM tbl_buyer
WHERE buname = '성춘향';

SELECT * FROM tbl_buyer WHERE buname = '이몽룡';

-- 이름이 홍길동으로 되어있는 데이터 리스트를 보고자 함.
-- 데이터가 없다 이런 경우는 결과가 Empty 인 상태.
SELECT * FROM tbl_buyer WHERE buname = '홍길동';

/*
buname 칼럼을 기준으로 조건을 설정 하였다.
어떤 값을 조건으로 데이터를 조회 한것.
buname 칼럼은 데이터가 추가될때 같은 이름의 데이터가 중복하여 저장될 수 있다.
이 칼럼을 기준으로 조회한 데이터가 비록 현재는 1개만 보이더라고 
이 데이터는 0개 이상의 데이터가 조회 될 것이다 라는 것을 반드시 예상해야 한다.

만약 buname 칼럼을 기준으로 하여 데이터를 update, delete 를 수행할 경우 
다수의(2개이상) 데이터에 변경(수정) 이 이루어 질 수 있다.
그러한 이유로 update, delete 를 수행 할때는 절대 buname 칼럼을 기준으로 삼아서는 안된다
*/

INSERT INTO tbl_buyer(buid, buname)
VALUES('0003','성춘향');
SELECT * FROM tbl_buyer;

SELECT * FROM tbl_buyer
WHERE buname = '성춘향';

SELECT * FROM tbl_buyer;
/*
buid 칼럼을 기준으로 조회하기
이 칼럼 TABLE 을 create 할때 PK(프라이머리 키 )성질을 설정 하였다.
PK 로 설정된 칼럼은 유일성, NOT NULL 속성을 갖게 된다.

만약 이칼럼에 이미 잇는 데이터를 또다시 추가 하려고 하면 다음같은 오류 발생.
 ' ORA-00001: 무결성 제약 조건(C##MYUSER.SYS_C008316)에 위배됩니다 '
PK 칼럼에 0001이라는 데이터를 갖는 리스트가 있는데 또다시 0001이라는 데이터를 추가하려고 
했기때문에 발생하는 오류이다.
*/
SELECT * FROM tbl_buyer WHERE buid = '0001';

-- 무결성 제약 조건 오류
-- 중복 데이터 추가 오류
INSERT INTO tbl_buyer(buid, buname)
VALUES('0003','임꺽정');
/*
' ORA-01400: NULL을 ("C##MYUSER"."TBL_BUYER"."BUID") 안에 삽입할 수 없습니다 '
현재 INSERT 명령을 수행하면서 buid 에 해당하는 값을 지정(저장)하지 않았다.
*/
INSERT INTO tbl_buyer(buname)
VALUES('임꺽정');
INSERT INTO tbl_buyer(buid)
VALUES('0004');

/*
TABLE 을 create 하면서 buid buname 을 NOT NULL 로 설정 하였다.
이 데이터를 추가(INSERT) 할때 최소한 buid 와 buname 값을 필수로 넣어햐 한다는 설정
이러한 설정을 "제약조건" 설정이라고 한다 
데이터를 추가 할대 조금이라도 문제가 잇는 데이터를 추가하여 
전체 데이터 베이스에 문제가 발생하는 것을 방지하는 목적이다.
 => " 무결성 유지 "
*/
INSERT INTO tbl_buyer(buid, buname) 
VALUES('0004','임꺽정');

/*
TABLE 개념 : Entity 를 물리적으로 구현한 상태
데이터를 보관, 관리하는 기본적인 틀.
DBMS 소프트웨어 마다 데이터를 저장하는 방법은 각각 고유한 기술적 부분이다.
이러한 부분을 DB 개발자, 사용자가 알 필요는 없다
DBMS 에서는 개발자, 사용자가 바라보는 모든데이터는 TABLE(표) 형식이다.

TABLE 을 작성하기 앞서, 개념적, 논리적 모델링을 수행하는데 이 단계에서는 
TABLE 을 Entity 라고 한다.

프로그래밍(Java) 에서는 객체,개체 등으로 취급핝다.
java 의 데이터 클래스가 여기에 해당한다.
*/



SELECT * FROM tbl_buyer;

-- 매우 위험한 코드
-- update 나 delete 를 수행 할때는 PK 가 아닌 칼럼을 기준으로 하지 마라 
-- 만약 PK 아닌 칼럼을 기준으로 할때는 매우 신중하게 명령을 수행 해야 한다.
UPDATE tbl_buyer
SET buTel = '010-333-3333'
WHERE buname = '성춘향';

/*
tbl_buyer 테이브에 성춘향 데이터 중 전화번호가 없는 데이터가 있다
전화번호가 없는 성춘향 데이터의 전화번호를 010-333-3333 으로 변경 하고 자 한다.

1. buname 칼럼의 데이터가 성춘향인 리스트를 조회한다.
2. 전화번호가 없는(null) 인 데이터에 buid 값을 확인 (0003) 임을 확인.
3.


*/
SELECT * FROM tbl_buyer WHERE buname = '성춘향';
UPDATE tbl_buyer SET butel = '010-222-2222'
WHERE buid = '0002';

SELECT * FROM tbl_buyer WHERE buname = '성춘향';
UPDATE tbl_buyer SET butel = '010-333-3333'
WHERE buid = '0003';

/*
1. 전체 고객 데이터를 조회 : SELECT * FROM tbl_buyer;
이몽룡의 주소가 현재 서울 특별시 이다 근데 이몽룡이 전라북도 익산시로 변경됨
2. 이몽룡의 데이터 조회하기 : SELECT * FROM tbl_buyer WHERE buname = '이몽룡';
3. 주소 업데이트 하기 : UPDATE tbl_buyer SET buaddr = '전라북도 익산시'
    WHERE buid = '0001';
*/

SELECT * FROM tbl_buyer;
SELECT * FROM tbl_buyer WHERE buname = '이몽룡';
UPDATE tbl_buyer SET buaddr = '전라북도 익산시'
WHERE buid = '0001';

SELECT * FROM tbl_buyer;

-- PK 인 buid 값이 0004 데이터를 삭제 하기
-- 중요한 데이터는 함부러 하지 않음.
DELETE FROM tbl_buyer WHERE buid = '0004';
SELECT * FROM tbl_buyer;


-- 데이터 추가 
-- 칼럼목록 개수, 순서 = 데이터 목록 개수, 순서와 서로 일치해야함.
INSERT INTO [table] (칼럼목록) VALUES(데이터 목록);

-- 데이터 조회
SELECT 칼럼목록 FROM [table] WHERE 칼럼 = 값;

-- 데이터 수정
UPDATE [table] SET 칼럼 = 값   -- 변경할 변수와 값
WHERE 칼럼 = 값;                -- 변경할 조건

-- 데이터 삭제
DELETE FROM [table] 
WHERE 칼럼 = 값; -- 삭제할 조건


-- 계좌정보 
CREATE TABLE tbl_acc (
	acNum	VARCHAR2(10) PRIMARY KEY,
	acDiv	VARCHAR2(1)	NOT NULL,	
	acBuId	VARCHAR2(5)	NOT NULL,	
    acBalance	NUMBER	DEFAULT 0	
);

--  각 고객의 계좌정보 생성하기 
INSERT INTO tbl_acc(acNum, acDiv, acBuid, acBalance)
VALUES('2023052301','1','0003',10000);

INSERT INTO tbl_acc(acNum, acDiv, acBuid, acBalance)
VALUES('2023052302','1','0001',50000);

INSERT INTO tbl_acc(acNum, acDiv, acBuid, acBalance)
VALUES('2023052303','1','0002',10000);

SELECT * FROM tbl_acc;

/*
현재 계좌정보를 조회 했는데 
고객정보가 고객 ID 뿐이여서 고객에 대한 이름, 전화번호 등을 알수가 없다.
고객정보와 계좌정보를 연계하여 함께 볼수 있다면 좋겠다.

< TABLE JOIN >
2개 이상의 table 을 서로 연계 하여 하나의 리스트로 보기

tbl_acc와 tbl_buyer 테이블을 연계하여 하나의 리스트로 보여라
이때 tbl_acc 의 acBuid 와tbl_buyer  buid 칼럼의 데이터를 비교하여 
같은 데이터는 한 라인에 보여라.
*/
SELECT * FROM tbl_acc, tbl_buyer
WHERE acBuId = buid;

-- 조인하되, 4개의 칼럼만 화면에 나타나도록 하고싶다.
SELECT  acNum, acBuId, buName, buTel
FROM tbl_acc, tbl_buyer
WHERE acBuId = buid;

SELECT * FROM tbl_buyer;

-- Projection SELECT 조회를 할때 * 사용 하지 않고 칼럼을 정렬하는것
SELECT buid, buname, butel, buaddr, bubirth, bujob
FROM tbl_buyer
ORDER BY buname, butel;


INSERT INTO tbl_buyer(buid, buname, butel)
VALUES ('0004','임꺽정','010-444-4444');

/*
 < SQL Deceloper  와 Java 코드에서 DB 를 서로 연동하여 처리하는 경우 발생하는 문제 >
SQL 에서 데이터를 INSERT, UPDATE, DELETE 하는 경우 
추가 수정 삭제된 정보는 아직 스토리지에 반영되지 않고
메모리에 임시 보관 저장 되어있는 상태 이다.

이 상태일때 자바에서 SELECT 를 수행하면 INSERT, UPDEATE, DELETE 된 데이터가 아닌 
이전 상태이 데이터가 조회 된다.

간혼 이 상황에서 DBMS 가 Connection 에서 무한정 응답하지 않는 경우도 있다.
자바는 DBMS가 응답하기를 기다리면서 무한정 기다리고 마치 프로젝트가 멈춘(Down)
상태가 되어버린다. 

SQL 에서 INSERT, UPDATE, DELETE 를 수행한 다음에는 강제로 스토리지에 
' Commit ' 을 해주어야 한다.
그래야만 Java 프로젝트에서 데이터를 조회 할 수 있다.
*/

Commit;

SELECT * FROM tbl_buyer;

INSERT INTO tbl_buyer(buid, buname)
VALUES ('0005','장길산');

-- Commit 이 되기 전의 데이터를 취소하는 명령
ROLLBACK;

-- PK 칼럼 기준으로 조건 설정하여 조회하기
-- 이를 조회하면 데이터 없거나, 1개만 조회된다.
SELECT buid, buname, butel, buaddr, bubirth, bujob
FROM tbl_buyer
WHERE buid = '0001';

INSERT INTO tbl_buyer(buid, buname, butel)
VALUES('0001','이','010-1111')

UPDATE tbl_buyer
SET buname = '',
    butel = '',
    buaddr = '',
    bubirth = '',
    bujob = ''
WHERE buid = ''





















