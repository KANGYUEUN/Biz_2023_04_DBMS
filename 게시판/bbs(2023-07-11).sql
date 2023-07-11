-- 여기는 bbsDB(2023-07-11)
create database bbsDB;
show databases;

use bbsDB;

create Table tbl_bbs (
	b_seq		bigint			primary key	auto_increment,		
	b_pseq		bigint			NOT null,				
	b_date		varchar(10)		NOT null,
	b_time		varchar(10)		NOT null,
	b_username	varchar(125)	NOT null,
	b_nickname	varchar(125)	NOT null,
	b_subject	varchar(125)	NOT null,
	b_content	text			NOT null,
	b_count		int				NOT null,
	b_update	datetime		NOT null
);

Drop Table tbl_bbs;


create table tbl_bbs (
	b_seq		bigint		PRIMARY KEY AUTO_INCREMENT,
	b_pseq		bigint,		
	b_date		varchar(10),		
	b_time		varchar(10),		
	b_username	varchar(125),		
	b_nickname	varchar(125),		
	b_subject	varchar(125),		
	b_content	text,		
	b_count		int,		
	b_update	datetime		
);
select * from tbl_bbs;

-- 정규화 하기 
select b_username, b_nickname
from tbl_bbs
group by b_username, b_nickname;

create table tbl_user (
	username varchar(125) primary key,
    nickname varchar(125) not null,
    tel 	varchar(20)
);

-- 데이터 직접 insert 하기 
-- tbl_bbs 로 부터 user 정보 분해하기 
insert into tbl_user(username, nickname)
values('callor@callor.com','내멋으로');

insert into tbl_user(username, nickname, tel)
values('hong','홍길동','090-1111-1111');
insert into tbl_user(username, nickname, tel)
values('lee','이몽룡','090-2222-2222');
insert into tbl_user(username, nickname, tel)
values('seoung','성춘향','090-3333-3333');


select * from tbl_user;


-- tbl_user(username) 와 tbl_bbs(b_username) 
-- ' 참조 무결성 관계 '설정하기
alter table tbl_bbs
add constraint f_name
foreign key (b_username)
references tbl_user(username);

-- FK 설정이 되면 
-- 두 table 간의 insert, update, delete 에서 이상현상을 방지하여
-- 참조 무결성 관계를 유지한다.
insert into tbl_bbs(b_username, b_nickname)
values ('aaa','임꺽정');

desc tbl_bbs;


select 
	B.b_seq,
	B.b_pseq,
	B.b_date,
	B.b_time,
	B.b_username,
    U.nickname,
	B.b_subject,
	B.b_content,
	B.b_count,
	B.b_update
from tbl_bbs B, tbl_user U
where B.b_username = U.username
LIMIT 10;









