#!/bin/bash
cd ./ansible && sed -e $'s/,/\\n/g' hosts > hosts1 && mv hosts1 hosts