-- -------
-- JOIN 문
-- 복수의 테이블을 묶어서 하나의 결과 집합으로 출력
-- -------

-- -----------
-- INNER JOIN 
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력 
-- -----------
-- 전 사원의 사번, 이름, 현재급여를 출력해주세요.
SELECT 
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp 
	JOIN salaries sal 
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL 
;

-- ANSI 방법, 표준이다 

SELECT 
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp, salaries sal 
WHERE
	emp.emp_id = sal.emp_id
	AND sal.end_at IS NULL 
;

-- 예전 JOIN 방식, 레거시 시스템 

-- 재직 중인 사원의 사번, 이름, 생일, 부서명
SELECT 
	emp.emp_id
	, emp.`name`
	, emp.birth
	, dep.dept_name
FROM employees emp 
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code 
			AND depe.end_at IS NULL 
ORDER BY emp.emp_id ASC 
;

-- ----------
-- LEFT JOIN 
-- ----------
-- 재직 중인 전 사원 정보를 출력하는데
-- 현재 부서장인 사원이면 부서장 정보도 출력해주세요.
SELECT 
	emp.emp_id
	, emp.`name`
	, depm.dept_code
FROM employees emp
	LEFT JOIN department_managers depm 
		ON emp.emp_id = depm.emp_id 
			AND emp.fire_at IS NULL 
			AND depm.end_at IS NULL
	JOIN departments dep
		ON dep.dept_code = depm.dept_code
ORDER BY depm.dept_code DESC
;

SELECT * FROM department_managers WHERE end_at IS NULL;

-- 서브 쿼리 응용 
SELECT 
	emp.emp_id
	, emp.`name`
	, tmp_manager.dept_code
	, tmp_manager.dept_name
FROM employees emp
	LEFT JOIN (
		SELECT 
			depm.emp_id
			, dep.dept_code
			, dep.dept_name
		FROM  departments dep 
			JOIN department_managers depm 
				ON dep.dept_code = depm.dept_code
					AND depm.end_at IS NULL 
	) tmp_manager
		ON emp.emp_id = tmp_manager.emp_id 
			AND emp.fire_at IS NULL
ORDER BY tmp_manager.dept_code DESC
;

-- 레프트 조인 응용 
SELECT 
	emp.emp_id
	, emp.`name`
	, depm.dept_code
	, dep.dept_name
FROM employees emp
	LEFT JOIN department_managers depm 
		ON emp.emp_id = depm.emp_id 
			AND emp.fire_at IS NULL 
			AND depm.end_at IS NULL
 	LEFT JOIN departments dep
		ON dep.dept_code = depm.dept_code
ORDER BY depm.dept_code IS NULL, depm.dept_code 
;

-- 이너 조인과 레프트 조인 응용 
SELECT 
	emp.emp_id
	, emp.`name`
	, depm.dept_code
	, dep.dept_name
FROM employees emp
	LEFT JOIN (department_managers depm 
 		JOIN departments dep
			ON dep.dept_code = depm.dept_code
				AND depm.end_at IS NULL
	)
		ON emp.emp_id = depm.emp_id 
			AND emp.fire_at IS NULL 
ORDER BY depm.dept_code IS NULL, depm.dept_code 
;

-- ------
-- UNION 
-- 두개 이상의 쿼리의 결과를 합쳐서 출력 
-- UNION		 (중복 레코드를 제거)
-- UNION ALL (중복 레코드를 제거 안함)
-- ------
-- 컬럼 개수 맞출 것 
SELECT *, '1' FROM employees WHERE emp_id IN (1, 3)
UNION 
SELECT *, '2' FROM employees WHERE emp_id IN (1, 5)
;


-- ----------
-- SELF JOIN 
-- 같은 테이블끼리 조인 
-- ----------
-- 현재 슈퍼바이저인 사원 정보 출력 
SELECT 
	emp.emp_id AS junior_emp_id
	, emp.`name` AS junior_name
	, emp.sup_id 
	, sup.emp_id AS sup_id
	, sup.`name` AS sup_name
FROM employees emp
	JOIN employees sup
		ON emp.sup_id = sup.emp_id
			AND emp.sup_id IS NOT NULL 
;
