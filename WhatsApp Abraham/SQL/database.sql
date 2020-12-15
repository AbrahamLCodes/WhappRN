SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema whatsapp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema whatsapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `whatsapp` DEFAULT CHARACTER SET utf8 ;
USE `whatsapp` ;

-- -----------------------------------------------------
-- Table `whatsapp`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `foto` VARCHAR(200) NULL,
  `informacion` VARCHAR(50) NULL,
  PRIMARY KEY (`idusuarios`, `telefono`))
ENGINE = InnoDB;

INSERT INTO `usuarios` VALUES ('1','6143748153','Felix Soto','https://vignette.wikia.nocookie.net/toradora/images/f/f8/Ryuuji.jpg/revision/latest/scale-to-width-down/200?cb=20131221040940&path-prefix=es','A quien le compro boneless?');
INSERT INTO `usuarios` VALUES ('2','6143721135','Mario Tejada','https://vignette.wikia.nocookie.net/wikia-toradora/images/6/60/46644.jpg/revision/latest?cb=20160206195911&path-prefix=es','Quien me compra boneless?');
INSERT INTO `usuarios` VALUES ('3','6481227000','Abraham Luna','https://vignette.wikia.nocookie.net/wikia-toradora/images/6/60/46644.jpg/revision/latest?cb=20160206195911&path-prefix=es','asdasd');

/* inserts de Felix */
INSERT INTO usuarios VALUES ('4','6142569001','Fernando Noche','https://static.wikia.nocookie.net/haruhi/images/4/47/Haruhi_Suzumiya_Profile.png/revision/latest/scale-to-width-down/1000?cb=20200802131752','Los Queries');
INSERT INTO usuarios VALUES ('5','6481227055','Nevin Almanza','https://static.wikia.nocookie.net/haruhi/images/4/47/Haruhi_Suzumiya_Profile.png/revision/latest/scale-to-width-down/1000?cb=20200802131752','Fuga a pistear');
INSERT INTO usuarios VALUES ('6','6141770591','Soto Blanco','https://static.wikia.nocookie.net/haruhi/images/4/47/Haruhi_Suzumiya_Profile.png/revision/latest/scale-to-width-down/1000?cb=20200802131752','Ya me canse');

select * FROM usuarios;

-- -----------------------------------------------------
-- Table `whatsapp`.`conversacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`conversacion` (
  `idconversacion` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`idconversacion`))
ENGINE = InnoDB;

INSERT INTO conversacion VALUES ('1','','Mario Tejada');
INSERT INTO conversacion VALUES ('2','','Felix Soto');


-- -----------------------------------------------------
-- Table `whatsapp`.`mensajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`mensajes` (
  `idmensajes` INT NOT NULL,
  `conversacion_idconversacion` INT NOT NULL,
  `mensaje` VARCHAR(60) NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_telefono` VARCHAR(12) NOT NULL,
  `visto` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idmensajes`),
  INDEX `fk_mensajes_conversacion_idx` (`conversacion_idconversacion` ASC) ,
  INDEX `fk_mensajes_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_telefono` ASC) ,
  CONSTRAINT `fk_mensajes_conversacion`
    FOREIGN KEY (`conversacion_idconversacion`)
    REFERENCES `whatsapp`.`conversacion` (`idconversacion`)
    ,
  CONSTRAINT `fk_mensajes_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_telefono`)
    REFERENCES `whatsapp`.`usuarios` (`idusuarios` , `telefono`)
   )
ENGINE = InnoDB;

INSERT INTO mensajes VALUES ('1','2','Que onda bebe, cuando me invitas a cenar?','2020/12/03','2:01:00','2','6143721135','1');
INSERT INTO mensajes VALUES ('2','2','De una vez, dime a que hora paso por ti?','2020/12/03','2:05:00','1','6143748153','1');
INSERT INTO mensajes VALUES ('3','2','ufff ahorita tengo unos pendientes dejame me arreglo rapido','2020/12/03','2:07:00','2','6143721135','1');
INSERT INTO mensajes VALUES ('4','2','Pasa por mi a las 5:00 sale?','2020/12/03','2:08:00','2','6143721135','1');
INSERT INTO mensajes VALUES ('5','2','Perfecto bebe llegare por ti en mi troca','2020/12/03','2:10:00','1','6143748153','1');


