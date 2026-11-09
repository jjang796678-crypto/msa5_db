-- INSERT문
-- DML 중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리 
-- INSERT INTO 테이블명 [(컬럼1, 컬럼2...)]
-- VALUES (값1, 값2...);
INSERT INTO employees (
	`name`
	, birth
	, gender
	, hire_at
	, fire_at
)
VALUES (
	'장영우'
	, '2000-01-01'
	, 'M'
	, NOW()
	, DEFAULT -- 디폴트를 지정도 가능하나, 일반적으로는 컬럼 자체를 생략한다
);

-- 복수의 레코드를 삽입하고 싶을 경우 
INSERT INTO employees (`name`, birth, gender, hire_at)
VALUES ('장영우', '2000-01-01', 'M', NOW())
, ('홍길동', '1700-01-01', 'M', NOW())
, ('갑돌이', '1900-01-01', 'M', NOW())
;

--  SELECT INSERT 
-- 조회된 결과를 가지고 INSERT를 실행
INSERT INTO title_emps (
	emp_id
	, title_code
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
SELECT 
	emp_id, 'T001', NOW(), NULL, NOW(), NOW(), NULL
FROM employees
WHERE 
	emp_id > 100000
;

-- USE sys : sys 데이터 베이스로 이동 
USE sys ;

-- TCL 문법
-- START TRANSACTION : 임시 저장 시작 
-- COMMIT : 임시 저장을 영구 저장으로 변경 
-- ROLLBACK : 임시 저장 취소 
START TRANSACTION;
COMMIT;
ROLLBACK;
