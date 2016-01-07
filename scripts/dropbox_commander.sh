#!/bin/bash -   
#title          :dropbox_commander.sh
#description    :Get commands from dropbox and execute it
#author         :ronny  
#date           :20150512
#version        :1      
#usage          :./dropbox_commander.sh
#notes          :       
#bash_version   :4.3.11(1)-release
#============================================================================
CMD_HOME=~/Dropbox/commands
CMD_LIST=~/scripts/dropbox_commands
CMD_FILE_EXTESION=txt
function process_commands()
{
    local f=$1
    echo "Processing "$f;
    parse_command $f
    echo "raw command: "$CMD
    if [ -n "$CMD" ]; then
       execute_command "$CMD"
    fi
}
function parse_command()
{
    local FILENAME=$1
    CMD=$(head -1 $FILENAME)
}
function execute_command()
{
    local RAW_CMD=$1
    local E_ARGS=$(echo $RAW_CMD | awk '{for (i=2; i<=NF; i++) printf("%s ",$i); print "";}')
    local EXEC_CMD=$(echo $RAW_CMD | awk '{ print $1 }')
    local SCRIPT_FILE=$(grep "$EXEC_CMD," $CMD_LIST | awk -F"," '{print $2}')
    if [ -n "$SCRIPT_FILE"  ]; then
        echo "executing $SCRIPT_FILE $E_ARGS"
        sh $SCRIPT_FILE $E_ARGS 
    fi
} 

echo "Starting dropbox commander interface ... "
echo "deleting all command files into "$CMD_HOME
rm -f $CMD_HOME/*.$CMD_FILE_EXTESION

while true; do

FILE_IN=$(inotifywait -e moved_to --format %w%f $CMD_HOME)
process_commands $FILE_IN

done


