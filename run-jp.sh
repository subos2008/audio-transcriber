#!/bin/bash
set -xe

export GOOGLE_APPLICATION_CREDENTIALS=/Users/ryan/Downloads/translator-259914-3b15a6fdd1f2.json

INPUT=$1
DIR=~/tmp/audio
BUCKET=russian-audio

mkdir -p $DIR
rm -f $DIR/*

BASENAME=$(basename "$INPUT")

# gcloud ml speech recognize-long-running can take 80m chunks
ffmpeg -i "$INPUT" -f segment -segment_time 4800 -c:a flac -c copy -acodec flac "$DIR/${BASENAME}%03d.flac"

# overwrite INPUT to be flac file
INPUT="$DIR/${BASENAME}000.flac"
BUCKET_PATH="${BASENAME}000.flac"
GS_PATH="gs://$BUCKET/$BUCKET_PATH"

# Upload if not present
if ! gsutil -q stat "$GS_PATH"
then
    gsutil cp "$INPUT" "gs://$BUCKET"
else
    echo INFO: "$GS_PATH" already exists in bucket, skipping Upload.
fi



gcloud ml speech recognize-long-running "$GS_PATH" --language-code=jp

say transcription complete

#Code bin
# For ~1m audios
# gcloud ml speech recognize $DIR/foo000.flac --language-code=ru
# ffmpeg -i "$INPUT" -f segment -segment_time 60 -c:a flac -c copy -acodec flac $DIR/foo%03d.flac
