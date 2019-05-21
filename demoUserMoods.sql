use MoodApp;

INSERT INTO UserMoodsByTime (username, entryTime, moodID, durationInHours)
VALUES 
("test", '2019-04-04 10:00:00', 0, 1),
("test", "2019-04-04 22:00:00", 2, 2),
("test", "2019-04-05 12:00:00", 3, 1),
("test", "2019-04-05 16:00:00", 4, 2),
("test", "2019-04-06 05:00:00", 5, 3),

("test", "2019-04-06 19:00:00", 6, 1),
("test", "2019-04-07 07:00:00", 7, 2),
("test", "2019-04-07 20:00:00", 0, 1),
("test", "2019-04-08 09:00:00", 1, 2),
("test", "2019-04-08 22:00:00", 2, 3),

("test", "2019-04-09 01:00:00", 3, 1),
("test", "2019-04-09 14:00:00", 4, 2),
("test", "2019-04-10 03:00:00", 5, 1),
("test", "2019-04-10 16:00:00", 6, 2),
("test", "2019-04-05 05:00:00", 7, 3),

("test", "2019-05-16 18:00:00", 0, 1),
("test", "2019-05-17 08:00:00", 1, 2),
("test", "2019-05-18 20:00:00", 2, 1),
("test", "2019-05-19 09:00:00", 3, 2),
("test", "2019-05-19 21:00:00", 4, 3);