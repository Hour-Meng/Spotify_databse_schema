# Write main code here
create table Users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender CHAR(1),
    password CHAR(100) NOT NULL, --never store plain text password, use hashing and salting in real applications--
    email VARCHAR(50) NOT NULL UNIQUE,
    country VARCHAR(50),
    date_of_birth DATE,
    profile_image BYTEA,
    created_at TIMESTAMP,
    is_active BOOLEAN,
    description TEXT
);

create Table Artists(
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    password CHAR(100) NOT NULL,
    gender CHAR(1),
    date_of_birth DATE,
    country VARCHAR(50),
    genre VARCHAR(50),
    profile_image BYTEA,
    description TEXT
);
-- why this table? Because an artist can have multiple genres, an example would be from my favorite artist of all time "Post Malone"
create TABLE Genres(
    genre_id SERIAL PRIMARY KEY,
    artist_id INT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    Foreign Key (artist_id) REFERENCES Artists(artist_id)
);

create Table Albums(
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    image BYTEA,
    description TEXT,
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
  
);

create TABLE Tracks(
    track_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    duration_seconds INT NOT NULL,
    album_id INT,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);

CREATE TABLE Playlists(
  playlist_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  image BYTEA,
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Playlist_Tracks(
  playlist_id INT,
  track_id INT,
  "order" INT,
  PRIMARY KEY (playlist_id, track_id),
  FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id),
  FOREIGN KEY (track_id) REFERENCES Tracks(track_id)
);

CREATE Table Followers(
    user_id INT,
    artist_id INT,
    PRIMARY KEY (user_id, artist_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (artist_id) REFERENCES Artists(artist_id)
);

CREATE Table Likes(
    user_id INT,
    track_id INT,
    liked_at TIMESTAMP,
    PRIMARY KEY (user_id, track_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (track_id) REFERENCES Tracks(track_id)
);

--to add a new column to the "users" table to store the user type(regular, premium)--
ALTER Table Users 
ADD COLUMN plan VARCHAR(10) NOT NULL DEFAULT 'regular';

CREATE Table Premium_Feature(
    premium_feature_id SERIAL PRIMARY KEY,
    perk VARCHAR(50) DEFAULT 'Ad-free listening'
);

create table Users_Premium_Feature(
    user_id int,
    premium_feature_id int,
    PRIMARY KEY (user_id, premium_feature_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    Foreign Key (premium_feature_id) REFERENCES Premium_Feature(premium_feature_id)
);

create table Payment(
    payment_id SERIAL PRIMARY KEY,
    user_id int not null,
    payment_method varchar(50) not null,
    paid_at date not null,
    amount decimal(10,2) not null,
    Foreign Key (user_id) REFERENCES Users(user_id)
);

create table Subscription_Plan (
    subscription_plan_id SERIAL PRIMARY KEY,
    name varchar(50) not null,
    price decimal(10,2) not null,
    description TEXT
);

--insert the plan into the "subscription_plan" table
INSERT INTO Subscription_Plan (name, price, description)
VALUES
('Monthly Premium', 9.99, 'Ad_free listening and offline playback'),
('Monthly Regular', 4.99, 'Regular features');

create table User_Subscription_Plan (
    user_id int,
    subscription_plan_id int,
    start_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_date TIMESTAMPTZ not null default (CURRENT_TIMESTAMP + INTERVAL '1 month'),
    primary key (user_id, subscription_plan_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (subscription_plan_id) REFERENCES Subscription_Plan(subscription_plan_id),
    CHECK (end_date > start_date)
);
-- test insert for user subscription plan
INSERT INTO User_Subscription_Plan (user_id, subscription_plan_id)
VALUES (1, 1);

CREATE Table User_Tracks(
    user_id int,
    track_id int,
    played_at DATE not null,
    play_count int default 1, --Number of time user played this track--
    primary key (user_id, track_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (track_id) REFERENCES Tracks(track_id)
);

CREATE Table Similarity (
    user_id int,
    track_id int,
    similarity_score float,
    primary key (user_id, track_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (track_id) REFERENCES Tracks(track_id)
);

--To calculate the similarity between tracks and users
INSERT into similarity (user_id, track_id, similarity_score)
select user_id, track_id,
    (SUM(play_count) / (SQRT(SUM(play_count) * SUM(play_count))))
from user_tracks
GROUP BY user_id, track_id;

create table Notification (
    notification_id SERIAL primary key,
    user_id int not null,
    title varchar(100) not null,
    content varchar(255) not null,
    created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
    Foreign Key (user_id) REFERENCES Users(user_id)
);

-- control the music quality
-- this is not a junction table
create table Track_Files(
    file_id SERIAL PRIMARY KEY,
    track_id int,
    file_path VARCHAR(255) not null,
    bitrate int not null, -- I'm calling it birtate instead of quality because bitrate tell you in kps
    format varchar(20) not null,
    file_size int,
    Foreign Key (track_id) REFERENCES Tracks(track_id)
);

