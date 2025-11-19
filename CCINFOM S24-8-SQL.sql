-- IT Asset and Inventory Management Database (CHONG, LAUS, MEDINA, SANTOS) --

CREATE DATABASE IF NOT EXISTS `asset_management_db` DEFAULT CHARACTER SET utf8mb4;
USE `asset_management_db`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- ------------------------------------------------
-- EMPLOYEES TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `Employee`;
CREATE TABLE IF NOT EXISTS `Employee`(
	`employeeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(50) NOT NULL,
    `lastName` VARCHAR(50) NOT NULL,
    `department` VARCHAR(50) NOT NULL,
    `position` VARCHAR(50) NOT NULL,
    `contactNumber` VARCHAR(20) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (`employeeID`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- ASSET TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `Asset`;
CREATE TABLE IF NOT EXISTS `Asset`(
	`assetID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `expiryDate` DATE NOT NULL,
    `purchaseDate` DATE NOT NULL,
    `a_status` ENUM('active', 'inactive', 'expired', 'damaged', 'lost', 'returned') NOT NULL,
    `assetType` ENUM('h', 's') NOT NULL,
    PRIMARY KEY (`assetID`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- HARDWARE ASSET TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `HardwareAsset`;
CREATE TABLE IF NOT EXISTS `HardwareAsset`(
	`H_assetID` INT UNSIGNED NOT NULL,
    `h_type` VARCHAR(20) NOT NULL,
    `brand` VARCHAR(50) NOT NULL,
    `model` VARCHAR(50) NOT NULL,
    `serialNumber` VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (`H_assetID`),
    INDEX `idx_hardware_assetID` (`H_assetID`),
    CONSTRAINT `idx_hardware_assetID`
		FOREIGN KEY (`H_assetID`) REFERENCES `Asset` (`assetID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- SOFTWARE LICENSE ASSET TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `SoftwareLicense`;
CREATE TABLE IF NOT EXISTS `SoftwareLicense`(
	`S_assetID` INT UNSIGNED NOT NULL,
    `softwareName` VARCHAR(20) NOT NULL,
    `version` VARCHAR(10) NOT NULL,
    `licenseKey` VARCHAR(50) NOT NULL UNIQUE,
    `numOfUsers` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`S_assetID`),
    INDEX `idx_software_license_assetID` (`S_assetID`),
    CONSTRAINT `idx_software_license_assetID`
		FOREIGN KEY (`S_assetID`) REFERENCES `Asset` (`assetID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- INVENTORY TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `Inventory`;
CREATE TABLE IF NOT EXISTS `Inventory`(
	`itemID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `itemName` VARCHAR(100) NOT NULL,
    `itemType` VARCHAR(50) NOT NULL,
    `unit` VARCHAR(20) NOT NULL,
    `stockQty` INT UNSIGNED NOT NULL,
    `reorderLevel` INT UNSIGNED NOT NULL,
    `i_status` ENUM('active', 'inactive') NOT NULL,
    PRIMARY KEY (`itemID`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- SUPPLIER TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `Supplier`;
CREATE TABLE IF NOT EXISTS `Supplier`(
	`supplierID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `companyName` VARCHAR(100) NOT NULL,
    `firstName` VARCHAR(50) NOT NULL,
    `lastName` VARCHAR(50) NOT NULL,
    `contactNumber` VARCHAR(20) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `zip` VARCHAR(10) NOT NULL,
    `street` VARCHAR(100) NOT NULL,
    `city` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`supplierID`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- ASSIGNING TRANSACTION
-- ------------------------------------------------
DROP TABLE IF EXISTS `Assigning`;
CREATE TABLE `Assigning`(
	`assignmentID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `assetID` INT UNSIGNED NOT NULL,
    `assignedBy` INT UNSIGNED NOT NULL,
    `assignmentDate` DATE,
    `as_status` ENUM('active', 'inactive') NOT NULL,
    PRIMARY KEY (`assignmentID`),
    INDEX `idx_assigned_by_employee` (`assignedBy`),
    CONSTRAINT `idx_assigned_by_employee`
		FOREIGN KEY (`assignedBy`) REFERENCES `Employee` (`employeeID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
    CONSTRAINT `idx_assigned_asset`
		FOREIGN KEY (`assetID`) REFERENCES `Asset` (`assetID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- MONITORING TRANSACTION
-- ------------------------------------------------
DROP TABLE IF EXISTS `Monitoring`;
CREATE TABLE `Monitoring`(
	`monitoringID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `assetID` INT UNSIGNED NOT NULL,
    `monitoringType` ENUM('s', 'h') NOT NULL,
    `lastCheckedDate` DATE NOT NULL,
    `expiryDate` DATE NULL,
    `notes` VARCHAR(255) NULL,
    PRIMARY KEY (`monitoringID`),
    INDEX `idx_monitoring_asset` (`assetID`),
    CONSTRAINT `idx_monitoring_asset`
		FOREIGN KEY (`assetID`) REFERENCES `Asset` (`assetID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- MONITORING TRANSACTION (SOFTWARE)
-- ------------------------------------------------
DROP TABLE IF EXISTS `SoftwareMonitoring`;
CREATE TABLE `SoftwareMonitoring`(
	`S_monitoringID` INT UNSIGNED NOT NULL,
    `depreciationStatus` VARCHAR(50),
    PRIMARY KEY (`S_monitoringID`),
    INDEX `idx_software_monitoring_asset` (`S_monitoringID`),
    CONSTRAINT `idx_software_monitoring_asset`
		FOREIGN KEY (`S_monitoringID`) REFERENCES `Monitoring` (`monitoringID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- MONITORING TRANSACTION (HARDWARE)
-- ------------------------------------------------
DROP TABLE IF EXISTS `HardwareMonitoring`;
CREATE TABLE `HardwareMonitoring`(
	`H_monitoringID` INT UNSIGNED NOT NULL,
    `complianceStatus` VARCHAR(50),
    PRIMARY KEY (`H_monitoringID`),
    INDEX `idx_hardware_monitoring_asset` (`H_monitoringID`),
    CONSTRAINT `idx_hardware_monitoring_asset`
		FOREIGN KEY (`H_monitoringID`) REFERENCES `Monitoring` (`monitoringID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- CONTRACT TRANSACTION
-- ------------------------------------------------
DROP TABLE IF EXISTS `Contract`;
CREATE TABLE `Contract`(
	`contractID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `assetID` INT UNSIGNED NOT NULL,
    `supplierID` INT UNSIGNED NOT NULL,
    `startDate` DATE NOT NULL,
    `expiryDate` DATE NOT NULL,
    `payment` VARCHAR(50) NULL,
    `responsibilities` VARCHAR(200) NULL,
    PRIMARY KEY (`contractID`),
    INDEX `idx_asset_purchased` (`assetID`),
    INDEX `idx_asset_purchased_from` (`supplierID`),
    CONSTRAINT `idx_asset_purchased`
		FOREIGN KEY (`assetID`) REFERENCES `Asset` (`assetID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
	CONSTRAINT `idx_asset_purchased_from`
		FOREIGN KEY (`supplierID`) REFERENCES `Supplier` (`supplierID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- CONTRACT RENEWAL TRANSACTION
-- ------------------------------------------------
DROP TABLE IF EXISTS `RenewalContract`;
CREATE TABLE `RenewalContract`(
	`renewalID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `assetID` INT UNSIGNED NOT NULL,
    `contractID` INT UNSIGNED NOT NULL,
    `renewedBy` INT UNSIGNED NOT NULL,
    `renewedFrom` INT UNSIGNED NOT NULL,
    `renewalDate` DATE NOT NULL,
    `newExpiryDate` DATE NOT NULL,
    PRIMARY KEY (`renewalID`),
    INDEX `idx_asset_renewed` (`assetID`),
    INDEX `idx_asset_contract` (`contractID`),
    INDEX `idx_asset_renewed_by` (`renewedBy`),
    INDEX `idx_asset_renewed_from` (`renewedFrom`),
    CONSTRAINT `idx_asset_renewed`
		FOREIGN KEY (`assetID`) REFERENCES `Asset` (`assetID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
	CONSTRAINT `idx_asset_contract`
		FOREIGN KEY (`contractID`) REFERENCES `Contract` (`contractID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
	CONSTRAINT `idx_asset_renewed_by`
		FOREIGN KEY (`renewedBy`) REFERENCES `Employee` (`employeeID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
	CONSTRAINT `idx_asset_renewed_from`
		FOREIGN KEY (`renewedFrom`) REFERENCES `Supplier` (`supplierID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- RESTOCK TRANSACTION
-- ------------------------------------------------
DROP TABLE IF EXISTS `Restock`;
CREATE TABLE `Restock`(
	`restockID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `supplierID` INT UNSIGNED NOT NULL,
    `itemID` INT UNSIGNED NOT NULL,
    `restockedBy` INT UNSIGNED NOT NULL,
    `qtyReceived` INT UNSIGNED NOT NULL,
    `unitCost` DECIMAL(10,2) NOT NULL,
    `deliveryDate` DATE NOT NULL,
    `orderDate` DATE NOT NULL,
    PRIMARY KEY (`restockID`),
    INDEX `idx_supplied_by` (`supplierID`),
    INDEX `idx_asset_restocked` (`itemID`),
    INDEX `idx_restocked_by` (`restockedBy`),
    CONSTRAINT `idx_supplied_by`
		FOREIGN KEY (`supplierID`) REFERENCES `Supplier` (`supplierID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
	CONSTRAINT `idx_asset_restocked`
		FOREIGN KEY (`itemID`) REFERENCES `Inventory` (`itemID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION,
	CONSTRAINT `idx_restocked_by`
		FOREIGN KEY (`restockedBy`) REFERENCES `Employee` (`employeeID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE Asset AUTO_INCREMENT = 1001;
ALTER TABLE Inventory AUTO_INCREMENT = 2001;
ALTER TABLE Employee AUTO_INCREMENT = 3001;
ALTER TABLE Supplier AUTO_INCREMENT = 4001;

ALTER TABLE Contract AUTO_INCREMENT = 5001;
ALTER TABLE RenewalContract AUTO_INCREMENT = 6001;
ALTER TABLE Restock AUTO_INCREMENT = 7001;
ALTER TABLE Assigning AUTO_INCREMENT = 8001;
ALTER TABLE Monitoring AUTO_INCREMENT = 9001;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------------------
-- SAMPLE DATA SET FOR IT ASSET AND INVENTORY MANAGEMENT DATABASE
-- -----------------------------------------------------------------

USE asset_management_db;

INSERT INTO Employee (firstName, lastName, department, position, contactNumber, email) VALUES
('Ethan', 'Valdez', 'IT Operations', 'IT Operations Engineer', '09170122345', 'ethan.valdez@novalink.com'),
('Carla', 'Montenegro', 'IT Asset Management', 'Asset Management Analyst', '09171239485', 'carla.montenegro@novalink.com'),
('Julian', 'Chavez', 'Procurement', 'Procurement Specialist', '09172349851', 'julian.chavez@novalink.com'),
('Bianca', 'Lopez', 'Cybersecurity', 'Information Security Officer', '09173458912', 'bianca.lopez@novalink.com'),
('Miguel', 'Soriano', 'Infrastructure Services', 'Systems Administrator', '09174567823', 'miguel.soriano@novalink.com'),
('Leah', 'Domingo', 'Network Services', 'Network Support Engineer', '09175678934', 'leah.domingo@novalink.com'),
('Patrick', 'Castro', 'IT Service Desk', 'Service Desk Technician', '09176789345', 'patrick.castro@novalink.com'),
('Rina', 'Aquino', 'Facilities & Logistics', 'Warehouse & Logistics Coordinator', '09177893456', 'rina.aquino@novalink.com'),
('Harold', 'Vergara', 'Finance & Compliance', 'Compliance and Audit Associate', '09178934567', 'harold.vergara@novalink.com'),
('Nadine', 'Santiago', 'Business Solutions', 'Business Systems Analyst', '09179012345', 'nadine.santiago@novalink.com');

INSERT INTO Asset (expiryDate, purchaseDate, a_status, assetType) VALUES
('2027-05-10', '2024-05-10', 'active', 'h'),
('2026-11-22', '2023-11-22', 'active', 's'),
('2025-09-30', '2022-09-30', 'expired', 'h'),
('2028-02-18', '2024-02-18', 'active', 's'),
('2024-12-01', '2021-12-01', 'damaged', 'h'),
('2027-07-14', '2023-07-14', 'active', 'h'),
('2025-04-05', '2022-04-05', 'returned', 's'),
('2029-01-10', '2024-01-10', 'active', 's'),
('2024-08-19', '2021-08-19', 'lost', 'h'),
('2026-03-25', '2023-03-25', 'inactive', 's');

INSERT INTO HardwareAsset (H_assetID, h_type, brand, model, serialNumber) VALUES
(1001, 'Laptop', 'Dell', 'Latitude 5440', 'SN-A1X45D9'),
(1003, 'Desktop', 'Lenovo', 'ThinkCentre M720', 'SN-HW93KD2'),
(1005, 'Router', 'TP-Link', 'Archer AX55', 'SN-RTR772Q'),
(1006, 'Monitor', 'HP', 'ProDisplay P24', 'SN-MNT882C'),
(1009, 'Keyboard', 'Logitech', 'MX Keys', 'SN-KBD114Z');

INSERT INTO SoftwareLicense (S_assetID, softwareName, version, licenseKey, numOfUsers) VALUES
(1002, 'Microsoft Office 365', 'Standard','O365-92KD-XY33-HF21', 25),
(1004, 'Adobe Photoshop', '2024', 'ADBP-88DH-223J-KL99', 2),
(1007, 'FortiClient VPN', '7.2', 'FCTVN-12KD-77HS-PLQ8', 50),
(1008, 'Windows 11 Pro', '23H2', 'WIN11P-91KD-QWEE-118Z', 1),
(1010, 'AutoCAD LT', '2023', 'ACLT-55RH-992L-ZXT7', 1);

INSERT INTO Inventory (itemName, itemType, unit, stockQty, reorderLevel, i_status) VALUES
('Cat6 Ethernet Cable', 'Networking', 'pieces', 120, 30, 'active'),
('SSD 1TB Samsung 870 EVO', 'Storage', 'pieces', 25, 5, 'active'),
('Wireless Mouse Logitech M331', 'Peripheral', 'pieces', 60, 15, 'active'),
('A4 Bond Paper', 'Office Supply', 'reams', 40, 10, 'active'),
('RJ45 Connectors', 'Networking', 'pack', 15, 5, 'active'),
('Printer Ink HP 680 Black', 'Consumable', 'cartridge', 8, 3, 'active'),
('USB-C to HDMI Adapter', 'Accessory', 'pieces', 20, 5, 'active'),
('Laptop Stand Aluminum Adjustable', 'Accessory', 'pieces', 12, 3, 'inactive'),
('Anti-Static Wrist Strap', 'Tool', 'pieces', 50, 10, 'active'),
('External Hard Drive Seagate 2TB', 'Storage', 'pieces', 10, 2, 'active');

INSERT INTO Supplier (companyName, firstName, lastName, contactNumber, email, zip, street, city) VALUES
('TechCore Distributors', 'Mark', 'Villanueva', '09171234567', 'mark.v@techcore.com', '1105', 'Aurora Blvd.', 'Quezon City'),
('Prime Office Solutions', 'Anna', 'Lopez', '09285551234', 'anna.lopez@primeoffice.ph', '1200', 'EDSA Extension', 'Pasay'),
('Innovatech Hardware Supply', 'John', 'Reyes', '09998887711', 'john.reyes@innovatech.com', '8000', 'JP Laurel Ave.', 'Davao City'),
('Metro IT Parts', 'Christine', 'Tan', '09187654321', 'ctan@metroitsupply.com', '6000', 'Osmeña Blvd.', 'Cebu City'),
('BlueWave Software Licensing', 'Daniel', 'Santos', '09351239876', 'dsantos@bluewave.ph', '1605', 'Ortigas Ave.', 'Pasig'),
('Reliable Office Depot', 'Karen', 'Lim', '09081234567', 'k.lim@reliabledepot.com', '1008', 'España Blvd.', 'Manila'),
('Digital Edge Components', 'Robert', 'Chua', '09175550000', 'rchua@digitaledge.com', '5000', 'Rizal St.', 'Iloilo City'),
('Unified Network Supplies', 'Jessa', 'Martinez', '09951234567', 'jessa.m@unsupplies.ph', '4026', 'Santa Rosa Tagaytay Rd.', 'Santa Rosa'),
('SecureSoft Licensing Hub', 'Patrick', 'Gomez', '09273334444', 'pgomez@securesoft.com', '7000', 'Pablo Ocampo St.', 'Zamboanga City'),
('NorthPoint Computer Parts', 'Elaine', 'Castro', '09364442222', 'ecast@northpointparts.ph', '2400', 'MacArthur Highway', 'Tarlac City');

INSERT INTO Assigning (assetID, assignedBy, assignmentDate, as_status) VALUES
(1001, 3002, '2024-01-10', 'active'),       -- Assigned laptop
(1002, 3002, '2024-01-12', 'active'),       -- Assigned software license
(1004, 3003, '2024-01-20', 'inactive'),     -- Assignment ended
(1006, 3001, '2024-02-05', 'active'),       -- Hardware asset
(1008, 3005, '2024-02-18', 'active'),       -- Software
(1003, 3009, '2024-03-02', 'inactive'),     -- Expired hardware previously assigned
(1005, 3006, '2024-03-14', 'active'),       -- Damaged hardware tracked
(1007, 3008, '2024-03-28', 'inactive'),     -- Returned software
(1009, 3004, '2024-04-11', 'active'),       -- Lost hardware logged as assigned historically
(1010, 3002, '2024-04-25', 'active');     -- Inactive software license assigned

INSERT INTO Monitoring (assetID, monitoringType, lastCheckedDate, expiryDate, notes) VALUES
(1001, 'h', '2024-05-15', NULL, 'Routine hardware inspection completed.'),
(1002, 's', '2024-05-20', '2026-11-22', 'License verification OK.'),
(1003, 'h', '2024-06-01', NULL, 'Unit showing signs of wear; monitor closely.'),
(1004, 's', '2024-06-10', '2028-02-18', 'Auto-renewal enabled.'),
(1005, 'h', '2024-06-18', NULL, 'Damaged unit; awaiting replacement approval.'),
(1006, 'h', '2024-07-02', NULL, 'Operating normally, no issues.'),
(1007, 's', '2024-07-15', '2025-04-05', 'Marked as returned; license no longer in use.'),
(1008, 's', '2024-07-22', '2029-01-10', 'Software functioning properly.'),
(1009, 'h', '2024-08-05', NULL, 'Item reported lost; monitoring archived.'),
(1010, 's', '2024-08-18', '2026-03-25', 'Inactive license, last audit passed.');

INSERT INTO SoftwareMonitoring (S_monitoringID, depreciationStatus) VALUES
(9002, 'Good – License fully valid'),
(9004, 'Good – Within subscription period'),
(9007, 'Deactivated – Returned license'),
(9008, 'Optimal – Long-term license active'),
(9010, 'Inactive – License nearing renewal');

INSERT INTO HardwareMonitoring (H_monitoringID, complianceStatus) VALUES
(9001, 'Compliant – No issues detected'),
(9003, 'Minor issues – Wear observed'),
(9005, 'Non-compliant – Damaged unit'),
(9006, 'Compliant – Operating normally'),
(9009, 'Non-compliant – Reported lost');

INSERT INTO Contract (assetID, supplierID, startDate, expiryDate, payment, responsibilities) VALUES
(1001, 4003, '2024-01-10', '2027-01-10', '₱48,000 – One-time', 'Supplier provides hardware diagnostics and annual maintenance.'),
(1002, 4005, '2024-02-05', '2026-02-05', '₱14,000/year', 'Supplier responsible for license renewal and version upgrades.'),
(1003, 4009, '2023-03-15', '2025-03-15', '₱25,000 – One-time', 'Supplier handles evaluation of expired hardware components.'),
(1004, 4002, '2024-03-20', '2028-03-20', '₱20,000/year', 'Supplier must handle software patching and technical support.'),
(1005, 4010, '2022-06-01', '2024-06-01', '₱18,000 – One-time', 'Supplier responsible for reviewing damage and providing replacement options.'),
(1006, 4001, '2023-07-18', '2027-07-18', '₱52,000 – One-time', 'Supplier provides compliance checks and annual servicing.'),
(1007, 4008, '2022-04-12', '2025-04-12', '₱12,000/year', 'Supplier manages license deactivation and reassignment processes.'),
(1008, 4004, '2024-01-28', '2029-01-28', '₱24,000/year', 'Supplier ensures long-term subscription stability and cloud sync support.'),
(1009, 4007, '2021-09-05', '2024-09-05', '₱20,500 – One-time', 'Supplier handles lost equipment reporting and verification.'),
(1010, 4006, '2023-04-02', '2026-04-02', '₱16,000/year', 'Supplier responsible for license compliance and reactivation assistance.');

INSERT INTO RenewalContract 
(assetID, contractID, renewedBy, renewedFrom, renewalDate, newExpiryDate) VALUES
(1001, 5001, 3003, 4003, '2026-12-15', '2029-12-15'),
(1002, 5002, 3002, 4005, '2025-12-10', '2028-12-10'),
(1003, 5003, 3009, 4009, '2025-02-20', '2027-02-20'),
(1004, 5004, 3004, 4002, '2027-12-05', '2030-12-05'),
(1005, 5005, 3008, 4010, '2024-05-15', '2026-05-15'),
(1006, 5006, 3001, 4001, '2027-06-20', '2029-06-20'),
(1007, 5007, 3007, 4008, '2025-03-25', '2027-03-25'),
(1008, 5008, 3005, 4004, '2029-01-05', '2031-01-05'),
(1009, 5009, 3010, 4007, '2024-08-10', '2026-08-10'),
(1010, 5010, 3006, 4006, '2026-03-15', '2028-03-15');

INSERT INTO Restock (supplierID, itemID, restockedBy, qtyReceived, unitCost, deliveryDate, orderDate) VALUES
(4001, 2001, 3003, 85, 145.00, '2025-01-12', '2025-01-07'),   
(4004, 2002, 3005, 30, 4450.00, '2025-02-18', '2025-02-12'),  
(4003, 2003, 3002, 55, 360.00, '2025-03-04', '2025-02-28'),    
(4002, 2004, 3006, 25, 115.00, '2025-03-22', '2025-03-18'),    
(4005, 2005, 3001, 180, 28.00, '2025-04-03', '2025-03-30'),    
(4006, 2006, 3009, 12, 1980.00, '2025-04-11', '2025-04-07'),  
(4007, 2007, 3007, 20, 740.00, '2025-05-15', '2025-05-10'),    
(4008, 2008, 3008, 6, 3480.00, '2025-05-28', '2025-05-23'),   
(4009, 2009, 3004, 45, 125.00, '2025-06-03', '2025-05-29'),    
(4010, 2010, 3010, 10, 7600.00, '2025-06-17', '2025-06-12');