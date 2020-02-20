#! /bin/bash

for i in *.jpeg; do
    if [ "$i" -nt "../thumbs/$i" ]; then
        convert "$i" -resize 250x250 "./thumbs/$i";
    fi
done;