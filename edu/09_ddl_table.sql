CREATE DATABASE test;
USE test;

-- ------------------------------------
-- 개념적 설계
-- 테이블과 필요한 속성*들이 무엇일까?
-- ------------------------------------
-- *여기서 속성은 컬럼을 말함
-- -----------
-- 테이블 생성
-- -----------
-- 유저 테이블 
-- pk, 이메일, pw, 이름, 생년, 월, 일, 전화번호, 성별, 주소, 프로필 사진
-- 가입일자, 탈퇴일, 작성일, 수정일, 삭제일 
CREATE TABLE users (
	  id 				BIGINT 			PRIMARY KEY 	AUTO_INCREMENT
	, email 			VARCHAR(100) 	NOT NULL 		UNIQUE 
	, `password`  	VARCHAR(255)	NOT NULL 
	, user_name		VARCHAR(30)		NOT NULL 
	, birth 			DATE 				NOT NULL 
	, phone 			CHAR(13) 		NOT NULL 		COMMENT '\'010-0000-1111\', 하이픈 포함 13자리' 
	, gender 		CHAR(1) 			NOT NULL 		COMMENT '\'M\', \'F\''
	, addr_number 	CHAR(5) 
	, addr1 			VARCHAR(50)	
	, addr2 			VARCHAR(50)	
	, `profile` 	VARCHAR(100) 
	, hired_at 		DATE 				NOT NULL 		DEFAULT (CURRENT_DATE()) 
	, withdrawn_at DATE 									DEFAULT NULL 
	, created_at 	DATETIME 		NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 
	, updated_at 	DATETIME 		NOT NULL 		DEFAULT CURRENT_TIMESTAMP()  
	, deleted_at 	DATETIME 							DEFAULT NULL 
 	-- CONSTRAINT 키워드로 이름을 별도로 지정 
	, CONSTRAINT uk_users_email UNIQUE (email) 
);

-- 게시글 테이블 
-- PK, 제목, 본문, 이미지, 작성자, 작성일, 수정일, 삭제일 
CREATE TABLE posts (
	  id 				BIGINT 			PRIMARY KEY		AUTO_INCREMENT	
	, user_id 		BIGINT 			NOT NULL 
	, title 			VARCHAR(100) 	NOT NULL 
	, content 		VARCHAR(500) 	
	, image 			VARCHAR(100)	NOT NULL 
	, deactived_at DATE 									DEFAULT NULL 
	, created_at 	DATETIME 		NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 
	, updated_at 	DATETIME 		NOT NULL 		DEFAULT CURRENT_TIMESTAMP() 
	, deleted_at 	DATETIME 							DEFAULT NULL 
-- 	, CONSTRAINT fk_posts_users_id FOREIGN KEY (user_id) REFERENCES users(id)
);

-- -----------
-- 테이블 수정 
-- -----------
-- 컬럼 추가 
ALTER TABLE users 
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\' 양식' 
DEFAULT (LPAD(MONTH(users.birth), 2, '0')) AFTER birth 
; 

-- 컬럼 수정 
ALTER TABLE users 
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\' 양식' ;

-- 컬럼 삭제 
ALTER TABLE users 
DROP COLUMN birth_month;

-- 제약조건 (CONSTRAINT) 추가
-- posts 테이블에 fk 제약 조건 추가 
ALTER TABLE posts
ADD CONSTRAINT fk_posts_users_id 
FOREIGN KEY (user_id) REFERENCES users(id);

-- 제약 조건 (CONSTRAINT) 제거
ALTER TABLE posts 
DROP CONSTRAINT fk_posts_users_id;

ALTER TABLE posts 
DROP INDEX fk_posts_users_id;

-- ----------------------
-- AUTO_INCREMENT 값 변경 
-- ----------------------
ALTER TABLE users AUTO_INCREMENT = 1; 

-- -----------
-- TRUNCATE 문 : 테이블의 모든 데이터를 깨끗하게 제거하는 문
-- -----------
TRUNCATE TABLE users; 

-- -----------
-- 테이블 삭제 
-- -----------
DROP TABLE posts, users;
