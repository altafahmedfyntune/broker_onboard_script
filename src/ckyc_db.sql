/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint unsigned DEFAULT NULL,
  `causer_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint unsigned DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `batch_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `config_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `config_settings` (`id`, `label`, `key`, `value`, `created_at`, `updated_at`) VALUES
	(3, 'http_logs.log_deletion_delay', 'http_logs.log_deletion_delay', '1', '2023-10-25 10:41:45', '2023-10-25 06:36:52'),
	(4, 'http_logs.is_stored_file_deletion_enabled', 'http_logs.is_stored_file_deletion_enabled', 'true', '2023-10-25 10:41:45', '2023-10-25 10:41:45'),
	(6, 'http_logs.is_file_storing_enabled', 'http_logs.is_file_storing_enabled', 'true', '2023-10-25 10:41:45', '2023-10-26 11:38:32'),
	(7, 'error_message.is_enabled', 'error_message.is_enabled', 'true', '2023-10-25 10:41:45', '2024-01-15 11:38:20'),
	(8, 'error_message.allowed_sections', 'error_message.allowed_sections', 'motor', '2023-10-25 10:41:45', '2023-10-25 10:41:45'),
	(9, 'http_logs.file_storing_sections', 'http_logs.file_storing_sections', 'motor', '2024-02-01 07:26:23', '2024-02-01 07:26:23'),
	(10, 'http_logs.is_file_storing_exceptional_ics', 'http_logs.is_file_storing_exceptional_ics', 'icici_lombard', '2024-02-01 07:26:49', '2024-02-01 07:27:25'),
	(11, 'middleware.request.mandatory.validation', 'middleware.request.mandatory.validation', 'Y', '2024-05-10 12:33:41', '2024-05-10 12:33:41'),
	(13, 'middleware.request.mandatory.sections', 'middleware.request.mandatory.sections', 'motor', '2024-05-14 08:26:35', '2024-05-14 08:26:35');

CREATE TABLE IF NOT EXISTS `error_message_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `section` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_alias` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `match_string` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `replace_string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rule` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_corporate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `error_message_rules` (`id`, `section`, `company_alias`, `type`, `match_string`, `replace_string`, `rule`, `created_at`, `updated_at`, `is_corporate`, `mode`) VALUES
	(10, 'motor', 'reliance_general', 'strContain', 'is not valid and not found in the records', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', NULL, '2024-01-02 08:03:50', 'N', 'other'),
	(12, 'motor', 'reliance_general', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##MODE":"mode","##DOB":"date_of_birth","##VALUE":"value"}', '2023-11-07 10:25:41', '2023-12-04 06:58:59', 'N', 'other'),
	(13, 'motor', 'reliance_general', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:28:16', '2023-11-30 08:03:27', 'Y', 'other'),
	(14, 'motor', 'reliance_general', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:29:33', '2023-12-04 06:59:58', 'Y', 'other'),
	(15, 'motor', 'icici_lombard', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Try other method to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:30:52', '2023-12-05 08:16:01', 'N', 'other'),
	(16, 'motor', 'icici_lombard', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:32:00', '2023-12-04 07:03:40', 'N', 'other'),
	(17, 'motor', 'universal_sompo', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:50:09', '2023-12-04 07:04:04', 'N', 'other'),
	(18, 'motor', 'universal_sompo', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC.', '{"##MODE":"mode","##DOB":"date_of_birth","##VALUE":"value"}', '2023-11-07 10:51:22', '2023-12-05 08:16:50', 'N', 'other'),
	(19, 'motor', 'cholla_mandalam', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC.', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-07 10:53:05', '2023-12-05 08:17:23', 'N', 'other'),
	(20, 'motor', 'cholla_mandalam', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:54:26', '2023-12-04 07:05:49', 'N', 'other'),
	(21, 'motor', 'magma', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:55:23', '2023-12-04 07:06:24', 'N', 'other'),
	(22, 'motor', 'magma', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Try using other ids to complete your KYC.', '{"##DOB":"date_of_birth","##VALUE":"value","##MODE":"mode"}', '2023-11-07 10:56:33', '2023-12-05 08:17:45', 'N', 'other'),
	(23, 'motor', 'liberty_general', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:57:52', '2023-12-05 08:18:03', 'N', 'other'),
	(24, 'motor', 'liberty_general', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:58:48', '2023-12-04 07:08:02', 'N', 'other'),
	(25, 'motor', 'future_generali', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 10:59:47', '2023-12-04 07:08:25', 'N', 'other'),
	(26, 'motor', 'future_generali', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC.', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-07 11:00:56', '2023-12-05 08:18:24', 'N', 'other'),
	(27, 'motor', 'universal_sompo', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 11:49:45', '2023-11-28 06:57:46', 'Y', 'other'),
	(28, 'motor', 'universal_sompo', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-07 11:51:54', '2023-12-04 07:09:18', 'Y', 'other'),
	(29, 'motor', 'liberty_general', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-07 12:00:56', '2023-11-28 06:56:55', 'Y', 'other'),
	(30, 'motor', 'liberty_general', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:02:35', '2023-12-04 07:09:41', 'Y', 'other'),
	(31, 'motor', 'cholla_mandalam', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:04:36', '2023-11-28 06:56:12', 'Y', 'other'),
	(32, 'motor', 'cholla_mandalam', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:06:18', '2023-12-04 07:10:08', 'Y', 'other'),
	(33, 'motor', 'icici_lombard', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:16:00', '2023-11-28 06:55:36', 'Y', 'other'),
	(34, 'motor', 'icici_lombard', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:18:27', '2023-12-04 07:10:28', 'Y', 'other'),
	(35, 'motor', 'magma', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-07 12:32:11', '2023-11-28 06:54:29', 'Y', 'other'),
	(36, 'motor', 'magma', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:33:47', '2023-12-04 07:11:02', 'Y', 'other'),
	(37, 'motor', 'future_generali', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##VALUE":"value","##MODE":"mode"}', '2023-11-07 12:36:58', '2023-11-28 07:50:45', 'Y', 'other'),
	(38, 'motor', 'future_generali', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-07 12:38:41', '2023-12-04 07:11:26', 'Y', 'other'),
	(39, 'motor', 'royal_sundaram', 'strContain', 'CKYC verification failed. Redirection link found', '##MODE - ##VALUE is not valid or not found in the records.<break>If the entered ##MODE is correct please click on Redirect for verification to complete your KYC.', '{"##MODE":"mode","##VALUE":"value"}', '2023-11-07 13:15:36', '2023-12-04 07:12:00', 'N', 'other'),
	(40, 'motor', 'royal_sundaram', 'strContain', 'CKYC verification failed. Redirection link found', '##MODE - ##VALUE is not valid or not found in the records.<break>Please enter a valid ##MODE.', '{"##MODE":"mode","##VALUE":"value"}', '2023-11-08 07:54:13', '2023-12-04 07:12:22', 'Y', 'other'),
	(41, 'motor', 'hdfc_ergo', 'strContain', 'CKYC verification failed. Redirection link found', '##MODE - ##VALUE is not valid or not found in the records.<break>If the entered ##MODE is correct please click on Redirect for Verification to complete your KYC.', '{"##MODE":"mode","##VALUE":"value"}', '2023-11-08 07:59:04', '2023-12-04 07:13:23', 'N', 'other'),
	(44, 'motor', 'iffco_tokio', 'strContain', 'No Record', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Try other method to complete your KYC.', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-08 08:26:57', '2023-12-05 08:19:56', 'N', 'other'),
	(45, 'motor', 'iffco_tokio', 'strContain', 'No Record', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB<break>If the entered details are correct please click on Try other method to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-08 08:34:31', '2023-12-04 12:41:49', 'Y', 'other'),
	(47, 'motor', 'edelweiss', 'strContain', 'CKYC Not verified / Record not found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC.', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-08 10:35:58', '2023-12-05 05:46:08', 'N', 'other'),
	(48, 'motor', 'edelweiss', 'strContain', 'Record not found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-08 10:50:59', '2023-11-28 06:12:12', 'Y', 'other'),
	(49, 'motor', 'sbi_general', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-08 13:17:16', '2023-12-04 07:14:46', 'N', 'other'),
	(50, 'motor', 'sbi_general', 'strContain', 'No record', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Birth: ##DOB', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-08 13:28:39', '2023-11-08 13:29:42', 'N', 'other'),
	(51, 'motor', 'sbi_general', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##VALUE":"value","##MODE":"mode"}', '2023-11-08 13:42:27', '2023-11-08 13:42:27', 'Y', 'other'),
	(52, 'motor', 'edelweiss', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-16 11:50:22', '2023-12-04 07:15:17', 'Y', 'other'),
	(61, 'motor', 'royal_sundaram', 'strContain', 'CKYC verification failed. Redirection link found', '##MODE - ##VALUE is not valid or not found in the records.<break><Please enter a valid ##MODE.', '{"##MODE":"mode","##VALUE":"value"}', '2023-11-24 10:44:44', '2023-12-04 07:15:40', 'Y', 'ckyc'),
	(62, 'motor', 'royal_sundaram', 'strContain', 'CKYC verification failed. Redirection link found', '##MODE - ##VALUE is not valid or not found in the records.<break>If the entered ##MODE is correct please click on Redirect for verification to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-24 12:19:30', '2023-12-04 07:16:11', 'N', 'ckyc'),
	(63, 'motor', 'cholla_mandalam', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please click on Redirect for verification to complete your KYC.', '{"##DOB":"date_of_birth","##VALUE":"value","##MODE":"mode"}', '2023-11-27 06:46:07', '2023-12-05 08:21:12', 'N', 'ckyc'),
	(65, 'motor', 'cholla_mandalam', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-27 07:48:36', '2023-11-28 10:22:43', 'Y', 'ckyc'),
	(66, 'motor', 'common', 'strContain', 'Date of birth', 'The entered Date of Birth (##DOB) does not match with the ##MODE - ##VALUE.<break>Please click on Edit Details and enter the correct Date of Birth.', '{"##DOB":"date_of_birth","##VALUE":"value","##MODE":"mode"}', '2023-11-27 08:05:52', '2023-12-04 07:27:00', 'N', 'ckyc'),
	(71, 'motor', 'hdfc_ergo', 'strContain', 'CKYC verification failed. Redirection link found', '##MODE - ##VALUE is not valid or not found in the records.<break>If the entered ##MODE is correct please Try using a different ID to complete your KYC.', '{"##MODE":"mode","##VALUE":"value"}', '2023-11-27 10:30:34', '2023-12-04 07:27:24', 'N', 'ckyc'),
	(72, 'motor', 'common', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please Try using other ID to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-27 10:38:16', '2023-12-05 08:21:50', 'N', 'ckyc'),
	(74, 'motor', 'edelweiss', 'strContain', 'Record not found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-28 05:54:40', '2023-11-28 06:06:33', 'Y', 'ckyc'),
	(77, 'motor', 'common', 'strContain', 'No record found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB<break>If the entered details are correct please Try using a different ID to complete your KYC.', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-11-28 07:36:42', '2023-12-04 07:28:36', 'Y', 'ckyc'),
	(78, 'motor', 'common', 'strContain', 'Date of birth', 'The entered Date of Incorporation (##DOB) does not match with the ##MODE - ##VALUE.<break>Please enter the correct Date of Incorporation.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-28 07:41:15', '2023-12-04 07:29:03', 'Y', 'ckyc'),
	(79, 'motor', 'iffco_tokio', 'strContain', 'No Record', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB<break>If the entered details are correct please Try using other ID to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-28 07:58:59', '2023-12-04 12:36:07', 'Y', 'ckyc'),
	(80, 'motor', 'edelweiss', 'strContain', 'CKYC Not verified / Record not found', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Birth: ##DOB<break>If the entered details are correct please Try using a different ID to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-28 11:57:25', '2023-12-05 05:42:57', 'N', 'ckyc'),
	(81, 'motor', 'icici_lombard', 'strContain', 'No record found, please retry with alternate KYC options.', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please Try using other ID to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-28 12:01:52', '2023-12-05 08:22:24', 'N', 'ckyc'),
	(82, 'motor', 'universal_sompo', 'strContain', 'Invalid GSTIN pattern', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-30 13:29:40', '2023-11-30 13:29:40', 'Y', 'other'),
	(83, 'motor', 'universal_sompo', 'strContain', 'Entered CIN/LLPIN/FLLPIN/FCRN is not found. Please enter valid details.', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-11-30 13:54:49', '2023-11-30 13:54:49', 'Y', 'other'),
	(85, 'motor', 'iffco_tokio', 'strContain', 'No Record', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of birth: ##DOB<break>If the entered details are correct please Try using other ID to complete your KYC.', '{"##DOB":"date_of_birth","##MODE":"mode","##VALUE":"value"}', '2023-12-04 12:21:34', '2023-12-05 08:23:28', 'N', 'ckyc'),
	(87, 'motor', 'universal_sompo', 'strContain', 'Entered CIN/LLPIN/FLLPIN/FCRN is not found. Please enter valid details.', 'CKYC verification failed. Please check the following details.<break>1. ##MODE: ##VALUE<break>2. Date of Incorporation: ##DOB', '{"##MODE":"mode","##VALUE":"value","##DOB":"date_of_birth"}', '2023-12-12 11:40:05', '2023-12-12 11:40:05', 'Y', 'other'),
	(88, 'motor', 'reliance_general', 'strContain', 'Impermissible values entered in PAN Number', 'The entered #MODE - #VALUE.<break>Please enter the valid #MODE', '{"##MODE":"mode","##VALUE":"value"}', '2023-12-16 06:57:08', '2023-12-16 06:57:08', 'N', 'other'),
	(90, 'motor', 'hdfc_ergo', 'strContain', 'No data found for txn_id', 'CKYC verification failed, please try using a different ID.', '{"":null}', '2024-01-02 10:39:30', '2024-01-02 10:39:30', 'Y', 'other');

CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `http_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint unsigned NOT NULL,
  `section` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trace_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `request_headers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `response_headers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status_code` smallint NOT NULL,
  `response_time` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `kyc_verification_statuses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tenant_id` int NOT NULL,
  `company_alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trace_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ckyc_reference_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ckyc_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extras` json DEFAULT NULL,
  `ic_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'journey',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2018_08_08_100000_create_telescope_entries_table', 1),
	(4, '2019_08_19_000000_create_failed_jobs_table', 1),
	(5, '2022_12_07_084331_create_http_logs_table', 1),
	(6, '2022_12_07_101538_create_tenants_table', 1),
	(7, '2022_12_07_102048_create_tenant_credentials_table', 1),
	(8, '2022_12_14_104604_create_kyc_verification_statuses_table', 1),
	(9, '2022_12_15_082652_add_column_ic_response_in_kyc_verification_statuses_table', 1),
	(10, '2022_12_15_104436_add_column_frontend_domains_in_tenants_table', 1),
	(11, '2022_12_22_084437_add_company_alias_to_tenant_credentials_table', 2),
	(12, '2022_12_27_094451_add_column_is_proxy_in_tenants_table', 3),
	(13, '2022_12_29_161005_add_headers_column_to_http_logs_table', 4),
	(14, '2023_01_01_062811_create_sessions_table', 4),
	(15, '2023_01_06_094536_create_redirection_responses_table', 5),
	(16, '2023_01_06_112653_add_column_section_in_redirection_responses_table', 6),
	(17, '2023_01_13_113052_add_company_alias_to_http_logs_table', 7),
	(18, '2023_01_19_162735_add_col_kyc_verification_status', 8),
	(19, '2023_01_19_181426_add_trace_id_column_to_kyc_verification_statuses', 9),
	(20, '2023_01_20_105653_change_default_value_for_trace_id_column_in_kyc_verification_statuses_table', 10),
	(21, '2023_02_27_181009_set_default_value_to_columns_in_kyc_verificarion_statuses_table', 11),
	(22, '2023_05_29_184219_change_data_type_of_url_column_in_http_logs', 12),
	(23, '2023_10_20_163608_create_config_settings_table', 12),
	(24, '2023_11_04_164749_create_error_message_rules_table', 13),
	(25, '2023_11_07_151446_alter_table_error_message_rules_add_column_is_corporate', 14),
	(26, '2023_11_22_204605_alter_only_for_ckyc_mode_to_error_message_rules', 15),
	(27, '2023_12_01_185238_alter_table_error_message_rules_change_column_replace_string_and_rule', 16),
	(28, '2024_04_25_115030_add_column_section_in_redirection_response', 17),
	(29, '2024_04_25_132735_add_data_type_section_in_redirection_responses', 18),
	(30, '2024_04_06_111324_create_jobs_table', 19),
	(31, '2024_04_06_115234_updated_redirection_response_clumn', 19),
	(32, '2024_04_06_120421_update_http_logs_column', 19);

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `redirection_responses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tenant_id` int DEFAULT NULL,
  `section` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trace_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `response` longtext COLLATE utf8mb4_unicode_ci,
  `response1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=915 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sbi_pincode_master` (
  `id` bigint unsigned NOT NULL,
  `PinCode` int NOT NULL,
  `locality_suburban_taluka_tehesil_name` varchar(200) NOT NULL,
  `state_code` int unsigned NOT NULL,
  `district_code` int unsigned NOT NULL,
  `city_code` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `telescope_entries` (
  `sequence` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `family_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `should_display_on_index` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`sequence`),
  UNIQUE KEY `telescope_entries_uuid_unique` (`uuid`),
  KEY `telescope_entries_batch_id_index` (`batch_id`),
  KEY `telescope_entries_family_hash_index` (`family_hash`),
  KEY `telescope_entries_created_at_index` (`created_at`),
  KEY `telescope_entries_type_should_display_on_index_index` (`type`,`should_display_on_index`)
) ENGINE=InnoDB AUTO_INCREMENT=68421 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `telescope_entries_tags` (
  `entry_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `telescope_entries_tags_entry_uuid_tag_index` (`entry_uuid`,`tag`),
  KEY `telescope_entries_tags_tag_index` (`tag`),
  CONSTRAINT `telescope_entries_tags_entry_uuid_foreign` FOREIGN KEY (`entry_uuid`) REFERENCES `telescope_entries` (`uuid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `telescope_monitoring` (
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `tenants` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `proxy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frontend_domains` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `tenants` (`id`, `name`, `alias`, `domain`, `proxy`, `frontend_domains`, `created_at`, `updated_at`) VALUES
	(1, 'Renewbuy ', 'renew_buy', 'uatckyc-api.rbstaging.in', '10.2.0.60:8080', '{"motor": "https://apiuatmotor.rbstaging.in/", "health": "https://uatapihealth.renewbuyinsurance.in/"}', NULL, NULL),
	(8, 'Renewbuy ', 'renew_buy', 'uatckyc-api.renewbuyinsurance.in', '10.2.0.60:8080', '{"motor": "https://apiuatmotor.rbstaging.in/", "health": "https://uatapihealth.renewbuyinsurance.in/"}', NULL, NULL);

CREATE TABLE IF NOT EXISTS `tenant_credentials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint unsigned NOT NULL,
  `company_alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `section` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `tenant_credentials` (`id`, `tenant_id`, `company_alias`, `code`, `value`, `section`, `created_at`, `updated_at`) VALUES
	(1, 8, 'max_bupa', 'username', 'Renewbuy', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(2, 8, 'max_bupa', 'password', 'Re@xbup@12#', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(3, 8, 'reliance_general', 'Subscription-Key', '9338b32e0ed447b68b257ccdc6cfb0bb', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(4, 8, 'liberty_general', 'Aggregator_Program_Name', 'RenewBuy', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(5, 8, 'icici_lombard', 'client_id', 'ro.renewBuy', 'health', '2022-12-22 18:13:45', '2022-12-22 18:13:46'),
	(6, 8, 'icici_lombard', 'client_secret', 'ro.r3n3w&u4', 'health', '2022-12-22 18:14:21', '2022-12-22 18:14:22'),
	(7, 8, 'icici_lombard', 'username', 'renewBuy', 'health', '2022-12-22 18:14:43', '2022-12-22 18:14:44'),
	(8, 8, 'icici_lombard', 'password', 'r3n3w&u4', 'health', '2022-12-22 18:15:07', '2022-12-22 18:15:08'),
	(9, 8, 'icici_lombard', 'public_key', 'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGEw6ySaxYBYUBf00h+w6w79MICj7l3fQmTgPjlEb5B825AStpnn1FhmRnFB2E6rHDD2gnLaGSTb9GK9bikJ6jcM4F4J61Or1DYBf21elsm4J3En9FUh/q81Xfbo22snb8fnEE+b+78p1+trESIl4r3yvF1SN5tU6zf+cfzv7jMvAgMBAAE=', 'health', '2022-12-22 18:16:06', '2022-12-22 18:16:07'),
	(10, 8, 'star', 'api_key', '7f358502df5b45d3921c4335bdfc7250', 'health', '2022-12-22 18:44:42', '2022-12-22 18:44:43'),
	(11, 8, 'star', 'secret_key', '0aba36a48b614f1e814494395c94d403', 'health', '2022-12-22 18:45:07', '2022-12-22 18:45:08'),
	(12, 8, 'max_bupa', 'PartnerName', 'Renewbuy', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(14, 8, 'bajaj_allianz', 'Bajaj_Allianz_Health_User_Id', 'webservice@d2cinsurance.com', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(15, 8, 'bajaj_allianz', 'Bajaj_Allianz_IMDcode', '10068847', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(16, 8, 'edelweiss', 'VISoF_Program_Name', 'RenewBuy', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(17, 8, 'edelweiss', 'X-Api-Key', 'vmX0qzSwUy5i4dyKa0MhuaQhQ6PECsp3FqZvwRX8', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(18, 8, 'edelweiss', 'auth_username', '2r9a4a9lpvj2lp5bqbo0jhcp0l', 'motor', '2022-12-24 05:02:50', '2022-12-24 05:02:51'),
	(19, 8, 'edelweiss', 'auth_password', '1q0fbp68juvm8f221f9ckh9j7i3ktq2hkibfk88q460pvccsfmqs', 'motor', '2022-12-24 05:02:50', '2022-12-24 05:02:51'),
	(20, 8, 'hdfc_ergo', 'api_key', '0452835c-b0ca-45', 'motor', '2022-12-24 03:21:59', '2024-02-06 12:10:22'),
	(21, 8, 'iffco_tokio', 'Iffco_Tokio_User_Name_Motor', 'ITGIMOT104', 'motor', NULL, NULL),
	(22, 8, 'iffco_tokio', 'Iffco_Tokio_Password_Motor', 'partner@2020', 'motor', NULL, NULL),
	(23, 8, 'hdfc_ergo', 'api_key', '8d399be8-0b6f-4a', 'health', '2022-12-26 07:15:28', '2022-12-26 07:15:30'),
	(24, 8, 'care_health', 'appId', '84444', 'health', '2022-12-26 07:15:28', '2022-12-26 07:15:30'),
	(25, 8, 'care_health', 'signature', 'ABBC1+zWgDlKfsrG5tMQH1Z+8NrJTRPh/L00piFiu7k=', 'health', '2022-12-26 07:15:28', '2022-12-26 07:15:30'),
	(26, 8, 'care_health', 'timestamp', '1678794156147', 'health', '2022-12-26 07:15:28', '2022-12-26 07:15:30'),
	(27, 8, 'care_health', 'applicationCD', 'PARTNERAPP', 'health', '2022-12-26 07:15:28', '2022-12-26 07:15:30'),
	(28, 8, 'care_health', 'securityKey', 'dkpBQ0Q3cGVGb1NXVnNsWW1EaERWb0ErQVFyTGFhSytNZCtrVzdzRGtrOW1DWktaTDdwWHRWdVZoYnpyV1JseA==', 'health', '2022-12-26 07:15:28', '2022-12-26 07:15:30'),
	(29, 8, 'max_bupa', 'Max_bupa_Folder_path', 'TPD_KYC_Doc_UAT', 'health', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(30, 8, 'liberty_general', 'Aggregator_Program_Name', 'RenewBuy', 'motor', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(31, 8, 'cholla_mandalam', 'TOKEN_PRIVATE_KEY', 'Uk5FV0BDS1lDVWF0', 'motor', NULL, '2024-04-26 11:58:18'),
	(32, 8, 'cholla_mandalam', 'TOKEN_USER_ID', '', 'motor', NULL, NULL),
	(33, 8, 'sbi_general', 'clientid', '79de4de3-d258-43b8-a89a-f42924dddb46', 'health', '2022-12-26 17:19:24', '2022-12-26 17:19:25'),
	(34, 8, 'sbi_general', 'secretkey', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'health', '2022-12-26 17:20:27', '2022-12-26 17:20:27'),
	(35, 8, 'sbi_general', 'clientid', '79de4de3-d258-43b8-a89a-f42924dddb46', 'motor', '2022-12-23 16:36:20', '2022-12-23 16:36:20'),
	(36, 8, 'sbi_general', 'secretkey', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'motor', '2022-12-23 16:40:41', '2022-12-23 16:40:42'),
	(37, 8, 'reliance_general', 'Subscription-Key', '34bbeae1712146728471f0ae0779ffc9', 'motor', '2022-12-22 14:18:45', '2024-04-18 10:09:08'),
	(38, 8, 'universal_sompo', 'userid', 'usgi_ckyc_user', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(39, 8, 'universal_sompo', 'password', 'Usgi!@2022', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(40, 8, 'universal_sompo', 'userid', 'usgi_ckyc_user', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(41, 8, 'universal_sompo', 'password', 'Usgi!@2022', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(42, 8, 'liberty_general', 'Aggregator_Program_Name_POS', 'RenewBuy', 'motor', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(43, 8, 'universal_sompo', 'WebAgg', 'WebAgg', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(44, 8, 'universal_sompo', 'WebAgg', 'WebAgg', 'health', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(45, 8, 'bajaj_allianz', 'Bajaj_Allianz_BusinessCorelationId', '36c18e93-ac17-4990-8451-e1929f42ea88', 'motor', NULL, NULL),
	(46, 8, 'max_bupa', 'MAX_BUPA_STFP_HOST', '1.6.8.22', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(47, 8, 'max_bupa', 'MAX_BUPA_STFP_USERNAME', 'Renewbuy_UAT', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(48, 8, 'max_bupa', 'MAX_BUPA_STFP_PASSWORD', 'EnDnAehFKLxH@#2022', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(49, 8, 'max_bupa', 'MAX_BUPA_STFP_PORT', '2746', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(50, 8, 'icici_lombard', 'client_id', 'ro.renewBuy', 'motor', '2022-12-01 05:56:03', '2022-12-01 05:56:03'),
	(51, 8, 'icici_lombard', 'client_secret', 'ro.r3n3w&u4', 'motor', '2022-12-01 05:56:03', '2022-12-01 05:56:03'),
	(52, 8, 'icici_lombard', 'username', 'renewBuy', 'motor', '2022-12-01 05:56:03', '2022-12-01 05:56:03'),
	(53, 8, 'icici_lombard', 'password', 'r3n3w&u4', 'motor', '2022-12-01 05:56:03', '2022-12-01 05:56:03'),
	(54, 8, 'icici_lombard', 'encryption_key', 'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGEw6ySaxYBYUBf00h+w6w79MICj7l3fQmTgPjlEb5B825AStpnn1FhmRnFB2E6rHDD2gnLaGSTb9GK9bikJ6jcM4F4J61Or1DYBf21elsm4J3En9FUh/q81Xfbo22snb8fnEE+b+78p1+trESIl4r3yvF1SN5tU6zf+cfzv7jMvAgMBAAE=', 'motor', '2022-12-01 05:56:03', '2022-12-01 05:56:03'),
	(55, 8, 'royal_sundaram', 'appId', 'D2C', 'motor', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(56, 8, 'royal_sundaram', 'appKey', 'D2C', 'motor', '2022-12-22 14:18:45', '2022-12-22 14:18:45'),
	(57, 8, 'royal_sundaram', 'appId', 'D2C', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(58, 8, 'royal_sundaram', 'appKey', 'D2C', 'health', '2022-12-22 08:48:45', '2022-12-22 08:48:45'),
	(59, 8, 'edelweiss', 'source', 'RenewBuy', 'motor', '2022-12-24 05:02:50', '2022-12-24 05:02:51'),
	(60, 8, 'icici_lombard', 'encryption_key', 'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGEw6ySaxYBYUBf00h+w6w79MICj7l3fQmTgPjlEb5B825AStpnn1FhmRnFB2E6rHDD2gnLaGSTb9GK9bikJ6jcM4F4J61Or1DYBf21elsm4J3En9FUh/q81Xfbo22snb8fnEE+b+78p1+trESIl4r3yvF1SN5tU6zf+cfzv7jMvAgMBAAE=', 'health', '2023-01-09 07:02:12', '2023-01-09 07:02:13'),
	(61, 8, 'edelweiss', 'source', 'RenewBuy-health', 'health', '2022-12-24 05:02:50', '2022-12-24 05:02:51'),
	(62, 8, 'edelweiss', 'VISoF_Program_Name', 'RenewBuy', 'health', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(63, 8, 'edelweiss', 'X-Api-Key', 'GNa3E0AW0N1rQX5iJptWP4oTuJMm6xL165BKAiFv', 'health', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(64, 8, 'edelweiss', 'auth_username', '2r9a4a9lpvj2lp5bqbo0jhcp0l', 'health', '2022-12-24 05:02:50', '2022-12-24 05:02:51'),
	(65, 8, 'edelweiss', 'auth_password', '1q0fbp68juvm8f221f9ckh9j7i3ktq2hkibfk88q460pvccsfmqs', 'health', '2022-12-24 05:02:50', '2022-12-24 05:02:51'),
	(66, 8, 'future_generali', 'system_name', 'Webagg', 'health', '2022-12-31 17:56:03', '2022-12-31 17:56:03'),
	(67, 8, 'future_generali', 'system_name', 'RenewBuy', 'motor', '2022-12-31 17:56:03', '2022-12-31 17:56:03'),
	(68, 8, 'sbi_general', 'clientid_BIKE', '79de4de3-d258-43b8-a89a-f42924dddb46', 'motor', '2022-12-23 16:36:20', '2022-12-23 16:36:20'),
	(69, 8, 'sbi_general', 'secretkey_BIKE', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'motor', '2022-12-23 16:40:41', '2022-12-23 16:40:42'),
	(70, 8, 'sbi_general', 'clientid_CAR', '79de4de3-d258-43b8-a89a-f42924dddb46', 'motor', '2022-12-23 16:36:20', '2022-12-23 16:36:20'),
	(71, 8, 'sbi_general', 'secretkey_CAR', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'motor', '2022-12-23 16:40:41', '2024-01-12 11:40:44'),
	(72, 8, 'magma', 'username', 'Renewbuy', 'motor', '2023-01-18 07:47:45', '2023-01-18 07:47:45'),
	(73, 8, 'magma', 'password', 'password1', 'motor', '2023-01-18 07:47:45', '2023-01-18 07:47:45'),
	(74, 8, 'magma', 'CompanyName', 'Renewbuy', 'motor', '2023-01-18 07:47:45', '2023-01-18 07:47:45'),
	(75, 8, 'sbi_general', 'clientid_CV', '79de4de3-d258-43b8-a89a-f42924dddb46', 'motor', '2022-12-23 16:36:20', '2022-12-23 16:36:20'),
	(76, 8, 'sbi_general', 'secretkey_CV', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'motor', '2022-12-23 16:40:41', '2022-12-23 16:40:42'),
	(77, 8, 'kotak', 'source', 'RenewBuy', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(78, 8, 'shriram', 'password', 'TEST@123', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(79, 8, 'shriram', 'username', 'TEST', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(80, 8, 'united_india', 'appId', 'ku7h0n', 'motor', '2023-02-02 09:17:36', '2023-02-02 09:17:38'),
	(81, 8, 'united_india', 'appKey', '2792xhp3nhjn0kcyn3e5', 'motor', '2023-02-02 09:17:36', '2023-02-02 09:17:38'),
	(83, 8, 'sbi_general', 'clientid_PCV', '79de4de3-d258-43b8-a89a-f42924dddb46', 'motor', '2022-12-23 16:36:20', '2022-12-23 16:36:20'),
	(84, 8, 'sbi_general', 'clientid_GCV', '79de4de3-d258-43b8-a89a-f42924dddb46', 'motor', '2022-12-23 16:36:20', '2022-12-23 16:36:20'),
	(85, 8, 'sbi_general', 'secretkey_PCV', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'motor', '2022-12-23 16:40:41', '2022-12-23 16:40:42'),
	(86, 8, 'sbi_general', 'secretkey_GCV', 'lC0eU6gN3sM2mO3vY8xT2nS8sV0rM2xB4xL8uF1uD5lE8jJ1pY', 'motor', '2022-12-23 16:40:41', '2022-12-23 16:40:42'),
	(87, 8, 'sbi_general', 'SBI_GENERAL_STFP_USERNAME', 'Renewbuy_Test', 'health', '2023-03-08 10:30:27', '2023-03-08 10:30:28'),
	(88, 8, 'sbi_general', 'SBI_GENERAL_STFP_URL', 'sftp1.sbigeneral.in', 'health', '2023-03-08 10:30:29', '2023-03-08 10:30:30'),
	(89, 8, 'sbi_general', 'SBI_GENERAL_STFP_PASSWORD', 'Renewbuy@123', 'health', '2023-03-08 10:30:31', '2023-03-08 10:30:32'),
	(90, 8, 'sbi_general', 'SBI_GENERAL_STFP_PORT', '2201', 'health', '2023-03-08 11:31:02', '2023-03-08 11:31:03'),
	(91, 8, 'sbi_general', 'Sbi_General_Folder_path', '/Renewbuy_Test', 'health', NULL, NULL),
	(92, 8, 'sbi_general', 'SBI_GENERAL_STFP_USERNAME', 'Renewbuy_Test', 'motor', '2023-03-08 10:30:27', '2023-03-08 10:30:28'),
	(93, 8, 'sbi_general', 'SBI_GENERAL_STFP_URL', 'sftp1.sbigeneral.in', 'motor', '2023-03-08 10:30:29', '2023-03-08 10:30:30'),
	(94, 8, 'sbi_general', 'SBI_GENERAL_STFP_PASSWORD', 'Renewbuy@123', 'motor', '2023-03-08 10:30:31', '2023-03-08 10:30:32'),
	(95, 8, 'sbi_general', 'SBI_GENERAL_STFP_PORT', '2201', 'motor', '2023-03-08 11:31:02', '2023-03-08 11:31:03'),
	(96, 8, 'sbi_general', 'Sbi_General_Folder_path', '/Renewbuy_Test', 'motor', '2023-03-20 05:50:30', NULL),
	(97, 8, 'oriental', 'appId', 'zi9alz', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(98, 8, 'oriental', 'appKey', 'nkqig1ppbmsfzve0mt6t', 'motor', '2022-12-24 03:21:59', '2022-12-24 03:22:00'),
	(101, 8, 'hdfc_ergo', 'api_key_company', '0452835c-b0ca-45', 'motor', '2022-12-24 03:21:59', '2024-01-12 06:03:03'),
	(112, 8, 'iffco_tokio', 'Iffco_Tokio_Password_Health', 'partner@2020', 'health', '2023-11-16 13:03:20', '2023-11-16 13:03:20'),
	(113, 8, 'iffco_tokio', 'Iffco_Tokio_User_Name_Health', 'ITGIHLT062', 'health', '2023-11-16 13:04:01', '2023-11-16 13:04:01'),
	(114, 8, 'hdfc_ergo', 'broker_name', 'RenewBuy', 'motor', '2023-12-11 12:10:05', '2023-12-11 12:10:05'),
	(115, 8, 'manipal_cigna', 'app_key', '98bd2deecaf68128a2db67050473b2ae', 'health', '2024-02-06 07:48:25', '2024-02-06 08:50:05'),
	(116, 8, 'manipal_cigna', 'app_id', 'df9d9e5c', 'health', '2024-02-06 07:48:47', '2024-02-06 08:49:51'),
	(117, 8, 'manipal_cigna', 'agent_id', '1600099-01', 'health', '2024-02-06 07:50:07', '2024-02-06 07:50:07');

CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Fyntune', 'admin@fyntune.com', NULL, '$2y$10$xzX0g1nENikYfMl9T9ivyeFxpw6K8ywbzMh/ATXK1syyW0J2VOFNq', NULL, '2023-01-02 09:00:39', '2023-01-02 09:00:39'),
	(2, 'Nisha Patil', 'nisha.patil@fyntune.com', '2022-09-23 05:46:29', '$2y$10$lQA6ABWjhj1ADmWTFsjd6ODunTYaKqnWyxaUDoEb/T7DN5OZ37S6i', NULL, '2023-01-07 05:41:13', '2023-01-07 05:46:29'),
	(3, 'Amit Gupta', 'amit.gupta@fyntune.com', '2024-05-10 10:19:26', '$2y$10$Rtpg7aSJ/ZVdBtI3F0dl6uINtdt1VrvgvraEINM3lfhiOYQ/Y0PDy', NULL, '2024-05-10 10:19:35', '2024-05-10 10:19:35');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
