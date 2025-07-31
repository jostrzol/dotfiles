function disowned -d 'run a command with no connections to the current shell session'
    nohup $argv </dev/null >/dev/null 2>&1 &
end

