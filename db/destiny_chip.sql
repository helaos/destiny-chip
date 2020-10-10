CREATE DATABASE `destiny_chip` CHARACTER SET utf8mb4;

USE `destiny_chip`;

DROP TABLE IF EXISTS `t_admin`;

CREATE TABLE `t_admin` (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
    `login_account` VARCHAR(255) NULL UNIQUE DEFAULT NULL COMMENT '登陆账号',
    `username` VARCHAR(30) NULL DEFAULT NULL COMMENT '用户昵称',
    `password` VARCHAR(255) NULL DEFAULT NULL COMMENT '登陆密码',
    `email` VARCHAR(50) NULL DEFAULT NULL COMMENT '邮箱地址',
    `create_time` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`)
)