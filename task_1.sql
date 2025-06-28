CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

DELETE FROM Genre;
INSERT INTO Genre (id, name)
VALUES  (1, 'рок'),
		(2, 'поп'),
		(3, 'джаз'),
		(4, 'шансон'),
		(5, 'рэп');

CREATE TABLE IF NOT EXISTS Artist(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

ALTER TABLE Artist
ADD COLUMN IF NOT EXISTS description VARCHAR;

DELETE FROM Artist;
INSERT INTO Artist (id, name, description)
VALUES  (1, 'Валерий Кипелов', 'Топовый исполнитель рок музыки '),
		(2, 'Асти', 'Артистка захватившая площадку в поп музыке'),
		(3, 'Фрэнк  Сенатра', 'Легенда джаз музыки'),
		(4, 'Круг', 'Лучший певец в жанре шансон'),
		(5, 'Михаил Горшенев', 'Культовый испонитель'),
		(6, 'Баста', 'Рэп исполнитель из Ростова');

CREATE TABLE IF NOT EXISTS genre_artist (
	artist_id INTEGER REFERENCES Artist(id) ON DELETE CASCADE,
	genre_id INTEGER REFERENCES Genre(id) ON DELETE cascade,
	PRIMARY KEY (artist_id, genre_id)
);

DELETE FROM genre_artist;
INSERT INTO genre_artist (artist_id, genre_id)
VALUES  (1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 1),
		(6, 5);

CREATE TABLE IF NOT EXISTS Albom (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

ALTER TABLE Albom
ADD COLUMN IF NOT EXISTS release_year INT;

ALTER TABLE Albom
ADD COLUMN IF NOT EXISTS title VARCHAR;

DELETE FROM Albom;
INSERT INTO Albom (id, name, release_year, title)
VALUES  (1, 'Возьми мое сердце', 1992, 'Лирические баллады'),
		(2, 'По барам', 2018, 'Альбов посвящен любви'),
		(3, 'Жизнь', 1968, 'Знаменитые песни Фрэнка Синатра'),
		(4, 'Центр', 2019, 'О не легкой воровской жизни'),
		(5, 'Коллизей', 1990, 'Легионеры в перед'),
		(6, 'Любовь', 2020, 'Любовь прекрасна'),
		(7, 'Кукла колдуна', 1999, 'Сказка');

CREATE TABLE IF NOT EXISTS artist_albom (
	artist_id INTEGER REFERENCES Artist(id) ON DELETE CASCADE,
	albom_id INTEGER REFERENCES Albom(id) ON DELETE cascade,
	PRIMARY KEY (artist_id, albom_id)
);

DELETE FROM artist_albom;
INSERT INTO artist_albom (artist_id, albom_id)
VALUES  (1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(1, 5),
		(2, 6),
		(5, 7),
		(6, 2);

CREATE TABLE IF NOT EXISTS Song (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	albom_id INTEGER REFERENCES Albom(albom_id) ON DELETE CASCADE
);

ALTER TABLE Song
ADD COLUMN IF NOT EXISTS duration INT;

DELETE FROM Song;
INSERT INTO Song (id, name, albom_id, duration)
VALUES  (1, 'Сердце', 1, 200),
		(2, 'Дорога', 5, 70),
		(3, 'Мой Бар', 2, 100),
		(4, 'Дождь', 6, 250),
		(5, 'Купола', 4, 70),
		(6, 'Фраер', 4, 90),
		(7, 'Мой путь', 3, 300),
		(8, 'Нью-Йорк', 3, 95),
		(9, 'Кукла', 7, 150),
		(10, 'Сансара', 2, 199);

CREATE TABLE IF NOT EXISTS Collections (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year_of_public INTEGER
);

DELETE FROM Collections;
INSERT INTO Collections (id, name, year_of_public)
VALUES  (1, 'Золотой рок', 1992),
		(2, 'Первая любовь', 2018),
		(3, 'Мир', 1968),
		(4, 'Лирика', 2020),
		(5, 'Лучшее в шансоне', 2019),
		(6, 'Панки Хой', 2000);

create table if not exists Collection_Song (
	collection_id INTEGER REFERENCES Collections(id) ON DELETE CASCADE,
	song_id INTEGER REFERENCES Song(id) ON DELETE CASCADE,
	PRIMARY KEY (collection_id, song_id)
);

DELETE FROM Collection_Song;
INSERT INTO Collection_Song (collection_id, song_id)
VALUES  (1, 1),
		(1, 2),
		(2, 3),
		(2, 4),
		(3, 7),
		(4, 5),
		(5, 6),
		(6, 9),
		(2, 10);




