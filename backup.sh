#!/bin/bash
BACKUPTIME=`date +%b-%d-%y` #get the current date
DESTINATION=/usr/b/$BACKUPTIME.tar.gz #create a backup file using the current date in its name
SOURCEFOLDER=/home/brian/.docs #the folder that contains the files that we want to backup
tar -cpzf $DESTINATION $SOURCEFOLDER #create the backup
