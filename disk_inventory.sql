/*
MODIFICATION LOG
3/3/21      JC       Started script, Create tables with foreign key relationships

3/10/21     JC       removed artist_type field from Artist (redundant with artist_type_id)

3/30/21     JC        Added stored procedures to insert, update, and delete Artists, disks, and borrowers


*/
USE [master];
GO
DROP DATABASE IF EXISTS disk_inventoryJC;
Go
CREATE DATABASE disk_inventoryJC;
Go
use disk_inventoryJC;
Go

IF SUSER_ID('diskUserJC') IS NULL CREATE LOGIN diskUserJC WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventoryJC;

-- Creates User named diskUserJC and adds to db_datareader role
CREATE USER diskUserJC;
ALTER ROLE db_datareader ADD MEMBER diskUserJC;
Go

--Creates artist type table
CREATE TABLE ArtistType (
	artist_type_id INT NOT NULL IDENTITY PRIMARY KEY,
	description VARCHAR(10));

	--Creates status table
CREATE TABLE Status (
	status_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(60) NOT NULL);

--Creates genre table
CREATE TABLE Genre (
	genre_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(60) NOT NULL);

--Creates disk type table
CREATE TABLE DiskType (
	disk_type_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(60) NOT NULL);

--Creates artist table
CREATE TABLE Artist (
	artist_id INT NOT NULL IDENTITY PRIMARY KEY,
	first_name VARCHAR(60) NOT NULL,
	last_name VARCHAR(60) NULL,
	artist_type_id INT REFERENCES ArtistType(artist_type_id));

--Creates Disk table
CREATE TABLE Disk (disk_id INT NOT NULL IDENTITY PRIMARY KEY,
	disk_name NVARCHAR(60) NOT NULL,
	release_date DATE NOT NULL,
	status_id INT REFERENCES Status(status_id),
	genre_id INT REFERENCES Genre(genre_id),
	disk_type_id INT REFERENCES DiskType(disk_type_id));

--Creates Borrower table
CREATE TABLE Borrower (
	borrower_id INT NOT NULL IDENTITY PRIMARY KEY,
	first_name NVARCHAR(60) NOT NULL,
	last_name NVARCHAR(60) NOT NULL,
	phone BIGINT NOT NULL);

--Creates Disk-Artist Table
CREATE TABLE DiskArtist (
	disk_artist_id INT NOT NULL IDENTITY PRIMARY KEY,
	disk_id INT NOT NULL REFERENCES Disk(disk_id),
	artist_id INT NOT NULL REFERENCES Artist(artist_id));

--Creates DiskRental table 
CREATE TABLE DiskRental (
	rental_id INT NOT NULL IDENTITY PRIMARY KEY,
	borrowed_date DATETIME NOT NULL,
	due_date DATETIME NOT NULL,
	return_date DATETIME NULL,
	borrower_id INT NOT NULL REFERENCES Borrower(borrower_id),
	disk_id INT NOT NULL REFERENCES Disk(disk_id));



USE [disk_inventoryJC]
GO

-- Inserting Artist Types
INSERT INTO [dbo].[ArtistType]
           ([description])
     VALUES
           ('Solo'),
		   ('Group')
GO


--Inserting disk types
INSERT INTO [dbo].[DiskType]
           ([description])
     VALUES
           ('Cassette'),
		   ('CD'),
		   ('DVD'),
		   ('Vinyl')
GO
--Inserting genres
INSERT INTO [dbo].[Genre]
           ([description])
     VALUES
           ('Rock'),
		   ('Pop'),
		   ('Jazz'),
		   ('Country'),
		   ('Hip-Hop')
GO

--Inserting Statuses
INSERT INTO [dbo].[Status]
           ([description])
     VALUES
           ('Loaned'),
		   ('Returned'),
		   ('Broken'),
		   ('Lost')
GO

--Inserting Artists
INSERT INTO [dbo].[Artist]
           ([first_name]
           ,[last_name]
           ,[artist_type_id])
     VALUES
           ('Outcast',
            NULL,
           2),
		   ('Snoop',
		   'Dogg',
		   1),
		   ('Biggie',
		   'Smalls',
		   1),
		   ('Tupac',
		   'Shakur',
		   1),
		   ('Too',
		   'Short',
		   1),
		   ('Slick',
		   'Rick',
		   1),
		   ('Nas',
		   NULL,
		   1),
		   ('Big L',
		   NULL,
		   1),
		   ('Kieth',
		   'Murray',
		   1),
		   ('Wu-Tang',
		   NULL,
		   2),
		   ('Dr. Dre',
		   NULL,
		   1),
		   ('Eminem',
		   NULL,
		   1),
		   ('A Tribe Called Quest',
		   NULL,
		   2),
		   ('RUN DMC',
		   NULL,
		   2),
		   ('Kanye',
		   'West',
		   1),
		   ('Pete',
		   'Rock',
		   1),
		   ('The Roots',
		   NULL,
		   2),
		   ('Fugees',
		   NULL,
		   2),
		   ('Fat Tony',
		   NULL,
		   1),
		   ('Nate',
		   'Dogg',
		   1)


