CREATE TABLE IF NOT EXISTS Genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Artist(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS genre_artist (
	artist_id INTEGER REFERENCES Artist(id) ON DELETE CASCADE,
	genre_id INTEGER REFERENCES Genre(id) ON DELETE cascade,
	PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS Albom (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS artist_albom (
	artist_id INTEGER REFERENCES Artist(id) ON DELETE CASCADE,
	albom_id INTEGER REFERENCES Albom(id) ON DELETE cascade,
	PRIMARY KEY (artist_id, albom_id)
);

CREATE TABLE IF NOT EXISTS Song (
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	albom_id INTEGER REFERENCES Albom(albom_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Collections (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT null,
	year_of_public INTEGER
);

CREATE TABLE IF NOT EXISTS Collection_Song (
	collection_id INTEGER REFERENCES Collections(id) ON DELETE CASCADE,
	song_id INTEGER REFERENCES Song(id) ON DELETE CASCADE,
	PRIMARY KEY (collection_id, song_id)
);






