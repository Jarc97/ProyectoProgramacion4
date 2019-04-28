
DROP SCHEMA IF EXISTS `eif209_1901_p01` ;
CREATE SCHEMA IF NOT EXISTS `eif209_1901_p01`
	DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE `eif209_1901_p01` ;
SET GLOBAL time_zone = '-6:00';
-- DROP TABLE IF EXISTS `eif209_1901_p01`.`grupo` ;
CREATE TABLE IF NOT EXISTS `eif209_1901_p01`.`grupo` (
  `id` INT(6) NOT NULL auto_increment,
  `secuencia` INT(6) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `cupo` INT(2) NOT NULL DEFAULT '0',
  `activo` INT(1) NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- DROP TABLE IF EXISTS `eif209_1901_p01`.`estudiante` ;
CREATE TABLE IF NOT EXISTS `eif209_1901_p01`.`estudiante` (
  `id` VARCHAR(15) NOT NULL,
  `nrc` INT(6) NOT NULL,
  `apellidos` VARCHAR(60) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `secuencia` INT(6) NOT NULL,
  `clave` VARCHAR(20) NOT NULL,
  `ultimo_acceso` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `grupo_id` INT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estudiante_grupo_idx` (`grupo_id` ASC),
  CONSTRAINT `fk_estudiante_grupo`
    FOREIGN KEY (`grupo_id`)
    REFERENCES `eif209_1901_p01`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE VIEW `general_estudiante` AS 
	SELECT
		`nrc`,
		`secuencia`,
		`id`,
		`apellidos`,
		`nombre`,
		`ultimo_acceso`,
		`grupo_id`
    FROM estudiante
    ORDER BY `nrc`, `secuencia`;
