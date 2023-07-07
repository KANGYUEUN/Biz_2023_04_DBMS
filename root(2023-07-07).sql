-- 여기는 root 화면(2023-07-07)
-- 유저 삭제
drop USER 'todo'@'localhost';
drop USER 'todo'@'192.168.4.%';
drop USER 'todo'@'%';

-- 사용자 재생성
drop user todo@localhost;
create USER 'todo'@'localhost' identified by '88888888';
-- 권한부여
grant all privileges on todoDB.* to todo@localhost;
-- 강제로 권한 적용 시키기
flush privileges;

-- MySQL 의 SCHEME 생성(새로운 DB)
create database scoreDB;

-- scoreDB 로 권한 부여 
grant all privileges on ScoreDB.* to todo@localhost;
flush privileges;