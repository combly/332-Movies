# CISC 332 Project
# Group 50

# Chris Gray 10185372 14cmg5
# Alex Huctwith 10138307 13aah12
# Ashley Drouillard 10183354 14aad4

# Delete old database
 Drop database moviedb;
# Build Tables
create database moviedb;
CREATE TABLE complex
(
	CName			VARCHAR(30)	NOT NULL,
	PhoneNumber		VARCHAR(10)	NOT NULL,
	Street			VARCHAR(20) NOT NULL,
	City			VARCHAR(20) NOT NULL,
	PostalCode		VARCHAR(6)  NOT NULL,		
	PRIMARY KEY(CName)
);

CREATE TABLE theatre
(
	TheatreNum  	INTEGER NOT NULL,
	Complex 		VARCHAR(30) NOT NULL,
	ScreenSize  	CHAR(1) NOT NULL,
	MaxSeats    	INTEGER NOT NULL,
	PRIMARY KEY(TheatreNum,Complex),
	FOREIGN KEY(Complex) REFERENCES complex(CName) ON UPDATE CASCADE
);

CREATE TABLE supplier
(
	Name 			VARCHAR(20) NOT NULL,
	Street 			VARCHAR(20),
	City			VARCHAR(20),
	PostalCode		VARCHAR(6),
	ContactFname	VARCHAR(20),
	ContactLname	VARCHAR(20),
	PhoneNumber 	VARCHAR(10),
	PRIMARY KEY(Name)
);

CREATE TABLE movie
(
	Title			VARCHAR(35)	NOT NULL,
	RunTime			INTEGER 	NOT NULL,
	Plot			VARCHAR(1000) NOT NULL,
	Supplier 		VARCHAR(20) NOT NULL,
	Production		VARCHAR(20) NOT NULL,
	Rating			VARCHAR(5) NOT NULL,
	PRIMARY KEY(Title),
	FOREIGN KEY(Supplier) REFERENCES supplier(Name) 
);

CREATE TABLE actors
(
	Title			VARCHAR(35) NOT NULL,
	Fname			VARCHAR(20) NOT NULL,
	Lname			VARCHAR(20) NOT NULL,
	PRIMARY KEY(Title,Fname,Lname),
	FOREIGN KEY(Title) REFERENCES movie(Title)
);

CREATE TABLE directors
(
	Title			VARCHAR(35) NOT NULL,
	Fname			VARCHAR(20) NOT NULL,
	Lname			VARCHAR(20) NOT NULL,
	PRIMARY KEY(Title,Fname,Lname),
	FOREIGN KEY(Title) REFERENCES movie(Title)
);

CREATE TABLE showing
(
	Complex 		VARCHAR(30) NOT NULL,
	Theatre 		INTEGER NOT NULL,
	StartTime		VARCHAR(5) NOT NULL,
	Day				date NOT NULL,
	NumSeats		INTEGER NOT NULL,
	Movie  			VARCHAR(35) NOT NULL,
	PRIMARY KEY(Complex,Theatre,StartTime,Day),
	FOREIGN KEY(Movie) REFERENCES movie(Title),
	FOREIGN KEY(Complex) REFERENCES complex(CName) ON UPDATE CASCADE,
	FOREIGN KEY(Theatre) REFERENCES theatre(TheatreNum) ON UPDATE CASCADE
);

CREATE TABLE runs
(
	Movie 			VARCHAR(35) NOT NULL,
	Complex 		VARCHAR(30) NOT NULL,
	StartDate 		date NOT NULL,
	EndDate 		date NOT NULL,
	PRIMARY KEY(Movie,Complex),
	FOREIGN KEY(Movie) REFERENCES movie(Title),
	FOREIGN KEY(Complex) REFERENCES complex(CName) ON UPDATE CASCADE
);

CREATE TABLE customer
(
	AccountNumber	INTEGER NOT NULL,
	Password		VARCHAR(20) NOT NULL,
	Fname 			VARCHAR(20) NOT NULL,
	Lname 			VARCHAR(20) NOT NULL,
	PhoneNumber		VARCHAR(10),
	Email			VARCHAR(30),
	CreditCardNum	VARCHAR(12),
	CreditCardExp	date,
	isAdmin			BOOLEAN,
	PRIMARY KEY(AccountNumber)
);

CREATE TABLE review
(
	AccountNumber	INTEGER NOT NULL,
	Movie 		  	VARCHAR(35) NOT NULL,
	Review		  	INTEGER NOT NULL,
	PRIMARY KEY(AccountNumber,Movie),
	FOREIGN KEy(AccountNumber) REFERENCES customer(AccountNumber),
	FOREIGN KEY(Movie) REFERENCES movie(Title)
);

