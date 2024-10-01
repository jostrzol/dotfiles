function opdf -d 'open pdf file in evince'
    nohup evince $argv[1] >/dev/null &
    disown
end
