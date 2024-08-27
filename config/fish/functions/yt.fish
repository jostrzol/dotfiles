function yt -d 'downloads yt videos using yt-dlp'
    argparse 'q/quality=' -- $argv
    or return

    if test -z "$_flag_quality"
        set -f _flag_quality 9999
    end

    yt-dlp \
      -f "(bestvideo*+bestaudio/best)[tbr<=$_flag_quality]" \
      -o '~/Downloads/YouTube/%(title)s.%(ext)s' \
      $argv
end

