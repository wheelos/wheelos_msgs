#!/bin/bash

for directory in wheelos_msgs/*; do
    if [ -d "$directory" ] && compgen -G "$directory/*.proto" > /dev/null; then
        python3 scripts/tools/proto_build_generator.py "$directory/BUILD"
    fi
done
