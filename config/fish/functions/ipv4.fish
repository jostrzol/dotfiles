function ipv4 -d 'show IP v4 address of this machine'
    ip -4 address show wlp1s0 | grep -oP --color=no '(?<=inet\\s)\\d+(\\.\\d+){3}'
end
