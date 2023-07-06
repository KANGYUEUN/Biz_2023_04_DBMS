-- 여기는 Todo_Server로 접속한 화면
USE todoDB;
create TABLE tbl_todolist (
	to_seq BIGINT primary KEY auto_increment,
    to_sdate varchar(10) NOT NULL,
    to_stime varchar(10) NOT NULL,
    to_content varchar(400) NOT NULL,
    to_edate varchar(10),
	to_etime varchar(10)
    );
    show Tables;