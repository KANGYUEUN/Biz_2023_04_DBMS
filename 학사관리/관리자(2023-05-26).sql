-- 관리자로 로그인 한 화면
-- 관리자는 SYSDBA 권한을 가진 사용자
-- SYSDBA 사용자는 데이터 베이스 시스템을 생성, 제거, 파괴 할수 있는 권한을 가진 사용자다.

-- " 오라클에서 관리자로 로그인 하여 수행할 작업 "
-- TableSpace 생성, User 생성

-- TABLESPACE  : 데이터를 저장할 물리적 저장소(파일)를 만드는 곳.
-- 데이터를 저장하기 위해 가장 먼저 생성해야할 객체
-- USER : DBMS 서버에 로그인을 하고, 자신이 관리할 데이터들과 연결하는 객체 
--        오라클에서 유저는 데이터 저장소의 개념
--         이 개념은 다른 DBMS 와 약간 다르게 취급 : 저장소 SCHEME 라고 표현 

-- C:/app/data : TABLESPACE 가 저장될 폴더 

-- 1. ' TABLESPACE 생성(CREATE) '
-- student Table Space 를 생성하고 저장소는 STUDENT.DBF 으로 하라
-- 초기용량은 1MByte 로 하고 1KByte 씩 자동 증가 하도록 설정해라

-- 저장소의 이름 : student / 저장소 폴더에 STUDENT.DBF 라고 생성하겠다. 
CREATE TABLESPACE student 
DATAFILE 'C:/app/data.dbf'
-- 초기에 저장소 공간 을 1M 으로 확보하고 부족하면 1K 씩 자동으로 증가.
SIZE 1M AUTOEXTEND ON NEXT 1K;

-- 2.  ' 사용자 생성(CREATE) 키워드 '
-- student 라는 사용자를 생성하고 비밀번호를 12341234로 설정
-- 기본 저장소 연결을 student 로 설정하라

-- 오라클 12c 이후 버전에서는 사용자 이름 등록하는 정책이 변경 되었다.
-- 만약 student 라는 사용자를 생성하고 싶으면 C#student 라는 이름으로 생성을 해야한다.
-- 이러한 정책은 보안적인 면에서 권장하지만 때로는 불편.
-- 일부 프로그래밍 언어에서 DB 에 접속 할때 ## 와 같은 특수 문자가 있으면
-- 접속에 문제를 일으키는 경우가 있다.

-- 오라클 에서는 12c 이후에 사용자 생성 정책을 예전 방식으로 사용할수 있도록하는 
-- 설정을 제공한다.
-- 이 설정명령은 user 생성 전에 항상 먼저 실행 해야 한다.
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER student IDENTIFIED BY 12341234
DEFAULT TABLESPACE student;


-- 3. 생성한 사용자에게 권한을 부여
-- 사용자 student 는 DBMS SW 에 로그인을 하고 
--       SQL 을 사용하여 데이터  Table 을 생성하고 
--       CRUD 명령을 수행하여 데이터를 관리한다.

-- 오라클에서 사용자를 생성한 직후에는 아무런 권한이 없다.
-- DBMS 에 로그인도 불가하다. 
-- 사용자에게 권한을 부여하여 기능을 활성화 시켜 줘야 한다.
-- 원칙적으로 권한 부여는 각각 항목별로 세부적 부여를 해야 하지만
-- 학습적 편리성을 위하여 모든 권한을 한번에 부여 할 것이다.

-- 사용자에게 DBA(데이터 관리자 ) 권한을 부여하라.
GRANT DBA TO student;



