create table libraryDB
--
use libraryDB

create table library (
	libraryID serial primary key,
	name varchar(64) not null,
	openTime time,
	closeTime time
);

-- book type enum or seperate table?
create table book (
	bookID serial primary key,
	bookCode varchar(8),
	-- type
	dateofrelease date not null
);

create table bookinlibrary (
	libraryID int foreign key  references library(libraryID),
	bookID int foreign key references books(bookID),
	primary key(libraryID, bookID)
);

create table country(
	countryID serial primary key,
	name varchar(64) not null,	-- constraint unique
	population int not null,
	averageSalary 
);

create table author (
	authorID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	dateOfBirth date not null,
	dateOfDeath date,		 -- constraint datum ne moze biti u buducnosti
	gender tinyint not null, -- constraint ili 0,1,2,9
	country int foreign key references country(countryID) not null
);

create table wrote (
	bookID int foreign key references book(bookID) not null,
	authorID int foreign key references author(authorID) not null,
	primary key (bookID, authorID),
	isMainAuthor boolean not null
);

create table bookkeeper (
	bookkeeperID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	worksInLibraryID int foreign key references library(libraryID) not null
);

create table user (
	userID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	fees float default 0.0	-- da koristim float ili numeric?
);
-- mozda dodat tablicu iskaznica pa dodat datum trajanja iskaznice
-- i u kojoj je knjiznici je uclanjen user
-- pa bi za posudivanje knjige morao provjeriti nalazi li se knjiga 
-- koju zeli posudit u toj knjiznici i je li mu iskaznica valjana i 
-- je li posudio vise od tri knjige

create table borrows (
	userID int foreign key references user(userID) not null,
	bookID int foreign key references book(bookID) not null,
	dateOfBorrowing date not null,
	dateToReturn date,
	dateOfReturn date	-- knjiga je vracena ako ovaj datum IS NOT NULL
	-- constraint provjerit je li user posudio vise od tri knjige
);

-- procedura za posudivanje knjige, sprema podatke u borrows

-- ● ime, prezime, spol (ispisati ‘MUŠKI’, ‘ŽENSKI’, ‘NEPOZNATO’, ‘OSTALO’;), ime države i 
--	 prosječna plaća u toj državi svakom autoru

-- ● naziv i datum objave svake znanstvene knjige zajedno s imenima glavnih autora koji su
--   na njoj radili, pri čemu imena autora moraju biti u jednoj ćeliji i u obliku Prezime,
--   I.; npr. Puljak, I.; Godinović, N.; Bilušić

-- ● sve kombinacije (naslova) knjiga i posudbi istih u prosincu 2023.; u slučaju da neka 
--   nije ni jednom posuđena u tom periodu, prikaži je samo jednom (a na mjestu posudbe neka piše null)

-- ● top 3 knjižnice s najviše primjeraka knjiga

-- ● po svakoj knjizi broj ljudi koji su je pročitali (korisnika koji posudili bar jednom)

-- ● imena svih korisnika koji imaju trenutno posuđenu knjigu

-- ● sve autore kojima je bar jedna od knjiga izašla između 2019. i 2022.

-- ● ime države i broj umjetničkih knjiga po svakoj (ako su dva autora iz iste države, računa
--   se kao jedna knjiga), gdje su države sortirane po broju živih autora od najveće ka najmanjoj

-- ● po svakoj kombinaciji autora i žanra (ukoliko postoji) broj posudbi knjiga tog autora u tom žanru

-- ● po svakom članu koliko trenutno duguje zbog kašnjenja; u slučaju da ne duguje ispiši “ČISTO”

-- ● autora i ime prve objavljene knjige istog

-- ● državu i ime druge objavljene knjige iste

-- ● knjige i broj aktivnih posudbi, gdje se one s manje od 10 aktivnih ne prikazuju

-- ● prosječan broj posudbi po primjerku knjige po svakoj državi

-- ● broj autora (koji su objavili više od 5 knjiga) po struci, desetljeću rođenja i spolu;
--   u slučaju da je broj autora manji od 10, ne prikazuj kategoriju; poredaj prikaz 
--   po desetljeću rođenja

-- ● 10 najbogatijih autora, ako po svakoj knjizi dobije brojPrimjeraka/brojAutoraPoKnjizi