-- root로 접속 (2023-07-14)
use bbsDB;
desc tbl_bbs;

-- tbl_bbs table에 대표 이미지를 저장하는 칼럼 추가하기
-- tbl_bbs table에 b_image 라는 칼럼을 추가하는데 
-- 데이터 타입은 varchar(125)로 하고 b_count 다음에 (b_update) 앞에 추가 하겠다.
-- alter table을 사용하여 새로운 칼럼을 추가하는 경우 
-- 제약사항(NOT NULL 등)을 동시에 추가 할수 없다.
alter table tbl_bbs
add b_image varchar(125)
after b_count;

-- table을 삭제하고 다시 같은 구조로 재생성.
truncate tbl_bbs;
-- FK 삭제하기 
alter table tbl_bbs
drop constraint FK이름;

-- 닉네임 칼럼 삭제하기
alter table tbl_bbs
drop b_nickname;

-- insert 명령문 test 해보기.
insert into tbl_bbs(
	b_pseq, 	b_date,  	b_time,		b_username,
	b_subject,	b_content, 	b_count, 	b_image
) values (
	1,1,1,1,1,1,1,1
);

select * from tbl_bbs;

-- 여러개 이미지 파일 업로드를 위한 새로운 table 만들기
create table tbl_images (
	i_seq			bigint		PRIMARY KEY		AUTO_INCREMENT,
	i_bseq			bigint		NOT NULL,
	i_originalName	varchar(125),			
	i_uploadName	varchar(255)			
);






