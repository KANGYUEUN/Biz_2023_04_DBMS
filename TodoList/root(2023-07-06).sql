-- 여기는 root 화면

/*
	 < MySQL 프로젝트 시작 >
     1. database 생성
     2. 사용자 등록
		DB 서버가 Application 서버와 같은 동일한 운영체제에 있을때는 
        사용자 등록이 선택 사항이다.
        root 사용자가 등록 되어있는데 root 사용자는 기본적으로 
        localhost 에서만 접근이 된다.
        
        만약 네트워크를 통해서 DB 서버에 접근 하거나
        특별히 보안이 요구되는 경우가 아니면 
        root 사용자를 일반 DB 사용자로 사용하는 경우가 많다.
*/
create database todoDB;
USE todoDB;
SHOW databases;

-- 사용자 등록
-- 사용자 등록을 할때 접근 할 수 있는 범위를 설정해야 한다.
-- 로컬에서만 접근 할 수 있는 todo생성
create USER 'todo'@'localhost' identified BY '12341234';

-- 로컬 네트워크(192.168.4.1~ 192.168.4.254)에서
-- 현재 시스템의 MySQL 에 접속 할 수 있는 사용자 생성.
Create USER 'todo'@'192.168.4.%' identified by '88888888';

-- 모든 곳에서 접근 할 수있는 사용자 생성.
-- 보안상 가장 위험.
-- "무결성 파괴 "
-- 만약 이 사용자가 자신의 id와 비번을 소홀히 하여 노출된다면,
-- 이 id와 비번을 통해 DB에 접근하고 DBMS 데이터를 모두 파괴 할수 있다
Create USER 'todo'@'%' identified by '88888888';


-- 현재 등록된 사용자는 MySQL Server에 접속 할 수있도록 권한을 가지고 있으나,
-- 그 외의 나머지 역할은 수행 할 수 없다.
-- DB생성, table 생성 등을 수행하려면 권한을 부여 해야 한다.
-- 오라클 : GRANT DBA TO user;

-- ALL PRIVILEGES : DBA 권한.
-- *.* : 모든 DataBase 에 대하여 모든 역할 수행
grant ALL privileges ON *.* To 'todo'@'localhost';
-- 네트워크를 통하여 접근한 todo 사용자에게
-- todoDB에 대하여 모든 권한을 부여하기
grant ALL privileges ON todoDB.* To 'todo'@'192.168.4.%';
-- todoDB 에 tbl_todolist 만 접근 하게 권한 부여.
grant ALL privileges ON todoDB.tbl_todolist To 'todo'@'192.168.4.%';
-- CRUD 명령어만 사용하게 조건을 거는것
grant Create, SELECT, INSERT, UPDATE, DELETE ON todoDB.* To 'todo'@'192.168.4.%';



