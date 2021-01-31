#!/usr/bin/env bash
perlcritic --quiet -p .perlcriticrc $* && echo "All source OK"
