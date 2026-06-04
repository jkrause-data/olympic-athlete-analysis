DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS athletes;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS sport;
DROP TABLE IF EXISTS years;
DROP TYPE IF EXISTS medal_enum;

CREATE TYPE medal_enum AS ENUM ('Gold', 'Silver', 'Bronze');

CREATE TABLE Years(
	YearID SERIAL PRIMARY KEY,
	Year  INT
);

CREATE Table Athletes (
	AthleteID SERIAL PRIMARY KEY,
	Name TEXT,
	Sex TEXT
);

CREATE Table Sport (
	SportID SERIAL PRIMARY KEY,
	Sport TEXT
);

CREATE Table Events (
	EventID SERIAL PRIMARY KEY,
	Event TEXT,
	SportID INT REFERENCES Sport(SportID)
);


CREATE Table Country (
	CountryID SERIAL PRIMARY KEY,
	Country TEXT,
	NOC TEXT
);

CREATE Table Results (
	ResultID SERIAL PRIMARY KEY,
	AthleteID INT REFERENCES Athletes(AthleteID),
	CountryID INT REFERENCES Country(CountryID),
	EventID INT REFERENCES Events(EventID),
	YearID INT REFERENCES Years(YearID),
	Age INT,
	Height INT,
	Weight INT,
	Medal medal_enum
		
);

COPY years(yearid, year)
FROM 'C:\Program Files\PostgreSQL\18\data\import\Olympics\Years.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    QUOTE '"'
);


COPY athletes(athleteid, name, sex)
FROM 'C:\Program Files\PostgreSQL\18\data\import\Olympics\Athletes.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    QUOTE '"'
);

COPY sport(sportid, sport)
FROM 'C:\Program Files\PostgreSQL\18\data\import\Olympics\Sport.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    QUOTE '"'
);

COPY events(eventid, event, sportid)
FROM 'C:\Program Files\PostgreSQL\18\data\import\Olympics\Events.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    QUOTE '"'
);

COPY country(countryid, country, noc)
FROM 'C:\Program Files\PostgreSQL\18\data\import\Olympics\Country.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    QUOTE '"'
);


COPY results(resultid, athleteid, countryid, eventid, yearid, age, height, weight, medal )
FROM 'C:\Program Files\PostgreSQL\18\data\import\Olympics\Results.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ';',
    QUOTE '"'
);