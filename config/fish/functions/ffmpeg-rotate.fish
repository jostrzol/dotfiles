function ffmpeg-rotate -d "Rotate video clockwise and remove rotation metadata"
  argparse --min-args 1 --max-args 1 -- $argv || return
  set -f file "$argv[1]"

  set -f base (path change-extension "" "$file")
  set -f ext (path extension "$file")
  set -f output "$base-rotated$ext"

  ffmpeg -i "$file" -filter:v transpose=0,transpose=0 \
    -c:v libx264 -preset veryfast -crf 22 \
    -c:a copy \
    -metadata:s:v rotate=0 \
    "$output"
end
