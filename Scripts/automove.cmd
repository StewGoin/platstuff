# Looks like gosub go_move -- look to combine or somehow multi-include and then update scripts

﻿##### Automove.Cmd
##### Original Author Tcool13
##### Improved upon by BakedMage
##### Recent Edits by PELIC
##### Changed to allow multiple word keys
##### Added attribution
##### Last Edited: 26 SEPTEMBER, 2012
ABSOLUTE.TOP:
     var destinationID %0
     var waitOnID %destinationID
     put #script abort automapper
INIT:
     if_1 goto startMove
     echo MUST ENTER DESTINATION ID
     echo example for crossing NE gate:
     echo .automove 172
     exit
startMove:
     if "$roomid" = "%destinationID" then goto doneMoving
     action goto restartPause when ^\.\.\.wait|^Sorry\,|YOU HAVE FAILED|MOVE FAILED
     action goto waitToMove when ^You are still stunned|^You don't seem to be able to move to do that|^You can't do that while entangled in a web|^You struggle against the shadowy webs to no avail\.|^You attempt that, but end up getting caught in an invisible box\.|^It's all a blur\!
     action goto restartStand when ^Stand up first\.|^You must be standing to do that\.|^You can't do that while sitting\.|^You can't do that while kneeling\.|^You can't do that while lying down\.|^You must stand first\.
     action goto restartRetreat when ^You can't do that while engaged\!|^You are engaged to .* range\!|^You try to move, but you're engaged\.|^While in combat\?  You'll have better luck if you first retreat\.
     action goto restartBadDirection when ^You can't go there\.|^You can't swim in that direction\.|^What were you referring to\?|^You can't slink in that direction\.
     if "$zoneid" = "107" && "$roomid" = "212" then send go gangplank
     if "$roomid" = "0" then goto unknownRoom
     action goto doneMoving when eval "$roomid" = "%destinationID"
     action goto doneMoving when YOU HAVE ARRIVED
     action goto doneClosed when SHOP CLOSED
     put #mapper goto %destinationID
moving:
     pause 0.3
     if "$roomid" != "%waitOnID" then goto moving
doneMoving:
     action remove YOU HAVE ARRIVED
     action remove eval "$roomid" = "%destinationID"
     put #script abort automapper
alertParent:
     put #parse AUTOMOVE COMPLETE!
alerted.parent:
     exit
doneClosed:
     action remove SHOP CLOSED
     action remove eval "$roomid" = "%destinationID"
     put #script abort automapper
     put #parse SHOP CLOSED!
     exit
unknownRoom:
     gosub stand
     put -retreat;-retreat
     gosub moveRandomDirection
     pause
     goto startMove
restartPause:
restartBadDirection:
     action clear
     put #queue clear
     # may need a counter on bad direction restarts to prevent infinite loops
     put #script abort automapper
     pause
     gosub waitToMove
     goto startMove
restartRetreat:
     action clear
     put #queue clear
     put #script abort automapper
     gosub stand
     put -retreat;-retreat
     pause 0.1
     goto startMove
restartStand:
     action clear
     put #queue clear
     put #script abort automapper
     gosub stand
     goto restartPause
stand:
     if $standing then return
     send stand
     pause 0.1
     goto stand
waitToMove:
     pause 0.1
     pause 0.1
     if $roundtime > 0 then goto waitToMove
     if $webbed then goto waitToMove
     if $stunned then goto waitToMove
     return
moveRandomDirection:
     if $north then
     {
     put north
     return
     }
     if $south then
     {
     put south
     return
     }
     if $east then
     {
     put east
     return
     }
     if $southwest then
     {
     put southwest
     return
     }
     if $west then
     {
     put west
     return
     }
     if $southeast then
     {
     put southeast
     return
     }
     if $northeast then
     {
     put northeast
     return
     }
     if $northwest then
     {
     put northwest
     return
     }
     if $out then
     {
     put out
     return
     }
     if $up then
     {
     put up
     return
     }
     if $down then
     {
     put down
     return
     }
     echo no random direction possible? looking to attempt to reset room exit vars
     #might need a counter here to prevent infinite loops
     put look
     waitforre ^Obvious
     pause
     goto moveRandomDirection
