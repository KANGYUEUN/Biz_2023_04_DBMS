use bbsdb;

drop table tbl_bbs;

create table tbl_bbs(
	b_seq	bigint		PRIMARY KEY	AUTO_INCREMENT,
	b_pseq	bigint,			
	b_date	varchar(10),			
	b_time	varchar(10),			
	b_username	varchar(125),							
	b_subject	varchar(125),			
	b_content	text,			
	b_count	int,			
	b_update	datetime			

);

