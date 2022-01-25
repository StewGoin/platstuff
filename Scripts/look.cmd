# Update? integrate as a part of automoving w/ global trigger to act on roomobjects?

IF_1 goto BEGIN
goto DOH

BEGIN:
put get ticket
pause
put stow gem
put look on %1
put look under %1
pause
put look in %1
put look behind %1
put study %1
pause
put look %1
put examine %1
put search %1
goto END

DOH:
echo Hey, moron...

END:
exit
