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
    `department` VARCHAR(100) NOT NULL,
    `position` VARCHAR(100) NOT NULL,
    `contactNumber` VARCHAR(20) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
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
    `status` ENUM('active', 'inactive', 'expired', 'damaged', 'lost', 'returned') NOT NULL,
    `assetType` ENUM('hardware', 'software') NOT NULL,
    PRIMARY KEY (`assetID`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- HARDWARE ASSET TABLE
-- ------------------------------------------------
DROP TABLE IF EXISTS `HardwareAsset`;
CREATE TABLE IF NOT EXISTS `HardwareAsset`(
	`H_assetID` INT UNSIGNED NOT NULL,
    `type` VARCHAR(20) NOT NULL,
    `brand` VARCHAR(50) NOT NULL,
    `model` VARCHAR(50) NOT NULL,
    `serialNumber` VARCHAR(50) NOT NULL,
    `assetType` ENUM('hardware', 'software') NOT NULL,
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
    `licenseKey` VARCHAR(50) NOT NULL,
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
    `status` ENUM('active', 'inactive') NOT NULL,
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
    `email` VARCHAR(100) NOT NULL,
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
    `assignedBy` INT UNSIGNED NOT NULL,
    `assignmentDate` DATE,
    `status` ENUM('active', 'inactive') NOT NULL,
    PRIMARY KEY (`assignmentID`),
    INDEX `idx_assigned_by_employee` (`assignedBy`),
    CONSTRAINT `idx_assigned_by_employee`
		FOREIGN KEY (`assignedBy`) REFERENCES `Employee` (`employeeID`)
        ON DELETE RESTRICT ON UPDATE NO ACTION
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------
-- MONITORING TRANSACTION
-- ------------------------------------------------
DROP TABLE IF EXISTS `Monitoring`;
CREATE TABLE `Monitoring`(
	`monitoringID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `assetID` INT UNSIGNED NOT NULL,
    `monitoringType` ENUM('software', 'hardware') NOT NULL,
    `expiryDate` DATE NOT NULL,
    `lastCheckedDate` DATE NULL,
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
    `payment` VARCHAR(50) NOT NULL,
    `responsibilites` VARCHAR(200) NULL,
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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;