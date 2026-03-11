# This will focus on creating view table for our SQL

CREATE VIEW Artist_info AS
SELECT
  Artists.artist_id as Artist_ID,
  Albums.album_name as Album_Name,
  Tracks.t_name as Track_Name
FROM Artists
JOIN Albums ON Artists.artist_id = Albums.artist_id
JOIN Tracks ON Albums.album_id = Tracks.album_id;

CREATE VIEW Playlist_Details AS
SELECT `Users`.u_name as User_Name,
       Playlists.playlist_name as Playlist_Name,
       Tracks.t_name as Track_Name
FROM `Users`
JOIN `Playlists` on `Users`.user_id = `Playlists`.user_id
JOIN `Playlist_Tracks` ON `Playlists`.playlist_id = `Playlist_Tracks`.playlist_id
JOIN `Tracks` on `Playlist_Tracks`.track_id = `Tracks`.track_id;


