-- addr 사용자 화면 (2023-07-04)

-- 주소록 + 취미정보가 있는 데이터를 정규화 하여 Relation 설정하기.

CREATE TABLE tbl_temp_hb (
    hb_a_id	    VARCHAR2(5),
    hb_name1	nVARCHAR2(30),
    hb_name2	nVARCHAR2(30),
    hb_name3	nVARCHAR2(30)
);

SELECT * FROM tbl_temp_hb;
SELECT COUNT(*) FROM tbl_temp_hb;

/*
 < 가로로 나열된 데이터를 세로로 배치하기 >

제 1정규화가 된 취미 데이터는 취미1, 취미2, 취미3 칼럼이 만들어진 table이다.
이 table에 만약 4번째 취미를 추가하고 싶으면,
새로운 칼럼을 추가하거나 4번째 취미를 다른 취미 항목으로 교체 해야 한다.

만약, 취미항목이 늘어나 칼럼을 추가 하게 되면
table 구조를 변경 해야 하고 , 상당히 많은 비용이 요구된다.(시간, 비용)
또한 table구조를 변경하는 것은 매우 신중하게 처리 해야 한다. 
다름 어플리케이션과 연동되는 table의 구조를 변경하면
아주 많은 부분에서변경을 해야하는 경우도 있다.

만약, 취미항목이 3개 미만인 경우는 데이터가 저장되지 않은 칼럼이 발생하고 
이 칼럼들은 보통 NULL 값으로 채워진다. 

table의 칼럼에 null값이 많은 것은 별로 좋은 현상이 아니
*/

SELECT hb_a_id, hb_name1 FROM tbl_temp_hb
UNION ALL
SELECT hb_a_id, hb_name2 FROM tbl_temp_hb
WHERE hb_name2 IS NOT NULL
UNION ALL
SELECT hb_a_id, hb_name3 FROM tbl_temp_hb
WHERE hb_name3 IS NOT NULL
ORDER BY hb_a_id;


-- 취미정보 실제 table
-- 제 2정규화
CREATE TABLE tbl_hobby (
    hb_seq	NUMBER          PRIMARY KEY,
    hb_aid	nVARCHAR2(5)     NOT NULL,
    hb_name	nVARCHAR2(30)   NOT NULL
);

SELECT * FROM tbl_hobby;
SELECT COUNT(*) FROM tbl_hobby; -- 390 개

-- 취미정보 제 3정규화
/*
DDL 명령 : DBA가 사용하는 명령들, 물리적 객체 생성, 제거, 변경을 수행하는 명령
    CREATE : 객체생성, 최초 프로젝트 시작시.
    DROP : 객체제거, 최초 프로젝트 시작시 잘 못 생성된 객체 재 생성.
    ALTER : 객체변경, 프로젝트 사용중 변경사항 발생시 구조변경 수행.
            구조변경은 매우 신중하게 수행 해야 한다.
*/
-- tbl_hobby table의 이름변경
ALTER TABLE tbl_hobby RENAME TO tbl_addr_hobby;
SELECT * FROM tbl_addr_hobby;

/*
 < 주소 취미 Relation TABLE 의 제 3정규화 >
제 2정규화가 되어있는 tbl_addr_hobby TABLE에는 
주소록의 ID(a_id) 와 취미 이름(hb_name)이 저장 되어있다.

hb_aid 칼럼은 주소 테이블과 연계되어있지만
hb_name 칼럼은 평범한 문자열로 구성 되어있다.

 만약 어떤 취미의 명칭을 변경하고자 할때는 
UPDATE tbl_addr_hobby SET hb_name = '변경할 이름 ' 
WHERE hb_name = '원래 이름'; 명령문을 사용 해야 한다.

 이 SQL 명령문은 TABLE 의 데이터를 다수 변경하는 명령이 된다.
UPDATE 명령은 기본적으로 PK 를 기준으로 1개의 데이터만 변경되도록 하는것이 좋다.
하지만 이 명령은 이러한 원칙에 위배된다.

 이때 UPDATE, DELETE 를 수행하는 과정에서 이 테이블에는 수정이상, 삭제이상 현상이
발생 할 수 있다. 또한, 취미정보를 추가하는 과정에서 유사한 취미가 다른 형식으로 
등록 되는 경우도 있다.

 이러한 여러가지 문제를 방지하기 위하여 TABLE을 분리하여 제 3정규화를 수행한다.
 
 1. 기존의 TABLE 에서 일반 문자열로 되어잇는 부분을 떼어 새로운 TABLE에 옮긴다.
 2. 기존 TABLE과 새로운 TABLE간에 Relation을 설정한다.
*/

-- 1. tbl_hoob table의 이름을 변경 : 엔티디를 릴레이션으로 이름 변경.
ALTER TABLE tbl_hobby RENAME TO tbl_addr_hobby;
SELECT * FROM tbl_addr_hobby;

