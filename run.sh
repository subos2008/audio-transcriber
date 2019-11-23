#!/bin/bash
set -xe

export GOOGLE_APPLICATION_CREDENTIALS=/Users/ryan/Downloads/translator-259914-3b15a6fdd1f2.json

INPUT=$1
DIR=~/tmp/audio

mkdir -p $DIR
rm $DIR/*
ffmpeg -i "$INPUT" -f segment -segment_time 50 -c:a flac -c copy -acodec flac $DIR/foo%03d.flac



gcloud ml speech recognize $DIR/foo000.flac --language-code=ru