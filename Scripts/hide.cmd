# Genericize to the common zones?

goto start
include includes.cmd

start:
waitfor You sit up
put #script abort all except hide
put stop sing
gosub go_room 173
pause
put hide
