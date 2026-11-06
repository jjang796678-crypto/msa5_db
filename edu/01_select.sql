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
	fire_at IS NULL -- null 을 찾을 때는 is 를 쓸 것 // 부정문은 is not 
;

-- 1990년생인 사원을 조회해주세요. 
SELECT
	*
FROM employees
WHERE
	birh >= '1990-01-01'
	AND birth <= '1990-12-31'
;

-- 이름이 '김철수' 또는 '정유리' 인 사원을 조회해주세요.
SELECT
	*
FROM employees
WHERE
	`name` = '박보람'
	OR `name` = '정유리'
;

-- 1990년생 이거나, 이름이 '정유리' 인 사원을 조회해주세요. 
SELECT
	*
FROM employees
WHERE
	(
		birth >= '1990-01-01'
		AND birth < '1991-01-01'
	)
	OR `name` = '정유리'
;

-- BETWEEN 연산자 : 지정한 범위 내의 데이터를 조회 
SELECT
	*
FROM employees
WHERE
-- 	birth >= '1990-01-01'
-- 	AND birth <= '1990-12-31'
	birth BETWEEN '1990-01-01' AND '1990-12-31'
;

-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터를 조회 
SELECT
	*
FROM employees
WHERE
-- 	`name` = '박보람'
-- 	OR `name` = '정유리'
	`name` IN('박보람', '정유리')
;

-- 사번 10001, 10005, 10006 인 사원의 모든 정보 조회 
SELECT
	*
FROM employees
WHERE
	emp_id IN(10001,10005,10006)
;

-- LIKE 절 : 문자열의 내용을 조회
-- % : 글자 수와 상관없이 조회할 경우 사용 
-- 이름이 '우'로 끝나는 사원 조회  
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우'
-- 	`name` LIKE '우%' -- '우'로 시작하는 사원 조회
-- 	`name` LIKE '%우%' -- '우'가 포함된 사원 조회
;

-- (_) : 언더바의 개수만큼 글자수를 허용해서 조회 
SELECT
	*
FROM employees
WHERE
	`name` LIKE '__우' -- '우'로 끝나는 3글자 
;

-- 풀텍스트 서치 : 존재 확인만 할 것, 멀티바이트 문자에선 제대로 작동하지 않을 확률이 높음 
SELECT
	*
FROM employees
WHERE
	MATCH('name')
	AGAINST('자연어' IN NATURAL LANGUAGE MODE)
;

-- 중요하지않음
ALTER TABLE employees 
ADD FULLTEXT INDEX fi_employees_name ('name')
;

-- ORDER BY 절 : 조회한 데이터를 정렬
SELECT
	*
FROM employees
-- WHERE 절 넣고 싶으면 여기에 
ORDER BY `name`, birth -- null은 오름차순 제일 위에  
;

SELECT
	birth,emp_id,`name`
FROM employees
ORDER BY 3 
; -- 매우 위험한 쿼리이니 사용하지 말 것 

-- LIMIT 절 , OFFSET 절: 출력의 개수를 제한 
SELECT
	*
FROM employees
LIMIT 10, 5 
;

-- 집계함수
-- SUM(값 - 컬럼명) : 조회된 해당 컬럼의 모든 값의 합계를 반환하는 함수 
-- 전 사원의 현재 급여 합계를 조회해 주세요. 
SELECT
	SUM(salary) sum_sal
FROM salaries -- 보통 복수형 <> 컬럼명은 보통 단수형 
WHERE 
	end_at IS NULL 
;

-- MAX(값 - 컬럼명)
SELECT
	MAX(salary) max_sal
FROM salaries
WHERE 
	end_at IS NULL 
;

-- MIN(값 - 컬럼명)
SELECT
	MIN(salary) min_sal
FROM salaries
WHERE 
	end_at IS NULL 
;

-- AVG(값 - 컬럼명)
SELECT
	AVG(salary) avg_sal
FROM salaries
WHERE 
	end_at IS NULL 
;

-- COUNT(값 - 컬럼명)
-- COUNT 는 (값) <- 안에 있는 것중 null은 제외하고 갯수를 세린다. < 내가 정리 
--  컬럼 명 삽입 시 검색 결과 중 해당 컬럼의 값이 NULL이 아닌 레코드의 총 수를 출력 
-- 현재 재직 중인 사원 수를 구해주세요.
SELECT
	COUNT(`name`) cnt
FROM employees
WHERE 
	fire_at IS NULL 
;

-- DISTINCT 키워드 : 검색결과에서 중복된 레코드 없이 출력 
SELECT DISTINCT
	`name`
FROM employees
;

-- GROUP BY 절, HAVING절 
-- 그룹으로 묶어서 조회 

--  부서별 사원 수 조회 
SELECT
-- SELECT절에 작성하는 컬럼은 
-- GROUP BY 절에서 사용한 컬럼과 
-- 집계함수만 작성해야한다.(SQL 표준 문법)
	dept_code
	, COUNT(*) cnt_emps
FROM department_emps
WHERE 
	end_at IS NULL
GROUP BY dept_code  
;

-- 직급별 사원 수가 10000명 이상인 직급을 조회해주세요 
SELECT 
	title_code
	, COUNT(*) cnt
FROM title_emps
WHERE 
	end_at IS NULL	
GROUP BY title_code 
	HAVING cnt >= 10000
;