-- -----------------------------------------------------
-- Table `whatsapp`.`usuarios_has_conversacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`usuarios_has_conversacion` (
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_telefono` VARCHAR(12) NOT NULL,
  `conversacion_idconversacion` INT NOT NULL,
  PRIMARY KEY (`usuarios_idusuarios`, `usuarios_telefono`, `conversacion_idconversacion`),
  INDEX `fk_usuarios_has_conversacion_conversacion1_idx` (`conversacion_idconversacion` ASC) ,
  INDEX `fk_usuarios_has_conversacion_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_telefono` ASC) ,
  CONSTRAINT `fk_usuarios_has_conversacion_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_telefono`)
    REFERENCES `whatsapp`.`usuarios` (`idusuarios` , `telefono`)
    ,
  CONSTRAINT `fk_usuarios_has_conversacion_conversacion1`
    FOREIGN KEY (`conversacion_idconversacion`)
    REFERENCES `whatsapp`.`conversacion` (`idconversacion`)
    )
ENGINE = InnoDB;
INSERT INTO usuarios_has_conversacion VALUES ('2','6143721135','2');
INSERT INTO usuarios_has_conversacion VALUES ('1','6143748153','2');
USE whatsapp;
SELECT * FROM usuarios;

-- -----------------------------------------------------
-- Table `whatsapp`.`contenido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`contenido` (
  `idcontenido` INT NOT NULL,
  `ruta` VARCHAR(100) NULL,
  `mensajes_idmensajes` INT NOT NULL,
  PRIMARY KEY (`idcontenido`),
  INDEX `fk_contenido_mensajes1_idx` (`mensajes_idmensajes` ASC) ,
  CONSTRAINT `fk_contenido_mensajes1`
    FOREIGN KEY (`mensajes_idmensajes`)
    REFERENCES `whatsapp`.`mensajes` (`idmensajes`)
    )
ENGINE = InnoDB;

INSERT INTO contenido VALUES ('1','','1');
INSERT INTO contenido VALUES ('2','','2');
INSERT INTO contenido VALUES ('3','','3');
INSERT INTO contenido VALUES ('4','','4');
INSERT INTO contenido VALUES ('5','','5');


-- -----------------------------------------------------
-- Table `whatsapp`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`estados` (
  `idestados` INT NOT NULL,
  `ruta` VARCHAR(80) NULL,
  `mensaje` VARCHAR(60) NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_telefono` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idestados`),
  INDEX `fk_estados_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_telefono` ASC) ,
  CONSTRAINT `fk_estados_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_telefono`)
    REFERENCES `whatsapp`.`usuarios` (`idusuarios` , `telefono`)
  )
ENGINE = InnoDB;

INSERT INTO estados VALUES ('1','https://i.pinimg.com/originals/f7/43/88/f74388f46cf957adfc2f17d3d55eea7a.jpg','Aqui con mi amors','2020/12/03','17:12:00','2','6143721135');
/* INSERTS de Felix arreglados*/
INSERT INTO estados VALUES ('2','https://i.pinimg.com/originals/f7/43/88/f74388f46cf957adfc2f17d3d55eea7a.jpg','Aqui con mi amors2','2020/01/30','13:16:01','3','6481227000');
INSERT INTO estados VALUES ('3','https://i.pinimg.com/originals/f7/43/88/f74388f46cf957adfc2f17d3d55eea7a.jpg','Aqui con mi amors3','2020/10/21','16:12:50','1','6143748153');
INSERT INTO estados VALUES ('4','https://i.pinimg.com/originals/f7/43/88/f74388f46cf957adfc2f17d3d55eea7a.jpg','Aqui con mi amors4','2020/02/23','13:15:30','4','6142569001');
select * from estados;
-- -----------------------------------------------------
-- Table `whatsapp`.`llamada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`llamada` (
  `idllamada` INT NOT NULL,
  `fechahora` DATETIME NOT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_telefono` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idllamada`),
  INDEX `fk_llamada_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_telefono` ASC) ,
  CONSTRAINT `fk_llamada_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_telefono`)
    REFERENCES `whatsapp`.`usuarios` (`idusuarios` , `telefono`)
    )
