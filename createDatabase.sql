#Ce fichier contient la base de données à créer

CREATE DATABASE IF NOT EXISTS raspisms;
USE raspisms;

CREATE TABLE IF NOT EXISTS settings
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL,
	value VARCHAR(1000) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS receiveds
(
	id INT NOT NULL AUTO_INCREMENT,
	at DATETIME NOT NULL,
	send_by VARCHAR(12) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	is_command BOOLEAN NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sendeds
(
	id INT NOT NULL AUTO_INCREMENT,
	at DATETIME NOT NULL,
	target VARCHAR(12) NOT NULL,
	content VARCHAR(1000) NOT NULL,
	before_delivered INT NOT NULL,
	delivered BOOLEAN NOT NULL DEFAULT FALSE,
	failed BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS scheduleds
(
	id INT NOT NULL AUTO_INCREMENT,
	at DATETIME NOT NULL,
	content VARCHAR(1000) NOT NULL,
	progress BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS contacts
(
	
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	number VARCHAR(12) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS groups
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS groups_contacts
(
	id INT NOT NULL AUTO_INCREMENT,
	id_group INT NOT NULL,
	id_contact INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_group) REFERENCES groups (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_contact) REFERENCES contacts (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS scheduleds_contacts
(
	id INT NOT NULL AUTO_INCREMENT,
	id_scheduled INT NOT NULL,
	id_contact INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_scheduled) REFERENCES scheduleds (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_contact) REFERENCES contacts (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS scheduleds_groups
(
	id INT NOT NULL AUTO_INCREMENT,
	id_scheduled INT NOT NULL,
	id_group INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_scheduled) REFERENCES scheduleds (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_group) REFERENCES groups (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS scheduleds_numbers
(
	id INT NOT NULL AUTO_INCREMENT,
	id_scheduled INT NOT NULL,
	number VARCHAR(12) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_scheduled) REFERENCES scheduleds (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS commands
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(25) NOT NULL,
	script VARCHAR(100) NOT NULL,
	admin BOOLEAN NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS events
(
	id INT NOT NULL AUTO_INCREMENT,
	type VARCHAR(25) NOT NULL,
	at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	text VARCHAR(255) NOT NULL,	
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users
(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
	admin BOOLEAN NOT NULL DEFAULT FALSE,
	transfer BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY (id),
	UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS transfers
(
	id INT NOT NULL AUTO_INCREMENT,
	id_received INT NOT NULL,
	progress BOOLEAN NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY (id_received) REFERENCES receiveds (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sms_stop
(
	id INT NOT NULL AUTO_INCREMENT,
	number VARCHAR(12) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE (number)
);

#On insert les données par défaut dans les settings
INSERT INTO settings (name, value)
VALUES ('transfer', '1'),
('sms_stop', '1'),
('detect_url', '1'); 
