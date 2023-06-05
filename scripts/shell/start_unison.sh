#!/bin/bash

stop_unison.sh
rm -f ~/.unison/*.log

# Run sync of disks
nohup unison a &

# Run sync of select folders
nohup unison ph_abudhabi &
nohup unison ph_crimsoncat &
nohup unison ph_spbvacay &
nohup unison ph_autoportraits &

sleep 5

# Watch logs
tail -f ~/.unison/*.log
