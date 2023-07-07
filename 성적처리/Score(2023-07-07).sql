-- ScoreDB 화면(2023-07-07)
-- root 에서 권한을 줘야 사용가능하다.
USE SCOREDB;

-- 일반(엑셀) 성적표를 저장 하기 위한 Table 생성
Create table tbl_scoreV1(
	sc_stnum	VARCHAR(5)		PRIMARY KEY,
	sc_kor		INT,		
	sc_eng		INT,		
	sc_math		INT,		
	sc_music	INT,		
	sc_art		INT,		
	sc_software	INT,		
	sc_database	INT		
);
show tables;
desc tbl_scoreV1;

-- 각 과목별 총점 표시하기
select * from tbl_scorev1;
-- view 등록하기
create view view_scorev1 as
(
select * ,
	sc_kor 
	+ sc_eng 
	+ sc_math 
	+ sc_music
	+ sc_art 
	+ sc_software 
	+ sc_database AS 총점,
	-- 각 과목별 평균 표시하기 
	(sc_kor 
	+ sc_eng 
	+ sc_math 
	+ sc_music
	+ sc_art 
	+ sc_software 
	+ sc_database) / 7 AS 평균
	from tbl_scorev1 );
    
    select * from view_scorev1;
    
    -- 국어 성적이 50점 이상인 학생들 리스트
    -- WHERE SELECTION
    select * from view_scoreV1
    where sc_kor >= 50;
    
    -- 평균 점수가 70점 미만인 학생들
    select * from view_scorev1
    where 평균 < 70;
    
    -- SQL을 사용한 간이 통계
    -- 전체 학생의 각 과목별 성적 총점계산
    -- 국어 성적의 총점 계산
    -- SUM() : ANSI SQL의 총 합계를 계산하는 통계함수
    -- AVG() : ANST SQL의 평균을 계산하는 통계함수.
    -- MAX(), MIN() : ANSI SQL의 최대값, 최소값을 계한하는 통계함수
    -- COUNT() : ANSI SQL의 개수를 계산하는 통계함수
    select sum(sc_kor), AVG(sc_kor),
    max(sc_kor), min(sc_kor), COUNT(sc_kor)
    from view_scorev1;
    
    select
    SUM(sc_kor) AS 국어,
    SUM(sc_eng) AS 영어,
    SUM(sc_math) AS 수학,
    SUM(sc_music) AS 음악,
    SUM(sc_art) AS 미술
    from view_scoreV1;
    
    select
    avg(sc_kor) AS 국어,
    avg(sc_eng) AS 영어,
    avg(sc_math) AS 수학,
    avg(sc_music) AS 음악,
    avg(sc_art) AS 미술
    from view_scoreV1;

	-- MySQL8 의 전용함수 
    select * from view_scorev1
    order by 평균 desc;

	--  평균을 오름차순 정렬 해서 랭킹을 계산해라.
    -- RANK() : 랭킹순으로 보이기 
	select *,
    RANK() Over ( order by 평균 desc ) 랭킹
    from view_scorev1
    order by 평균 desc;
    
    -- dense_RANK() : 동점자 처리를 하되, 석차를 건너뜀 없이 보여라.
    select *,
    dense_RANK() Over ( order by 평균 desc ) 랭킹
    from view_scorev1
    order by 평균 desc;
   
   -- Sub Query : SQL 결과를 사용하여 다른 SQL 을 실행하는 것.(비효율)
   select * from    
   (
    select *,
    RANK() Over ( order by 평균 desc ) 랭킹
    from view_scorev1
     ) AS SUB
     where SUB.랭킹 < 5;

select sub.과목코드, sub.과목명 from     
(
	select sc_stnum, 'B001' AS 과목코드,'국어' AS 과목명, sc_kor from tbl_scorev1
	union aLL
	select sc_stnum, 'B002','영어', sc_eng from tbl_scorev1
	union aLL
	select sc_stnum, 'B003','수학', sc_math from tbl_scorev1
	union aLL
	select sc_stnum, 'B004','음악', sc_music from tbl_scorev1
	union aLL
	select sc_stnum, 'B005','미술', sc_art from tbl_scorev1
	union aLL
	select sc_stnum, 'B006','소프트웨어공학', sc_software from tbl_scorev1
	union aLL
	select sc_stnum, 'B007','데이터베이스', sc_database from tbl_scorev1
) AS SUB
group by SUB.과목코드, SUB.과목명;

-- 학생정보 제 3정규화 데이터 테이블
-- 학번과 과목코드를 복합키(슈퍼키), PK 생성
create table tbl_score (
	sc_stnum	VARCHAR(5)	NOT NULL,
	sc_bcode	VARCHAR(4)	NOT NULL,
	sc_score	INT			NOT NULL,
						PRIMARY KEY(sc_stnum, sc_bcode)	
);

-- 과목정보 table
create table tbl_subject (
	b_code	VARCHAR(4)		PRIMARY KEY,
	b_name	VARCHAR(20)		
);

-- 과목정보 엑셀 데이터를 tbl_subject 에 insert 해 보기
/* 과목코드	과목명
B001	국어
B002	영어
B003	수학
B004	음악
B005	미술
B006	소프트웨어공학
B007	데이터베이스
*/
insert into tbl_subject(b_code, b_name) values('B001','국어');
insert into tbl_subject(b_code, b_name) values('B002','영어');
insert into tbl_subject(b_code, b_name) values('B003','수학');
insert into tbl_subject(b_code, b_name) values('B004','음악');
insert into tbl_subject(b_code, b_name) values('B005','미술');
insert into tbl_subject(b_code, b_name) values('B006','소프트웨어공학');
insert into tbl_subject(b_code, b_name) values('B007','데이터베이스');

