#!/bin/bash
# Run he docker container. 

docker run --rm -d -it -p 8080:80 -p 5005:5005 -p 5055:5055 --name \
"VEETEE" ashelle5/veetee:1.0
