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
