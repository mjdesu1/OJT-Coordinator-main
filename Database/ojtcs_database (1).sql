-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2025 at 07:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ojtcs_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accounts`
--

CREATE TABLE `tbl_accounts` (
  `ID` bigint(20) NOT NULL,
  `UID` bigint(10) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `role` varchar(30) DEFAULT NULL,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_accounts`
--

INSERT INTO `tbl_accounts` (`ID`, `UID`, `name`, `username`, `password`, `role`, `status`) VALUES
(1, 1, 'Ryan James Capadocia', 'ryanjames', 'magandareyn@2', 'administrator', 0),
(3, 1000000000, 'Lorenzo Asis', 'lorenzoasis', 'Lorenzo.asis2023', 'User', 1),
(4, 2000000000, 'Brandon Logon', 'brandon23', 'Brandon.logon4sale', 'User', 0),
(5, 3000000000, 'Jeric Dayandante', 'jeric20', 'Jeric@4sale', 'User', 0),
(13, 1234567825, 'Joseph Contador', 'josephpogi23', 'Joseph@pogi23', 'User', 0),
(14, 10, 'Administers According', 'adminaccs', '@Admin2023', 'administrator', 0),
(15, 1278654638, 'Testing One', 'testing55', 'Passwordko@123', 'User', 0),
(16, 2023123456, 'John Smith', 'johnny23', 'SecurePassword.2020', 'User', 0),
(18, 12, 'Michaejoshua paloa', 'michaeljoshua', '@Mjdesu123', 'administrator', 0),
(19, 13, 'JohnRil morales', 'johnrilmorales', '@Johnril123', 'moderator', 0),
(20, 3000000001, 'Michaeljoshuapaloa', 'mjdesu01', '@Mjdesu123', 'User', 0),
(21, 3000000002, 'Michaeljoshuapaloa', 'charlielerio1', 'Charlie1@', 'User', 0),
(22, 3000000003, 'Michael Joshua Barazan Paloa', 'michaeljoshua1', '@Mjdesu12345', 'User', 0),
(23, 3000000004, 'Michael Joshua Barazan Paloa', 'michaeljoshua1', '@Mjdesu1234', 'User', 0);

