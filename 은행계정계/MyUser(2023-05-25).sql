-- 여기는 MyUser(C##myuser) 로 접속한 화면 
DROP TABLE tbl_accList;

CREATE TABLE tbl_accList (
    aioSEQ	NUMBER		PRIMARY KEY,
    acNum	    VARCHAR2(20)	NOT NULL,
    aioDate	    VARCHAR2(10)	NOT NULL,
    aioTime	    VARCHAR2(10)	NOT NULL,
    aioDiv	    VARCHAR2(1)	    NOT NULL,
    aioInput	NUMBER	        DEFAULT 0,
    aioOutput	NUMBER	        DEFAULT 0,
    aioREM	    VARCHAR2(30)	
);
  
DESC tbl_accList;
/*
DBMS table 의 일련번호 문제 
table 에 PK 를 임의의 일련번호로 설정 했을 경우 
데이터를 인서트 할때 마다 새로운 일련번호를 생성하여 값을 추가 해야 한다.

DBMS 엔진에 따라 인서트를 할때 자동으로 일련번호를 생성하는 기능이 있는데
오라클에는 없다(11 버전 이하), 12 이상에서는 자동 생성하는 기능이 있는데 
다른 DBMS 에 비하여 상당히 불편하다. 

오라클 에서는 일련번호를 자동으로 생성해 주는 도구를 만들어야 한다.

*/
DROP SEQUENCE seq_accList;
CREATE SEQUENCE seq_accList
START WITH 1 INCREMENT BY 1;

-- seq 시작값은 1로 하고 실행 할때마다 1씩 증가
SELECT seq_accList.NEXTVAL 
FROM DUAL;


INSERT INTO tbl_accList(aioSEQ, acNum, aioDate, aioTime, aioDiv, aioInPut, aioOutput)
VALUES(seq_accList.NEXTVAL, '2023052401','2023-95-24','11:10:00','1',10000,0);


SELECT * FROM tbl_accList;
DELETE FROM tbl_accList;
COMMIT;

SELECT * FROM tbl_acc;






































