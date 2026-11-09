-- DELETE 문
-- DML 중하나로 저장되어 있는 
-- 기존 데이터를 삭제하기 위해 사용하는 쿼리 
-- DELETE FROM 테이블명
-- [WHERE 조건];
DELETE FROM title_emps 
WHERE 
	start_at >= '2026-11-09'
;