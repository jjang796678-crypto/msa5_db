-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT 
	*
FROM titles
;

-- 2. 현재 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
SELECT 
	emp_id
FROM salaries 
WHERE
	salary >= 60000000
	AND end_at IS NULL
;

-- 3. 현재 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT 
	emp_id
FROM salaries
WHERE 
	salary BETWEEN 60000000 AND 70000000
	AND end_at IS NULL
;

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT 
	*
FROM employees
WHERE 
	emp_id = 10001
	OR emp_id = 10005
;

-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT 
	title_code
	, title 
FROM titles 
WHERE 
	title LIKE '%사%'
;
	
-- 6. 사원(퇴사자 포함) 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT 
	`name`
FROM employees
ORDER BY `name` ASC
;

-- 7. 사원(퇴사자 포함)별 전체 급여의 평균을 조회해 주세요.
SELECT 
	(
		SELECT 
			AVG(sal.salary)
		FROM salaries sal 
		WHERE 
			sal.emp_id = emp.emp_id 
	) avg_sal 
FROM employees emp
;

-- 8. 사원(퇴사자 포함)별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
SELECT 
	emp.emp_id
	, (
		SELECT 
			AVG(sal.salary)
		FROM salaries sal 
		WHERE 
			sal.emp_id = emp.emp_id 
	) avg_sal 
FROM employees emp
WHERE 
	(
		SELECT 
			AVG(sal.salary)
		FROM salaries sal 
		WHERE 
			sal.emp_id = emp.emp_id 
	)  
	BETWEEN 30000000 AND 50000000
;

-- 9. 사원(재직 중)별 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.
SELECT 
	emp.emp_id
	, emp.`name`
	, emp.gender  
FROM employees emp
WHERE 
	(
		SELECT 
			AVG(sal.salary)
		FROM salaries sal 
		WHERE 
			sal.emp_id = emp.emp_id 
	) >= 70000000
	AND emp.fire_at IS NULL 
;

-- 10. 현재 직급이 'T005'인,
--   사원(재직 중)의 사원번호와 이름을 조회해 주세요.
SELECT 
	emp.emp_id
	, emp.`name` 
FROM employees emp
WHERE 
	emp.emp_id IN (
		SELECT 
			tte.emp_id
		FROM title_emps tte
		WHERE 
			tte.title_code = 'T005'
			AND tte.end_at IS NULL 
	)
	AND emp.fire_at IS NULL 
;