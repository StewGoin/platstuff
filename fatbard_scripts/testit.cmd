debug 10
action var FOURTHLINE $1 when \(1\) refined metal ingot \((\d+) volume\)
pause
put #parse (1) refined metal ingot (9 volume)

put #echo %FOURTHLINE