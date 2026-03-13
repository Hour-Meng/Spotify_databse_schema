# Write main code here
create table Users(
    user_id int PRIMARY KEY AUTO_INCREMENT,
    u_name VARCHAR(50) NOT NULL,
    u_gender CHAR(1),
    u_password VARCHAR(100) NOT NULL,
    u_email VARCHAR(50) NOT NULL UNIQUE,
    u_country VARCHAR(50),
    u_date_of_birth DATE,
    u_profile_image BLOB,
    u_created_at TIMESTAMP,
    u_is_active BOOLEAN,
    u_description TEXT
);


create Table Artists(
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    a_name VARCHAR(50) NOT NULL UNIQUE,
    a_email VARCHAR(50) NOT NULL UNIQUE,
    a_password VARCHAR(100) NOT NULL,
    a_gender CHAR(1),
    a_date_of_birth DATE,
    a_country VARCHAR(50),
    a_genre VARCHAR(50),
    a_profile_image BLOB,

    a_description TEXT
);


create Table Albums(
    album_id int PRIMARY KEY AUTO_INCREMENT,
    album_name VARCHAR(50) NOT NULL,
    album_image BLOB,
    album_description TEXT,
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
  
);

create TABLE Tracks(
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    t_name VARCHAR(50) NOT NULL,
    t_length INT NOT NULL,
    t_path VARCHAR(255),
    album_id INT,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);

CREATE TABLE Playlists(
  playlist_id INT PRIMARY KEY AUTO_INCREMENT,
  playlist_name VARCHAR(50) NOT NULL,
  playlist_image BLOB,
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Playlist_Tracks(
  playlist_id INT,
  track_id INT,
  `Order` INT,
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
    like_date_time DATETIME,
    PRIMARY KEY (user_id, track_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (track_id) REFERENCES Tracks(track_id)
);

--to add a new column to the "users" table to store the user type(regular, premium)--
ALTER Table `Users` ADD u_plan VARCHAR(10) NOT NULL DEFAULT "regular";

CREATE Table Premium_Feature(
    premium_feature_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(10) 
);

-- to insert the premium user feaure into the "premium_feature" table--
INSERT INTO Premium_Feature (name) VALUES ('Ad-free listening');

create table Users_Premium_Feature(
    user_id int,
    premium_feature_id int,
    PRIMARY KEY (user_id, premium_feature_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    Foreign Key (premium_feature_id) REFERENCES Premium_Feature(premium_feature_id)
);

create table Payment(
    payment_id int primary key AUTO_INCREMENT,
    user_id int not null,
    payment_method varchar(50) not null,
    payment_data date not null,
    amount decimal(10,2) not null,
    Foreign Key (user_id) REFERENCES Users(user_id)
);

create table Subscription_Plan (
    subscription_plan_id int primary key AUTO_INCREMENT,
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
    start_date DATE not null,
    end_date DATE not null,
    primary key (user_id, subscription_plan_id),
    Foreign Key (user_id) REFERENCES Users(user_id),
    Foreign Key (subscription_plan_id) REFERENCES Subscription_Plan(subscription_plan_id)
);

CREATE Table User_Tracks(
    user_id int,
    track_id int,
    play_date DATE not null,
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
    notification_id int primary key AUTO_INCREMENT,
    user_id int not null,
    title varchar(100) not null,
    content varchar(255) not null,
    creation_date DATE not null,
    Foreign Key (user_id) REFERENCES Users(user_id)
)