CREATE TABLE reservation
(
	AccountNumber	INTEGER NOT NULL,
	Complex 		VARCHAR(30) NOT NULL,
	Theatre 		INTEGER NOT NULL,
	StartTime		VARCHAR(5) NOT NULL,
	Day				date NOT NULL,
	NumTickets		INTEGER	NOT NULL,
	PRIMARY KEY(AccountNumber, Complex, Theatre, StartTime, Day),
	FOREIGN KEY(AccountNumber) REFERENCES customer(AccountNumber),
	FOREIGN KEY(Complex,Theatre,StartTime,Day) REFERENCES showing(Complex,Theatre,StartTime,Day) ON UPDATE CASCADE
);

# Insert Data

Insert into complex values
("Odeplex Cineon","6135551829","14 Doggo Drive","Kingston","K3Z5L4"),
("Mandlark Cinemas","6135553145","72 Birb Boulevard","Kingston","K8M5N8"),
("The Reening Scroom","6135551234","45 Snek Street","Kingston","T6U8O8"),
("Galaxy Plex" , "6135551234","42 Snek Street","Kingston","T6U8O8");

Insert into supplier values
("Movies R Us",NULL,NULL,NULL,NULL,NULL,NULL),
("Whole Lotta Movies",NULL,NULL,NULL,NULL,NULL,NULL),
("Okay Movies","18 Hollywood Ave","Hollywood", "H1HK26", "George","Brown","9051236565");

Insert into movie values
("Tammy and the T-Rex",88,
"A teen (Denise Richards) learns that a scientist (Terry Kiser) implanted her dead boyfriend's brain into an animatronic dinosaur.",
"Movies R Us","Greenline Productions","R"),

("Shrek Forever After",83,
"Long-settled into married life and fully domesticated, Shrek (Mike Myers) begins to long for the days when he felt like a real ogre. Duped into signing a contract with devious Rumpelstiltskin, he finds himself in an alternate version of Far Far Away, where ogres are hunted",
"Okay Movies","DreamWorks Animations","G"),

("Monty Python and the Holy Grail",91,
"King Arthur and his knights embark on a low-budget search for the Grail, encountering many, very silly obstacles.",
"Movies R Us","Python Pictures","PG");

Insert into runs values
("Tammy and the T-Rex", "Odeplex Cineon", '2018-03-10', '2018-06-10'),
("Tammy and the T-Rex", "Mandlark Cinemas", '2018-03-10', '2018-06-10'),
("Tammy and the T-Rex", "The Reening Scroom", '2018-03-10', '2018-06-10'),

("Shrek Forever After", "Odeplex Cineon", '2018-03-10', '2018-06-10'),
("Shrek Forever After", "Mandlark Cinemas", '2018-03-10', '2018-06-10'),
("Shrek Forever After", "The Reening Scroom", '2018-03-10', '2018-06-10'),
("Shrek Forever After", "Galaxy Plex", '2010-03-10', '2020-06-10'),

("Monty Python and the Holy Grail", "Odeplex Cineon", '2018-03-10', '2018-06-10'),
("Monty Python and the Holy Grail", "Mandlark Cinemas", '2018-03-10', '2018-06-10'),
("Monty Python and the Holy Grail", "The Reening Scroom", '2018-03-10', '2018-06-10');


Insert into theatre values
(1, "Odeplex Cineon", "S", 30),
(2, "Odeplex Cineon", "M", 40),
(3, "Odeplex Cineon", "L", 50),
(1, "Mandlark Cinemas", "S", 30),
(2, "Mandlark Cinemas", "M", 40),
(3, "Mandlark Cinemas", "L", 50),
(1, "The Reening Scroom", "S", 30),
(2, "The Reening Scroom", "M", 40),
(3, "The Reening Scroom", "L", 50),
(1, "Galaxy Plex", "S", 30),
(2, "Galaxy Plex", "M", 40),
(3, "Galaxy Plex", "L", 50);


Insert into showing values
("Odeplex Cineon", 1, "17:00", '2018-03-30', 15, "Tammy and the T-Rex"),
("Mandlark Cinemas", 1, "17:30", '2018-03-30', 10, "Tammy and the T-Rex"),
("The Reening Scroom", 1, "18:00", '2018-03-30', 20, "Tammy and the T-Rex"),
("Odeplex Cineon", 1, "20:00", '2018-03-30', 15, "Tammy and the T-Rex"),
("Mandlark Cinemas", 1, "20:30", '2018-03-30', 10, "Tammy and the T-Rex"),
("The Reening Scroom", 1, "21:00", '2018-03-30', 20, "Tammy and the T-Rex"),
("Odeplex Cineon", 1, "17:00", '2018-03-10', 15, "Tammy and the T-Rex"),
("Mandlark Cinemas", 1, "17:30", '2018-03-20', 10, "Tammy and the T-Rex"),
("The Reening Scroom", 1, "20:00", '2018-03-11', 20, "Tammy and the T-Rex"),