ENGINE = InnoDB;
INSERT INTO llamada VALUES('1','2020/12/03 16:45:00','2','6143721135');
INSERT INTO llamada VALUES('2','2020/12/02 12:12:00','2','6143721135');
INSERT INTO llamada VALUES('3','2020/12/03 18:20:00','2','6143721135');

INSERT INTO llamada VALUES('4','2020/2/03 16:45:00','1','6143748153');
INSERT INTO llamada VALUES('5','2020/1/02 12:12:00','4','6142569001');
INSERT INTO llamada VALUES('6','2020/12/03 18:20:00','1','6143748153');

-- -----------------------------------------------------
-- Table `whatsapp`.`llamada_has_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whatsapp`.`llamada_has_usuarios` (
  `llamada_idllamada` INT NOT NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `usuarios_telefono` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`llamada_idllamada`, `usuarios_idusuarios`, `usuarios_telefono`),
  INDEX `fk_llamada_has_usuarios_usuarios1_idx` (`usuarios_idusuarios` ASC, `usuarios_telefono` ASC) ,
  INDEX `fk_llamada_has_usuarios_llamada1_idx` (`llamada_idllamada` ASC) ,
  CONSTRAINT `fk_llamada_has_usuarios_llamada1`
    FOREIGN KEY (`llamada_idllamada`)
    REFERENCES `whatsapp`.`llamada` (`idllamada`)
   ,
  CONSTRAINT `fk_llamada_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` , `usuarios_telefono`)
    REFERENCES `whatsapp`.`usuarios` (`idusuarios` , `telefono`)
   )
ENGINE = InnoDB;
INSERT INTO llamada_has_usuarios VALUES ('1','2','6143721135');
INSERT INTO llamada_has_usuarios VALUES ('2','2','6143721135');
INSERT INTO llamada_has_usuarios VALUES ('3','2','6143721135');

use whatsapp;

/* Chats*/
use whatsapp;
SELECT usuarios.nombre, usuarios.foto, usuarios_has_conversacion.conversacion_idconversacion as idconversacion FROM usuarios JOIN usuarios_has_conversacion ON usuarios.idusuarios = usuarios_has_conversacion.usuarios_idusuarios JOIN (SELECT conversacion_idconversacion FROM usuarios_has_conversacion WHERE usuarios_idusuarios = 2) AS c ON c.conversacion_idconversacion = usuarios_has_conversacion.conversacion_idconversacion WHERE usuarios_idusuarios != 2;

-- contactos
SELECT nombre, foto FROM usuarios WHERE idusuarios != 2;

/* Llamadas*/
SELECT idllamada, fechahora, usuarios_idusuarios, foto, nombre FROM llamada INNER JOIN usuarios ON usuarios_idusuarios=idusuarios WHERE usuarios_idusuarios != 2 ORDER BY idllamada;

/*Estados*/
SELECT ruta, usuarios_idusuarios, hora, nombre FROM estados INNER JOIN usuarios ON usuarios_idusuarios=idusuarios WHERE usuarios_idusuarios != 2;

use whatsapp;
SELECT usuarios.nombre, usuarios.foto, usuarios_has_conversacion.conversacion_idconversacion as idconversacion FROM usuarios JOIN usuarios_has_conversacion ON usuarios.idusuarios = usuarios_has_conversacion.usuarios_idusuarios JOIN (SELECT conversacion_idconversacion FROM usuarios_has_conversacion WHERE usuarios_idusuarios = 2) AS c ON c.conversacion_idconversacion = usuarios_has_conversacion.conversacion_idconversacion WHERE usuarios_idusuarios != 2;




CREATE DATABASE whapp;
USE whapp;

CREATE TABLE usuarios(
celular varchar(50) PRIMARY KEY,
nombre varchar (50) PRIMARY KEY
);

INSERT INTO usuarios VALUES ('6141110000', 'Ruben');