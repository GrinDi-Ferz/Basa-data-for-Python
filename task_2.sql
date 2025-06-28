--TASK 2
--1)Название и продолжительность самого продолжительного трека
SELECT name, duration FROM Song
WHERE duration = (SELECT MAX(duration) FROM Song)

--2)Название трека, продолжительность которого не менее 3,5 минут
SELECT name FROM Song
WHERE duration >= 3.5*60;

--3)Названия сборников, вышедших за период с 2018 по 2020 год включительно.
SELECT name FROM Collections
WHERE year_of_public BETWEEN 2018 AND 2020;

--4)Исполнители, это имя состоит из одного слова
SELECT name FROM Artist 
WHERE name  NOT LIKE '% %';

--5)Название трека, содержащее слово «мой» или «мой»
SELECT name FROM Song 
WHERE LOWER(name) LIKE '%мой%';

--TASK 3
--1)Количество исполнителей в каждом жанре.
SELECT name, count(ga.artist_id) FROM Genre
JOIN genre_artist ga ON id = ga.genre_id
GROUP BY name;

--2)Количество треков, вошедших в альбомы 2019–2020 годов
SELECT albom.name, albom.release_year, count(s.albom_id) FROM albom 
JOIN song s ON albom.id = s.albom_id
WHERE albom.release_year BETWEEN 2019 AND 2020
GROUP BY albom.name, albom.release_year;

--3)Средняя продолжительность треков по каждому альбому.
SELECT albom.name, AVG(s.duration) FROM albom
JOIN song s ON albom.id = s.albom_id
GROUP BY albom.name;

--4)Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT artist.name, albom.release_year FROM artist 
JOIN artist_albom aa ON id = aa.artist_id
JOIN albom ON aa.albom_id = albom.id
WHERE albom.release_year != 2020; 

--5)Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT collections.name FROM collections 
JOIN collection_song cs  ON collections.id = cs.collection_id
JOIN song ON cs.song_id = song.id
JOIN albom ON song.albom_id = albom.id
JOIN artist_albom aa ON albom.id = aa.albom_id
JOIN artist ON aa.artist_id = artist.id
WHERE artist.name LIKE '%Круг%'
GROUP BY collections.name
ORDER BY collections.name;

--TASK 4
--1)Названия альбомов, в которых представлены исполнители более чем одного жанра.
SELECT albom.name FROM albom 
JOIN artist_albom aa ON albom.id = aa.albom_id
JOIN artist ON aa.artist_id = artist.id
JOIN genre_artist ON artist.id = genre_artist.artist_id 
GROUP BY albom.name
HAVING count(genre_artist.genre_id) > 1;

--2)Наименования треков, которые не включены в сборники.
SELECT song.name FROM song
LEFT JOIN collection_song ON song.id = collection_song.song_id
WHERE collection_song.song_id IS NULL;

--3)Исполнитель или исполнители, записавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько
select artist.name, song.duration from artist 
join artist_albom on artist.id = artist_albom.artist_id
join song on artist_albom.albom_id = song.albom_id
where song.duration in (select MIN(duration) from song);

--4)Названия альбомов, содержащих наименьшее количество треков.
select albom.name from albom 
join song on albom.id = song.albom_id
group by albom.name
HAVING count(song.id) in 
	(select count(song.id) from albom
	join song on albom.id = song.albom_id 
	group by albom.name
	order by count(song.id)
	limit 1)


