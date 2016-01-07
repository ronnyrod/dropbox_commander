# dropbox_commander 
A Script to execute scripts remotely based on Dropbox for Linux
> **Pre-requisites:**

> - install ***inotifywait*** tool.

> Before execute *dropbox_commander*, open script and modify this variables (acording to your local configurations):

> - **CMD_HOME** - Root path to commands you will send to dropbox_commander to execute it - ***This path must be include inside Dropbox directory***.
> - **CMD_LIST** - File path to allowed command list (comma value separated)
> - **CMD_FILE_EXTESION** - File extension of files contained in $CMD_HOME (rest of files will be ignored)

## List of command to be executed, row file format 

*dropbox_commader* will parse command you send using a CSV file pointed by $CMD_LIST, each row file will follow this format:

***COMMAND_NAME,PATH_TO_SCRIPT***

## Testing dropbox_commander

Supposing your *dropbox_commander* variables are defined as follow:

**CMD_HOME**=~/Dropbox/commands

**CMD_LIST**=~/scripts/dropbox_commands

**CMD_FILE_EXTESION**=txt


and the file pointed by **$CMD_LIST** contains following line:

**help**,**~/scripts/help_dropbox_commader.sh**

Now in shell terminal execute *dropbox_commander* script:
```
./dropbox_commander.sh
```
You should obtain an output like this:
```
Starting dropbox commander interface ...
deleting all command files into ~/Dropbox/commands
Setting up watches.
Watches established.
```
In other shell terminal execute:
```
cd ~/Dropbox/commands
```
```
echo "help" > cmd.txt
```
And verify that at first shell terminal *dropbox_commader* has validated and executed your custom script "**~/scripts/help_dropbox_commader.sh**"
