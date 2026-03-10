# Write main code here
create table users(
    user_id int PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    gender CHAR(1),
    password VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    country VARCHAR(50),
    date_of_birth DATE,
    profile_image BLOB,
    created_at TIMESTAMP,
    is_active BOOLEAN,
    description TEXT
)


create Table artists(
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    gender CHAR(1),
    date_of_birth DATE,
    country VARCHAR(50),
    genre VARCHAR(50),
    profile_image BLOB,

    description TEXT
)