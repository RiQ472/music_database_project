#******************************************
#CRUD(Create, Read,Update and Delete) Practice 
#******************************************
#Create database
#******************************************
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
('Shakira', 'Colombia', 1990, 'Latin Pop', TRUE, TRUE);

#SELECT * 
#from artists;

-- Add productions for each artist
INSERT INTO productions (title, production_type, release_year, genre, studio, rating) VALUES
('Music', 'movie', 2021, 'Musical/Drama', 'Landay Entertainment', 'PG-13'),  -- Sia
('Mito', 'movie', 2021, 'Thriller', 'DPR', 'R'),  -- DPR IAN
('The Little Mermaid', 'movie', 2023, 'Fantasy/Musical', 'Walt Disney Pictures', 'PG'),  -- Chloe x Halle (Halle Bailey)
('Judas and the Black Messiah', 'movie', 2021, 'Biography/Drama', 'Warner Bros', 'R'),  -- J. Cole (cameo)
('Lovely Runner', 'tv_show', 2024, 'Romance/Time Travel', 'tvN', 'TV-14'),  -- Twice (Kim Hye-yoon, not Twice member but showcasing K-pop culture)
('Kaleidoscope', 'animated_film', 2016, 'Fantasy', 'Coldplay/Independent', 'NR'),  -- Coldplay (voice cameos in their own film)
('Ralph Breaks the Internet', 'animated_film', 2018, 'Comedy/Adventure', 'Walt Disney Animation Studios', 'PG'),  -- Imagine Dragons (cameo)
('X-Men Origins: Wolverine', 'movie', 2009, 'Action/Superhero', '20th Century Fox', 'PG-13'),  -- Black Eyed Peas (will.i.am)
('Girl Meets World', 'tv_show', 2014, 'Comedy/Drama', 'Disney Channel', 'TV-G'),  -- Sabrina Carpenter
('Scream VI', 'movie', 2023, 'Horror', 'Paramount Pictures', 'R'),  -- Doja Cat (cameo)
('Spenser Confidential', 'movie', 2020, 'Action/Comedy', 'Netflix', 'R'),  -- Post Malone
('Frozen II', 'animated_film', 2019, 'Fantasy/Musical', 'Walt Disney Animation Studios', 'PG'),  -- AURORA (sang "Into the Unknown" - inspiration)
('Eternals', 'movie', 2021, 'Action/Superhero', 'Marvel Studios', 'PG-13'),  -- BTS (cameo reference)
('Zootopia', 'animated_film', 2016, 'Comedy/Adventure', 'Walt Disney Animation Studios', 'PG'),  -- Shakira
('Don''t Look Up', 'movie', 2021, 'Comedy/Satire', 'Netflix', 'R');  -- Ariana Grande

-- Link artists to their productions in production_cast
INSERT INTO production_cast (production_id, artist_id, role_name, role_type, is_lead_role) VALUES  -- Nested query/Subquery
-- Sia in Music
((SELECT production_id FROM productions WHERE title = 'Music'),  	-- Scalar Subquery(Select returns a single value that is used directly in the insert statement
 (SELECT artist_id FROM artists WHERE artist_name = 'Sia'), 		-- Inline SELECT
 'Ebo', 'actor', FALSE),

-- DPR IAN in Mito
((SELECT production_id FROM productions WHERE title = 'Mito'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'DPR IAN'), 
 'Mito', 'actor', TRUE),

-- Chloe x Halle in The Little Mermaid (Halle Bailey)
((SELECT production_id FROM productions WHERE title = 'The Little Mermaid'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Chloe X Halle'), 
 'Ariel', 'actor', TRUE),

-- J. Cole in Judas and the Black Messiah
((SELECT production_id FROM productions WHERE title = 'Judas and the Black Messiah'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'J. Cole'), 
 'Himself', 'cameo', FALSE),

-- Twice in Lovely Runner
((SELECT production_id FROM productions WHERE title = 'Lovely Runner'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Twice'), 
 'Themselves', 'cameo', FALSE),

-- Coldplay in Kaleidoscope
((SELECT production_id FROM productions WHERE title = 'Kaleidoscope'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Coldplay'), 
 'Themselves', 'voice_actor', FALSE),

-- Imagine Dragons in Ralph Breaks the Internet
((SELECT production_id FROM productions WHERE title = 'Ralph Breaks the Internet'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Imagine Dragons'), 
 'Themselves', 'cameo', FALSE),

-- Black Eyed Peas in X-Men Origins (will.i.am as John Wraith)
((SELECT production_id FROM productions WHERE title = 'X-Men Origins: Wolverine'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Black Eyed Peas'), 
 'John Wraith', 'actor', FALSE),

-- Sabrina Carpenter in Girl Meets World
((SELECT production_id FROM productions WHERE title = 'Girl Meets World'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Sabrina Carpenter'), 
 'Maya Hart', 'actor', TRUE),

-- Doja Cat in Scream VI
((SELECT production_id FROM productions WHERE title = 'Scream VI'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Doja Cat'), 
 'Herself', 'cameo', FALSE),

-- Post Malone in Spenser Confidential
((SELECT production_id FROM productions WHERE title = 'Spenser Confidential'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Post Malone'), 
 'Squeeb', 'actor', FALSE),

-- AURORA in Frozen II (song inspiration/performance)
((SELECT production_id FROM productions WHERE title = 'Frozen II'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'AURORA'), 
 'Voice of Iduna (inspiration)', 'voice_actor', FALSE),

-- BTS in Eternals
((SELECT production_id FROM productions WHERE title = 'Eternals'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'BTS'), 
 'Themselves', 'cameo', FALSE),

-- Shakira in Zootopia
((SELECT production_id FROM productions WHERE title = 'Zootopia'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Shakira'), 
 'Gazelle', 'voice_actor', FALSE),

-- Ariana Grande in Don't Look Up
((SELECT production_id FROM productions WHERE title = 'Don''t Look Up'), 
 (SELECT artist_id FROM artists WHERE artist_name = 'Ariana Grande'), 
 'Riley Bina', 'actor', FALSE);

-- Show all artists and their productions with role types
SELECT 
    a.artist_name,
    p.title AS production_title,
    p.production_type,
    p.release_year,
    pc.role_name,
    pc.role_type,
    pc.is_lead_role
FROM artists a
JOIN production_cast pc ON a.artist_id = pc.artist_id
JOIN productions p ON pc.production_id = p.production_id
ORDER BY a.artist_name, p.release_year;
 

