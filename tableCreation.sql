DROP DATABASE IF EXISTS MoodApp;

CREATE DATABASE MoodApp;

USE MoodApp;

CREATE TABLE IF NOT EXISTS Users(
	username varchar(20),
	displayName varchar(20),
	password varchar(20),
	creationDate datetime,
	PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS UserDefinedEvent(
	eventID int,	
	username varchar(20),
	event varchar(20),
	PRIMARY KEY (eventID)
);

CREATE TABLE IF NOT EXISTS MoodColor(
	moodID int,
	mood varchar(20),
	color varchar(20),
	PRIMARY KEY (moodID)
);

CREATE TABLE IF NOT EXISTS UserMoodsByTime(
	username varchar(20),
	entryTime datetime,
	moodID int,
	durationInHours int,
	PRIMARY KEY (username, entryTime),
	FOREIGN KEY (moodID) REFERENCES MoodColor(MoodID)
);

CREATE TABLE IF NOT EXISTS UserEventsByTime(
	username varchar(20),
	entryTime datetime,
	eventID int,
	durationInHours int,
	PRIMARY KEY (username, entryTime),
	FOREIGN KEY (eventID) REFERENCES UserDefinedEvent(eventID)
);


INSERT INTO MoodColor (moodID, mood, color)
VALUES 
	(0, "Anger", "#FF5D5D"),
	(1, "Anxiety", "#5DEBFF"),
	(2, "Tranquility", "#C95DFF"),
	(3, "Craving", "#FE8540"),
	(4, "Disgust", "#BAFF68"),
	(5, "Joy", "#FFE65D"),
	(6, "Romance", "#FF5DD2"),
	(7, "Sadness", "#5D72FF");
	
INSERT INTO Users VALUES ("test", "test", "password", NOW());

 create view UserMoodsLastWeek as
 select username,entryTime,durationInHours,mood,color from usermoodsbytime natural join moodcolor
 where entryTime BETWEEN date_sub(now(),INTERVAL 1 WEEK) and now() AND username="test";
 
DELIMITER //

CREATE PROCEDURE getMoods()
BEGIN
SELECT * FROM moodcolor;
END;
//


CREATE PROCEDURE getVizDetails()
BEGIN
SELECT COUNT(*) As count, color FROM UserMoodsByTime natural join MoodColor WHERE username="test" GROUP BY color;
END;
//

CREATE PROCEDURE insertUserMood(
								in _username varchar(20),
								in _entryTime datetime,
								in _moodID int,
								in _durationInHours int
								)
BEGIN
INSERT INTO UserMoodsByTime (username, entryTime, moodID, durationInHours) VALUES (_username, _entryTime, _moodID, _durationInHours);
END;
//

CREATE PROCEDURE getUserDetails()
BEGIN
SELECT * FROM Users WHERE username="test";
END;
//


CREATE PROCEDURE getMoodsFromView()
BEGIN
SELECT * FROM UserMoodsLastWeek;
END;
//

CREATE TRIGGER dateCheck
	BEFORE INSERT ON UserMoodsByTime
	FOR EACH ROW
BEGIN
	IF NEW.entryTime > NOW() 
		THEN SET new.entryTime = NULL;
	END IF;
END;
//


Create FUNCTION MostFrequentMood()
RETURNS varchar(100) 
BEGIN
    DECLARE dummy int;
	DECLARE moodRet varchar(20);
	DECLARE colorRet varchar(20);

SELECT MAX(counts) as maxCt, color, mood into dummy, colorRet, moodRet FROM (

    SELECT COUNT(*) As counts, mood, color
    FROM UserMoodsByTime NATURAL JOIN MoodColor
    WHERE username="test"
    GROUP BY mood
   )
AS moodCount;
 
RETURN CONCAT(moodRet,'|', colorRet);

END
//



DELIMITER ;



