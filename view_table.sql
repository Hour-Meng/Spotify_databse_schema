# This will focus on creating view table for our SQL

CREATE VIEW Artist_info AS
SELECT
  Artists.artist_id,
  Albums.album_name,
  Tracks.t_name
FROM Artists
JOIN Albums ON Artists.artist_id = Albums.artist_id
JOIN Tracks ON Albums.album_id = Tracks.album_id;

