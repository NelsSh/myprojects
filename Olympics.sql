-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Creating database and tables
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE projects;

CREATE TABLE projects.olympics_history (
id INT, name VARCHAR(80), 
sex CHAR(1),
age VARCHAR(2), 
height VARCHAR(3), 
weight VARCHAR(12), 
team VARCHAR(50), 
noc VARCHAR(3), 
games VARCHAR(12), 
year INT, 
season VARCHAR(6), 
city VARCHAR(23), 
sport VARCHAR(27), 
event VARCHAR(100), 
medal VARCHAR(6)
);  

CREATE TABLE projects.olympics_history_NOC_regions (noc VARCHAR(4), region VARCHAR(100), notes VARCHAR(100));

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Trying to import my dataset. Import Wizard took a reasonable time with olympics_history_noc_regions but took way too long with olympics_history.
#Thus, decided to use the MYSQL command line client instead with the below syntax and it finished in 3.03s compared to more than 2 days it was still going for!!
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/sharo/OneDrive/Desktop/myprojects/athlete_events.csv' 
INTO TABLE projects.olympics_history FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#QUESTIONS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
#1. Total number of olympic games held in dataset
SELECT count(DISTINCT games) AS total_olympic_games FROM olympics_history;

#2. List of all games held in dataset
SELECT DISTINCT year, season, city FROM olympics_history ORDER BY year;

#3. Total number of nations that participated in each olympic game
SELECT games, count(1) AS total_countries 
	FROM (SELECT games, B.region FROM olympics_history A 
			JOIN olympics_history_noc_regions B
			WHERE A.noc = B.noc
			GROUP BY games, B.region) AS subquery
	GROUP BY games ORDER BY games;

#4. Which nations participated in all the olympic games held thus far?
SELECT pc.*
	FROM (SELECT country, count(1) AS total_participated_games 
			FROM (SELECT games, B.region AS country
					FROM olympics_history A
					JOIN olympics_history_noc_regions B ON A.noc=B.noc
					GROUP BY games, B.region) AS subquery
			GROUP BY country)pc 
	JOIN (SELECT count(distinct games) AS tot_games
	FROM olympics_history)tg ON tg.tot_games = pc.total_participated_games
	ORDER BY 1;
 
 #5. Which sports have been played in all summer games?
 SELECT *
	FROM (SELECT sport, count(1) AS num_of_games
			FROM (SELECT DISTINCT games, sport
					FROM olympics_history WHERE season = 'Summer') 
				AS subquery
          	GROUP BY sport)t3
    JOIN (SELECT count(DISTINCT games) AS total_games
          	FROM olympics_history WHERE season = 'Summer')t1 
	ON t1.total_games = t3.num_of_games;

#6. Which sports have only been featured once in all the games?
SELECT t2.*, t1.games
	FROM (SELECT sport, count(1) as num_of_games
          	FROM (SELECT DISTINCT games, sport
          	FROM olympics_history) AS subquery
          	GROUP BY sport)t2
    JOIN (SELECT DISTINCT games, sport
          	FROM olympics_history)t1 ON t1.sport = t2.sport
	WHERE t2.num_of_games = 1
	ORDER BY t1.sport;



















 
 