GO


-- Insert 20 Disks
INSERT INTO [dbo].[Disk]
		   ([disk_name]
           ,[release_date]
           ,[status_id]
           ,[genre_id]
           ,[disk_type_id])
     VALUES
           ('Stankonia'
           ,'2000-07-21'
           ,1
           ,5
           ,1),
		   ('The Score',
		   '1996-09-01',
		   2,
		   2,
		   4),
		   ('Illmatic',
		   '1994-08-11',
		   4,
		   3,
		   3),
		   ('The Anthology',
		   '1999-03-09',
		   1,
		   1,
		   1),
		   ('Moment of Truth',
		   '1998-04-05',
		   3,
		   5,
		   2),
		   ('Better Dayz',
		   '2002-01-21',
		   1,
		   4,
		   1),
		   ('It Was Written',
		   '1994-09-30',
		   2,
		   2,
		   4),
		   	('Midnight Marauders',
		   '1993-11-10',
		   2,
		   3,
		   3),
		   ('Things Fall Apart',
		   '1999-12-10',
		   1,
		   4,
		   3),
		   ('Graduation',
		   '2007-11-12',
		   2,
		   5,
		   1),
		   ('Late Registration',
		   '2005-04-11',
		   4,
		   2,
		   3),
		   ('The Big Picture',
		   '1997-05-20',
		   1,
		   2,
		   4),
		   ('The Danger Zone',
		   '1999-03-19',
		   1,
		   5,
		   3),
		   ('Soul Survivor',
		   '2001-07-19',
		   2,
		   3,
		   3),
		   ('The Slim Shady LP',
		   '1999-02-13',
		   2,
		   5,
		   1),
		   ('The Ruler''s Back',
		   '1991-04-06',
		   1,
		   3,
		   4),
		   ('Raising Hell',
		   '1986-01-21',
		   2,
		   1,
		   4),
		   ('Crown Royal',
		   '1999-09-03',
		   1,
		   5,
		   2),
		   ('The Chronic',
		   '1992-08-30',
		   1,
		   5,
		   2),
		   ('The Doggfather',
		   '2001-06-11',
		   2,
		   2,
		   3),
		   ('Malice in Wonderland',
		   '1999-02-19',
		   1,
		   1,
		   1)
GO

--Update the release date of "The Doggfather"
UPDATE [dbo].[Disk]
   SET [release_date] = '1998-10-09'
      
 WHERE disk_name = 'The Doggfather'
GO

--Make sure release date changed
--SELECT * FROM Disk WHERE disk_name = 'The Doggfather';




-- Add 20 Borrowers
INSERT INTO [dbo].[Borrower]
           ([first_name]
           ,[last_name]
           ,[phone])
     VALUES
           ('Alan'
           ,'Allbrite'
           ,2089876512),
		   ('Brittany',
		   'Brown',
		   9876541234),
		   ('Casey',
		   'Colbert',
		   1234567890),
		   ('Diane',
		   'Dante',
		   5671237654),
		   ('Ethan',
		   'Emery',
		   1987651234),
		   ('Fiona',
		   'Fitzgerald',
		   4350981234),
		   ('Gary',
		   'Gulman',
		   1982341234),
		   ('Holly',
		   'Howards',
		   8907621342),
		   ('Ian',
		   'Ingraham',
		   3214561234),
		   ('Jenny',
		   'Johnson',
		   3451231543),
		   ('Kelly',
		   'Knox',
		   5430981234),
		   ('Liam',
		   'Lebowski',
		   8761237654),
		   ('Mandy',
		   'Monroe',
		   4561237654),
		   ('Niel',
		   'Nixon',
		   9871236556),
		   ('Oswald',
		   'Obermeyer',
		   6540981287),
		   ('Penny',
		   'Palmer',
		   7561542667),
		   ('Quinn',
		   'Quail',
		   9042345667),
		   ('Richard',
		   'Ramirez',
		   7865431123),
		   ('Sylvia',
		   'Sacramento',
		   7569812233),
		   ('Theodore',
		   'Tennyson',
		   9671234421),
		   ('Ulrich',
		   'Unsworth',
		   53410988743)
