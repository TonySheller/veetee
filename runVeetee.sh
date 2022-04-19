#!/bin/bash

docker run --rm --gpus all -it -p 8888:8888 -p 6006:6006 -v /mnt/e/en705603/veetee:/home/veetee/work ashelle5/veetee:0.1
