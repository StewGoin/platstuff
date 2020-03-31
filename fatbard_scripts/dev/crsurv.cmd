put .afk on
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
var swimnum 7
var PERCING ON
var HOMESTART OFF
var jugcon $jugcon
var jugglie $jugglie
var survcon $survcon
var storage $survcon
var bait bait
var baitcon $baitcon
var loc crossing
var hum $hum
var origami $origami
var originstloc $originstloc
var cambrinth $cambrinth
var cambcon $cambcon
var compcon cloak
var comp1 $comp1
var comp2 $comp2
var polecon $polecon
var faldside south
timer clear
timer start

## Setup portion
if "$lefthand" != "Empty" then put stow left
if "$righthand" != "Empty" then put stow right
put remove $headarmor;stow
put remove $handarmor;stow
pause 0.5
put stop hum
put stop sing
put awaken
put mana song 5
pause 0.5
goto locationstart

## includes
include skillcheck.inc.cmd
include origami.cmd
include fishing.cmd
include comp.cmd
# include jug.cmd
include cam.cmd
include climb.inc.cmd
include faldswim.cmd

movedir:
	if "%PERCING" = "ON" then gosub percit
	move $1 $2 $3 $4 $5
	return

percit:
	if $Power_Perceive.LearningRate > 8 then return
	put perc
	pause
#	put exp
#	waitfor EXP HELP
	return

return:
	return

##### Location check

locationstart:
	#put sing harm
	IF_1 goto homestart
	if "$roomname" = "Fisherman's Corner, Wilde Lane" then goto fishing
	if "$roomname" = "Mill Pond" then goto preswim
	if "$roomname" = "The Marsh, Stone Road" then goto tofishing
	if "$roomname" = "Faldesu River, South Bank" then goto faldswim
	if "$roomname" = "North Turnpike, Forest" then goto ngatetoswim
	if "$roomname" = "The Crossing, Hodierna Way" then goto climbstart
	if "$roomname" = "The Raven's Court, Foyer" then goto stealing
	if "$roomname" = "The Raven's Court, Dining Room" then goto precourt
	if "$roomname" = "The Raven's Court, Cigar Lounge" then goto stationaryloc
	if "$roomname" = "Bards' Guild, Performance Hall" then goto perf2gate
	if "$roomname" = "Bards' Guild, Prop Room" then goto stationaryloc
put look
	matchwait

homestart:
	var HOMESTART YES
	goto stationaryloc
	
precourt:
	move s
	goto courtstart

##### Swimming related
bard2gate:
gosub origami.start
gosub movedir go door
gosub movedir e
perf2gate:
gosub movedir e
gosub movedir out
gosub movedir e
gosub movedir n
gosub movedir e
gosub movedir e
gosub movedir n
gosub movedir n
gosub movedir w
gosub movedir go arch
goto ngatetoswim

rav2gate:
pause
action remove ^\.\.\.wait|^Sorry, you may only type
if ($Mechanical_Lore.LearningRate < $origexp) then gosub origami.start
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
put sing harm
move go door
pause
put #var powerwalk on
put #goto 173
waitfor YOU HAVE ARRIVED

ngatetoswim:
put #goto 98
waitfor YOU HAVE ARRIVED

put #goto 121
waitfor YOU HAVE ARRIVED

put #goto 7
waitfor YOU HAVE ARRIVED
pause 2
#put #goto 131
#waitfor YOU HAVE ARRIVED
pause 2
put stop sing
put dive river
#goto preswim
faldswim:
gosub startsouth
swimdone:
pause
move climb bridge
move se
put stop sing
goto tofishing

bardtofish:
gosub movedir e
gosub movedir out
goto bardtofish2

##### Foraging / Animal Lore = Fishing!
tofishing:
pause
action remove ^\.\.\.wait|^Sorry, you may only type
if ($Mechanical_Lore.LearningRate < $origexp) then gosub origami.start
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
put sing harm
put #var powerwalk on
put #goto 54
waitfor YOU HAVE ARRIVED

put #goto 45
waitfor YOU HAVE ARRIVED

put #goto 81
waitfor YOU HAVE ARRIVED
pause 2
move sw
pause
echo switching maps
put #goto 24
waitfor YOU HAVE ARRIVED

move e
pause 2

# bypass fishing
put #goto 42
waitfor YOU HAVE ARRIVED
goto climbstart
# fishing
put #goto 58
waitfor YOU HAVE ARRIVED
pause 2
gosub movedir go pier
gosub movedir se
gosub movedir s
gosub movedir s
gosub movedir s
gosub movedir s
gosub movedir s
gosub movedir sw
gosub movedir s
gosub movedir w
fishing:
pause
action remove ^\.\.\.wait|^Sorry, you may only type
if ($Mechanical_Lore.LearningRate < $origexp) then gosub origami.start
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
put pyroff
pause 3
action remove ^\.\.\.wait|^Sorry, you may only type
put .fishing %bait crossing
waitfor Script Finished
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
pause
put pyron
pause 3
goto toclimb

##### Climbing!
toclimb:
action remove ^\.\.\.wait|^Sorry, you may only type
if ($Mechanical_Lore.LearningRate < $origexp) then gosub origami.start
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
put sing harm
gosub movedir e
gosub movedir n
gosub movedir ne
gosub movedir n
gosub movedir n
gosub movedir n
gosub movedir n
gosub movedir n
gosub movedir nw
gosub movedir go gate
gosub movedir e
gosub movedir e
gosub movedir e
gosub movedir e
gosub movedir ne
gosub movedir go bridge
gosub movedir ne
goto climbstart

climbstart:
put .climbcross
waitfor Script Done
goto fromclimb

EMPTYHANDS:
echo
echo *** EMPTY YOUR HANDS ***
echo
exit

fromclimb:
	put sing harm
put #goto 509
goto stationaryloc

stationaryloc:
put stop hum
put sing harm
pause 0.5
action remove ^\.\.\.wait|^Sorry, you may only type
put .reckus
waitfor Script Done
if ($Mechanical_Lore.LearningRate < $origexp) then gosub origami.start
gosub comp.start
gosub cam.start
# gosub jug.start
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
put stop sing
if ("%HOMESTART" = "YES") then
{
	var HOMESTART NO
	goto locationstart
}
put #goto 585
waitfor YOU HAVE ARRIVED
action remove ^\.\.\.wait|^Sorry, you may only type
if %t > 6000 then goto stealing
else goto courtstart
stealing:
	put stop sing
	put .stealcross
	waitfor Script Done
	timer clear
	timer start
	pause
courtstart:
put sing harm
put .court
waitfor Script Done
action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
goto rav2gate