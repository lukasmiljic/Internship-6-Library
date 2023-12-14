--create table libraryDB
----
--use libraryDB

create table bookkeeper (
	bookkeeperID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	worksInLibraryID int references library(libraryID)
);

create table library (
	libraryID serial primary key,
	name varchar(64) not null
	-- workinghours 
);

create table bookinlibrary (
	libraryID int references library(libraryID),
	bookID int references books(bookID),
	primary key(libraryID, bookID)
);

-- book type enum or seperate table?
create table book (
	bookID serial primary key,
	bookCode varchar(16),
	-- type
	dateofrelease date not null
);
create table author (
	authorID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
	dateOfBirth date not null,
	dateOfDeadth date,
	-- gender myb seperate table?
	country varchar(32) not null
);

create table wrote (
	bookID int references book(bookID) not null,
	authorID int references author(authorID) not null,
	primary key (bookID, authorID),
	isMainAuthor boolean not null
);

-- datum trajanja iskaznice i u kojoj je knjiznici je uclanjen
-- pa bi za posudivanje knjige morao provjeriti nalazi li se knjiga 
-- koju zeli posudit u toj knjiznici i je li mu iskaznica valjana i 
-- je li posudio vise od tri knjige
create table user (
	userID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null,
);

create table borrows (
	userID int references user(userID) not null,
	bookID int references book(bookID) not null,
	dateOfBorrowing date not null
);