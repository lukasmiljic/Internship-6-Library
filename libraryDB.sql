create table libraryDB
--
use libraryDB

create table library (
	libraryID serial primary key,
	name varchar(64) not null,
	openTime time,
	closeTime time,
	constraint open_close_time_invalid check (closeTime > openTime)
);

create type bookType as enum('school', 'art', 'science', 'biography', 'tehnical');
create table book (
	bookID serial primary key,
	title varchar(127) not null,
	bookCode varchar(8) not null,	-- ovo ne ide tu nego u bookinlibrary al nemam dovoljno vremena :(
	type bookType not null,
	dateofrelease date not null
);

create table bookinlibrary (
	libraryID int references library(libraryID),
	bookID int references book(bookID),
	primary key(libraryID, bookID)
);

create table country(
	countryID serial primary key,
	name varchar(64) unique not null,
	population bigint not null,
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
	-- promjeni ovo u countryid
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

create table libraryUser (
	userID serial primary key,
	firstName varchar(32) not null,
	lastName varchar(64) not null
);

create table borrows (
	borrowingID serial primary key,
	userID int references libraryUser(userID) not null,
	bookID int references book(bookID) not null,
	dateOfBorrowing date not null,
	dateToReturn date not null,
	dateOfReturn date,
	constraint invalid_return_date check ((dateToReturn - dateOfBorrowing) < 60)
);

create procedure borrowBook (libraryuserID int, bookID int)
as $$
begin
if (select count(*) from (select b.userID from borrows b where userID = b.userID and b.dateOfReturn is null)) >= 3 then
raise exception 'Too many borowed books!';
return;
end if;
insert into borrows(userID, bookID, dateOfBorrowing, dateToReturn)
		values (@libraryuserID, @bookID, current_date, current_date + 20);
end;
$$
language plpgsql;