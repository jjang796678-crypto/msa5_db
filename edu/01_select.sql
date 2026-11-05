-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를 
-- 조회하기 위해 사용하는 쿼리 
-- 조회한 데이터 중 특정 컬럼만 출력 

-- SELECT절 : 조회한 데이터 중 특정 컬럼만 출력 
SELECT
	emp_id
	, `name` -- `(백틱)으로 감싸면, 컬럼으로써 인식시킨다. 라는 의믜 
	, gender
FROM employees -- 테이블 지정 
;

-- Asterrisk (*) : 모든 컬럼 조회 
SELECT 
	* 
FROM employees
;


-- WHERE절 : 특정 컬럼의 값이 조건에 맞는 데이터만 조회 (필터링) 
-- 사번이 10009인 사원의 모든 정보를 조회해주세요 
SELECT 
	* 
FROM employees 
WHERE 
	emp_id = 10009
;

-- 사원명이 '박보람'인 사람의 정보를 조회해주세요 
SELECT 
	* 
FROM employees 
WHERE
	`name` = '박보람'
;

-- 생일이 2000-01-01 이후인 사원 모두 찾아주세요 
SELECT 
	* 
FROM employees
WHERE 
	birth >= '2000-01-01' -- 시 분 초 마이크로초 '2000-01-01 00:00:00.000'
;

-- 퇴사하지 않은 사원 정보 다 주세요 
-- null 값을 찾고 싶을 때 is 
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL -- 부정문은 is not 
;

