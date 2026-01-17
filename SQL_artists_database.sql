#******************************************
#CRUD(Create, Read,Update and Delete) Practice 
#******************************************
#Create database
#******************************************
CREATE DATABASE artists_tracker;
USE artists_tracker;
#******************************************
#	The Artist
#******************************************
CREATE TABLE artists (
artist_id INT PRIMARY KEY AUTO_INCREMENT,
artist_name VARCHAR(255) NOT NULL,
country VARCHAR(100),
formed_year INT,
genre VARCHAR(100),
is_active BOOLEAN DEFAULT TRUE,
also_acts BOOLEAN DEFAULT FALSE
);
#******************************************
#	The Album
#******************************************
CREATE TABLE albums (
    album_id INT PRIMARY KEY AUTO_INCREMENT,
    album_title VARCHAR(255) NOT NULL,
    artist_id INT,
    release_date DATE,
    album_type ENUM('studio', 'live', 'single', 'soundtrack'),  -- ADDED soundtrack
    label VARCHAR(255),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);
#******************************************
#	Tracks
#******************************************
CREATE TABLE tracks (
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    track_title VARCHAR(255) NOT NULL,
    album_id INT,
    track_number INT,
    duration_seconds INT,
    explicit_content BOOLEAN DEFAULT FALSE,
    is_soundtrack BOOLEAN DEFAULT FALSE,  -- NEW
    FOREIGN KEY (album_id) REFERENCES albums(album_id)
);
#******************************************
#	Production
#******************************************
CREATE TABLE productions (
    production_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    production_type ENUM('movie', 'tv_show', 'animated_film', 'animated_series'),
    release_year INT,
    genre VARCHAR(100),
    studio VARCHAR(255),
    rating VARCHAR(10)
    );
#******************************************
#	Production Soundtrack
-- Tracks featured in movies/Tv shows
#******************************************
CREATE TABLE production_soundtrack (
    production_id INT,
    track_id INT,
    is_original_score BOOLEAN DEFAULT FALSE,  -- was it made FOR this production?
    PRIMARY KEY (production_id, track_id),
    FOREIGN KEY (production_id) REFERENCES productions(production_id),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id)
    );
#******************************************
#	Production Cast
-- Artist who have acted or voiced characters
#******************************************
CREATE TABLE production_cast (
    cast_id INT PRIMARY KEY AUTO_INCREMENT,
    production_id INT,
    artist_id INT,  -- Links to your artists table!
    role_name VARCHAR(255),  -- Character name
    role_type ENUM('actor', 'voice_actor', 'cameo'),
    is_lead_role BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (production_id) REFERENCES productions(production_id),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);


INSERT INTO artists (artist_name, country, formed_year, genre, is_active, also_acts) VALUES
('Sia', 'Australia', 1995, 'Pop', TRUE, TRUE),
('DPR IAN', 'Australia', 2020, 'Alternative R&B/K-Pop', TRUE, TRUE),
('Chloe X Halle', 'USA', 2011, 'R&B', TRUE, TRUE),
('J. Cole', 'USA', 2007, 'Hip Hop', TRUE, FALSE),
('Twice', 'South Korea', 2015, 'K-Pop', TRUE, FALSE),
('Coldplay', 'United Kingdom', 1996, 'Alternative Rock', TRUE, FALSE),
('Imagine Dragons', 'USA', 2008, 'Alternative Rock/Pop Rock', TRUE, FALSE),
('Black Eyed Peas', 'USA', 1995, 'Hip Hop/Pop', TRUE, FALSE),
('Sabrina Carpenter', 'USA', 2011, 'Pop', TRUE, TRUE),
('Doja Cat', 'USA', 2014, 'Pop/Hip Hop', TRUE, FALSE),
('Post Malone', 'USA', 2013, 'Hip Hop/Pop', TRUE, FALSE),
('AURORA', 'Norway', 2012, 'Art Pop/Electropop', TRUE, FALSE),
('BTS', 'South Korea', 2013, 'K-pop/Pop', TRUE, TRUE),
('Ariana Grande', 'USA', 2008, 'Pop/R&B', TRUE, TRUE);

Select * 
from artists


