-- --------------------------------------------------------
-- 호스트:                          3.34.244.19
-- 서버 버전:                        11.4.2-MariaDB-ubu2004 - mariadb.org binary distribution
-- 서버 OS:                        debian-linux-gnu
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- FoodBee 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `FoodBee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `FoodBee`;

-- 테이블 FoodBee.approval_sign 구조 내보내기
CREATE TABLE IF NOT EXISTS `approval_sign` (
  `emp_no` int(11) NOT NULL,
  `approval_sign_file` varchar(200) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`emp_no`),
  CONSTRAINT `FK_emp_TO_approval_sign_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.attendance 구조 내보내기
CREATE TABLE IF NOT EXISTS `attendance` (
  `date` date NOT NULL,
  `emp_no` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `update_start_time` datetime DEFAULT NULL,
  `update_end_time` datetime DEFAULT NULL,
  `update_reason` varchar(3000) DEFAULT NULL,
  `final_time` datetime DEFAULT NULL,
  `approval_state` varchar(1) NOT NULL,
  `approval_datetime` datetime DEFAULT NULL,
  `approval_reason` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`date`,`emp_no`),
  KEY `FK_emp_TO_attendance_1` (`emp_no`),
  CONSTRAINT `FK_emp_TO_attendance_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.authority 구조 내보내기
CREATE TABLE IF NOT EXISTS `authority` (
  `authority_code` varchar(5) NOT NULL,
  `acess_page` varchar(100) NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`authority_code`,`acess_page`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `board_no` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `board_category` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `view` int(11) NOT NULL DEFAULT 0,
  `content` varchar(3000) NOT NULL,
  `board_pw` varchar(100) NOT NULL,
  `like_cnt` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`board_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.board_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_comment` (
  `comment_no` int(11) NOT NULL AUTO_INCREMENT,
  `board_no` int(11) NOT NULL,
  `content` varchar(3000) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `comment_pw` varchar(100) NOT NULL,
  PRIMARY KEY (`comment_no`,`board_no`),
  KEY `FK_board_TO_board_comment_1` (`board_no`),
  CONSTRAINT `FK_board_TO_board_comment_1` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.bunsiness_trip_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `bunsiness_trip_history` (
  `business_trip_no` int(11) NOT NULL AUTO_INCREMENT,
  `emp_no` int(11) NOT NULL,
  `business_trip_destination` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `cancle_YN` varchar(1) NOT NULL DEFAULT 'N',
  `cancle_reason` varchar(3000) DEFAULT NULL,
  `emergency_contact` varchar(100) NOT NULL,
  `draft_doc_no` int(11) NOT NULL,
  PRIMARY KEY (`business_trip_no`),
  KEY `FK_emp_TO_bunsiness_trip_history_1` (`emp_no`),
  KEY `FK_draft_doc_TO_bunsiness_trip_history_1` (`draft_doc_no`),
  CONSTRAINT `FK_draft_doc_TO_bunsiness_trip_history_1` FOREIGN KEY (`draft_doc_no`) REFERENCES `draft_doc` (`draft_doc_no`),
  CONSTRAINT `FK_emp_TO_bunsiness_trip_history_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.day_off_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `day_off_history` (
  `day_off_no` int(11) NOT NULL AUTO_INCREMENT,
  `emp_no` int(11) NOT NULL,
  `draft_doc_no` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `cancel_YN` varchar(1) NOT NULL DEFAULT 'N',
  `cancel_reason` varchar(3000) DEFAULT NULL,
  `use_year` varchar(4) NOT NULL,
  `emergency_contact` varchar(100) NOT NULL,
  PRIMARY KEY (`day_off_no`),
  KEY `FK_emp_TO_day_off_history_1` (`emp_no`),
  KEY `FK_draft_doc_TO_day_off_history_1` (`draft_doc_no`),
  CONSTRAINT `FK_draft_doc_TO_day_off_history_1` FOREIGN KEY (`draft_doc_no`) REFERENCES `draft_doc` (`draft_doc_no`),
  CONSTRAINT `FK_emp_TO_day_off_history_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.doc_referrer 구조 내보내기
CREATE TABLE IF NOT EXISTS `doc_referrer` (
  `referrer_emp_no` int(11) NOT NULL,
  `draft_doc_no` int(11) NOT NULL,
  PRIMARY KEY (`referrer_emp_no`,`draft_doc_no`),
  KEY `FK_draft_doc_TO_doc_referrer_1` (`draft_doc_no`),
  CONSTRAINT `FK_doc_referrer_emp` FOREIGN KEY (`referrer_emp_no`) REFERENCES `emp` (`emp_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_draft_doc_TO_doc_referrer_1` FOREIGN KEY (`draft_doc_no`) REFERENCES `draft_doc` (`draft_doc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.doc_tmp 구조 내보내기
CREATE TABLE IF NOT EXISTS `doc_tmp` (
  `tmp_no` int(11) NOT NULL AUTO_INCREMENT,
  `tmp_name` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `use_YN` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`tmp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.draft_doc 구조 내보내기
CREATE TABLE IF NOT EXISTS `draft_doc` (
  `draft_doc_no` int(11) NOT NULL AUTO_INCREMENT,
  `drafter_emp_no` int(11) NOT NULL,
  `create_datetime` datetime NOT NULL,
  `title` varchar(300) NOT NULL,
  `content` varchar(3000) NOT NULL,
  `mid_approver_no` int(11) NOT NULL,
  `mid_approval_state` varchar(1) NOT NULL,
  `mid_approval_datetime` datetime DEFAULT NULL,
  `final_approver_no` int(11) NOT NULL,
  `final_approval_state` varchar(1) NOT NULL,
  `final_approval_datetime` datetime DEFAULT NULL,
  `mid_approver_reason` varchar(3000) DEFAULT NULL,
  `final_approver_reason` varchar(3000) DEFAULT NULL,
  `doc_approver_state_no` varchar(1) NOT NULL,
  `tmp_no` int(11) NOT NULL,
  PRIMARY KEY (`draft_doc_no`),
  KEY `FK_emp_TO_draft_doc_1` (`drafter_emp_no`),
  KEY `FK_doc_tmp_TO_draft_doc_1` (`tmp_no`),
  CONSTRAINT `FK_doc_tmp_TO_draft_doc_1` FOREIGN KEY (`tmp_no`) REFERENCES `doc_tmp` (`tmp_no`),
  CONSTRAINT `FK_emp_TO_draft_doc_1` FOREIGN KEY (`drafter_emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.draft_doc_detail 구조 내보내기
CREATE TABLE IF NOT EXISTS `draft_doc_detail` (
  `draft_doc_order` int(11) NOT NULL,
  `draft_doc_no` int(11) NOT NULL,
  `state_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `text` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`draft_doc_order`,`draft_doc_no`),
  KEY `FK_draft_doc_TO_draft_doc_detail_1` (`draft_doc_no`),
  CONSTRAINT `FK_draft_doc_TO_draft_doc_detail_1` FOREIGN KEY (`draft_doc_no`) REFERENCES `draft_doc` (`draft_doc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.draft_doc_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `draft_doc_file` (
  `draft_doc_file_no` int(11) NOT NULL AUTO_INCREMENT,
  `original_file` varchar(200) NOT NULL,
  `save_file` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `draft_doc_no` int(11) NOT NULL,
  PRIMARY KEY (`draft_doc_file_no`),
  KEY `FK_draft_doc_TO_draft_doc_file_1` (`draft_doc_no`),
  CONSTRAINT `FK_draft_doc_TO_draft_doc_file_1` FOREIGN KEY (`draft_doc_no`) REFERENCES `draft_doc` (`draft_doc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.emp 구조 내보내기
CREATE TABLE IF NOT EXISTS `emp` (
  `emp_no` int(11) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `ext_no` varchar(100) DEFAULT NULL,
  `emp_email` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post_no` varchar(10) DEFAULT NULL,
  `emp_pw` varchar(100) DEFAULT NULL,
  `error_cnt` int(11) unsigned zerofill DEFAULT NULL,
  `pw_update_datetime` date DEFAULT NULL,
  `signup_YN` varchar(1) NOT NULL DEFAULT 'N',
  `signup_date` date DEFAULT NULL,
  `emp_state` varchar(1) NOT NULL,
  `end_date` date DEFAULT NULL,
  `rank_name` varchar(50) NOT NULL,
  `dpt_no` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`emp_no`),
  KEY `FK_rank_authority_TO_emp_1` (`rank_name`),
  KEY `FK_group_TO_emp_1` (`dpt_no`),
  CONSTRAINT `FK_group_TO_emp_1` FOREIGN KEY (`dpt_no`) REFERENCES `group` (`dpt_no`),
  CONSTRAINT `FK_rank_authority_TO_emp_1` FOREIGN KEY (`rank_name`) REFERENCES `rank` (`rank_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.group 구조 내보내기
CREATE TABLE IF NOT EXISTS `group` (
  `dpt_no` varchar(4) NOT NULL,
  `dpt_name` varchar(50) NOT NULL,
  `superior_dpt_no` varchar(50) DEFAULT NULL,
  `dpt_start_year` varchar(4) NOT NULL,
  `dpt_end_year` varchar(4) NOT NULL,
  `authority_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`dpt_no`),
  KEY `FK_group_authority` (`authority_code`) USING BTREE,
  CONSTRAINT `FK_group_authority` FOREIGN KEY (`authority_code`) REFERENCES `authority` (`authority_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.msg 구조 내보내기
CREATE TABLE IF NOT EXISTS `msg` (
  `msg_no` int(11) NOT NULL AUTO_INCREMENT,
  `sender_emp_no` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `content` varchar(3000) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `msg_state` varchar(1) NOT NULL,
  PRIMARY KEY (`msg_no`),
  KEY `FK_emp_TO_msg_1` (`sender_emp_no`),
  CONSTRAINT `FK_emp_TO_msg_1` FOREIGN KEY (`sender_emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.msg_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `msg_file` (
  `msg_file_no` int(11) NOT NULL AUTO_INCREMENT,
  `msg_no` int(11) NOT NULL,
  `original_file` varchar(200) NOT NULL,
  `save_file` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`msg_file_no`),
  KEY `FK_msg_TO_msg_file_1` (`msg_no`),
  CONSTRAINT `FK_msg_TO_msg_file_1` FOREIGN KEY (`msg_no`) REFERENCES `msg` (`msg_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.msg_repicient 구조 내보내기
CREATE TABLE IF NOT EXISTS `msg_repicient` (
  `repicient_order` int(11) NOT NULL,
  `msg_no` int(11) NOT NULL,
  `repicient_emp_no` int(11) NOT NULL,
  `read_YN` varchar(1) NOT NULL DEFAULT 'N',
  `read_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`repicient_order`,`msg_no`),
  KEY `FK_msg_TO_msg_repicient_1` (`msg_no`),
  KEY `FK_emp_TO_msg_repicient_1` (`repicient_emp_no`),
  CONSTRAINT `FK_emp_TO_msg_repicient_1` FOREIGN KEY (`repicient_emp_no`) REFERENCES `emp` (`emp_no`),
  CONSTRAINT `FK_msg_TO_msg_repicient_1` FOREIGN KEY (`msg_no`) REFERENCES `msg` (`msg_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.notice 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice` (
  `notice_no` int(11) NOT NULL AUTO_INCREMENT,
  `writer_emp_no` int(11) NOT NULL,
  `dpt_no` varchar(4) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `content` varchar(3000) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`notice_no`),
  KEY `FK_emp_TO_notice_1` (`writer_emp_no`),
  KEY `FK_group_TO_notice_1` (`dpt_no`),
  CONSTRAINT `FK_emp_TO_notice_1` FOREIGN KEY (`writer_emp_no`) REFERENCES `emp` (`emp_no`),
  CONSTRAINT `FK_group_TO_notice_1` FOREIGN KEY (`dpt_no`) REFERENCES `group` (`dpt_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.notice_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice_file` (
  `notice_file_no` int(11) NOT NULL AUTO_INCREMENT,
  `notice_no` int(11) NOT NULL,
  `original_file` varchar(200) NOT NULL,
  `save_file` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL,
  `update_datetime` datetime NOT NULL,
  PRIMARY KEY (`notice_file_no`),
  KEY `FK_notice_TO_notice_file_1` (`notice_no`),
  CONSTRAINT `FK_notice_TO_notice_file_1` FOREIGN KEY (`notice_no`) REFERENCES `notice` (`notice_no`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.profile_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `profile_img` (
  `emp_no` int(11) NOT NULL,
  `original_file` varchar(200) NOT NULL,
  `save_file` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`emp_no`),
  CONSTRAINT `FK_emp_TO_profile_img_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.rank 구조 내보내기
CREATE TABLE IF NOT EXISTS `rank` (
  `rank_name` varchar(50) NOT NULL,
  `authority_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`rank_name`),
  KEY `FK_rank_authority` (`authority_code`),
  CONSTRAINT `FK_rank_authority` FOREIGN KEY (`authority_code`) REFERENCES `authority` (`authority_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.revenue_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `revenue_history` (
  `reference_month` date NOT NULL,
  `category_name` varchar(300) NOT NULL,
  `drafter_emp_no` int(11) NOT NULL,
  `draft_doc_no` int(11) NOT NULL,
  `revenue` int(11) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reference_month`,`category_name`,`drafter_emp_no`),
  KEY `FK_emp_TO_revenue_history_1` (`drafter_emp_no`),
  KEY `FK_draft_doc_TO_revenue_history_1` (`draft_doc_no`),
  CONSTRAINT `FK_draft_doc_TO_revenue_history_1` FOREIGN KEY (`draft_doc_no`) REFERENCES `draft_doc` (`draft_doc_no`),
  CONSTRAINT `FK_emp_TO_revenue_history_1` FOREIGN KEY (`drafter_emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.room_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `room_img` (
  `img_order` int(11) NOT NULL,
  `room_no` int(11) NOT NULL,
  `original_file` varchar(200) NOT NULL,
  `save_file` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `use_YN` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`img_order`,`room_no`),
  KEY `FK_room_info_TO_room_img_1` (`room_no`),
  CONSTRAINT `FK_room_info_TO_room_img_1` FOREIGN KEY (`room_no`) REFERENCES `room_info` (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.room_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `room_info` (
  `room_no` int(11) NOT NULL AUTO_INCREMENT,
  `room_name` varchar(50) NOT NULL,
  `room_place` varchar(100) NOT NULL,
  `room_max` int(11) NOT NULL,
  `info` varchar(3000) NOT NULL,
  `use_YN` varchar(1) NOT NULL DEFAULT 'Y',
  `create_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `update_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `caution` varchar(3000) NOT NULL,
  PRIMARY KEY (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.room_rsv 구조 내보내기
CREATE TABLE IF NOT EXISTS `room_rsv` (
  `rsv_no` int(11) NOT NULL AUTO_INCREMENT,
  `room_no` int(11) NOT NULL,
  `emp_no` int(11) NOT NULL,
  `rsv_date` date NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `type` varchar(50) NOT NULL,
  `rsv_state` varchar(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`rsv_no`,`room_no`,`emp_no`),
  KEY `FK_room_info_TO_room_rsv_1` (`room_no`),
  KEY `FK_emp_TO_room_rsv_1` (`emp_no`),
  CONSTRAINT `FK_emp_TO_room_rsv_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`),
  CONSTRAINT `FK_room_info_TO_room_rsv_1` FOREIGN KEY (`room_no`) REFERENCES `room_info` (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.schedule 구조 내보내기
CREATE TABLE IF NOT EXISTS `schedule` (
  `schedule_no` int(11) NOT NULL AUTO_INCREMENT,
  `emp_no` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `content` varchar(3000) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  PRIMARY KEY (`schedule_no`,`emp_no`),
  KEY `FK_emp_TO_schedule_1` (`emp_no`),
  CONSTRAINT `FK_emp_TO_schedule_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.state_classfication 구조 내보내기
CREATE TABLE IF NOT EXISTS `state_classfication` (
  `state_cf_code` varchar(10) NOT NULL,
  `state_cf_name` varchar(50) NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  `use_YN` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`state_cf_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 FoodBee.state_code 구조 내보내기
CREATE TABLE IF NOT EXISTS `state_code` (
  `state_code` varchar(1) NOT NULL,
  `state_cf_code` varchar(10) NOT NULL,
  `state_code_name` varchar(50) NOT NULL,
  `use_YN` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`state_code`,`state_cf_code`),
  KEY `FK_state_classfication_TO_state_code_1` (`state_cf_code`),
  CONSTRAINT `FK_state_classfication_TO_state_code_1` FOREIGN KEY (`state_cf_code`) REFERENCES `state_classfication` (`state_cf_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
