-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2023 at 05:54 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dentcare_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment_tab`
--

CREATE TABLE `appointment_tab` (
  `appointment_id` int(11) NOT NULL COMMENT 'record id',
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `approve` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_tab`
--

INSERT INTO `appointment_tab` (`appointment_id`, `patient_id`, `doctor_id`, `service_id`, `date`, `time`, `approve`) VALUES
(1, 5, 1, 12, '2023-09-05', '10:30:00', 0),
(2, 7, 1, 3, '2023-09-05', '11:00:00', 0),
(3, 2, 1, 7, '2023-09-06', '09:15:00', 1),
(4, 9, 6, 5, '2023-09-06', '10:00:00', 1),
(5, 3, 1, 15, '2023-09-06', '14:30:00', 0),
(6, 10, 2, 9, '2023-09-07', '11:45:00', 1),
(7, 1, 8, 1, '2023-09-14', '14:48:00', 1),
(8, 8, 7, 6, '2023-09-07', '15:15:00', 0),
(9, 4, 5, 14, '2023-09-08', '10:15:00', 0),
(10, 6, 10, 2, '2023-09-08', '16:00:00', 1),
(11, 1, 1, 1, '2023-09-05', '13:02:15', 0),
(12, 9, 1, 1, '2023-09-13', '10:03:53', 1),
(13, 6, 1, 1, '2023-09-01', '12:04:44', 1),
(14, 5, 1, 1, '2023-08-24', '11:05:15', 1),
(15, 10, 1, 1, '2023-08-21', '15:05:36', 1),
(16, 1, 2, 4, '2023-09-12', '13:09:00', 1),
(17, 1, 2, 4, '2023-09-12', '13:09:00', 1),
(18, 1, 1, 1, '2023-08-22', '08:11:28', 1),
(19, 1, 1, 3, '2023-09-07', '11:56:00', 0),
(20, 1, 1, 3, '2023-09-07', '11:56:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$tq9LhaAA2Dyl3RuiaQQke0$aykUbfxpjrSzo1Z04mZzLSdvHYHQT9GRhoI4xXebcJU=', '2023-03-17 16:51:53.882689', 1, 'root', '', '', 'root@gmail.com', 1, 1, '2023-03-10 05:49:51.678620'),
(2, 'pbkdf2_sha256$390000$j4wpLgcvQxu312C5gMxrNr$cdBiO25vRb/sCo6C5eLpxF9Nngdp6zYWvSjMQL82Bdw=', '2023-03-18 14:29:42.740915', 0, 'rita_patel', '', '', '', 0, 1, '2023-03-17 05:28:09.421853'),
(3, 'pbkdf2_sha256$390000$MNF1F9lbe1lHQQ6u0cM5YC$8jgYgxGx3Sy5J4UTPW7sk36Ex+GnTVcZzIRUqgNuLFE=', '2023-03-17 16:36:49.637187', 0, 'urvi_soni', '', '', '', 0, 1, '2023-03-17 16:35:47.378028');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `name` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `message` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`name`, `subject`, `message`, `email`) VALUES
('John D.', 'Appointment Query', 'When is the earliest I can book a teeth cleaning?', 'johnd@example.com'),
('Lisa M.', 'Orthodontic Treatment', 'I\'m interested in braces. Do you offer Invisalign?', 'lisam@email.com'),
('Sam T.', 'Billing Inquiry', 'I was charged for a service I didn\'t receive. Can you check?', 'sam.t@dentalsite.net'),
('Elise H.', 'Feedback', 'Your staff was incredibly friendly during my last visit. Thank you!', 'elise.h@smilefeedback.org'),
('Mike P.', 'Toothache Emergency', 'I have severe pain in my lower right molar. Can I come in today?', 'mikep@urgent.help'),
('Anne L.', 'Teeth Whitening', 'How long does your teeth whitening procedure take?', 'anne@brightsmile.com'),
('Tim R.', 'Pediatric Dentistry', 'Do you have specialists for children\'s dentistry?', 'tim.childcare@dentistry.com'),
('Sophie K', 'Cancellation', 'I need to cancel my appointment for next Tuesday.', 'sophieK@cancelmail.com'),
('Vinay P.', 'Dental Implants Query', 'How long is the recovery process for dental implants?', 'vinay.questions@toothplace.com'),
('shalvi', '123', 'learning', 'shalvi@gmail.com'),
('shalvi', '123', 'learning', 'shalvi@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-03-17 05:28:09.946685', '2', 'rita_patel', 1, '[{\"added\": {}}]', 4, 1),
(2, '2023-03-17 16:35:48.456679', '3', 'urvi_soni', 1, '[{\"added\": {}}]', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'myapp3', 'patient_registration'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-03-02 05:23:59.755221'),
(2, 'auth', '0001_initial', '2023-03-02 05:24:01.347751'),
(3, 'admin', '0001_initial', '2023-03-02 05:24:01.764835'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-03-02 05:24:01.826808'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-03-02 05:24:01.852799'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-03-02 05:24:02.001524'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-03-02 05:24:02.179583'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-03-02 05:24:02.250052'),
(9, 'auth', '0004_alter_user_username_opts', '2023-03-02 05:24:02.288030'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-03-02 05:24:02.431346'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-03-02 05:24:02.446154'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-03-02 05:24:02.495018'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-03-02 05:24:02.570422'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-03-02 05:24:02.625247'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-03-02 05:24:02.684664'),
(16, 'auth', '0011_update_proxy_permissions', '2023-03-02 05:24:02.719617'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-03-02 05:24:02.774112'),
(18, 'sessions', '0001_initial', '2023-03-06 04:53:41.912195');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0xnvdieabqq5jhvc51qlvuhipq4pekh7', 'eyJ1c2VybmFtZSI6ImF0dWxfMTIifQ:1qXNVM:44Nq4pC_qIeB018zVHRpa1xMir08eIitearpNg10pZU', '2023-09-02 15:04:44.420793'),
('4clwri0my6vjr22c578yu57nvprhihxk', 'eyJ1c2VybmFtZSI6ImF0dWxfMTIifQ:1q7TyE:MT8bVDhUq9ezWe2_JE-GxHrTRZeiHwise89TszQ9y0U', '2023-06-23 04:43:30.722388'),
('7fcn63yema17k5tat882qhk5fuotlc5h', '.eJxdyzEKgDAMheGrSGZxcFE6OXgPibVopLUlTQUR724FcXD9_vdO2NAZUBAXtDtBCcYh2Q8Y15AY67abH6-0d3kTaALVlJCi4f9_8lo8Dy_3XBWOJNliXFAk9xiMJrQkR85w3Q0YK2k:1pqWRZ:oxrynsfgIijMHNKdmQ29SIwy3xkqOyUaXYX-zBxn2Ow', '2023-05-07 09:55:41.745839'),
('smu8155yb2wgysamu3dtboc7vuop1xnx', '.eJyrViotTi3KS8xNVbJSKs5IzCnLVNJRQuen5iZm5sAFihKzCkqLEo0sHNJB4nrJ-blANQWZKUpW5jpKKfnJJflF8VAjUor0FAoyK0uLMxSK8_MylWoBjwwmgQ:1pyw1r:ApIcXRFPhpIQbL_jINxfDvkgXGgvNK0aCTT10tE5_u4', '2023-05-30 14:51:55.302915'),
('tj0izxtwi7bv5gl9cmcp11cdhd4sxudu', '.eJyrViotTi3KS8xNVbJSSiwpzYk3NFLSUYIKAFmpuYmZORBmQWYKiFELALOSD0M:1qFRrz:ESpA7bPog4nHxPGTKH4fe4L2RaJ__gcyyEfw487uzgE', '2023-07-15 04:05:59.593962'),
('wz2lyj7keew398ivdaubo1qvgzc3a45p', 'eyJ1c2VybmFtZSI6ImF0dWxfMTIifQ:1qTyw9:jzel8ITkFZzAHiRdzovwstAYyso-VOgS5dOFRbPr9Jg', '2023-08-24 06:14:21.947244');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_availability`
--

CREATE TABLE `doctor_availability` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `days` int(11) NOT NULL COMMENT '1 or 2',
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `notes` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_availability`
--

INSERT INTO `doctor_availability` (`id`, `doctor_id`, `days`, `start_time`, `end_time`, `notes`) VALUES
(1, 1, 1, '09:59:00', '16:59:00', 'open all days monday to friday'),
(2, 2, 2, '11:04:27', '19:04:27', 'open on monday,wednesday,friday');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_change_time`
--

CREATE TABLE `doctor_change_time` (
  `change_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_change_time`
--

INSERT INTO `doctor_change_time` (`change_id`, `doctor_id`, `date`, `start_time`, `end_time`) VALUES
(1, 3, '2023-09-01', '09:00:00', '11:00:00'),
(2, 7, '2023-09-01', '14:00:00', '16:00:00'),
(3, 5, '2023-09-02', '10:00:00', '12:30:00'),
(4, 1, '2023-09-02', '13:00:00', '15:00:00'),
(5, 8, '2023-09-03', '08:30:00', '10:30:00'),
(6, 4, '2023-09-03', '11:00:00', '13:00:00'),
(7, 10, '2023-09-04', '09:30:00', '11:30:00'),
(8, 2, '2023-09-04', '15:00:00', '17:00:00'),
(9, 9, '2023-09-05', '08:00:00', '10:00:00'),
(10, 6, '2023-09-05', '14:30:00', '16:30:00'),
(11, 1, '2023-09-03', '09:00:00', '13:00:00'),
(12, 1, '2023-09-03', '11:00:00', '15:00:00'),
(13, 1, '2023-09-11', '11:01:00', '16:01:00'),
(16, 12, '2023-09-06', '09:25:00', '12:25:00');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_tab`
--

CREATE TABLE `doctor_tab` (
  `doctor_id` int(11) NOT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `area` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `clinic_name` varchar(100) NOT NULL,
  `speciality` varchar(100) NOT NULL,
  `contact_no` varchar(13) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_tab`
--

INSERT INTO `doctor_tab` (`doctor_id`, `doctor_name`, `area`, `address`, `clinic_name`, `speciality`, `contact_no`, `email_id`, `username`, `password`) VALUES
(1, 'Dr. Shalvi', 'Satellite', '123 Prahlad Nagar, Satellite', 'Smile Clinic', '1,3', '9965231025', 'ceshalvi@gmail.com', 'drshalvi', '123'),
(2, 'Dr. Jones', 'Maninagar', '456 Kankaria, Maninagar', 'Tooth Care', '4', '7752365201', 'drjones@toothcare.com', 'drjones456', 'toothpass!'),
(3, 'Dr. Kim', 'Bopal', '789 Ambli Road, Bopal', 'Bright Smile', '2,5,7', '8852413698', 'drkim@brightsmile.com', 'drkim789', 'bright123!'),
(4, 'Dr. Lee', 'Navrangpura', '012 C.G. Road, Navrangpura', 'Dental Hub', '3', '7741258963', 'drlee@dentalhub.com', 'drlee012', 'navranpass!'),
(5, 'Dr. Patel', 'Vastrapur', '345 Vastrapur Lake Road', 'Dental Wellness', '6,9', '9874563210', 'drpatel@wellness.com', 'drpatel345', 'vstrapass!'),
(6, 'Dr. Desai', 'Bodakdev', '678 Sindhu Bhavan Road', 'Tooth Palace', '8,10', '9987455632', 'drdesai@toothpalace.com', 'drdesai678', 'boda456!'),
(7, 'Dr. Mehta', 'Paldi', '910 Paldi Circle', 'Smile Hub', '5,7', '8852147896', 'drmehta@smilehub.com', 'drmehta910', 'paldipass!'),
(8, 'Dr. Shah', 'Thaltej', '234 Thaltej Drive', 'Dental Clinic', '1,4,7', '9978523652', 'drshah@dentalclinic.com', 'drshah234', 'thal123!'),
(9, 'Dr. Amin', 'Naranpura', '567 Naranpura Cross Roads', 'Healthy Smiles', '3,8', '9012345678', 'dramin@healthysmiles.com', 'dramin567', 'naranpass!'),
(10, 'Dr. Gupta', 'Ghatlodia', '891 Ghatlodia Square', 'Tooth & Gum', '2,6', '8741023658', 'drgupta@toothgum.com', 'drgupta891', 'ghatlipass!'),
(11, 'Dr. Mihir', 'ranip', '22 svsquare', 'mihir\'s dental clinic', '3,8', '9985412365', 'mihir@gmail.com', 'drmihir', '100'),
(12, 'Shalvi Rajpura', 'bawda', 'gujarat', 'smile dental clinic', '', '9856324102', 'ceshalvi@gmail.com', 'shalvi1', '123'),
(13, 'sneha', 'gota', 'vande mataram', 'sneha\'s dental clinic', '2,4,8', '9998876767', '2sneha4@gmail.com', 'sneha', '123');

-- --------------------------------------------------------

--
-- Table structure for table `doc_tab`
--

CREATE TABLE `doc_tab` (
  `doctor_id` int(11) NOT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `area` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `clinic_name` varchar(100) NOT NULL,
  `speciality` varchar(100) NOT NULL,
  `contact_no` varchar(13) NOT NULL,
  `email_id` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doc_tab`
--

INSERT INTO `doc_tab` (`doctor_id`, `doctor_name`, `area`, `address`, `clinic_name`, `speciality`, `contact_no`, `email_id`) VALUES
(1, 'Dr. Atul shah', 'Naranpura', 'Shantivan complex', 'Atul\'s dental clinic', 'teeth CRT', '9898989898', 'dratuldent@gmail.com'),
(2, 'Dr Mitul Choksi', 'Memnagar', '10, Suryarath Complex', 'smile dental clinic', 'teeth whitening', '7788263737', 'smile@gmail.com'),
(3, '', '', '', '', '', '5,marutiplaza', 'bodakdev'),
(6, '', '', '', '', '', '15,arvedplaza', 'satellite'),
(7, '', 'satellite', '15,arvedplaza', 'Parul\'s dental clinic', 'dental implant', '9852003520', 'parul@gmail.com'),
(9, 'Dr. parul desai', 'satellite', '15,arvedplaza', 'Parul\'s dental clinic', 'dental implant', '9852003520', 'parul@gmail.com'),
(10, 'dr. bindi goswami', 'bodakdev', '5,marutiplaza', 'bindi\'s clinic', 'dental implant', '9898776655', 'bindi@gmail.com'),
(11, 'dr. piyush soni', 'shastrinagar', '3,kameshwar complex', 'piyush clinic', 'root canal', '9638524150', 'piyush@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `patient_registration`
--

CREATE TABLE `patient_registration` (
  `patient_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `contact_no` varchar(13) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_registration`
--

INSERT INTO `patient_registration` (`patient_id`, `name`, `email_id`, `contact_no`, `username`, `password`) VALUES
(1, 'Shalvi Rajpura', 'ceshalvi@gmail.com', '9985412032', 'shalvi', '123'),
(2, 'Priya Sharma', 'priya.sharma@email.com', '234-567-8901', 'priya.sharma', 'priyapass!'),
(3, 'Vivek Singh', 'vivek.singh@webmail.com', '345-678-9012', 'viveksingh', 'vivekpass456!'),
(4, 'Ananya Patel', 'ananya.patel@mysite.com', '456-789-0123', 'ananya.p', 'ananyasecure!'),
(5, 'Rohan Desai', 'rohan.desai@domain.com', '567-890-1234', 'rohan.desai', 'rohan1234!'),
(6, 'Kavita Reddy', 'kavita.reddy@personal.com', '678-901-2345', 'kavitaR', 'kavita567!'),
(7, 'Amit Joshi', 'amit.joshi@workmail.com', '789-012-3456', 'amit.j', 'amitpass!'),
(8, 'Lakshmi Iyer', 'lakshmi.iyer@inbox.com', '890-123-4567', 'lakshmiI', 'lakshmipassword!'),
(9, 'Suresh Nair', 'suresh.nair@site.com', '901-234-5678', 'suresh.n', 'suresh890!'),
(10, 'Deepika Menon', 'deepika.menon@home.com', '012-345-6789', 'deepika.m', 'deepikapass123!'),
(11, 'uma', 'uma@gmail.com', '8854125410', 'uma', '111');

-- --------------------------------------------------------

--
-- Table structure for table `service_tab`
--

CREATE TABLE `service_tab` (
  `service_id` int(11) NOT NULL,
  `service_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service_tab`
--

INSERT INTO `service_tab` (`service_id`, `service_type`) VALUES
(1, 'General Checkup'),
(2, 'Teeth Cleaning'),
(3, 'Dental Fillings'),
(4, 'Root Canal Treatment'),
(5, 'Dental Crowns'),
(6, 'Dental Bridges'),
(7, 'Dental Implants'),
(8, 'Teeth Whitening'),
(9, 'Orthodontics (Braces)'),
(10, 'Wisdom Tooth Extraction'),
(11, 'Dentures'),
(12, 'Periodontal (Gum) Treatment'),
(13, 'Cosmetic Dentistry (Veneers)'),
(14, 'Pediatric Dentistry'),
(15, 'Emergency Dental Care');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment_tab`
--
ALTER TABLE `appointment_tab`
  ADD PRIMARY KEY (`appointment_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor_change_time`
--
ALTER TABLE `doctor_change_time`
  ADD PRIMARY KEY (`change_id`);

--
-- Indexes for table `doctor_tab`
--
ALTER TABLE `doctor_tab`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `doc_tab`
--
ALTER TABLE `doc_tab`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `patient_registration`
--
ALTER TABLE `patient_registration`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `service_tab`
--
ALTER TABLE `service_tab`
  ADD PRIMARY KEY (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment_tab`
--
ALTER TABLE `appointment_tab`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'record id', AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `doctor_availability`
--
ALTER TABLE `doctor_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctor_change_time`
--
ALTER TABLE `doctor_change_time`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `doctor_tab`
--
ALTER TABLE `doctor_tab`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `doc_tab`
--
ALTER TABLE `doc_tab`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `patient_registration`
--
ALTER TABLE `patient_registration`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `service_tab`
--
ALTER TABLE `service_tab`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
