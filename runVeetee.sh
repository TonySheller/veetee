#!/bin/bash

docker run --rm -d -it -p 8080:80 -p 443:443  --name "VEETEE" -v /mnt/e/en705603/veetee:/home/veetee/work ashelle5/veetee:0.2