--
-- Triggers `tbl_accounts`
--
DELIMITER $$
CREATE TRIGGER `Update_Status_Trigger` AFTER UPDATE ON `tbl_accounts` FOR EACH ROW BEGIN
  IF NEW.role = 'user' THEN
    UPDATE tbl_trainee SET status = NEW.status WHERE UID = NEW.UID;
  ELSEIF NEW.role = 'administrator' THEN
    UPDATE tbl_admin SET status = NEW.status WHERE UID = NEW.UID;
  ELSEIF NEW.role = 'moderator' THEN
    UPDATE tbl_admin SET status = NEW.status WHERE UID = NEW.UID;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `UID` bigint(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `admin_uname` varchar(30) NOT NULL,
  `admin_pword` varchar(30) NOT NULL,
  `admin_email` varchar(30) NOT NULL,
  `department` varchar(20) NOT NULL,
  `imagePath` varchar(512) DEFAULT '../Image/Profile.gif',
  `date_created` date DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `role` varchar(20) DEFAULT 'moderator',
  `status` int(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='For Administrators';

--
-- Dumping data for table `tbl_admin`
--

INSERT INTO `tbl_admin` (`UID`, `name`, `admin_uname`, `admin_pword`, `admin_email`, `department`, `imagePath`, `date_created`, `last_login`, `role`, `status`) VALUES
(1, 'Michael Joshua', 'MJDESU@1', '@mj123', 'michaeljoshuabpaloa@asscat.edu', 'BSIT', '../uploads/ryanjames_Credentials/Profile/lVUtx_ryanjames_Profile.jpg', '2023-06-30', '2025-05-11 12:46:28', 'administrator', 0),
(10, 'Administers According', 'adminaccs', '@Admin2023', 'Admin+Accordingly@gmail.com', 'BSIT', '../uploads/adminaccs_Credentials/Profile/7sXsF_adminaccs_Profile.gif', '2023-07-08', '2025-05-21 12:55:11', 'administrator', 0),
(12, 'Michaejoshua paloa', 'michaeljoshua', '@Mjdesu123', 'michaeljoshuapaloa@gmail.com', 'BSIT', '../uploads/michaeljoshua_Credentials/michaeljoshua_Profile_gluxz.jpg', '2025-05-21', '2025-06-07 01:14:01', 'administrator', 0),
(13, 'JohnRil morales', 'johnrilmorales', '@Johnril123', 'johnrilmorales@asscat.edu.ph', 'BSIT', '../uploads/johnrilmorales_Credentials/johnrilmorales_Profile_kulkn.jpg', '2025-05-22', '2025-06-01 18:35:26', 'moderator', 0);

--
-- Triggers `tbl_admin`
--
DELIMITER $$
CREATE TRIGGER `Insert_admin` AFTER INSERT ON `tbl_admin` FOR EACH ROW BEGIN
    INSERT INTO tbl_accounts (UID, name, username, password, role)
    VALUES (NEW.UID, NEW.name, NEW.admin_uname, NEW.admin_pword, New.role);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_announcement`
--

CREATE TABLE `tbl_announcement` (
  `ID` int(1) NOT NULL,
  `Title` varchar(128) DEFAULT 'announcement',
  `Description` text NOT NULL,
  `PostedBy` text DEFAULT NULL,
  `DateAdded` date NOT NULL,
  `DateEnd` date NOT NULL,
  `isEnded` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This if For Announcement For all Trainee';

--
-- Dumping data for table `tbl_announcement`
--

INSERT INTO `tbl_announcement` (`ID`, `Title`, `Description`, `PostedBy`, `DateAdded`, `DateEnd`, `isEnded`) VALUES
(1, 'Temporary Maintenance Notice', 'We apologize for the inconvenience, but our system is currently undergoing scheduled maintenance to ensure optimal performance and stability. During this time, access to our services will be temporarily unavailable.', 'Ryan James Capadocia', '2023-07-13', '2024-07-13', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_evaluation`
--

CREATE TABLE `tbl_evaluation` (
  `ID` int(10) NOT NULL,
  `UID` bigint(10) DEFAULT NULL,
  `Q1` int(10) DEFAULT NULL,
  `Q2` int(10) DEFAULT NULL,
  `Q3` int(10) DEFAULT NULL,
  `Q4` int(10) DEFAULT NULL,
  `Q5` int(10) DEFAULT NULL,
  `Q6` int(10) DEFAULT NULL,
  `Q7` int(10) DEFAULT NULL,
  `Q8` int(10) DEFAULT NULL,
  `Q9` int(10) DEFAULT NULL,
  `Q10` int(10) DEFAULT NULL,
  `Q11` int(10) DEFAULT NULL,
  `Q12` int(10) DEFAULT NULL,
  `Q13` int(10) DEFAULT NULL,
  `Q14` int(10) DEFAULT NULL,
  `Q15` int(10) DEFAULT NULL,
  `Q16` int(10) DEFAULT NULL,
  `Q17` int(10) DEFAULT NULL,
  `Q18` int(10) DEFAULT NULL,
  `QoW` int(100) DEFAULT NULL,
  `Prod` int(100) DEFAULT NULL,
  `WHTS` int(100) DEFAULT NULL,
  `IWR` int(100) DEFAULT NULL,
  `Total` int(11) DEFAULT NULL,
  `date_Taken` datetime DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `evaluated_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='For Trainee Evaluation';

--
-- Dumping data for table `tbl_evaluation`
--

INSERT INTO `tbl_evaluation` (`ID`, `UID`, `Q1`, `Q2`, `Q3`, `Q4`, `Q5`, `Q6`, `Q7`, `Q8`, `Q9`, `Q10`, `Q11`, `Q12`, `Q13`, `Q14`, `Q15`, `Q16`, `Q17`, `Q18`, `QoW`, `Prod`, `WHTS`, `IWR`, `Total`, `date_Taken`, `feedback`, `evaluated_by`) VALUES
(4, 1000000000, 3, 4, 5, 4, 4, 4, 5, 3, 4, 4, 5, 4, 5, 4, 4, 5, 4, 5, 80, 85, 83, 90, 88, '2023-08-20 09:39:27', 'Congratulations on completing the OJT program! Your dedication and hard work throughout the internship were truly commendable. It was evident that you approached each task with enthusiasm and a strong desire to learn. Your ability to adapt to new challenges and proactively seek solutions was impressive. Moreover, your attention to detail and the quality of your work consistently exceeded expectations.', 'Ryan James Capadocia'),
(5, 3000000001, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 100, 100, 100, 100, 100, '2025-05-22 19:46:33', 'nfjdhfkfjdkfd', 'JohnRil morales');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_events`
--

CREATE TABLE `tbl_events` (
  `ID` int(10) NOT NULL,
  `eventID` int(10) DEFAULT NULL,
  `eventTitle` varchar(50) DEFAULT NULL,
  `eventCreated` date DEFAULT NULL,
  `eventDescription` text DEFAULT NULL,
  `eventImage` varchar(512) DEFAULT '../Image/eventImage.jpg',
  `eventDate` date DEFAULT NULL,
  `eventStartTime` time DEFAULT NULL,
  `eventEndTime` time DEFAULT NULL,
  `eventType` varchar(50) DEFAULT NULL,
  `eventCompletion` date DEFAULT NULL,
  `eventEnded` varchar(10) DEFAULT 'false',
  `eventLocation` varchar(128) DEFAULT NULL,
  `eventSlots` int(10) NOT NULL DEFAULT 50,
  `eventOrganizer` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_events`
--

INSERT INTO `tbl_events` (`ID`, `eventID`, `eventTitle`, `eventCreated`, `eventDescription`, `eventImage`, `eventDate`, `eventStartTime`, `eventEndTime`, `eventType`, `eventCompletion`, `eventEnded`, `eventLocation`, `eventSlots`, `eventOrganizer`) VALUES
(4, 124, 'Science Fair', '2023-08-02', 'he Science Fair is an annual event where students showcase their scientific knowledge and present their innovative projects to the school community. It promotes scientific inquiry and encourages creativity in the field of science. No outsider allowed inside school.', '../uploads/Science Fair_Event/Eventimg/jngiu_Eventimg(Science Fair).jpg', '2025-05-22', '09:00:00', '12:00:00', 'other', '2025-06-22', 'false', 'School Gymnasium', 49, 'Science Department'),
(5, 125, 'Cultural Diversity Day', '2023-08-03', 'Cultural Diversity Day celebrates the rich and diverse cultures within our school community. It includes various activities, performances, and displays representing different countries and traditions. Students and staff come together to foster inclusivity and appreciation for cultural differences.', '../uploads/Cultural Diversity Day_Event/Eventimg/dmpuk_Eventimg(Cultural Diversity Day).jpg', '2025-05-22', '10:00:00', '14:00:00', 'other', '2025-06-22', 'false', 'School Courtyard', 45, 'School Courtyard'),
(8, 128, 'Tech Innovators Summit 2025', '2025-05-22', 'Event Description\r\nThe Tech Innovators Summit 2025 is a one-day conference that brings together students, professionals, and industry leaders to discuss the latest trends in information technology and innovation. The event features keynote speeches, breakout sessions, tech exhibits, and networking opportunities. Attendees will gain insights into future technologies, digital transformation, and startup development. This summit aims to inspire young innovators and foster collaboration among tech enthusiasts in the region.\r\n\r\n', '../uploads/Tech Innovators Summit 2025_Event/Eventimg/fynxg_Eventimg(Tech Innovators Summit 2025).jpeg', '2025-05-22', '07:17:00', '19:17:00', 'other', '2025-06-22', 'false', 'ASSCAT Main Auditorium, Agusan del Sur', 149, 'ASSCAT ICT Department');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_programs`
--

CREATE TABLE `tbl_programs` (
  `ID` int(10) NOT NULL,
  `progID` bigint(255) DEFAULT NULL,
  `title` varchar(512) DEFAULT NULL,
  `progimage` varchar(512) NOT NULL DEFAULT 'Image/Programoffer.jpg',
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `progloc` text DEFAULT NULL,
  `department` varchar(512) DEFAULT NULL,
  `hours` int(50) DEFAULT 600,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `Duration` varchar(100) DEFAULT NULL,
  `Supervisor` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_programs`
--

INSERT INTO `tbl_programs` (`ID`, `progID`, `title`, `progimage`, `description`, `start_date`, `end_date`, `progloc`, `department`, `hours`, `start_time`, `end_time`, `Duration`, `Supervisor`) VALUES
(2, 2000000000, 'Web Development Internship', 'Image/Programoffer.jpg', 'This is a long paragraph written to show how the line-height of an element is affected by our utilities. Classes are applied to the element itself or sometimes the parent element. These classes can be customized as needed with our utility API. This is a long paragraph written to show how the line-height of an element is affected by our', '2025-05-22', '2025-07-24', 'didto ila carlie bh', NULL, 640, '09:00:00', '17:00:00', '16', 'Johnril'),
(3, 3000000000, 'backend Development Internship', 'Image/Programoffer.jpg', 'This OJT program provides students with hands-on experience in web development, equipping them with practical skills and knowledge in HTML, CSS, and JavaScript. Participants will work on real-world projects and collaborate with experienced developers to create responsive and dynamic websites.', '2025-05-22', '2025-07-24', 'ASSCAT', NULL, 320, '09:00:00', '13:00:00', '8', 'Criezl Jean'),
(4, 1000000000, 'Marketing Internship', 'Image/Programoffer.jpg', 'The Marketing Internship provides students with practical experience in various aspects of marketing, including market research, social media management, and campaign development. Participants will work closely with the marketing team and gain valuable insights into the field while contributing to real-world projects.', '2025-05-22', '2025-07-31', 'ASSCAT', NULL, 160, '09:00:00', '12:00:00', '4', 'Erl Jhon'),
(11, 2023123456, 'Name', 'Image/Programoffer.jpg', 'This is a long paragraph written to show how the line-height of an element is affected by our utilities. Classes are applied to the element itself or sometimes the parent element. These classes can be customized as needed with our utility API. This is a long paragraph written to show how the line-height of an element is affected by our', '2023-09-03', '2023-11-26', 'Sa Cabite  Malapit sa Molino', NULL, 480, '09:00:00', '17:00:00', '12', 'CapsLock'),
(12, 3000000001, 'NameWeb Development Internship', 'Image/Programoffer.jpg', 'This is a long paragraph written to show how the line-height of an element is affected by our utilities. Classes are applied to the element itself or sometimes the parent element. These classes can be customized as needed with our utility API. This is a long paragraph written to show how the line-height of an element is affected by our', '2025-05-22', '2025-07-24', 'didto ila carlie bh', NULL, 640, '09:00:00', '17:00:00', '16', 'Johnril'),
(13, 3000000002, 'NEWBE Frontend DEV', 'Image/Programoffer.jpg', 'this program is for frontend junior developers ', '2025-05-29', '2025-06-26', 'Davoa del sur', NULL, 160, '09:58:00', '15:57:00', '4', 'Johnril'),
(14, 3000000003, 'Web Development Internship', 'Image/Programoffer.jpg', 'This is a long paragraph written to show how the line-height of an element is affected by our utilities. Classes are applied to the element itself or sometimes the parent element. These classes can be customized as needed with our utility API. This is a long paragraph written to show how the line-height of an element is affected by our', '2025-05-22', '2025-07-24', 'didto ila carlie bh', NULL, 640, '09:00:00', '17:00:00', '16', 'Johnril');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_resource`
--

CREATE TABLE `tbl_resource` (
  `ID` int(100) NOT NULL,
  `UID` bigint(255) DEFAULT NULL,
  `resume` text DEFAULT NULL,
  `placement` text DEFAULT NULL,
  `Birth` text DEFAULT NULL,
  `MoA` text DEFAULT NULL,
  `Waiver` text DEFAULT NULL,
  `MedCert` text DEFAULT NULL,
  `GMCert` text DEFAULT NULL,
  `RegForm` text DEFAULT NULL,
  `consent` text DEFAULT NULL,
  `Evaform` text DEFAULT NULL,
  `NarraForm` text DEFAULT NULL,
  `TimeCard` text DEFAULT NULL,
  `COC` text DEFAULT NULL,
  `Doc1_date` date DEFAULT NULL,
  `Doc2_date` date DEFAULT NULL,
  `Doc3_date` date DEFAULT NULL,
  `Doc4_date` date DEFAULT NULL,
  `Doc5_date` date DEFAULT NULL,
  `Doc6_date` date DEFAULT NULL,
  `Doc7_date` date DEFAULT NULL,
  `Doc8_date` date DEFAULT NULL,
  `Doc9_date` date DEFAULT NULL,
  `Doc10_date` date DEFAULT NULL,
  `Doc11_date` date DEFAULT NULL,
  `Doc12_date` date DEFAULT NULL,
  `Doc13_date` date DEFAULT NULL,
  `Doc1_stat` int(3) NOT NULL DEFAULT 0,
  `Doc2_stat` int(3) NOT NULL DEFAULT 0,
  `Doc3_stat` int(3) NOT NULL DEFAULT 0,
  `Doc4_stat` int(3) NOT NULL DEFAULT 0,
  `Doc5_stat` int(3) NOT NULL DEFAULT 0,
  `Doc6_stat` int(3) DEFAULT 0,
  `Doc7_stat` int(3) NOT NULL DEFAULT 0,
  `Doc8_stat` int(3) NOT NULL DEFAULT 0,
  `Doc9_stat` int(3) NOT NULL DEFAULT 0,
  `Doc10_stat` int(3) NOT NULL DEFAULT 0,
  `Doc11_stat` int(3) NOT NULL DEFAULT 0,
  `Doc12_stat` int(3) NOT NULL DEFAULT 0,
  `Doc13_stat` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='for Trainee Douments';

--
-- Dumping data for table `tbl_resource`
--

INSERT INTO `tbl_resource` (`ID`, `UID`, `resume`, `placement`, `Birth`, `MoA`, `Waiver`, `MedCert`, `GMCert`, `RegForm`, `consent`, `Evaform`, `NarraForm`, `TimeCard`, `COC`, `Doc1_date`, `Doc2_date`, `Doc3_date`, `Doc4_date`, `Doc5_date`, `Doc6_date`, `Doc7_date`, `Doc8_date`, `Doc9_date`, `Doc10_date`, `Doc11_date`, `Doc12_date`, `Doc13_date`, `Doc1_stat`, `Doc2_stat`, `Doc3_stat`, `Doc4_stat`, `Doc5_stat`, `Doc6_stat`, `Doc7_stat`, `Doc8_stat`, `Doc9_stat`, `Doc10_stat`, `Doc11_stat`, `Doc12_stat`, `Doc13_stat`) VALUES
(1, 2000000000, '../uploads/brandon23_Credentials/Resume/zCcJj_brandon23_Resume.jpg', '../uploads/brandon23_Credentials/PlacementForm/kL3Zs_brandon23_PlacementForm.jpg', '../uploads/brandon23_Credentials/BirthCertificate/EGd6x_brandon23_BirthCertificate.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-11', '2023-07-11', '2023-07-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 1000000000, '../uploads/lorenzoasis_Credentials/Resume/MiI57_lorenzoasis_Resume.png', '../uploads/lorenzoasis_Credentials/PlacementForm/SseRI_lorenzoasis_PlacementForm.pdf', '../uploads/lorenzoasis_Credentials/BirthCertificate/IEEJ2_lorenzoasis_BirthCertificate.pdf', '../uploads/lorenzoasis_Credentials/MemorandumOfAgreement/pBlx1_lorenzoasis_MemorandumOfAgreement.pdf', '../uploads/lorenzoasis_Credentials/Waiver/0YWty_lorenzoasis_Waiver.png', '../uploads/lorenzoasis_Credentials/MedicalCertificate/3XJ6I_lorenzoasis_MedicalCertificate.jpg', '../uploads/lorenzoasis_Credentials/GoodMoralCertificate/Dc6Me_lorenzoasis_GoodMoralCertificate.png', '../uploads/lorenzoasis_Credentials/RegistrationForm/CXKwt_lorenzoasis_RegistrationForm.jpg', NULL, '../uploads/lorenzoasis_Credentials/EvaluationForm/V0Qjc_lorenzoasis_EvaluationForm.pdf', '../uploads/lorenzoasis_Credentials/NarrativeReport/46I7x_lorenzoasis_NarrativeReport.pdf', '../uploads/lorenzoasis_Credentials/DailyTimeRecord/x26dI_lorenzoasis_DailyTimeRecord.pdf', '../uploads/lorenzoasis_Credentials/CertificateOfCompletion/cXuj5_lorenzoasis_CertificateOfCompletion.pdf', '2023-07-12', '2023-08-13', '2023-08-26', '2023-08-26', '2023-07-12', '2023-07-12', '2023-08-13', '2023-07-12', NULL, '2023-07-12', '2023-07-12', '2023-07-12', '2023-07-12', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1),
(3, 3000000000, '../uploads/jeric20_Credentials/Resume/ffF4x_jeric20_Resume.pdf', '../uploads/jeric20_Credentials/PlacementForm/VOEzX_jeric20_PlacementForm.pdf', '../uploads/jeric20_Credentials/BirthCertificate/MWdWn_jeric20_BirthCertificate.pdf', '../uploads/jeric20_Credentials/MemorandumOfAgreement/b6WvQ_jeric20_MemorandumOfAgreement.pdf', '../uploads/jeric20_Credentials/Waiver/HGXVV_jeric20_Waiver.pdf', '../uploads/jeric20_Credentials/MedicalCertificate/40Pya_jeric20_MedicalCertificate.png', '../uploads/jeric20_Credentials/GoodMoralCertificate/TZZBp_jeric20_GoodMoralCertificate.pdf', '../uploads/jeric20_Credentials/RegistrationForm/F5poE_jeric20_RegistrationForm.jpg', NULL, NULL, NULL, NULL, NULL, '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', NULL, NULL, NULL, NULL, NULL, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 1234567825, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 1278654638, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 2023123456, '../uploads/johnny23_Credentials/Resume/RVD9H_johnny23_Resume.pdf', NULL, NULL, '../uploads/johnny23_Credentials/MemorandumOfAgreement/L3Hp0_johnny23_MemorandumOfAgreement.pdf', '../uploads/johnny23_Credentials/Waiver/ySYkm_johnny23_Waiver.pdf', NULL, '../uploads/johnny23_Credentials/GoodMoralCertificate/6uf9k_johnny23_GoodMoralCertificate.pdf', NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-11', NULL, NULL, '2023-09-03', '2023-09-03', NULL, '2023-09-03', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 3000000001, '../uploads/mjdesu01_Credentials/Resume/iZsnj_mjdesu01_Resume.jpg', '../uploads/mjdesu01_Credentials/PlacementForm/146Fr_mjdesu01_PlacementForm.jpg', '../uploads/mjdesu01_Credentials/BirthCertificate/1rCFU_mjdesu01_BirthCertificate.jpg', '../uploads/mjdesu01_Credentials/MemorandumOfAgreement/BZFnp_mjdesu01_MemorandumOfAgreement.jpg', '../uploads/mjdesu01_Credentials/Waiver/sG99C_mjdesu01_Waiver.jpg', '../uploads/mjdesu01_Credentials/MedicalCertificate/a6HjK_mjdesu01_MedicalCertificate.jpg', '../uploads/mjdesu01_Credentials/GoodMoralCertificate/W36oc_mjdesu01_GoodMoralCertificate.jpg', '../uploads/mjdesu01_Credentials/RegistrationForm/qj3in_mjdesu01_RegistrationForm.jpg', NULL, NULL, NULL, NULL, NULL, '2025-05-22', '2025-05-22', '2025-05-22', '2025-05-22', '2025-05-22', '2025-05-22', '2025-05-22', '2025-05-22', NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 3000000003, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 3000000004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_secquestion`
--

CREATE TABLE `tbl_secquestion` (
  `ID` int(11) NOT NULL,
  `UID` bigint(10) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_secquestion`
--

INSERT INTO `tbl_secquestion` (`ID`, `UID`, `question`, `answer`, `date_submitted`, `date_updated`) VALUES
(1, 3000000000, '1;2;3', 'idono;catdog;mars', '2023-08-27 13:03:10', '2023-09-03 18:42:13'),
(2, 1000000000, '18;16;7', 'vajulet;golden;bookworm', '2023-08-27 14:23:57', NULL),
(3, 1278654638, NULL, NULL, NULL, NULL),
(4, 2000000000, NULL, NULL, NULL, NULL),
(5, 1234567825, NULL, NULL, NULL, NULL),
(6, 2023123456, '18;16;3', 'red;golden;bacoor', '2023-09-03 09:17:02', '2023-09-03 09:17:30'),
(7, 3000000001, '3;9;13', 'wdsd;dwdw;dwdw', '2025-05-22 19:10:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_trainee`
--

CREATE TABLE `tbl_trainee` (
  `UID` bigint(10) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `trainee_uname` varchar(30) DEFAULT NULL,
  `trainee_pword` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `age` int(100) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `status` int(5) DEFAULT 0,
  `role` varchar(50) DEFAULT 'User',
  `account_Created` date DEFAULT NULL,
  `profile_Completed` varchar(10) DEFAULT 'false',
  `vaccine_Completed` tinyint(1) NOT NULL DEFAULT 0,
  `security_Question` tinyint(1) NOT NULL DEFAULT 0,
  `image` varchar(512) DEFAULT '../Image/Profile.png',
  `gender` varchar(10) DEFAULT NULL,
  `course` varchar(30) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `program` varchar(30) DEFAULT NULL,
  `prog_duration` varchar(20) DEFAULT NULL,
  `fulfilled_time` varchar(20) DEFAULT NULL,
  `completed` varchar(20) DEFAULT NULL,
  `evaluated` varchar(20) DEFAULT 'false',
  `address` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `postal_code` int(20) DEFAULT NULL,
  `province` varchar(30) DEFAULT NULL,
  `Join_an_Event` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-false, 1-true',
  `EventID` int(11) DEFAULT NULL,
  `Program_stat` int(3) DEFAULT 0 COMMENT '0 - pending. 1- Approved, 2 - Denied',
  `Resource_Completed` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_trainee`
--

INSERT INTO `tbl_trainee` (`UID`, `name`, `trainee_uname`, `trainee_pword`, `email`, `birthdate`, `age`, `department`, `status`, `role`, `account_Created`, `profile_Completed`, `vaccine_Completed`, `security_Question`, `image`, `gender`, `course`, `phone`, `program`, `prog_duration`, `fulfilled_time`, `completed`, `evaluated`, `address`, `city`, `postal_code`, `province`, `Join_an_Event`, `EventID`, `Program_stat`, `Resource_Completed`) VALUES
(1000000000, 'mjpaloa', 'mjpaloa', 'Lorenzo.asis2023', 'lorenzo.Asis@gmail.com', '1970-01-01', 23, 'BSCS', 1, 'User', '2023-06-30', 'true', 0, 1, '../uploads/lorenzoasis_Credentials/lorenzoasis_Profile_HJTSZ.gif', 'male', 'BSCS-2B', '09876543219', 'Marketing Internship', '4', '160', 'true', 'true', 'Queenstown Molino 3', 'Bacoor', 4102, 'Cavite', 0, 123, 0, 1),
(1234567825, 'mjpaloa', 'josephpogi23', 'Joseph@pogi23', 'joseph.contador@cvsu.edu.ph', '2004-02-09', 23, 'BSIT', 0, 'User', '2023-07-03', 'true', 1, 0, '../uploads/josephpogi23_Credentials/josephpogi23_Profile_Tq3UZ.jpg', 'male', 'BSIT-2B', '09687363887', NULL, NULL, NULL, NULL, 'false', 'DASMA PALIRARAN BACOOR CAVITE', 'DASMA', 404, 'Dasma', 0, 126, 0, 0),
(1278654638, 'mjpaloa', 'testing55', 'Passwordko@123', 'test@gmail.com', '2002-08-06', 21, 'BSIT', 0, 'User', '2023-08-11', 'true', 0, 0, '../Image/Profile.png', 'female', 'BSIT-2B', '09675645233', NULL, NULL, NULL, NULL, 'false', 'taga imus to', 'imus', 4102, 'Cavite', 1, 123, 0, 0),
(2000000000, 'mjpaloa', 'brandon23', 'Brandon.logon4sale', 'Brandon@gmail.com', '2023-07-06', 21, 'BSCS', 0, 'User', '2023-06-30', 'true', 0, 0, '../uploads/brandon23_Credentials/brandon23_Profile_75fzg.jpeg', 'male', 'BSCS-2B', '09897867564', 'Name', '16', '640', NULL, 'false', 'Ohio', 'Columbus', 4300, 'Ohio', 0, 123, 0, 0),
(2023123456, 'mjpaloa', 'mjpaloa123', 'SecurePassword.2020', 'michaeljoshuabpaloa1@asscat.ed', '2000-07-19', 23, 'BSCS', 0, 'User', '2023-08-11', 'true', 0, 1, '../uploads/johnny23_Credentials/johnny23_Profile_hcWNg.gif', 'male', 'BSCS-2C', '09786752324', 'Name', '12', '480', NULL, 'false', 'iwan ko kung tagasaan to', 'baccor', 4102, 'Cavite', 0, 123, 0, 0),
(3000000000, 'mjpaloa', 'mjpaloa1', 'Jeric@4sale', 'mjpaloa1@gmail.com', '2023-06-30', 20, 'BSIT', 0, 'User', '2023-06-30', 'true', 1, 1, '../Image/Profile.png', 'male', 'BSIT-2B', '09675453124', 'Web Development Internship', '8', '320', 'true', 'false', 'Taga Prima banda sa imus', 'City of Imus', 4103, 'Cavite', 0, 123, 0, 0),
(3000000001, 'Michaeljoshuapaloa', 'mjdesu01', '@Mjdesu123', 'michaeljoshuapaloa@asscat.edu.', '2005-07-06', 20, 'BSIT', 0, 'User', '2025-05-22', 'true', 1, 1, '../uploads/mjdesu01_Credentials/mjdesu01_Profile_2BhiC.jpg', 'male', 'BSIT-2B', '09532765484', 'NameWeb Development Internship', '16', '640', NULL, 'true', 'p4CADS', 'bunawan', 8506, 'agusan del sur', 1, 128, 0, 0),
(3000000002, 'Michaeljoshuapaloa', 'charlielerio1', 'Charlie1@', 'charlieotaza@yahoo.com', NULL, 20, NULL, 0, 'User', '2025-05-28', 'false', 0, 0, '../Image/Profile.png', NULL, NULL, NULL, 'NEWBE Frontend DEV', '4', '160', NULL, 'false', NULL, NULL, NULL, NULL, 0, NULL, 0, 0);

--
-- Triggers `tbl_trainee`
--
DELIMITER $$
CREATE TRIGGER `Insert_Trainee` AFTER INSERT ON `tbl_trainee` FOR EACH ROW BEGIN
    INSERT INTO tbl_Accounts (UID, name, username, password, role)
    VALUES (NEW.UID,  NEW.name, NEW.trainee_uname, NEW.trainee_pword, NEW.role);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_vaccine`
--

CREATE TABLE `tbl_vaccine` (
  `ID` int(10) NOT NULL,
  `UID` bigint(255) NOT NULL,
  `vaccineName` varchar(128) DEFAULT NULL,
  `vaccineType` varchar(128) DEFAULT NULL,
  `vaccineDose` varchar(128) DEFAULT NULL,
  `vaccineLoc` varchar(512) NOT NULL,
  `vaccineImage` varchar(512) DEFAULT '../Image/Vaccination_Image.jpg',
  `VaccDoseOne` varchar(128) NOT NULL,
  `VaccDosetwo` varchar(128) NOT NULL,
  `VaccDoseBooster` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='For  Vaccination Details off Trainee';

--
-- Dumping data for table `tbl_vaccine`
--

INSERT INTO `tbl_vaccine` (`ID`, `UID`, `vaccineName`, `vaccineType`, `vaccineDose`, `vaccineLoc`, `vaccineImage`, `VaccDoseOne`, `VaccDosetwo`, `VaccDoseBooster`) VALUES
(1, 3000000000, 'Johnson', '2', 'one', 'Sa prima diko alam  san banda', '../uploads/jeric20_Credentials/jeric20_Vaccine/jeric20_VaccineCard.jpg', '2023-07-01', '', ''),
(2, 1234567825, 'Johnson', '1', 'booster', 'DASMA PALA PALA OPEN COURT', '../uploads/josephpogi23_Credentials/josephpogi23_Vaccine/josephpogi23_VaccineCard.png', '2019-12-02', '2020-12-03', '2021-02-04'),
(3, 3000000001, 'Pfizer', '1', 'Choose...', 'libertad ADS', '../uploads/mjdesu01_Credentials/mjdesu01_Vaccine/mjdesu01_VaccineCard.jpg', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_accounts`
--
ALTER TABLE `tbl_accounts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `tbl_announcement`
--
ALTER TABLE `tbl_announcement`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_evaluation`
--
ALTER TABLE `tbl_evaluation`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_events`
--
ALTER TABLE `tbl_events`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_programs`
--
ALTER TABLE `tbl_programs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_resource`
--
ALTER TABLE `tbl_resource`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_secquestion`
--
ALTER TABLE `tbl_secquestion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UID` (`UID`);

--
-- Indexes for table `tbl_trainee`
--
ALTER TABLE `tbl_trainee`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `tbl_vaccine`
--
ALTER TABLE `tbl_vaccine`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_accounts`
--
ALTER TABLE `tbl_accounts`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `UID` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_evaluation`
--
ALTER TABLE `tbl_evaluation`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_events`
--
ALTER TABLE `tbl_events`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_programs`
--
ALTER TABLE `tbl_programs`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tbl_resource`
--
ALTER TABLE `tbl_resource`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_secquestion`
--
ALTER TABLE `tbl_secquestion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_trainee`
--
ALTER TABLE `tbl_trainee`
  MODIFY `UID` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3000000005;

--
-- AUTO_INCREMENT for table `tbl_vaccine`
--
ALTER TABLE `tbl_vaccine`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_secquestion`
--
ALTER TABLE `tbl_secquestion`
  ADD CONSTRAINT `tbl_secquestion_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `tbl_trainee` (`UID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
