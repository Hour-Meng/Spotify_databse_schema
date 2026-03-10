# Write main code here
create table users(
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
)


create Table artists(
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
)