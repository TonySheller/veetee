#!/bin/sh
# redirect stdout/stderr to a file
exec >/tmp/logfile.txt 2>&1

echo "Starting actions Server"
(cd /home/veetee/rasa; rasa run actions &)
sleep 1
echo "Starting Virtual Assistant"
(cd /home/veetee/rasa; rasa run -m models --enable-api --cors "*" &)

sleep 10