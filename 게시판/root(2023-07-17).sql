-- root로 접속한 화면(2023-07-17)

desc tbl_bbs;
select * from tbl_images;

insert into tbl_bbs(b_username)
values('callor');
-- AUTO_INCREMENT 로 설정된 칼럼의 가장 
-- 마지막 insert 된 data 가져오기.
select last_insert_id();

-- file 한번에 insert 하기 
insert into tbl_bbs(b_username)
values('callor1'),('callor2'),('callor3'),('callor4'),('callor5');

select * from tbl_images;

truncate tbl_bbs;
truncate tbl_images;


select * from tbl_bbs;
select * from tbl_images;

drop table tbl_images;
