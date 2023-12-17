-- ● ime, prezime, spol (ispisati ‘MUŠKI’, ‘ŽENSKI’, ‘NEPOZNATO’, ‘OSTALO’;), ime države i 
--	 prosječna plaća u toj državi svakom autoru
select a.firstname, a.lastName, 
case 
	when a.gender = 1 then 'MAN'
	when a.gender = 2 then 'WOMAN'
	when a.gender = 0 then 'OTHER'
	else 'UNKNOWN'
	end as gender,
c.name as country, c.averageSalary as countryaveragesalary from author a
join country c on a.country = c.countryID;

-- ● naziv i datum objave svake znanstvene knjige zajedno s imenima glavnih autora koji su
--   na njoj radili, pri čemu imena autora moraju biti u jednoj ćeliji i u obliku Prezime,
--   I.; npr. Puljak, I.; Godinović, N.; Bilušić
SELECT b.title ,b.dateofrelease, STRING_AGG(a.lastname || ', ' || LEFT(a.firstname, 1), '; ') AS Authors 
FROM book b
JOIN wrote w ON b.BookId = w.BookId
JOIN author a ON w.AuthorId = a.AuthorId
WHERE b.type = 'science' AND w.isMainAuthor = true
GROUP BY b.BookId;

-- ● top 3 knjižnice s najviše primjeraka knjiga
select l.name, count(*) as numberofbooks
from library l
join bookinlibrary bil on l.libraryID = bil.libraryID
group by l.libraryID
order by numberofbooks DESC
limit 3;

-- ● po svakoj knjizi broj ljudi koji su je pročitali (korisnika koji posudili bar jednom)
select b.title, count(*) as reads
from book b
join borrows bo on b.bookID = bo.bookID
group by b.bookID;

-- ● imena svih korisnika koji imaju trenutno posuđenu knjigu
select distinct u.firstname 
from libraryUser u
join borrows b on u.userID = b.userID
where b.dateOfReturn is null;

-- ● sve autore kojima je bar jedna od knjiga izašla između 2019. i 2022.
select distinct a.firstname, a.lastname from author a
join wrote w on a.authorID = w.authorID
join book b on b.bookID = w.bookID
where extract(year from b.dateofrelease) between 2019 and 2022;

-- ● ime države i broj umjetničkih knjiga po svakoj (ako su dva autora iz iste države, računa
--   se kao jedna knjiga), gdje su države sortirane po broju živih autora od najveće ka najmanjoj
select c.name, count (*) as numberofbooks from country c
join author a on a.country = c.countryID
join wrote w on a.authorid = w.authorID
join book b on w.bookID = b.bookID
where b.type = 'art'

-- ● po svakoj kombinaciji autora i žanra (ukoliko postoji) broj posudbi knjiga tog autora u tom žanru
select a.firstname, a.lastname, b.genre, count(bo.borrowingID) as reads
from authors a
join wrote w on a.authorID = w.authorID
join book b on b.bookID = w.BookId
join borrows bo on b.bookID = bo.bookID
group by a.authorID, b.genre

-- ● po svakom članu koliko trenutno duguje zbog kašnjenja; u slučaju da ne duguje ispiši “ČISTO”
select u.firstname, u.lastName, case
	when b.dateToReturn < current_date then 'HAS FEES'
	else 'NO FEES'
	end as status
from libraryuser u
join borrows b on u.userID = b.userID;

-- ● autora i ime prve objavljene knjige istog
select a.firstName, a.lastName, b.title from author a
join wrote w on a.authorID = w.authorID
join book b on b.bookID = w.bookID
order by b.dateofrelease
limit 1;

-- ● državu i ime druge objavljene knjige iste
select c.name, b.title from country c
join author a on a.country = c.countryID 
join wrote w on a.authorID = w.authorID
join book b on b.bookID = w.bookID
order by b.dateofrelease
limit 1;

-- ● knjige i broj aktivnih posudbi, gdje se one s manje od 10 aktivnih ne prikazuju
select b.title, count(bo.borrowingID) as numberofactiveborrowings
from book b
join borrows bo on b.bookID = bo.bookID
where bo.dateOfReturn is null
group by b.bookid
having count(bo.borrowingID) > 10