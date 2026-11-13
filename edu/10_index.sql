-- ------
-- INDEX
-- ------
-- INDEX 확인 
SHOW INDEX FROM employees ; 

-- 0.03초
SELECT * FROM employees WHERE `name` = '이미경' ; 

-- INDEX 
ALTER TABLE employees 
ADD INDEX idx_employees_name (`name`);

-- INDEX 제거 
ALTER TABLE employees 
DROP INDEX idx_employees_name ; 
