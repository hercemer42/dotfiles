#!/bin/bash
BACKUPTIME=`date +%b-%d-%y` #get the current date
DESTINATIONFOLDER=/usr/b
SOURCEFOLDER=/home/brian #the folder that contains the files that we want to backup
tar -cpzf $DESTINATIONFOLDER/docs_$BACKUPTIME.tar.gz $SOURCEFOLDER/.docs #create the backup
tar -cpzf $DESTINATIONFOLDER/history_$BACKUPTIME.tar.gz $SOURCEFOLDER/.zsh_history
tar -cpzf $DESTINATIONFOLDER/config_$BACKUPTIME.tar.gz $SOURCEFOLDER/.config
