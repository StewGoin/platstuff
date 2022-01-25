var container bright.pouch

ECHO *******************************
ECHO **
ECHO ** This script assumes that you will have cloth or tanned leather in your right hand
ECHO ** and the tailoring book turned to the correct page before starting
ECHO **
ECHO ** 
ECHO ** When starting the script, type .lw <item>
ECHO ** Optional: to make multiple items, type .lw <item> <container>
ECHO **
ECHO ** For Genie, change Var container to where you keep tools
ECHO ** Script currently does not work in Wizard without MANY modifications
ECHO **
ECHO ********************************


action var yards $1 when material \((\d+) yards\)$
action var yards $1 when cloth \((\d+) yards\)$
action var yards 1 when \(1 yard\)$
action var have $1 when You count out (\d+) yards of material there\.$

Glance:
put I HAND
match HaveCloth cloth
match HaveLeather leather
matchwait

HaveCloth:
var material cloth
goto top
HaveLeather:
var material leather
goto top

top:
put get tailor book
put read my book;count my %material
waitfor A list of
pause 0.5
if %yards = %have then goto GetBook
if %yards > %have then goto NotEnough
put stow book;get yard in my %container
put mark my %material at %yards yards
match CutLeather You count out
match NotEnough There is not enough
matchwait

CutLeather:
put put yard in my %container;get scissor in my %container;cut my %material with my scissor
waitfor You carefully cut
put put scissor in my %container;stow %material
waitfor You put
put get %material
waitfor You pick up

GetBook:
put get my tailor book;study my book
waitfor Roundtime
pause 0.5
pause 0.5
put stow my book
waitfor You put
put get my scissor in my %container

FirstCut:
put cut my %material with my scissor
goto Matches

Matches:
match %s ...wait
match Get.Awl needs holes punched
match Get.Yard dimensions appear to have shifted and could benefit from some remeasuring.
match Get.Pins could use some pins to
match Get.Scissor With the measuring complete, now it is time to cut away more
match Get.Needle Roundtime
match Get.Stamp You cannot figure out how to do that
match Get.Needle That tool does not seem suitable
match LargePad You need another finished large cloth padding
match Smallpad You need another finished small cloth padding
match Handle You need another finished leather shield handle
match LongCord You need another finished long leather cord
match MoreThread The needles need to have thread
match Get.Slick A deep crease develops
match Get.Slick wrinkles from all the handling and could use 
match Get.Needle New seams must now be sewn
matchwait

MoreThread:
put put my needle in my %container;get thread
waitfor You get
put put my thread on needle in my %container
waitfor You carefully thread
put get needle in my %container
goto Sew

Sew:
save Sew
put push my %1 with my sew needle
goto Matches

Poke:
save Poke
put poke my %1 with my %tool
goto Matches

Measure:
save Measure
put measure my %1 with my yardstick
goto Matches

Cut:
save Cut
put cut my %1 with my scissor
goto Matches

Rub:
save Rub
put rub my %1 with my slickstone
goto Matches

Mark:
put mark my %1 with my stamp
waitfor Roundtime
pause 1
put stow stamp
done:
if_2 goto Continue
exit

Get.Needle:
if %tool = Yard then goto Get.Scissor
if %tool = Needle then goto Sew
var tool Needle
pause 1
put put $lefthand in my %container;get sew needle in my %container
match Get.Needle ...wait
match Sew You get
matchwait

Get.Awl:
var tool Awl
pause 1
put put $lefthand in my %container;get awl in my %container
match Get.Awl ...wait
match Poke You get
matchwait

Get.Pins:
var tool Pins
pause 1
put put $lefthand in my %container;get pins in my %container
match Get.Pins ...wait
match Poke You get
matchwait

Get.Scissor:
var tool Scissor
pause 1
put put $lefthand in my %container;get scissor in my %container
match Get.Scissor ...wait
match Cut You get
matchwait

Get.Slick:
var tool Slick
pause 1
put put $lefthand in my %container;get slick in my %container
match Get.Slick ...wait
match Rub You get
matchwait

Get.Yard:
var tool Yard
pause 1
put put $lefthand in my %container;get yard in my %container
match Get.Yard ...wait
match Measure You get
matchwait

Get.Stamp:
var tool Stamp
pause 1
put put $lefthand in my %container
ECHO *********************************************************
ECHO ** If you want to mark, delete the next line, "GOTO DONE"
ECHO *********************************************************
goto done
put get my stamp 
match Get.Stamp ...wait
match Mark You get
matchwait




LargePad:
var assemble Large Pad
goto Assemble
SmallPad:
var assemble Small Pad
goto Assemble
Handle:
var assemble shield handle
goto Assemble
LongCord:
var assemble long cord
goto Assemble


Assemble:
var tool Assemble
put put $lefthand in my %container;get %assemble in %container
waitfor You get
put assemble my %assemble with my %1
goto Get.Needle

Continue:
put put my %1 in my %2
Exp:
put exp outfit
match Locked mind lock
match Locked nearly locked 
match Locked enthralled
match Locked rapt
match GetMaterial Overall
matchwait

GetMaterial:
put get my %material
waitfor You get
goto Glance