create table libraryDB
--
use libraryDB

create table library (
	libraryID serial primary key,
	name varchar(64) not null,
	openTime time,
	closeTime time
);
create type bookType as enum('school', 'art', 'science', 'biography', 'tehnical');
create table book (
	bookID serial primary key,
	bookCode varchar(8),
	type bookType not null,
	dateofrelease date not null
);

create table bookinlibrary (
	libraryID int references library(libraryID),
	bookID int references books(bookID),
	primary key(libraryID, bookID)
);

create table country(
	countryID serial primary key,
	name varchar(64) unique not null,
	population int not null,
	averageSalary decimal(12,2) not null
);

create table author (
	authorID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	dateOfBirth date not null,
	dateOfDeath date,
	gender smallint not null,
	constraint author_gender_value check (gender between 0 and 2 or gender = 9),
	country int references country(countryID) not null
);

create table wrote (
	bookID int references book(bookID) not null,
	authorID int references author(authorID) not null,
	primary key (bookID, authorID),
	isMainAuthor boolean not null
);

create table bookkeeper (
	bookkeeperID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	worksInLibraryID int references library(libraryID) not null
);

create table user (
	userID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	-- fees numeric(12,2) default 0.0	--ovo promjeniti u bigint i spremat cente
	-- mozda jednostavnije ne pamtit dugovanja samo u selectu izbacit korisnike koji imaju dugovanja iako ovo nije najbolje rjesenje problema
);

create table borrows (
	userID int references user(userID) not null,
	bookID int references book(bookID) not null,
	dateOfBorrowing date not null,
	dateToReturn date not null,
	dateOfReturn date,	-- knjiga je vracena ako ovaj datum IS NOT NULL
	constraint too_many_books check (select count(*) from (select b.userID from borrows b where userID = b.userID and b.dateOfReturn is null))>3,	-- pogledaj moze li se ovo nekako jednostavnije s grupiranjem il necim
	constraint invalid_return_date check (datediff(dateOfBorrowing, dateToReturn) > 60)
);

create procedure borrowBook (userID int, bookID int)
language sql
as $$
	insert into borrows(userID, bookID, dateOfBorrowing, dateToReturn)
	values (@userID, @bookID, current_date, current_date + 20)
$$;

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