-- 2. 취미 Relation 에서 취미이름(hb_name) 항목을 중복 데이터 없이 추출하기.
-- (= 중복 없이 데이터를 모으기 )
-- hb_name 칼럼의 데이터를 같은 데이터끼리 그룹(묶어)지어 리스트를 만든다.
-- GROUP BY : 중복된 데이터 없이 항목 묶기
SELECT hb_name FROM tbl_addr_hobby
GROUP BY hb_name ORDER BY hb_name;

-- 3. 제 3정규화 데이터 IMPORT 
-- 주의 : 기존 제 2정규화 데이터를 엑셀로 보내서 
--          제 3정규화 데이터가 완료된후 다음을 진행할것.
-- tbl_addr_hobby table을 기존 table 을 DROP 하고 새로운 구조로 생성하기.
DROP TABLE tbl_addr_hobby;

CREATE TABLE tbl_addr_hobby (
    ah_seq	    NUMBER		PRIMARY KEY,
    ah_aid	    VARCHAR2(5)	NOT NULL,	
    ah_hbcode	VARCHAR2(5)	NOT NULL	
);
DESC tbl_addr_hobby;

SELECT COUNT(*) FROM tbl_addr_hobby; -- 390

SELECT ah_hbcode FROM tbl_addr_hobby
GROUP BY ah_hbcode ORDER BY ah_hbcode;

-- 4. 취미 Entity Import
DROP TABLE tbl_hobby;
CREATE TABLE tbl_hobby (
    hb_code	    VARCHAR2(5)		PRIMARY KEY,
    hb_name	    nVARCHAR2(30)	NOT NULL,	
    hb_descrip	nVARCHAR2(400)		
);
SELECT * FROM tbl_addr_hobby;


/* 
  < Table JOIN >
정규화(2,3정규화) 된 TABLE의 정보를 Select(조회) 하면
단순히 1개의 TABLE만으로는 어떤 정보를 보여주고 있는지 알수가 없다.

2,3 정규화된 TABLE은 필연적으로 서로 JOIN이 되어야먄 정보를 알수 있다.
JOIN은 2개 이상의 TABLE 을 서로 연계하여 필요한 정보를 확인하는 것이다.
*/
-- tbl_addr_hobby 곱하기 tbl_address
-- 카티션곱
SELECT * FROM tbl_addr_hobby, tbl_address;
SELECT COUNT(*) FROM tbl_addr_hobby, tbl_address;

-- addr_hobby Relation과 address Entity 테이블을 나열하되, 
-- 두 테이블의 칼럼 ah_aid 와 a_id 데이터가 일치한 정보만 나열하라.
-- < EG JOIN >
-- EQ JOIN 은 모든 JOIN 방식중 가장빠르다. 단 참조 무결성 제약 조건이 완벽해야 한다.
-- EQ JOIN은 연계하는 table간에 참조무결성 제약 조건이 완벽할때는 아무런 문제 없이 조히간능
-- 하지면 연계하는 Table 간에 참조결성 제약 조거에 위배되면 데이터 신뢰 불가.
SELECT ah_aid, a_name, a_tel, a_addr, ah_hbcode FROM tbl_addr_hobby, tbl_address
WHERE ah_aid = a_id;

SELECT COUNT(*) FROM tbl_addr_hobby, tbl_address WHERE ah_aid = a_id; -- 387
SELECT COUNT(*) FROM tbl_addr_hobby; -- 390

-- < LEFT JOIN >

-- JOIN을 실행하는 table 간에 참조무결성이 의심스럽거나, 위배될지 모른다는 전제하에
-- 데이터를 확인하는 JOIN
-- FROM [table1] LEFT JOIN [table2]
-- 왼쪽 table1의 데이터는 무조건 SELECT 하고 
-- 오른쪽 table2의 데이터는 ON 에서 설정한 조건에 맞는 것만 가져오기.
-- 오른쪽 table2에 조건맞는 데이터가 있으면 보여주고, 없으면 null로 표현.

-- 1. SELECT 한 데이터의 누락이 발생하지 않는다.
-- 2. 참조 무결성 제약 조건이 완벽하게 성립하는지 확인하는 용도.

-- tbl_addr_hobby 의 값을 모두 펼치고 tbl_address 와 서로 일치하는 값만 보여라.
-- 없는 값을 NULL로 표현해라 = LEFT JOIN
SELECT ah_aid, a_name, a_tel, a_addr, ah_hbcode FROM tbl_addr_hobby
LEFT JOIN tbl_address ON ah_aid = a_id ORDER BY ah_aid;

-- null 값을 보여라
-- 주소취미 Relation 과 주소 Entity 간의 참조 무결성 검사.
-- 이 결과에서 list가 한개도 나오지 않아야 한다.
SELECT ah_aid, a_name, a_tel, a_addr, ah_hbcode FROM tbl_addr_hobby
LEFT JOIN tbl_address ON ah_aid = a_id 
WHERE a_name IS NULL ORDER BY ah_aid;

