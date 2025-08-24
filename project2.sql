-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
select count(*)
from spotify;


select count(distinct artist )
from spotify;

select max(duration_min)
from spotify;

select * 
from spotify
where duration_min = 0;

-- delete the song which has 0 duration 

delete from spotify 
where duration_min = 0

select * 
from spotify
where duration_min = 0;

-- Querstion 1
-- // retrive all the name which has more than on billion stream //

select * 
from spotify 
where stream > 1000000000;


-- question no. 2
-- list all albumbs which thweir respective artist

select * 
from spotify 

select distinct artist , album
from spotify 
-- group by artist, album;

-- Querstion 3--
-- Get the total number of comments for tracks where licensed = TRUE.
select * 
from spotify;

select sum(comments) as comment
from spotify
where licensed = 'true'

--question 4--
-- Find all tracks that belong to the album type single.
select * 
from spotify

select track
from spotify 
where album_type = 'single';

-- Question 5 
-- -- Count the total number of tracks by each artist.

select *
from spotify

select artist, count(track)
from spotify 
group by artist

-- -- Question 5 --
-- Calculate the average danceability of tracks in each album.

select *
from spotify;

select album, avg(danceability)  as avgdance
from spotify
group by album
order by 2 desc;

-- -- -- Question 6 --
-- Find the top 5 tracks with the highest energy values.
select *
from spotify

select track, avg(energy) as avg_ener
from spotify 
group by track
order by avg_ener desc
limit 5;


-- -- Question 7 ---
-- List all tracks along with their views and likes where official_video = TRUE.

select *
from spotify

select track, sum(views) as views_, sum(likes) as Likes
from spotify
where official_video = 'True'
group by 1
order by 2 desc
limit 5;

-- ----Question 9 ------
-- For each album, calculate the total views of all associated tracks.

select *
from spotify

SELECT album,track, sum(views) as total_views
from spotify
group by album,track
order by 2 desc;

-- question 10 -------
-- Retrieve the track names that have been streamed on Spotify more than YouTube.
select *
from
(
select track,
SUM(case when (most_played_on = 'Spotify') THEN stream 
	ELSE 0
    END )as stream_youtube, 
SUM(CASE 
	when (most_played_on = 'Youtube') THEN stream 
	ELSE 0
	END)	as stream_spotify
	
from spotify
GROUP BY TRACK)as t1 
where stream_spotify > stream_youtube and stream_youtube > 0











-- ---- Question 12 --------
-- Write a query to find tracks where the liveness score is above the average.

select track
from spotify 
where liveness >(select avg(liveness)
from spotify)

-- ----Question 13--------
--  calculate the difference between the highest and lowest energy values for tracks in each album.
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC
