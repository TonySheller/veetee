#!/bin/sh
# redirect stdout/stderr to a file
#exec >/tmp/logfile.txt 2>&1

echo "Training Rasa Server"
(cd /home/veetee/rasa; rasa train )