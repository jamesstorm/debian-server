#!/bin/sh
#
docker run --name debian-11 -h debian -e LANG=C.UTF-8 -it debian:11 /bin/bash -l