GO


-- Delete Penny as a borrower
DELETE FROM [dbo].[Borrower]
      WHERE first_name = 'Penny';
GO





USE [disk_inventoryJC]
GO
-- Insert disk rentals
INSERT INTO [dbo].[DiskRental]
           ([borrowed_date]
           ,[due_date]
           ,[return_date]
           ,[borrower_id]
           ,[disk_id])
     VALUES
           ('2019-02-22'
           ,'2019-03-22'
		   ,'2019-03-22'
           ,4
           ,5),
		   ('2019-02-28'
           ,'2019-03-28',
		   '2019-03-28',
		   8,
		   11),
		   ('2019-03-04',
		   '2019-04-04',
		   NULL,
		   18,
		   12),
		   ('2019-03-07',
		   '2019-04-07',
		   '2019-04-04',
		   7,
		   15),
		   ('2019-03-10',
		   '2019-05-10',
		   '2019-05-12',
		   11,
		   6),
		   ('2019-03-11',
		   '2019-04-11',
		   '2019-04-11',
		   3,
		   10),
		   ('2019-03-12',
		   '2019-04-12',
		   NULL,
		   1,
		   14),
		   ('2019-03-14',
		   '2019-05-14',
		   '2019-05-11',
		   15,
		   2),
		   ('2019-03-15',
		   '2019-04-15',
		   '2019-04-16',
		   15,
		   9),
		   ('2019-03-16',
		   '2019-04-16',
		   '2019-04-16',
		   12,
		   18),
		   ('2019-03-16',
		   '2019-05-16',
		   NULL,
		   12,
		   12),
		   ('2019-03-17',
		   '2019-04-17',
		   NULL,
		   18,
		   7),
		   ('2019-03-17',
		   '2019-04-17',
		   '2019-04-17',
		   13,
		   13),
		   ('2019-03-18',
		   '2019-04-18',
		   '2019-04-18',
		   10,
		   20),
		   ('2019-03-19',
		   '2019-05-19',
		   NULL,
		   6,
		   4),
		   ('2019-04-20',
		   '2019-05-20',
		   '2019-05-20',
		   14,
		   3),
		   ('2019-04-21',
		   '2019-06-21',
		   NULL,
		   2,
		   8),
		   ('2019-04-22',
		   '2019-05-22',
		   '2019-05-21',
		   5,
		   1),
		   --same disk & same borrower as DiskRentalID = 1
		    ('2019-04-22'
           ,'2019-05-22'
		   ,'2019-05-22'
           ,4
           ,5),
		   ('2019-05-23',
		   '2019-05-23',
		   NULL,
		   4,
		   14)	   
GO

-- Insert diskartists
INSERT INTO [dbo].[DiskArtist]
           ([disk_id]
           ,[artist_id])
     VALUES
           (1,
		   1),
		   (20,
		   2),
		   (6,
		   4),
		   (16,
		   6),
		   (3,
		   7),
		   (7,
		   7),
		   (13,
		   8),
		   (18,
		   9),
		   (19,
		   11),
		   (21,
		   2),
		   (17,
		   14),
		   (15,
		   12),
		   (14,
		   16),
		   (12,
		   8),
		   (11,
		   15),
		   (10,
		   15),
		   (9,
		   17),
		   (8,
		   13),
		   (6,
		   4),
		   (5,
		   10),
		   (4,
		   13),
		   (2,
		   17),
		   (19,
		   2)
GO

--Find borrowed disks that have not been returned
SELECT borrower_id, disk_id, borrowed_date, return_date
FROM DiskRental
WHERE return_date IS NULL;

GO

--Select all disks and display titel, release date, and artist names ordered by date.
SELECT disk_name, release_date, first_name, last_name
FROM Disk JOIN DiskArtist ON Disk.disk_id = DiskArtist.disk_id
			JOIN Artist ON DiskArtist.artist_id = Artist.artist_id
ORDER BY release_date;

--PROJECT 4
--3
SELECT disk_name AS 'Disk Name', release_date AS 'Release Date', first_name AS 'Artist first name', last_name AS 'Artist last name'
FROM Disk JOIN DiskArtist ON Disk.disk_id = DiskArtist.disk_id
			JOIN Artist on DiskArtist.artist_id = Artist.artist_id
WHERE artist_type_id = 1
ORDER BY release_date ASC;
Go
--4