SELECT ah_aid, ah_hbcode, hb_name FROM tbl_addr_hobby
LEFT JOIN tbl_hobby ON ah_hbcode = hb_code;

-- 이 두개의 table은 조건이 완벽하다.
-- 주소취미 Relation 과 취미 Entity 간의 참조 무결성 검사
-- 이 결과는 리스트가 한개도 나오지 않아야 한다. 
SELECT ah_aid, ah_hbcode, hb_name FROM tbl_addr_hobby
LEFT JOIN tbl_hobby ON ah_hbcode = hb_code
WHERE hb_name IS NULL;

-- 현재 tbl_address TABLE의 데이터가 테스트 과정에서 문제가 생겼다.
-- 저장된 데이터를 모두 clear 하고, 엑셀의 데이터로 다시 import하자.

-- 기존의 table을 DROP하고 다시 CREATE TABLE해라.
TRUNCATE TABLE tbl_address;
SELECT * FROM tbl_address;

SELECT ah_aid, ah_hbcode, a_name, a_tel, a_addr
FROM tbl_addr_hobby
LEFT JOIN tbl_address ON ah_aid = a_id
WHERE ah_aid <= 'A0010';

SELECT ah_aid, ah_hbcode, hb_name, hb_descrip
FROM tbl_addr_hobby 
LEFT JOIN tbl_hobby
ON ah_hbcode = hb_code;

--  < VIEW의 생성 (읽기, 보기전용 table) >
-- 물리적 TABLE에 SQL 을 적용해셔 작성 하였더니, 다소 복잡하게 완성 되었다.
-- 이 후 이 SQL을 사용할 일이 많을것 같을때
-- 이 SQL을 view로 생성하였다.

-- VIEW는 일반적으로 Read Only 읽기 SELECT만 가능하다.
CREATE VIEW view_addr_hobby
AS( SELECT ah_aid, ah_hbcode, hb_name, a_name, a_tel, a_addr
    FROM tbl_addr_hobby
    LEFT JOIN tbl_address ON ah_aid = a_id
    LEFT JOIN tbl_hobby ON ah_hbcode = hb_code
);

SELECT * FROM view_addr_hobby;
SELECT * FROM view_addr_hobby
WHERE ah_aid = 'A0002';

DROP VIEW view_addr_hobby;

CREATE VIEW view_addr_hobby
AS( SELECT ah_aid AS 아이디,
            ah_hbcode AS 취미코드,
            hb_name AS 취미,
            a_name AS 이름,
            a_tel AS 전화번호,
            a_addr AS 주소
            
    FROM tbl_addr_hobby
    LEFT JOIN tbl_address ON ah_aid = a_id
    LEFT JOIN tbl_hobby ON ah_hbcode = hb_code
);
SELECT * FROM view_addr_hobby;


-- < 참조무결성 설정하기 > ★ (= FOREIGN KEY 설정하기)
-- 연계된 Entity, Relation 간의 참조관계가 잘 유지되도록, TABLE에 제약 조건을 
-- 설정하는 것을 의미한다.
-- 1. FK는 Relation table에 설정한다. 
-- 2. FK는 1:N의 관계 table 에서 N의 table에 설정한다.

-- addr_hobby와 address 간의 FK 설정.
ALTER TABLE tbl_addr_hobby  -- tbl_addr_hobby TABLE(Relation table)
ADD CONSTRAINT f_addr -- f_addr 이름으로 제약조건을 추가 하겠다.
FOREIGN KEY (ah_aid) -- tbl_addr_hobby의 ah_aid칼럼을 
REFERENCES tbl_address(a_id); -- tbl_address table의 a_id 칼럼과 연계.

DELETE FROM tbl_address WHERE a_id = 'A0001';

-- addr_hobby 와 hobby간의 FK설정.
ALTER TABLE tbl_addr_hobby  -- tbl_addr_hobby TABLE(Relation table)
ADD CONSTRAINT f_hobby -- f_hobby 이름으로 제약조건을 추가 하겠다.
FOREIGN KEY (ah_hbcode) -- tbl_addr_hobby의 ah_hbcode칼럼을 
REFERENCES tbl_hobby(hb_code); -- tbl_hobby table의 hb_code 칼럼과 연계.


/*
     < TABLE의 FK 연계조건 >
    _______________________________________________________________________
    tbl_address               tbl_hobby                    tbl_addr_hobby
    -----------------------------------------------------------------------
    코드 o   >>                                         코드가 있을 수 있다.
                              코드 o   >>               코드가 있을 수 있다.
                                
    ------------------------------------------------------------------------
    코드 x   >>                                          절대 없다.
                              코드 x   >>                절대 없다.
    ------------------------------------------------------------------------
    반드시 있어야 한다.                             <<    코드가 있다.
                            반드시 있어야 한다.     <<    코드가 있다.
    ------------------------------------------------------------------------
    삭제 할 수 없다.                                <<    코드가 있다.
                            삭제 할 수 없다.        <<    코드가 있다.
    ------------------------------------------------------------------------                            

*/


































