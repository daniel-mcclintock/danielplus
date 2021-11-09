# danielplus
## death to disney+

```sh
# Fzf a movie to watch
movie

# Fzf a series to watch
series

# Watch a random movie
random-movie

# Watch a random series
random-series

# Infinitely watch random media
daniel+
```

 - Assumes movies are stored in individial directories
   - eg: /media/path/{movie_directory}/{movie_file}.mkv
 - Assumes series are stored in individial directories, with season sub-directories
   - eg: /media/path/{series_directory}/{series_season}/{series_s01e01}.mkv

 - depends gsudo, fzf, mpv, cifs-utils
 - export `CIFS_MEDIA_REMOTE_PATH` with your CIFS/Samba Network path to your "legit" media server.
   eg: `export CIFS_MEDIA_REMOTE_PATH=//192.168.1.2/movies_and_shit`
 - export `CIFS_MEDIA_LOCAL_PATH` with a local path to mount media to
 - eg: `export CIFS_MEDIA_LOCAL_PATH=/mnt/movies_and_shit`
 - source danielplus.sh
