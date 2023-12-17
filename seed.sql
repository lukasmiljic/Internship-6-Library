-- test data for queries
insert into country(countryID, name, population, averagesalary) 
values 
	(1, 'Croatia', 3500000, 6000),
	(2, 'United States Of America', 332000000, 50000),
	(3, 'France', 67000000, 40000),
    (4, 'Germany', 83000000, 45000);

insert into author(authorID, firstName, lastName, dateOfBirth, dateOfDeath, gender, country)
values
	(1, 'Miroslav', 'Krleza', '1893-07-07', '1981-12-29', 1, 1),
	(2, 'Mark', 'Twain', '1835-11-30', '1910-04-21', 1, 2),
	(3, 'Albert', 'Camus', '1913-11-07', '1960-01-04', 1, 3),
    (4, 'Karl', 'Marx', '1818-05-05', '1883-03-14', 1, 4),
    (5, 'Friedrich', 'Engels', '1820-11-28', '1895-05-05', 1, 4);

insert into book(bookID, title, bookCode, type, dateofrelease)
values
	(1, 'Das Kapital', 'A100', 'science', '1867--10-14'),
	(2, 'The Stranger', 'A101', 'art', '2020--03-19');

insert into wrote(bookID, authorID, isMainAuthor)
values 
	(1, 4, true),
	(1, 5, true),
    (2, 3, true);

insert into library (libraryID, name)
values 
    (1, 'Sveucilisna knjiznica Split'),
    (2, 'Gradska knjiznica Marka Marulica'),
    (3, 'Knjiznica grada Zagreba');

insert into bookinlibrary(libraryid, bookid)
values 
	(1, 1),
	(1, 2),
	(2, 1),
	(3, 2);

insert into libraryuser(userID, firstname, lastName)
values (1, 'Ante', 'Antic');

call borrowBook(1,1);