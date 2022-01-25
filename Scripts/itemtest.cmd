# check for new verbs (kick it to CB for thoughts)

#debug 8
var verblist clean|clench|close|drink|eat|exhale|flirt|gaze|glance|grin|growl|hug|invoke|juggle|kick|kiss|lick|motion|nibble|nudge|open|pat|peer|pet|pinch|poke|prod|pull|punch|push|read|roll|rub|shake|slap|smooch|snuggle|squint|tap|throw|tickle|tilt|touch|tune|turn|wash|wave|yank 
setvar verbcount 46
setvar index 0 
LOOP: 
     if (%index > %verbcount) then goto EXIT 
     PUT %verblist(%index) %1 
     evalmath index %index + 1 
     PAUSE 0.5
     GOTO LOOP 
EXIT: 
     exit