CREATE VIEW View_Individual_Artist
AS
SELECT first_name, last_name 
FROM Artist 
WHERE artist_type_id = 1;
Go
SELECT * FROM View_Individual_Artist;
--5
SELECT disk_name, release_date, first_name
FROM Disk JOIN DiskArtist ON Disk.disk_id = DiskArtist.disk_id
			JOIN Artist ON DiskArtist.artist_id = Artist.artist_id
WHERE artist_type_id = 2
ORDER BY release_date;

--6
SELECT disk_name, release_date, first_name
FROM Disk JOIN DiskArtist ON Disk.disk_id = DiskArtist.disk_id
			JOIN Artist ON DiskArtist.artist_id = Artist.artist_id
WHERE Artist.first_name NOT IN (SELECT first_name FROM View_Individual_Artist)
ORDER BY release_date;

--7
SELECT first_name, last_name, disk_name, borrowed_date, return_date
FROM DiskRental JOIN Borrower ON DiskRental.borrower_id = Borrower.borrower_id
				JOIN Disk ON DiskRental.disk_id = Disk.disk_id
ORDER BY borrowed_date;

--8
SELECT DiskRental.disk_id, disk_name, COUNT(*) AS 'Times borrowed'
FROM DiskRental JOIN Disk ON DiskRental.disk_id = Disk.disk_id
GROUP BY Disk.disk_name, DiskRental.disk_id;

--9
SELECT disk_name, borrowed_date, return_date, last_name
FROM DiskRental JOIN Disk on DiskRental.disk_id = Disk.disk_id
				JOIN Borrower on DiskRental.borrower_id = Borrower.borrower_id
WHERE return_date IS NULL;

--Project 5
--4.  Create, Insert, Update, and delete stored procedures for the disk table.
--Update procedure accepts input parameters for all columns. Insert accepts all columns
--as input parameters for all columns except for identity fields. Deletes accepts a primary key for delete.

-- Insert disk store procedure
DROP PROC IF EXISTS sp_ins_disk;
GO
CREATE PROC sp_ins_disk
	@disk_name nvarchar(60), @release_date date, @status_id int, @genre_id int, @disk_type_id int
AS
	BEGIN TRY
		INSERT Disk (disk_name, release_date, status_id, genre_id, disk_type_id)
		VALUES (@disk_name, @release_date, @status_id, @genre_id, @disk_type_id);
	END TRY
	BEGIN CATCH
		PRINT 'An Error occured: ';
		PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
	END CATCH
GO

GRANT EXECUTE ON sp_ins_disk to diskUserJC;
GO
EXEC sp_ins_disk 'ATLiens', '04-21-1996', 1, 2, 3
GO

SELECT * FROM Disk;

-------------------------------------------------------------------------------------

--update disk stored procedure
DROP PROC IF EXISTS sp_upd_disk;
GO
CREATE PROC sp_upd_disk 
	@disk_id int, @disk_name nvarchar(60), @release_date date, @status_id int, @genre_id int, @disk_type_id int
AS
BEGIN TRY
	UPDATE Disk SET disk_name = @disk_name,
					release_date = @release_date,
					status_id = @status_id,
					genre_id = @genre_id,
					disk_type_id = @disk_type_id
			WHERE disk_id = @disk_id
END TRY
BEGIN CATCH
	PRINT 'An error occurred...';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_upd_disk TO diskUserJC;
GO
EXEC sp_upd_disk 22, 'atliens', '06-27-1996', 2, 2, 2;

------------------------------------------------------------------------
-- Delete by id
DROP PROC IF EXISTS sp_del_disk;
GO
CREATE PROC sp_del_disk @disk_id int
AS
BEGIN TRY
	DELETE FROM [dbo].[Disk]
      WHERE disk_id = @disk_id;
END TRY
BEGIN CATCH
	PRINT 'An error occurred...';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_del_disk to diskUserJC;
GO
EXEC sp_del_disk 22
GO

SELECT * FROM Disk;

/*
2. Create Insert, Update, and Delete stored procedures for the artist table. Update procedure accepts input parameters for all columns.
Insert accepts all columns as input parameters except for identity fields. Delete accepts a primary key value for delete.
*/

-- Stored procedure to insert artist
DROP PROC IF EXISTS sp_ins_artist;
GO
CREATE PROC sp_ins_artist @first_name nvarchar(60), @last_name nvarchar(60), @artist_type_id int
AS
BEGIN TRY
	INSERT INTO [dbo].[Artist]
			   ([first_name]
			   ,[last_name]
			   ,[artist_type_id])
		 VALUES
			   (@first_name
			   ,@last_name
			   ,@artist_type_id)