("Odeplex Cineon", 2, "19:00", '2018-03-30', 40, "Monty Python and the Holy Grail"),
("Mandlark Cinemas", 2, "20:30", '2018-03-30', 10, "Monty Python and the Holy Grail"),
("The Reening Scroom", 2, "17:00", '2018-03-30', 40, "Monty Python and the Holy Grail"),
("Odeplex Cineon", 2, "17:00", '2018-03-30', 40, "Monty Python and the Holy Grail"),
("Mandlark Cinemas", 2, "17:30", '2018-03-30', 10, "Monty Python and the Holy Grail"),
("The Reening Scroom", 2, "20:00", '2018-03-30', 40, "Monty Python and the Holy Grail"),
("Odeplex Cineon", 2, "17:00", '2018-03-10', 40, "Monty Python and the Holy Grail"),
("Mandlark Cinemas", 2, "17:30", '2018-03-20', 10, "Monty Python and the Holy Grail"),
("The Reening Scroom", 2, "20:00", '2018-03-11', 40, "Monty Python and the Holy Grail"),

("Odeplex Cineon", 3, "12:00", '2018-03-30', 50, "Shrek Forever After"),
("Mandlark Cinemas", 3, "13:30", '2018-03-30', 45, "Shrek Forever After"),
("The Reening Scroom", 3, "16:00", '2018-03-30', 30, "Shrek Forever After"),
("Odeplex Cineon", 3, "14:00", '2018-03-30', 50, "Shrek Forever After"),
("Mandlark Cinemas", 3, "17:30", '2018-03-30', 45, "Shrek Forever After"),
("The Reening Scroom", 3, "18:00", '2018-03-30', 30, "Shrek Forever After"),
("Odeplex Cineon", 3, "14:00", '2018-03-15', 50, "Shrek Forever After"),
("Mandlark Cinemas", 3, "17:30", '2018-03-12', 45, "Shrek Forever After"),
("The Reening Scroom", 3, "18:00", '2018-03-22', 30, "Shrek Forever After"),

("Galaxy Plex", 3, "12:00", '2018-03-30', 50, "Shrek Forever After"),
("Galaxy Plex", 2, "13:30", '2018-03-30', 45, "Shrek Forever After"),
("Galaxy Plex", 1, "16:00", '2018-03-30', 30, "Shrek Forever After"),
("Galaxy Plex", 3, "14:00", '2018-03-30', 50, "Shrek Forever After");

Insert into actors values
("Tammy and the T-Rex","Denise","Richards"),
("Tammy and the T-Rex","Theo", "Forsett"),
("Tammy and the T-Rex","Paul","Walker"),

("Monty Python and the Holy Grail","Graham", "Chapman"),
("Monty Python and the Holy Grail","John", "Cleese"),
("Monty Python and the Holy Grail","Eric", "Idle"),
("Monty Python and the Holy Grail","Terry", "Gilliam"),
("Monty Python and the Holy Grail","Terry", "Jones"),
("Monty Python and the Holy Grail","Michael", "Palin"),

("Shrek Forever After","Mike","Myers"),
("Shrek Forever After","Eddie","Murphy"),
("Shrek Forever After","Cameron","Diaz"),
("Shrek Forever After","Antonio","Banderas");

Insert into directors values
("Tammy and the T-Rex","Stewart","Raffill"),

("Monty Python and the Holy Grail","Terry", "Gilliam"),
("Monty Python and the Holy Grail","Terry", "Jones"),

("Shrek Forever After","Mike","Mitchell");


Insert into customer values
(10183354, "123abc", "Ashley", "Drouillard", "1234567890", "ashley@email.com", "1234 5677 8900 1234", '2020-08-18',true),
(10185372, "ripley", "Chris", "Gray", "1234567890", "email@address.com", "1234 5677 8300 1234", '2020-08-18',true);

Insert into review values
(10183354, "Shrek Forever After", 80),
(10183354, "Monty Python and the Holy Grail", 80),
(10183354, "Tammy and the T-Rex", 100),
(10185372, "Shrek Forever After", 70),
(10185372, "Monty Python and the Holy Grail", 90),
(10185372, "Tammy and the T-Rex", 100);


Insert into reservation values
(10183354, "Mandlark Cinemas", 3, "13:30", '2018-03-30', 2),
(10183354, "Odeplex Cineon", 1, "17:00", '2018-03-10', 3),
(10183354, "Mandlark Cinemas", 2, "17:30", '2018-03-20', 2);

