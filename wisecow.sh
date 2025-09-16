#!/usr/bin/env bash

# Add /usr/games to PATH for cowsay and fortune
export PATH=$PATH:/usr/games

SRVPORT=4499
RSPFILE=response

rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
    read line
    echo $line
}

handleRequest() {
    get_api
    mod=$(fortune)
    cat <<EOF > $RSPFILE
HTTP/1.1 200 OK

<pre>$(cowsay "$mod")</pre>
EOF
}

prerequisites() {
    command -v cowsay >/dev/null 2>&1 &&
    command -v fortune >/dev/null 2>&1 &&
    command -v nc >/dev/null 2>&1 || 
    { 
        echo "Install prerequisites: cowsay, fortune, netcat"
        exit 1
    }
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."
    while true; do
        cat $RSPFILE | nc -l -p $SRVPORT -k | handleRequest
        sleep 0.01
    done
}

main
