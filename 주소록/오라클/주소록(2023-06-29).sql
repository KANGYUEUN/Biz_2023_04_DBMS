-- 여기는 addr USER화면(2023-06-29)
/*
tbl_adress table에 대하여 다음 결과를 확인하는 SQL을 작성 

1. table 에 저장된 전체 데이터 의 개수는 몇개인가
2. table 에 저장된 전체 리스트를 전화번호 순으로 정렬하여 확인하기
3. table 에 저장된 전체 리스트를 이름순으로 정렬하여 확인하기
4. table 에 저장된 전체 리스트 중에 성씨가 "이"으로 시작하는 리스트 확인하기
5. table 에 저장된 전체 리스트 중에서 전화번호의 국번(090-2222-1234 중에서 두번째 구역)이
    3으로 시작되는 리스트의 개수는 몇개인가?
*/

-- 1번 (총 저장된 전체 데이터 개수는 199개 이다)
SELECT COUNT(*) FROM tbl_address;

-- 2번 (전체 데이터 중 전화번호 순으로 정렬)
SELECT  a_id, a_name, a_tel, a_addr FROM tbl_address 
ORDER BY a_tel;

-- 2번 역순정렬 (내림차순 정렬) DESC
SELECT * FROM tbl_address ORDER BY a_tel DESC;
-- 테이블의 구조확인의 키워드
DESCRIBE tbl_address;
-- 축약형
DESC tbl_address;

-- 3번 (전체 데이터 중 ID순정렬 하고 같은 아이디 있으면 이름순으로 정렬)
SELECT a_id, a_name, a_tel, a_addr FROM tbl_address 
ORDER BY a_id, a_name;
-- ID 순으로 오름차순정렬하고 같은 id 있으면 이름순 내림차순 정렬.
SELECT a_id, a_name, a_tel, a_addr FROM tbl_address 
ORDER BY a_id, a_name DESC;

-- 4번 (전체 데이터중 이 씨로 시작하는 사람 확인)
SELECT * FROM tbl_address WHERE a_name LIKE '이%';

-- 5번
SELECT * FROM tbl_address WHERE SUBSTR(a_tel,5,1)=3
ORDER BY a_tel;
-- 중간 문자열 검색, 전화번호중에 3이 포함된 모든 전화번호
SELECT * FROM tbl_address WHERE  a_tel LIKE '%3%';
--'____3%' 앞에 어떤 문자열이 와도 뒷자리가 3
SELECT * FROM tbl_address WHERE a_tel LIKE '____3%'
ORDER BY a_tel;

-- 40개 개수 찾기
SELECT COUNT(*) FROM tbl_address WHERE SUBSTR(a_tel,5,1)= '3'
ORDER BY a_tel;

-- 전화번호 국번이 3으로 시작되는 번호중 ID가 가장큰 값과 가장 작은 값을 찾기
SELECT  MAX(A_ID) 최대값, MIN(A_ID) 최소값 FROM tbl_address WHERE SUBSTR(a_tel,5,1)= 3;


