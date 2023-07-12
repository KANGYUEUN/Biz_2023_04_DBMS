-- 2023-07-12 Test 2번문제
create database iolistDB;
show databases;

use iolistDB;

-- Test 4, 5번 문제
create user 'korea'@'localhost' identified by '!Biz8080';
create user 'korea'@'192.168.0.%' identified by '!Biz8080';

-- 5번 문제 iolistDB 권한부여
grant all privileges on iolistDB.* to 'korea'@'192.168.0.%';

-- 6번 문제 table 생성하기 (일련번호 칼럼 자동증가 옵션)
drop table tbl_iolist;
create table tbl_iolist (
	io_seq		bigint		PRIMARY KEY auto_increment,
	io_date		varchar(10)	NOT NULL,	
	io_time		varchar(10)	NOT NULL,	
	io_pcode	varchar(5)	NOT NULL,	
	io_dcode	varchar(4)	NOT NULL,	
	io_inout	varchar(1)	NOT NULL,	
	io_qty		bigint		NOT NULL,	
	io_iprice	bigint,		
	io_oprice	bigint		
);
tbl_iolist

create table tbl_dept (
	d_code		varchar(4)		PRIMARY KEY,
	d_name		varchar(125)	NOT NULL,	
	d_ceo		varchar(50)		NOT NULL,	
	d_tel		varchar(20)		NOT NULL,	
	d_address	varchar(125)		
);

create table tbl_product (
	p_code		varchar(125)	PRIMARY KEY,
	p_name		varchar(125)	NOT NULL,	
	p_iprice	bigint,		
	p_oprice	bigint		
);

show tables;

-- 7번 문제 참조무결성 관계 성립 검증 하기 
select io_seq, io_date, io_time, io_pcode, 
		io_dcode, io_inout, io_qty, io_iprice, io_oprice
from tbl_iolist left join tbl_dept
on io_dcode = d_code
where io_date Is NULL order by io_seq;

select io_seq, io_date, io_time, io_pcode, 
		io_dcode, io_inout, io_qty, io_iprice, io_oprice
from tbl_iolist left join tbl_product
on io_pcode = p_code
where io_date Is NULL order by io_seq;



-- 8번 문제 참조무결성 관계 설정하기 
alter table tbl_iolist
add constraint f_dcode
foreign key (io_dcode)
references tbl_dept(d_code);

alter table tbl_iolist
add constraint f_pcode
foreign key (io_pcode)
references tbl_product(p_code);

-- 9번 문제 매입매출 거래일자 SELECTION 하기 
-- import 한 data 확인하기 
select * from tbl_iolist;
-- view table 만들기 
create view view_iolist as 
(
select *,
io_seq
+ io_date
+ io_time
+ io_pcode
+ io_dcode
+ io_inout
+ io_qty
+ io_iprice
+ io_oprice
from tbl_iolist);

select * from view_iolist;

-- 9번 문제 매입매출 거래일자 SELECTION 하기 
select * 
from tbl_iolist where io_date >= '2023-03-01'
AND io_date <= '2023-03-31';

-- 10번 거래구분 1 거래수량 60이상 70미만 데이터 SELECTION 하기
select * from tbl_iolist 
where io_inout = '1'
AND '60' <= io_qty AND io_qty < '70';

-- 11번 3개 테이블 구조 확인하기
describe tbl_iolist;
describe tbl_dept;
describe tbl_product;

-- 12번 3개 table JOIN 하기 
select io_seq, io_date, io_time, d_code, d_name, p_code, p_name
		io_inout, io_qty, p_oprice
from tbl_iolist left join tbl_dept
on io_dcode = d_code
left join tbl_product
on io_pcode = p_code;

-- 13번 상품코드, 상품명 으로 그룹핑, 통계함수 통해 레코드 개수 계산tbl_iolist
select * from tbl_iolist;
select * from tbl_dept;
select * from tbl_product;
select io_pcode 상품코드, p_name 상품명, Count(io_pcode) 레코드수 
from tbl_iolist left join tbl_product 
on p_code = io_pcode
group by io_pcode
order by io_pcode;

-- 14번 거래구분, 상품코드, 상품명 그룹핑, 매입,매출 수량합계 각각 작성
select io_inout 구분, io_pcode 상품코드, p_name 상품명, SUM(io_qty) 수량합계
from tbl_iolist left join tbl_product
on p_code = io_pcode
group by io_inout, io_pcode
order by io_pcode, io_inout;

-- 15번 전채거래 매입합계금액, 매출합계금액 계산
select io_inout 거래구분, SUM(io_qty * io_iprice) 매입합계,
SUM(io_qty * io_oprice) 매출합계 from tbl_iolist 
group by io_inout;

-- 16번 상품코드, 상품명 그룹핑, 평균매입단가 평균매출 단가 출력alter
select io_pcode 상품코드, p_name 상품명, AVG(io_iprice) 평균매입단가,
AVG(io_oprice) 평균매출단가 from tbl_iolist left join tbl_product
on p_code = io_pcode
group by io_pcode
order by io_pcode;

-- 17번 user 정보 insert
create table tbl_user (
	username varchar(125) primary key,
    nickname varchar(125) NOT NULL,
    tel varchar(20) 
);
insert into tbl_user(username, nickname,tel)
values('hong','홍길동','010-1111-1111');
insert into tbl_user(username, nickname,tel)
values('lee','이몽룡','010-2222-2222');
insert into tbl_user(username, nickname,tel)
values('leem','임꺽정','010-3333-3333');

select * from tbl_user;

-- 18번 전화번호 변경하기 (pk 조회)
select * from tbl_user where username = 'hong';
update tbl_user SET tel = '010-1111-5555' where username = 'hong';

-- 19번 임꺽정 데이터 삭제 작성
select * from tbl_user where username = 'leem';
delete from tbl_user where username = 'leem';

-- 20번 nickname 에 '길' 문자열 데이터 SELECTION 하기 (중간문자열검색)
select * from tbl_user where nickname LIKE '%길%';


 


