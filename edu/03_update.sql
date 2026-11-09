-- UPDATE문 
-- DML 중 하나로 저장되어 있는 기존 데이터를
-- 수정하기 위해 사용하는 쿼리 
-- UPDATE 테이블명
-- SET 
-- 	컬럼1 = 값1 
-- 	[, 컬럼2 = 값2...]
-- [WHERE 절] 

-- 100005 사원의 이름을 변경하고싶다 
UPDATE employees
SET 
	`name` = '미어캣'
	, gender = 'F'
WHERE
	emp_id = 100005
;

-- 100005번 사원의 생일을 '2020-01-01' 
-- 이름을 '마이콜'로 변경해 주세요.
UPDATE employees
SET 
	`name` = '마이콜'
	, birth = '2020-01-01'
WHERE
	emp_id = 100005
;