END TRY
BEGIN CATCH
	PRINT 'An error occurred...';
	PRINT 'Message: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_ins_artist TO diskUserJC;
GO
EXEC sp_ins_artist 'Beastie Boys', NULL, 2;
GO
EXEC sp_ins_artist NULL, NULL, NULL; --Throws error
GO
SELECT * FROM Artist;
--------------------------------------------------------------------------------------

--Stored procedure to update Artists
DROP PROC IF EXISTS sp_upd_artist;
GO
CREATE PROC sp_upd_artist @artist_id int, @first_name nvarchar(60), @last_name nvarchar(60), @artist_type_id int
AS
BEGIN TRY
	UPDATE [dbo].[Artist]
	   SET [first_name] = @first_name
		  ,[last_name] = @last_name
		  ,[artist_type_id] = @artist_type_id
	 WHERE [artist_id] = @artist_id
END TRY
BEGIN CATCH
	PRINT 'Message: ';
	PRINT 'ERROR MESSAGE: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_upd_artist TO diskUserJC;
GO
EXEC sp_upd_artist 21, 'Beastie', 'Boys', 1;
GO
EXEC sp_upd_artist 21, NULL, NULL, NULL; --Throws error
GO
SELECT * FROM Artist;

-------------------------------------------------------------------------------------------------

--stored procedure to delete artist

DROP PROC IF EXISTS sp_del_artist;
GO
CREATE PROC sp_del_artist @artist_id int
AS
BEGIN TRY
DELETE FROM [dbo].[Artist]
      WHERE artist_id = @artist_id
END TRY
BEGIN CATCH
	PRINT 'Message: ';
	PRINT 'ERROR MESSAGE: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_del_artist TO diskUserJC;
GO
EXEC sp_del_artist 21;
GO

SELECT * FROM Artist
--------------------------------------------------------------------------------------------------------
/*
3. Create Insert, Update, and Delete stored procedures for the borrower table.
Update procedure accepts input parameters for all columns.
Insert accepts all columns as input parameters except for identity fields.
Delete accepts a primary key value for delete.
*/


-- stored prcedure to insert borrower
DROP PROC IF EXISTS sp_ins_borrower;
GO
CREATE PROC sp_ins_borrower @first_name nvarchar(60), @last_name nvarchar(60), @phone bigint
AS
BEGIN TRY
	INSERT INTO [dbo].[Borrower]
			   ([first_name]
			   ,[last_name]
			   ,[phone])
		 VALUES
			   (@first_name
			   ,@last_name
			   ,@phone)
END TRY
BEGIN CATCH
	PRINT 'Message: ';
	PRINT 'ERROR MESSAGE: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_ins_borrower TO diskUserJC;
GO
EXEC sp_ins_borrower 'Jac', 'Casper', 2087611056;
GO
EXEC sp_ins_borrower NULL, NULL, NULL; --Throws error
GO

SELECT * FROM Borrower;

----------------------------------------------------------------------

--stored procedure to update borrower
DROP PROC IF EXISTS sp_upd_borrower;
GO
CREATE PROC sp_upd_borrower @borrower_id int, @first_name nvarchar(60), @last_name nvarchar(60), @phone bigint
AS
BEGIN TRY
	UPDATE [dbo].[Borrower]
	   SET [first_name] = @first_name
		  ,[last_name] = @last_name
		  ,[phone] = @phone
	 WHERE [borrower_id] = @borrower_id
END TRY
BEGIN CATCH
	PRINT 'Message: ';
	PRINT 'ERROR MESSAGE: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_upd_borrower TO diskUserJC;
GO
EXEC sp_upd_borrower 22, 'John', 'Casper', 1111111111;
GO
-- Throws error
EXEC sp_upd_borrower 22, NULL, NULL, NULL;
GO
SELECT * FROM Borrower;

-------------------------------------------------------------------------

--stored procedure to delete borrower

DROP PROC IF EXISTS sp_del_borrower;
GO
CREATE PROC sp_del_borrower @borrower_id int
AS
BEGIN TRY
DELETE FROM [dbo].[Borrower]
      WHERE borrower_id = @borrower_id
END TRY
BEGIN CATCH
	PRINT 'Message: ';
	PRINT 'ERROR MESSAGE: ' + CONVERT(VARCHAR(200), ERROR_MESSAGE());
END CATCH
GO
GRANT EXECUTE ON sp_del_borrower TO diskUserJC;
GO
EXEC sp_del_borrower 22;
GO
SELECT * FROM Borrower;