select * from tbl_subject;
select count(*) from tbl_subject;

select * from tbl_score;
select count(*) from tbl_score;

-- 성적표와 과목정보를 JOIN 하여 
-- 학번, 과목코드, 과목명, 점수를 projection 하여 출력
select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score
left join tbl_subject
on sc_bcode = b_code;

-- 성적표와 과목정보가 완전 참조 관계일때는 EQ JOIN 을 사용 할 수 있다.
-- 완전참조 관계 확인하기
-- 결과 값이 하나도 없어야 한다.
select sc_stnum, sc_bcode, b_name, sc_score
from tbl_score, tbl_subject
where sc_bcode = b_code;

-- < FK : 완전참조 무결성 관계 설정 >
-- 성적표와 과목정보가 계속 완전 참조 관계가 되도록 설정하기.
-- ansi SQL
alter table tbl_score
add constraint f_code
foreign key (sc_bcode)
references tbl_subject(b_code);

-- MySQL
alter table tbl_score
add foreign key(sc_bcode)
references tbl_subject(b_code);
-- 지우기
alter table tbl_score
drop foreign key tbl_score_ibfk_1;


-- < 제약조건 추가하기 >
-- on delete : Master(tbl_subject) table의 키가 삭제 될때 사용
/*
CASCADE : master 삭제 -> sub 도 모두 삭제
SET NULL : master 삭제 -> sub는 null, 만약 sub 칼럼이 NOT NULL 이면 오류 발생
NO ACTION : master 삭제 -> sub 에는 변화 없이 
SET DEFAULT : master 삭제 -> sub Table 생성 할때 default 옵션으로 지정값 세팅.
RESTRICT : 아무것도 하지마, 삭제 하지마
*/
-- on update : Master(tbl_subject) table의 키가 변경 될때 사용
alter table tbl_score
add constraint f_code
foreign key (sc_bcode)
references tbl_subject(b_code)
on delete cascade;

-- S0001 학생의 점수 출력하기
select sc_stnum, sc_bcode, sc_score
from tbl_score, tbl_subject
where sc_bcode = b_code and sc_stnum = 'S0001';

-- 전체 학생의 국어 점수 출력하기
select sc_stnum, sc_bcode, sc_score
from tbl_score, tbl_subject
where sc_bcode = b_code and b_name = '국어';

-- 학생별 총점 계산하기
select sc_stnum, SUM(sc_score)
from tbl_score
group by sc_stnum;

-- 과목별 총점, 평균 계산하기 
select sc_bcode, sum(sc_score) 총점, AVG(sc_score) 평균
from tbl_score
group by sc_bcode;

-- 제 3정규화된 데이터를 pivot 펼쳐서 보고서 형식으로 출력
-- 세로방향으로 펼쳐진 데이터를 가로방향으로 펼쳐서 보기
select
	sum(if(sc_bcode = 'B001', sc_score, 0)) AS 국어,
	sum(if(sc_bcode = 'B002', sc_score, 0)) AS 영어,
	sum(if(sc_bcode = 'B003', sc_score, 0)) AS 수학,
	sum(if(sc_bcode = 'B004', sc_score, 0)) AS 음악,
	sum(if(sc_bcode = 'B005', sc_score, 0)) AS 미술,
	sum(if(sc_bcode = 'B006', sc_score, 0)) AS 소프트웨어공학,
	sum(if(sc_bcode = 'B007', sc_score, 0)) AS 데이터베이스
from tbl_score;

-- 제 3정규화가 되어있는 데이터를 PIVOT 보고서 형식으로 출력.
select sc_stnum,
	sum(if(sc_bcode = 'B001', sc_score, 0)) AS 국어,
	sum(if(sc_bcode = 'B002', sc_score, 0)) AS 영어,
	sum(if(sc_bcode = 'B003', sc_score, 0)) AS 수학,
	sum(if(sc_bcode = 'B004', sc_score, 0)) AS 음악,
	sum(if(sc_bcode = 'B005', sc_score, 0)) AS 미술,
	sum(if(sc_bcode = 'B006', sc_score, 0)) AS 소프트웨어공학,
	sum(if(sc_bcode = 'B007', sc_score, 0)) AS 데이터베이스,
    sum(sc_score) AS 총점,
    avg(sc_score) AS 평균
from tbl_score
group by sc_stnum;

select sc_stnum, SUM(sc_score)
from tbl_score group by sc_stnum;

-- 총점이 500 점 이상인 학생만 보여라
select sc_stnum, SUM(sc_score) from tbl_score
group by sc_stnum
Having SUM(sc_score) > 500;
-- 밑의 코드가 더 효율적임.
select sc_stnum, SUM(sc_score) AS 총점
from tbl_score group by sc_stnum
having 총점 > 500;

-- 학번이 S0010 보다 작은 학생들의 총점 계산하기
-- 전체 데이터를 먼저 select 하고 조건을 걸어서 비효율적임.
select sc_stnum, SUM(sc_score) AS 총점 
from tbl_score group by sc_stnum
having sc_stnum < 'S0010';
-- 밑의 코드가 더 효율적이다.
select sc_stnum, SUM(sc_score) AS 총점 
from tbl_score where sc_stnum < 'S0010'
group by sc_stnum; 




