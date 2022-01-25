# cleanup / integrate boat commands, and add aliases (aliases should be displayed on a argumentless script call)

#LAUNCH

IF_1 goto launch
ECHO ===================================================
ECHO  Usage is: .LAUNCH [destination port]
ECHO ===================================================
EXIT

launch:
put command Fuchye to launch
waitfor calls out, "Cast off!"
put command Fuchye to sail for %1
EXIT
