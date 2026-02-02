#!/bin/sh
id=$(echo "$1" | sed -nE 's@.*(v=|be/)([^&?/]+).*@\2@p')
[ -n "$id" ] && echo "https://www.youtube.com/embed/$id"
