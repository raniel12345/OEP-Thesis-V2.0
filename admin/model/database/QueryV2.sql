CREATE DATABASE OEPDb;

USE OEPDb;

CREATE TABLE IF NOT EXISTS AdminUsers(
	id INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(50),
	password VARCHAR(250),
	email_address VARCHAR(50),
	user_type INT DEFAULT 0,
	tag TEXT,
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Slideshow(
	id INT NOT NULL AUTO_INCREMENT,
	firstTitle VARCHAR(70),
	secondTitle VARCHAR(70),
	content TEXT,
	imgServerFileName VARCHAR(255),
	imgOrigFilename VARCHAR(255),
	userName VARCHAR(50),
	userId INT NOT NULL,
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Partners(
	id INT NOT NULL AUTO_INCREMENT,
	partnerName VARCHAR(50),
	info TEXT,
	contactSmart VARCHAR(50) DEFAULT "",
	contactGlobe VARCHAR(50) DEFAULT "",
	contactEmail VARCHAR(100) DEFAULT "",
	userName VARCHAR(50),
	userId INT NOT NULL,
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PartnersProductCategory(
	id INT NOT NULL AUTO_INCREMENT,
	prodCat VARCHAR(50),
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PartnersMotif(
	id INT NOT NULL AUTO_INCREMENT,
	partnerID INT,
	theme VARCHAR(70),
	prodCatID INT NOT NULL,
	userName VARCHAR(50),
	userId INT NOT NULL,
	isDeleted INT DEFAULT 0,
	FOREIGN KEY (partnerID) REFERENCES Partners(id),
	FOREIGN KEY (prodCatID) REFERENCES PartnersProductCategory(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PartnersMotifImages(
	id INT NOT NULL AUTO_INCREMENT,
	motifID INT NOT NULL,
	serverName VARCHAR(255),
	origName VARCHAR(255),
	imageRefNo INT NOT NULL,
	price DECIMAL(19,2) DEFAULT 0,
	isDelete INT DEFAULT 0,
	FOREIGN KEY (motifID) REFERENCES PartnersMotif(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Services(
	id INT NOT NULL AUTO_INCREMENT,
	service VARCHAR(50),
	motif VARCHAR(50),
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Venues(
	id INT NOT NULL AUTO_INCREMENT,
	venue VARCHAR(50),
	notes TEXT,
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;
ALTER TABLE Venues
ADD isOutside INT DEFAULT 0;


CREATE TABLE IF NOT EXISTS ServiceMotifs(
	id INT NOT NULL AUTO_INCREMENT,
	serviceID INT NOT NULL,
	motif VARCHAR(50),
	isDeleted INT DEFAULT 0,
	FOREIGN KEY (serviceID) REFERENCES Services(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS RecentEvents(
	id INT NOT NULL AUTO_INCREMENT,
	serviceID INT NOT NULL,
	eventName VARCHAR(50),
	address VARCHAR(100),
	eventDate DATE,
	description TEXT,
	comments TEXT,
	userName VARCHAR(50),
	userId INT NOT NULL,
	isDelete INT DEFAULT 0,
	FOREIGN KEY (serviceID) REFERENCES Services(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS RecentEvents_Images(
	id INT NOT NULL AUTO_INCREMENT,
	eventID INT NOT NULL,
	serverName VARCHAR(255),
	origName VARCHAR(255),
	isDelete INT DEFAULT 0,
	FOREIGN KEY (eventID) REFERENCES RecentEvents(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Materials(
	id INT NOT NULL AUTO_INCREMENT,
	material VARCHAR(50),
	userName VARCHAR(50),
	userId INT NOT NULL,
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS MaterialThemes(
	id INT NOT NULL AUTO_INCREMENT,
	materialID INT NOT NULL,
	theme VARCHAR(50),
	userName VARCHAR(50),
	userId INT NOT NULL,
	isDeleted INT DEFAULT 0,
	FOREIGN KEY (materialID) REFERENCES Materials(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS MaterialsTheme_images(
	id INT NOT NULL AUTO_INCREMENT,
	themeID INT NOT NULL,
	serverName VARCHAR(255),
	origName VARCHAR(255),
	referenceNo INT NOT NULL,
	price DECIMAL(19,2) DEFAULT 0,
	isDeleted INT DEFAULT 0,
	FOREIGN KEY (themeID) REFERENCES MaterialThemes(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Menus(
	id INT NOT NULL AUTO_INCREMENT,
	setTitle VARCHAR(50),
	setPrice DECIMAL(19,2),
	soup VARCHAR(70),
	soupIsChangable INT DEFAULT 0,
	chicken VARCHAR(70),
	chickenIsChangable INT DEFAULT 0,
	seafoods VARCHAR(70),
	seafoodsIsChangable INT DEFAULT 0,
	porkBeef VARCHAR(70),
	porkBeefIsChangable INT DEFAULT 0,
	vegetable VARCHAR(70),
	vegetableIsChangable INT DEFAULT 0,
	rice VARCHAR(70),
	riceIsChangable INT DEFAULT 0,
	salad VARCHAR(70),
	saladIsChangable INT DEFAULT 0,
	dessert VARCHAR(70),
	dessertIsChangable INT DEFAULT 0,
	drinks VARCHAR(70),
	drinksIsChangable INT DEFAULT 0,
	isDeleted INT DEFAULT 0,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Inquiries(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(70),
	name VARCHAR(50),
	contactNo VARCHAR(50),
	event VARCHAR(50),
	venue VARCHAR(100),
	isVenueOutside INT DEFAULT 0,
	venueAddress VARCHAR(255) DEFAULT "none",
	noOfGuests INT DEFAULT 0,
	inquiry TEXT,
	dateInq TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS RegisteredEmails(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(100),
	uniqueTag TEXT,
	isConfirm INT DEFAULT 0,
	dateReg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS RegisteredClient(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(100),
	uniqueTag TEXT,
	fullName VARCHAR(50),
	contactNo VARCHAR(50),
	clientPass TEXT,
	dateReg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ClientEvents(
	id INT NOT NULL AUTO_INCREMENT,
	clientInfoID INT NOT NULL,
	serviceID INT NOT NULL,
	serviceMotifID INT NOT NULL,
	venueID INT NOT NULL,
	venueAddress VARCHAR(70) DEFAULT 'NONE',
	eventDate DATE,
	eventStartTime VARCHAR(30),
	eventEndTime VARCHAR(30),
	noOfGuests INT DEFAULT 0,
	entryDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	isDeleted INT DEFAULT 0,
	eventStatus INT DEFAULT 1,
	FOREIGN KEY (clientInfoID) REFERENCES RegisteredClient(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;


--budgetRangeID INT NOT NULL,
--1 new event, 2 approved, 3 on-going preparation, 4 event on-going, 5 done

CREATE TABLE IF NOT EXISTS EventsMaterials(
	id INT NOT NULL AUTO_INCREMENT,
	eventID INT NOT NULL,
	materialID INT NOT NULL,
	materialMotifImgID INT DEFAULT 0,
	isDeleted INT DEFAULT 0,
	dateEntry TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (eventID) REFERENCES ClientEvents(id),
	FOREIGN KEY (materialID) REFERENCES Materials(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS EventsFoodsEntertainments(
	id INT NOT NULL AUTO_INCREMENT,
	eventID INT NOT NULL,
	prodCatID INT NOT NULL,
	PartnersMotifImgID INT DEFAULT 0,
	isDeleted INT DEFAULT 0,
	dateEntry TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (eventID) REFERENCES ClientEvents(id),
	FOREIGN KEY (prodCatID) REFERENCES PartnersProductCategory(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS EventsSelectedMenu(
	id INT NOT NULL AUTO_INCREMENT,
	eventID INT NOT NULL,
	setID INT NOT NULL,
	soup VARCHAR(50),
	chicken VARCHAR(50),
	seafoods VARCHAR(50),
	porkBeef VARCHAR(50),
	vegetable VARCHAR(50),
	rice VARCHAR(50),
	salad VARCHAR(50),
	dessert VARCHAR(50),
	drinks VARCHAR(50),
	isDeleted INT DEFAULT 0,
	dateEntry TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (eventID) REFERENCES ClientEvents(id),
	FOREIGN KEY (setID) REFERENCES Menus(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ClientEventBillsPaymentMethod(
	id INT NOT NULL AUTO_INCREMENT,
	eventID INT NOT NULL,
	paymentMethod INT DEFAULT 0,
	FOREIGN KEY (eventID) REFERENCES ClientEvents(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ClientEventBillsPayments(
	id INT NOT NULL AUTO_INCREMENT,
	eventID INT NOT NULL,
	amount DECIMAL(19,2),
	entryDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (eventID) REFERENCES ClientEvents(id),
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS AuditTrail(
	id INT NOT NULL AUTO_INCREMENT,
	currUser VARCHAR(70),
	action VARCHAR(255),
	dateEntry TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Clients_RecoveredEmail(
	id INT NOT NULL AUTO_INCREMENT,
	email_address VARCHAR(100),
	clientID INT,
	tag TEXT,
	dateEntry TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	isDone INT DEFAULT 0,
	PRIMARY KEY(id)
);
