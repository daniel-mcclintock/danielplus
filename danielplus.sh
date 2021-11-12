#!/bin/bash

media() {
  gsudo mount -t cifs $CIFS_MEDIA_REMOTE_PATH $CIFS_MEDIA_LOCAL_PATH -o user=$USER && cd $CIFS_MEDIA_LOCAL_PATH
}

movie() {
  IS_MOUNTED="$(mount | grep $CIFS_MEDIA_REMOTE_PATH | wc -l)"

  if [ "$IS_MOUNTED" -eq "1" ]; then
    cd $CIFS_MEDIA_LOCAL_PATH/movies >>/dev/null
    MOVIE="$(ls | fzf)"
    echo "$MOVIE"
    mpv "./$MOVIE"
  else
    media
    movie
  fi
}

series() {
  IS_MOUNTED="$(mount | grep $CIFS_MEDIA_REMOTE_PATH | wc -l)"

  if [ "$IS_MOUNTED" -eq "1" ]; then
    cd $CIFS_MEDIA_LOCAL_PATH/series >>/dev/null
    SERIES="$(ls | fzf)"
    echo "$SERIES"

    SEASON="all $(ls "$SERIES/")"
    SEASON="$(echo $SEASON | tr " " "\n" | fzf)"

    if [ "$SEASON" == "all" ]; then
      mpv "./$SERIES/"
    else
      EPISODE="all $(ls "./$SERIES/$SEASON/")"
      EPISODE="$(echo $EPISODE | tr " " "\n" | fzf)"

      if [ "$EPISODE" == "all" ]; then
        mpv "./$SERIES/$SEASON/"
      else
        mpv "./$SERIES/$SEASON/$EPISODE"
      fi
    fi
  else
    media
    series
  fi
}

random-series() {
  IS_MOUNTED="$(mount | grep $CIFS_MEDIA_REMOTE_PATH | wc -l)"

  if [ "$IS_MOUNTED" -eq "1" ]; then
    cd $CIFS_MEDIA_LOCAL_PATH/series >>/dev/null
    SERIES="$(ls | sort -R | head -n 1)"
    echo "$SERIES"
    mpv "$SERIES" --no-terminal
  else
    media
    random-series
  fi
}

recent-movie() {
  # The same as movie, sorted by directory creation date
  IS_MOUNTED="$(mount | grep $CIFS_MEDIA_REMOTE_PATH | wc -l)"

  if [ "$IS_MOUNTED" -eq "1" ]; then
    cd $CIFS_MEDIA_LOCAL_PATH/movies >>/dev/null
    MOVIE="$(ls -t | fzf)"
    echo "$MOVIE"
    mpv "./$MOVIE"
  else
    media
    recent-movie
  fi
}

random-movie() {
  IS_MOUNTED="$(mount | grep $CIFS_MEDIA_REMOTE_PATH | wc -l)"

  if [ "$IS_MOUNTED" -eq "1" ]; then
    cd $CIFS_MEDIA_LOCAL_PATH/movies >>/dev/null
    MOVIE="$(ls | sort -R | head -n 1)"
    echo "$MOVIE"
    mpv "$MOVIE" --no-terminal
  else
    media
    random-movie
  fi
}

daniel-plus() {
  while [ true ]; do
    if [ "$(($RANDOM % 10))" -lt 5 ]; then
      printf "Movie: "
      random-movie
    else
      printf "Series: "
      random-series
    fi
  done
}
alias daniel+=daniel-plus
