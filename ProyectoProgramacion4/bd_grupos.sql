
DROP SCHEMA IF EXISTS `bd_grupos`;
CREATE SCHEMA `bd_grupos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE `bd_grupos`;
SET GLOBAL time_zone = '-6:00';

-- DROP TABLE `bd_grupos`.`estudiante`;
CREATE TABLE IF NOT EXISTS `bd_grupos`.`estudiante` (
  `id` VARCHAR(15) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`));

-- DROP TABLE `bd_grupos`.`grupo`;
CREATE TABLE IF NOT EXISTS `bd_grupos`.`grupo` (
  `id` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id`));

-- DROP TABLE `bd_grupos`.`grupo_formado`;
CREATE TABLE IF NOT EXISTS `bd_grupos`.`grupo_formado` (
  `estudiante_id` VARCHAR(15) NOT NULL,
  `grupo_id` VARCHAR(15) NOT NULL,
  
  PRIMARY KEY (`estudiante_id`, `grupo_id`),
  INDEX `fk_formadoGrup_curso1_idx` (`grupo_id` ASC),
  CONSTRAINT `fk_formadoGrup_estudiante`
  
    FOREIGN KEY (`estudiante_id`)
    REFERENCES `bd_grupos`.`estudiante` (`id`)
    ON DELETE NO ACTION
    
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formadoGrup_curso1`
    FOREIGN KEY (`grupo_id`)
    
    REFERENCES `bd_grupos`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
