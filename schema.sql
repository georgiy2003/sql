
-- Genres (many artists <-> many genres)
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE
);

-- Artists
CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- artists <-> genres (many-to-many)
CREATE TABLE artists_genres (
    artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, genre_id)
);

-- Albums 
CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    release_date DATE,
    label VARCHAR(200)
);

-- artists <-> albums (many-to-many)
CREATE TABLE artists_albums (
    artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, album_id)
);

-- Tracks
CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    duration_seconds INTEGER,
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE,
    track_number INTEGER
);

-- Compilations (сборники)
CREATE TABLE compilations (
    id SERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    year INTEGER NOT NULL CHECK (year > 1800 AND year < 2100)
);

CREATE TABLE compilation_tracks (
    compilation_id INTEGER NOT NULL REFERENCES compilations(id) ON DELETE CASCADE,
    track_id INTEGER NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
    position INTEGER, -- optional: order in compilation
    PRIMARY KEY (compilation_id, track_id)
);

CREATE INDEX idx_tracks_album ON tracks(album_id);
CREATE INDEX idx_artists_name ON artists(name);
CREATE INDEX idx_genres_name ON genres(name);

