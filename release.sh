#!/usr/bin/bash
bundle update
git add --all .
git commit -am "${*:1}"
git push -u origin rails6
rake release
