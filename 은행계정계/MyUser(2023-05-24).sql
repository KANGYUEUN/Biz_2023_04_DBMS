-- 여기는 MyUser(C##myuser) 로 접속한 화면 

SELECT acNum, acDiv, acbuid, acbalance 
FROM tbl_acc
ORDER BY acNum;

SELECT acNum, acDiv, acbuid, acbalance
FROM tbl_acc 
WHERE acNum = '2023052301';

SELECT * FROM tbl_acc;

INSERT INTO tbl_acc(acnum, acDiv, acbuid, acbalance)
VALUES('2023052401','1','0001','10000');

INSERT INTO tbl_acc(acnum, acDiv, acbuid, acbalance)
VALUES('2023052402','2','0003','10000');

SELECT * FROM tbl_acc
WHERE acbuid = '0001'
ORDER BY acNum;

-- 고객 ID 가 0001 인 계좌정보를 
-- 잔액 순으로 오름차순 정렬하여 보이기 (기본값)
SELECT * FROM tbl_acc
WHERE acbuid = '0001'
ORDER BY acbalance  ASC;

-- 금액이 큰순에서 작은순으로 보이기 ' DESC '
-- 내림차순 정렬
SELECT * FROM tbl_acc
WHERE acbuid = '0001'
ORDER BY acbalance DESC;

-- 고객 ID 가 0001과 0003인 고객 계좌정보 조회
SELECT * FROM tbl_acc
WHERE acbuid = '0001' OR acbuid = '0003';

-- 계좌 잔액이 20000이상인 고객 계좌정보 조회 
SELECT * FROM tbl_acc
WHERE acbalance >= 20000;

-- 한개의 칼럼에 다수의 조건 검색이 필요한 경우
-- OR 연산일 경우 = IN 키워드를 사용 할 수 있다.
SELECT * FROM tbl_acc
WHERE acbuid IN('0001','0003');

-- 잔액이 10000~20000인 경우 조회
SELECT * FROM tbl_acc
WHERE acbalance  >= 10000 AND acbalance <= 20000;

-- 각각 범위 값이 포함관계인 경우 ( >=, <=) 'BETWEEN'
SELECT * FROM tbl_acc
WHERE acbalance BETWEEN 10000 AND 20000;

-- acBuId 의 0001도 0003도 아닌 고객의 ID 조회 'NOT'
SELECT * FROM tbl_acc
WHERE NOT acbuid IN('0001','0003');

-- 위의 코드와 결과가 같다
SELECT * FROM tbl_acc
WHERE acbuid != '0001' AND acbuid <> '0003';

DESCRIBE tbl_acc;
-- table 의 구조 명령(DDL 명령을 사용)
-- table 의 구조를 변경 하는 것은 상당한 비용 발생.
-- 초기설계가 잘 못된 경우 구조 변경을 실시하는데 상당한 주의 필요.
-- 구조변경 과정에서 문제가 발생하면 데이터가 손상되는 문제가 있다

-- tbl_acc 의 acNum  칼럼 길이가 현재 10개 
-- 이 칼럼의 길이를 VARCHAR2(20)으로 하고자함.
-- 구조변경 과정에서 문제가 발생하면 데이터가 
-- 구조변경 할때 칼럼의 크기는 절대 줄여지면 안됨.
ALTER TABLE tbl_acc MODIFY (acNum VARCHAR2(20));
DESC tbl_acc;
SELECT * FROM tbl_acc;


-- SQL 에는 기본적으로 여러 기능을 수행하는 함수들이 내장 되어 있다
-- substr(칼럼,시작,개수) : 칼럼의 문자열을 시작 위치부터 개수 만큼 잘라내기
-- max(칼럼) : 전체 리스트(조건에 맞는 데이터) 중에서 가장 큰 값을 찾기
-- min(칼럼) : 전체 리스트(조건에 맞는 데이터) 중에서 가장 작은 값 찾기 

SELECT substr(max(acNum),9)
FROM tbl_acc
WHERE substr(acNum,0,8) = '20230524';

SELECT * FROM tbl_acc;





























