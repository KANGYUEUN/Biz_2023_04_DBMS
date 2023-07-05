-- 여기는 관리자 화면

-- 주소록 데이터를 관리하기 위하여 project 시작
-- 오라클은 데이터를 저장하기 위하여 데이터 저장 공간을 먼저 설정해야 한다.
-- 물리적 저장 공간을 TableSpace 라고 한다. 

/*
addrDB 라는 이름의 저장소를 만듬
실제 데이터는 'c:/app/data/addr.dbf' 이다.
초기 크기는 1M이며 용량이 부족하면 1K 씩 자동 증가한다.
*/
CREATE TABLESPACE addrDB
DATAFILE 'c:/app/data/addr.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

/*
오라클 에서는 실제 데이터는 TABLESPACE 에 저장되지만
시스템을 통해 DB 데이터 접근시에는 TABLESPACE를 사용하지 않는다.
생성된 TABLESPACE 와 연결하는 사용자를 생성하고,
사용자를 통하여 data 에 접근한다.
*/

-- 사용자 생성하기
-- 오라클 21c 에서는 사용자 등록전 스크립트 실행을 ON 해야함.
-- 오라클 12c 이상에서는 사용자 ID 를 C##ID  형식으로 생성해야 한다.
-- 사용자 ID 를 관리하기가 상당히 불편하다.
-- 이 작업을 선행하지 않으면 사용자 ID 와 TABLESPACE 를 연동 할 수 없다.
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

/*
addr 이라는 사용자ID 를 등록하고 
비밀번호는 12341234 로 한다.
또한 addr 사용자와 addrDB TABLESPACE 를 서로 연동한다.
*/
CREATE USER addr IDENTIFIED BY 12341234
DEFAULT TABLESPACE addrDB;

/*
새로 생성한 사용자에게 DB 접근(CRUD) 할수 있는 권한 부여하기 
권한을 부여할때 로그인, CRUD 하기, TABLE 생성하기 등의 권한을 
세부적으로 부여해야 하는데, 학습하는 상황에서 세부적인 권한부여는 불편하므로
DBA 의 권한을 부여한다.

오라클 에서 DBA 의 권한은 SYSDBA 보다 다소 제한된 권한 이다.
System 에 직접 접근 하는 것을 금지하고, 그 외 권한을 모두 부여한다.

*/
-- 사용자 ID addr 에게 DBA 권한을 부여하기.
GRANT DBA TO addr;
























