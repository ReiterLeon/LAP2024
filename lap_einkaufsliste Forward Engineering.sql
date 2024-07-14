-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lap_einkaufsliste
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lap_einkaufsliste
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lap_einkaufsliste` DEFAULT CHARACTER SET utf8 ;
USE `lap_einkaufsliste` ;

-- -----------------------------------------------------
-- Table `lap_einkaufsliste`.`BENUTZER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_einkaufsliste`.`BENUTZER` (
  `idBENUTZER` INT NOT NULL AUTO_INCREMENT,
  `BENUTZERMail` VARCHAR(45) NOT NULL,
  `BENUTZERPasswort` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`idBENUTZER`),
  UNIQUE INDEX `idBENUTZER_UNIQUE` (`idBENUTZER` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_einkaufsliste`.`KATEGORIE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_einkaufsliste`.`KATEGORIE` (
  `idKATEGORIE` INT NOT NULL AUTO_INCREMENT,
  `KATEGORIEBezeichnung` VARCHAR(45) NULL,
  `BENUTZER_idBENUTZER` INT NOT NULL,
  PRIMARY KEY (`idKATEGORIE`, `BENUTZER_idBENUTZER`),
  UNIQUE INDEX `idKATEGORIE_UNIQUE` (`idKATEGORIE` ASC) ,
  INDEX `fk_KATEGORIE_BENUTZER1_idx` (`BENUTZER_idBENUTZER` ASC) ,
  CONSTRAINT `fk_KATEGORIE_BENUTZER1`
    FOREIGN KEY (`BENUTZER_idBENUTZER`)
    REFERENCES `lap_einkaufsliste`.`BENUTZER` (`idBENUTZER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_einkaufsliste`.`PRODUKT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_einkaufsliste`.`PRODUKT` (
  `idPRODUKT` INT NOT NULL AUTO_INCREMENT,
  `PRODUKTBezeichnung` VARCHAR(45) NULL,
  `PRODUKTBeschreibung` VARCHAR(45) NULL,
  `KATEGORIE_idKATEGORIE` INT NOT NULL,
  `BENUTZER_idBENUTZER` INT NOT NULL,
  PRIMARY KEY (`idPRODUKT`, `KATEGORIE_idKATEGORIE`, `BENUTZER_idBENUTZER`),
  UNIQUE INDEX `idPRODUKT_UNIQUE` (`idPRODUKT` ASC) ,
  INDEX `fk_PRODUKT_KATEGORIE1_idx` (`KATEGORIE_idKATEGORIE` ASC) ,
  INDEX `fk_PRODUKT_BENUTZER1_idx` (`BENUTZER_idBENUTZER` ASC) ,
  CONSTRAINT `fk_PRODUKT_KATEGORIE1`
    FOREIGN KEY (`KATEGORIE_idKATEGORIE`)
    REFERENCES `lap_einkaufsliste`.`KATEGORIE` (`idKATEGORIE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUKT_BENUTZER1`
    FOREIGN KEY (`BENUTZER_idBENUTZER`)
    REFERENCES `lap_einkaufsliste`.`BENUTZER` (`idBENUTZER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_einkaufsliste`.`LISTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_einkaufsliste`.`LISTE` (
  `idLISTE` INT NOT NULL AUTO_INCREMENT,
  `LISTEBezeichnung` VARCHAR(45) NULL,
  `BENUTZER_idBENUTZER` INT NOT NULL,
  PRIMARY KEY (`idLISTE`, `BENUTZER_idBENUTZER`),
  UNIQUE INDEX `idLISTE_UNIQUE` (`idLISTE` ASC) ,
  INDEX `fk_LISTE_BENUTZER1_idx` (`BENUTZER_idBENUTZER` ASC) ,
  CONSTRAINT `fk_LISTE_BENUTZER1`
    FOREIGN KEY (`BENUTZER_idBENUTZER`)
    REFERENCES `lap_einkaufsliste`.`BENUTZER` (`idBENUTZER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_einkaufsliste`.`SHOP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_einkaufsliste`.`SHOP` (
  `idSHOP` INT NOT NULL AUTO_INCREMENT,
  `SHOPBezeichnung` VARCHAR(45) NULL,
  `BENUTZER_idBENUTZER` INT NOT NULL,
  PRIMARY KEY (`idSHOP`, `BENUTZER_idBENUTZER`),
  UNIQUE INDEX `idSHOP_UNIQUE` (`idSHOP` ASC) ,
  INDEX `fk_SHOP_BENUTZER_idx` (`BENUTZER_idBENUTZER` ASC) ,
  CONSTRAINT `fk_SHOP_BENUTZER`
    FOREIGN KEY (`BENUTZER_idBENUTZER`)
    REFERENCES `lap_einkaufsliste`.`BENUTZER` (`idBENUTZER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_einkaufsliste`.`LISTE_PRODUKT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_einkaufsliste`.`LISTE_PRODUKT` (
  `idLISTE_PRODUKT` INT NOT NULL AUTO_INCREMENT,
  `LISTE_PRODUKTAnmerkung` VARCHAR(60) NULL,
  `LISTE_PRODUKTMenge` INT NULL,
  `LISTE_PRODUKTGekauft` BIT NOT NULL,
  `LISTE_idLISTE` INT NOT NULL,
  `SHOP_idSHOP` INT NOT NULL,
  `PRODUKT_idPRODUKT` INT NOT NULL,
  PRIMARY KEY (`idLISTE_PRODUKT`, `LISTE_idLISTE`, `PRODUKT_idPRODUKT`),
  UNIQUE INDEX `idLISTE_PRODUKT_UNIQUE` (`idLISTE_PRODUKT` ASC) ,
  INDEX `fk_LISTE_PRODUKT_LISTE1_idx` (`LISTE_idLISTE` ASC) ,
  INDEX `fk_LISTE_PRODUKT_SHOP1_idx` (`SHOP_idSHOP` ASC) ,
  INDEX `fk_LISTE_PRODUKT_PRODUKT1_idx` (`PRODUKT_idPRODUKT` ASC) ,
  CONSTRAINT `fk_LISTE_PRODUKT_LISTE1`
    FOREIGN KEY (`LISTE_idLISTE`)
    REFERENCES `lap_einkaufsliste`.`LISTE` (`idLISTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LISTE_PRODUKT_SHOP1`
    FOREIGN KEY (`SHOP_idSHOP`)
    REFERENCES `lap_einkaufsliste`.`SHOP` (`idSHOP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LISTE_PRODUKT_PRODUKT1`
    FOREIGN KEY (`PRODUKT_idPRODUKT`)
    REFERENCES `lap_einkaufsliste`.`PRODUKT` (`idPRODUKT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
