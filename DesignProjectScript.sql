DROP TABLE IF EXISTS Artists;
DROP TABLE IF EXISTS Albums;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Suggestions;
DROP TABLE IF EXISTS RadioStations;
DROP TABLE IF EXISTS AccountType;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS RecordCompanies;

CREATE TABLE Artists (
    artistID char(3) not null,
    artistName text not null,
    artistBio text,
    primary key (artistID)
);


CREATE TABLE Albums (
    albumID int not null,
    albumName text,
    albumYear int,
    albumArtworkID varchar(6),
    primary key (albumID)
);


CREATE TABLE Genres (
    genreID int not null,
    genreName text not null,
    primary key (genreID)
);


CREATE TABLE Songs (
    songID varchar(5) not null,
    artistID char(3) text not null,
    companyID text not null,
    genreID int not null,
    songName text,
    songYear int not null,
    songLyrics text,
    primary key (songID)
);


CREATE TABLE Billing (
    ccNumber char(16) not null,
    userID varchar(6) not null,
    ccv int not null,
    expDate int not null,
    primary key (ccNumber)
);


CREATE TABLE Suggestions (
    songID varchar(5) not null,
    userID varchar(6) not null,
    LikeDislike text,
    primary key (songID, userID)
);



CREATE TABLE RadioStations (
    radioSID varchar(3) not null,
    userID varchar(6) not null,
    moodType text,
    primary key (radioSID)
);


CREATE TABLE AccountType (
    acctID text not null,
    acctType text not null,
    primary key (acctID)
);


CREATE TABLE Users (
    userID varchar (6) not null,
    acctID text not null,
    name text not null,
    email text,
    gender text not null,
    age int not null,
    zipCode int not null,
    socialAcct text,
    primary key (userID)
);



CREATE TABLE RecordCompanies (
    companyID text not null,
    companyName text not null,
    primary key (companyID)
);


INSERT INTO  Artists (artistID, artistName, artistBio)
VALUES ('a01', 'Maroon 5', 'Great band originally started in California'),
       ('j02', 'Jimmy Hendrix', 'The most amazing guitarist in the 70s'),
       ('t05', 'Tiesto', 'A pioneer in the EDM music industry'),
       ('m07', 'Metallica', 'Been on the scene for many years');
       

INSERT INTO Albums (albumID, albumName, albumYear, albumArtworkID)
VALUES ('2386', 'Songs About Jane', '2002', 'mr5sng'),
       ('9937', 'Blues','1994','exhe24'),
       ('8492', 'Nyana', '2003', 'tes846'),
       ('7748', 'Ride The Lightning', '1984', 'rlo662');
       
INSERT INTO Genres (genreID, GenreName)
VALUES ('08', 'Pop'),
       ('03', 'Rock'),
       ('02', 'EDM'),
       ('03', 'Rock'),

INSERT INTO Songs (songID, artistID, companyID, genreID, songName, songYear, SongLyrics)
VALUES ('555rc','a01','UNL', '08', 'Sunday Morning', '2002', 'I love to see her sunday mornings...'),
       ('887mm','j02','MTN', '03', 'Hey Joe', '1994', 'That man standing in the corner...'),
       ('446li','t05','SPN', '02', 'Summer Nights', '2015', 'You and I...'),
       ('498kk','m07','CPL', '03', 'Enter Sandman', '1991', 'Since the sandman...');
       
INSERT INTO Billing (ccNumber, userID, ccv, expDate)
VALUES ('7954628497498546', 'r01879', '798', '0419'),
       ('8884875168219740', 'a01229', '444', '1119'),
       ('5468546210849521', 'c07777', '624', '0817'),
       ('9654546238495215', 'm08954', '598', '1220');
       
INSERT INTO Suggestions (songID, userID, likeDislike)
VALUES ('a01', 'r01879', 'like'),
       ('j02', 'j9999', 'like'),
       ('t05', 'y2465', 'dislike'),
       ('m07', 's8798', 'like');
       
INSERT INTO RadioStations (radioSID, userID, moodType)
VALUES ('845', 'r01879', 'Relaxing'),
       ('887', 'j9999', 'Boxing'),
       ('246', 'y2465', 'Partying'),
       ('635', 's8798', 'Workout');
       
INSERT INTO AccountType (acctID, AcctType)
VALUES ('T489', 'Trial'),
       ('T238', 'Trial'),
       ('M289', 'Member'),
       ('M457', 'Member');
       
INSERT INTO Users (userId, acctID, name, email, gender, age, zipCode, socialAcct)
VALUES ()

INSERT INTO RecordCompanies (companyID, companyName)
VALUES ('UNL', 'Universal Records'),
       ('MTN', 'Motown Records'),
       ('SPN', 'Spinning Records'),
       ('CPL', 'Capital Record');
       

CREATE TRIGGER userChange
AFTER UPDATE ON Users
FOR EACH ROW EXECUTE PROCEDURE changeAlias();

DECLARE 
    old text: = $1;
    new text: = $2;
    resultset REFCURSOR: =$3;
BEGIN
    open resultset for
    UPDATE Artists
    SET artistName = new
    WHERE artistName = old
    RETURN resultset;
$$ LANGUAGE plpsql;
       
select *
from Users;

select *
from Artists;

select *
from Albums;

select *
from Genres;

select *
from Songs;

select *
from Billing;

select *
from Suggestions;

select *
from RadioStations;

select *
from AccountType;

select *
from RecordCompanies;






