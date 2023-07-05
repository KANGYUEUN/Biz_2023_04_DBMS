-- 이 화면은 root 화면 
/*
MySQL은 DataBase라는 Scheme 를 통하여 물리적인 DB를 관리한다.
Oracle은 TableSpace 라는 물리적 저장소와 연결한 사용자를 통하여 DB를 관리한다.

현업에서 가장 많이 사용하는 2가지의 DBMS를 서로 비교 함으로써
DB에 대한 이론을 정리 해 보기 바란다.

Oracle에서는 사용자가 Scheme가 되며, 
MySQL에서는 사용자가 DBMS, 물리적저장소 등에 접근하는 권한을 가진 사용자 개념이다.

*/
-- project 시작을 하기 위하여 DataBase를 생성하기.
create database addrDB;
show databases;

-- MySQL 에서는 사용자가로 로그인 한수,
-- Scheme(Database)에 접속하는 절차가 필요하다.
USE addrDB;
-- addrDB에 접속한 상태가 된다.

CREATE TABLE tbl_address (
    a_id	VARCHAR(5)		PRIMARY KEY,
    a_name	nVARCHAR(20)	NOT NULL,	
    a_tel	VARCHAR(15)		NOT NULL,	
    a_addr	nVARCHAR(125)	NOT NULL	
);

DESC tbl_address;

/*
 < BIGINT type의 PK칼럼 >
 보통 기본데이터로 PK를 생성할 수 없을 경우
 별도의 칼럼을 생성하고 그 칼럼에 일련번호 속성을 부여하여 PK로 만든다.
 이때 PK의 값은 무한히 커질수 있으므로 INT 형보다 상당히 큰 BIGINT type으로 설정한다.
 
 < AUTO_INCREMENT 속성 >
 MySQL 에서는 일련번호 칼럼에 대하여 자동값 증가 생성 속성이 있다.
 PK 칼럼에만 이 속성을 부여 할 수 있고, 이 속성을 가진 PK칼럼은
 Insert 가 수행될때 자동으로 1씩 증가되는 일련번호를 생성하여
 칼럼 데이터에 주입한다.
 
*/
CREATE TABLE tbl_addr_hobby (
	ah_seq		BIGINT		AUTO_INCREMENT	PRIMARY KEY,
	ah_aid		VARCHAR(5)	NOT NULL,	
	ah_hbcode	VARCHAR(5)	NOT NULL	
);
insert tbl_addr_hobby (ah_aid, ah_hbcode)
value('A0001','H0001');

select * from tbl_addr_hobby;

drop table tbl_hobby;
create table tbl_hobby (
	hb_code		VARCHAR(5)		PRIMARY KEY,
	hb_name		VARCHAR(30)		NOT NULL,	
	hb_descrip	VARCHAR(400)		
);
-- 현재 시스템의 DataBase(SCHEME) 리스트 확인.
show databases;
-- 현재 DB(addrDB)에 생성된 TABLE LIST 확인.
show tables;

-- table의 구조 확인하기.
describe tbl_address;
desc tbl_address;

-- import 한 data 확인하기.
select * from tbl_address;
-- 제목 줄 제거하기.
delete from tbl_address where a_id = '';
select count(*) from tbl_address;

-- import 한 data 확인하기.
select * from tbl_addr_hobby;
select count(*) from tbl_addr_hobby;

desc tbl_hobby;

select * from tbl_hobby;
select count(*) from tbl_hobby;

-- 정확히 import 되었는지 확인하기.
-- 보고서 자료 만들때 사용함.
select '주소록 Entity' AS 제목, count(*) AS 개수 from tbl_address
union all
select '취미 Entity', count(*) from tbl_addr_hobby
union all
select '취미 Relation',count(*) from tbl_hobby;
commit;