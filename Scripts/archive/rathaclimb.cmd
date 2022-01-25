# Clean, rename, etc...

#Climb Ratha

#;This script was created by the player of Kraelyst the Hand in November 2007
#;It teaches well to 150 to 200 ranks.
#;Theoretically anyone of any skill should be able to use it.

### set humstyle
	var hum $hum

### retreat from anything
action send $lastcommand when ^\.\.\.wait|^Sorry, you may only type
action put #send retreat;#send retreat when ^\*.*at you\..*You|closes to melee range on you
action send retreat when closes to pole weapon range on you
action put #queue clear when You retreat from combat\.|You try to back away

put stance eva

ECHO
ECHO *** Start inside the 1st tier bank
	ECHO *** Script always ends at the 1st Tier Bank
ECHO
if "$charactername" = "Ryken" then put stop sing
put awake
goto locationmatch
include climb.inc.cmd

locationmatch:
match leaveporticoa [Lower Bank of Ratha, Portico]
match goatrium [Lower Bank of Ratha, Currency Exchange]
match goatrium [Lower Bank of Ratha, Auction Bourse]
match goatrium [Lower Bank of Ratha, Cashier]
match StartScript [Lower Bank of Ratha, Atrium]
match tobank [Kygar's Pub, Courtyard]
put look
matchwait

tobank:
move s
move go door
move ne
move e
move e
move ne
move e
move ne
move e
move e
move e
move ne
move e
move se
move e
move e
move e
move e
move e
move e
move s
move se
move se
move ne
move se
move e
move e
move ne
move e
move ne
move n
goto CLIMB01

leaveporticoa:
move go door
goto StartScript

goatrium:
move go atrium
goto StartScript

StartScript:
move go massive door
move climb broad stairs
move sw
move s
move s
move s
move e
move e
move e
move e
move e
move s
move se
move se
move ne
move se
move e
move e
move ne
move e
move ne
move n
goto CLIMB01

CLIMB01:
save CLIMB01
gosub Climb.Inc basalt.slabs
goto FAIL01

CLIMB02:
SAVE CLIMB02
match PASS02 [Shore Walk, Beach]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb basalt slabs
matchwait

FAIL01:
PASS02:
move s
move sw
move w
move sw
move w
move w
move nw
move sw
move nw
move nw
move n
move w
move w
move w
move w
move w
move n
move n
move n
move nw
move nw
move n
move nw
move sw
move w
move go broken grating
move go passage
goto 001

001:
save 001
match 002 the slip of a loose brick
match retreat engaged
match UNGUARD Although tempted to move,
put nw 
matchwait

002:
save 002
match 003 touch of a drop of water
match retreat engaged
put sw
matchwait

003:
save 003
match 004 touch of a feathery
match retreat engaged
put w
matchwait

004:
save 004
match 005 the feel of soft, yielding mud
match retreat engaged
put up
matchwait

005:
save 005
match 006 [The Sewers, Beneath the Drain]
match retreat engaged
put go obscure opening
matchwait

006:
pause
move go gilded drain
move ne
move e
move se
move se
move s
move s
move sw
move s
move s
move w
move nw
move w
move nw
move w
move w
move w
move sw
move w
move climb retaining wall
goto CLIMB03

CLIMB03:
save CLIMB03
gosub Climb.Inc face.cliff
goto FAIL03

CLIMB04:
SAVE CLIMB04
match CLIMB05 [Ratha, Base of the Cliff]
match FALLEN slip after a few feet
match FALLEN You must be standing
match CLIMB06 steepness is intimidating
match CLIMB06 can't seem to find purchase
match CLIMB06 find it hard going.
match CLIMB06 your footing is questionable
match CLIMB06 A wave of dizziness hits you
match CLIMB06 Struck by vertigo
match CLIMB06 go back the way you came.
match retreat engaged
put climb narrow ledge
matchwait

CLIMB05:
SAVE CLIMB05
match CLIMB06 [Odalva Reach, Narrow Ledge]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb sheer cliff
matchwait

CLIMB06:
SAVE CLIMB06
match CLIMB07 [Odalva Reach, Edge of Cliff]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb face cliff
matchwait

FAIL03:
CLIMB07:
SAVE CLIMB07
match PASS07 [Ratha, Odalva Reach]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb retaining wall
matchwait

PASS07:
move nw
move w
move climb driftwood fence
move climb driftwood fence
move go trail
move n
move climb driftwood fence
move w
goto CLIMB08

CLIMB08:
SAVE CLIMB08
gosub Climb.Inc sandy.embankment
goto FAIL08

CLIMB09:
SAVE CLIMB09
match PASS09 [Meadow Park, Shallow Pond]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb sandy embankment
matchwait

FAIL08:
PASS09:
move e
move climb driftwood fence
goto CLIMB10

CLIMB10:
SAVE CLIMB10
gosub Climb.Inc Sana'ati.tree
goto FAIL10

CLIMB11:
SAVE CLIMB11
match CLIMB12 [Sana'ati Tree, Upper Limb]
match FALLEN slip after a few feet
match FALLEN You must be standing
match FAIL11 steepness is intimidating
match FAIL11 can't seem to find purchase
match FAIL11 find it hard going.
match FAIL11 your footing is questionable
match FAIL11 A wave of dizziness hits you
match FAIL11 Struck by vertigo
match FAIL11 go back the way you came.
match retreat engaged
put climb large limb
matchwait

CLIMB12:
SAVE CLIMB12
match CLIMB13 [Sana'ati Tree, Bird's Nest Lookout]
match FALLEN slip after a few feet
match FALLEN You must be standing
match FAIL12 steepness is intimidating
match FAIL12 can't seem to find purchase
match FAIL12 find it hard going.
match FAIL12 your footing is questionable
match FAIL12 A wave of dizziness hits you
match FAIL12 Struck by vertigo
match FAIL12 go back the way you came.
match retreat engaged
put climb frayed rope
matchwait

CLIMB13:
SAVE CLIMB13
match CLIMB14 [Sana'ati Tree, Upper Limb]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb frayed rope
matchwait

FAIL12:
CLIMB14:

SAVE CLIMB14
match CLIMB15 [Sana'ati Tree, Low Hanging Branch]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb upper limb
matchwait

FAIL11:
CLIMB15:

SAVE CLIMB15
match PASS15 [Odalva Reach, Meadow Park]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb large branch
matchwait

FAIL10:
PASS15:
move s
move s
move e
move se
move e
move ne
move e
move e
move e
move se
move e
move se
move e
move n
move n
move ne
move n
move n
move nw
move nw
move w
move sw
move go gilded drain 
move go obscure opening

033:
save 033
match 034 the reek of mold
match retreat engaged
match UNGUARD Although tempted to move,
put n
matchwait

034:
save 034
match 035 something silent brushing past
match retreat engaged
put up
matchwait

035:
save 035
match 036 the tang of the salt sea
match retreat engaged
put nw
matchwait

036:
save 036
match 037 the smell of fish, fresh
match retreat engaged
put w
matchwait

037:
save 037
match 038 [The Sewers, Beneath the Grating]
match retreat engaged
put go narrow crevice
matchwait

038:
pause
move go sewer grating
move ne
move ne
move n
move w
move nw
move ne
move e
move se
goto CLIMB16

CLIMB16:
SAVE CLIMB16
gosub Climb.Inc drainpipe
goto FAIL16

CLIMB17:
SAVE CLIMB17
match PASS17 [Ratha, Theater District]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match PAUSE go back the way you came.
match retreat engaged
put climb drainpipe
matchwait

FAIL16:
PASS17:
pause
move nw
move w
move sw
move se
move e
move s
move sw
move sw
move go sewer grating
goto CLIMBCHECK01

CLIMBCHECK01:
pause
match FinishEarly bewilder
match FinishEarly dazed
match FinishEarly mind lock
match DontFinishEarly EXP HELP for more information
put skill climbing
matchwait

DontFinishEarly:
move go narrow crevice

301:
save 301
match 302 tang of the salt sea
match retreat engaged
put e
matchwait

302:
save 302
match 303 something silent brushing past
match retreat engaged
put se
matchwait

303:
save 303
match 304 the reek of mold
match retreat engaged
put down
matchwait

304:
save 304
match 305 the slip of a loose brick
match retreat engaged
put w
matchwait

305:
save 305
match 306 the feel of soft, yielding mud
match retreat engaged
put nw 
matchwait

306:
save 306
match 307 the touch of a drop of water
match retreat engaged
put s
matchwait

307:
save 307
match 308 A large circular opening
match retreat engaged
put sw
matchwait

308:
save 308
match 309 pungent, spicy aroma
match retreat engaged
put up
matchwait

309:
save 309
match 310 odd whiff of incense
match retreat engaged
put w
matchwait

310:
save 310
match 311 A light flickers to the southwest
match retreat engaged
put nw
matchwait

311:
save 311
match 312 The tunnel walls have been built
match retreat engaged
put n
matchwait

312:
save 312
match 313 stream of water falls to the floor.
match retreat engaged
put n
matchwait

313:
save 313
match 314 Water flows in from the north
match 314 Water flows into a hole
match retreat engaged
match FAIL-LADDER You must be standing
match FAIL-LADDER steepness is intimidating
match FAIL-LADDER can't seem to find purchase
match FAIL-LADDER find it hard going.
match FAIL-LADDER your footing is questionable
match FAIL-LADDER slip after a few feet
match FAIL-LADDER A wave of dizziness hits you
match FAIL-LADDER Struck by vertigo
match FAIL-LADDER go back the way you came.
put climb ladder
matchwait

314:
save 314
match 315 The walls are narrowly within
match 315 The walls curve into the ceiling
match retreat engaged
put n
matchwait

315:
save 315
match 316 A thin sheet of water flows
match retreat engaged
put n
matchwait

316:
save 316
match 317 Nadamian Avenue]
match retreat engaged
put go polished grate
matchwait

317:
pause
move n
move n
move n
move n
move n
move w
move w
move go gate
move nw
move nw
move n
move n
move ne
move n
goto CLIMB18

CLIMB18:
SAVE CLIMB18
gosub Climb.Inc narrow.path
goto FAIL18

CLIMB19:
SAVE CLIMB19
match PASS19 [Reshalia Trade Road, Farmland]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match retreat engaged
put climb narrow path
matchwait

FAIL18:
PASS19:
move n
move nw
move nw
move ne
move nw
move nw
move ne
move ne

match waitfor317cont You can't go there
match 317cont Just to the southwest
put ne
matchwait

waitfor317cont:
ECHO
ECHO *** There is a stupid farmer or farm animals blocking the trade road.
ECHO *** You must wait for them to pass.
ECHO
MATCH start317cont traffic starts
MATCH start317cont The herd of pigs finally passes
MATCH start317cont The stolid farmer slaps the reins on his team one more time
MATCHWAIT

start317cont:
move ne
317cont: 
move ne
move nw
move ne
move ne
move ne
ECHO
ECHO *** Entering a muddy section of the Reshalia Trade Road
ECHO
pause
goto TOMERROW1

tomerrow1:
save tomerrow1
match tomerrow2 A pedal mill stands
match tomerrow2 Two large Gor'Togs,
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
match stand type ahead
put nw
matchwait

tomerrow2:
save tomerrow2
match tomerrow3 The occasional crunch underfoot
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
put nw
matchwait

tomerrow3:
save tomerrow3
match tomerrow4 farmers have built a wooden
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
put nw
matchwait

tomerrow4:
save tomerrow4
match tomerrow5 pile of decomposing weeds
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
put n
matchwait

tomerrow5:
move nw
pause
move nw

CLIMB20:
SAVE CLIMB20
gosub Climb.Inc oak.tree
goto FAIL20

CLIMB21:
SAVE CLIMB21
match PASS21 [Reshalia Trade Road, Farmland]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match retreat engaged
put climb down
matchwait

FAIL20:
PASS21:
move nw
move n
move n
move nw
move w
move w
move w
move w
move w
move nw
move w
move nw
move nw
move w
move nw
move nw
goto CLIMB22

CLIMB22:
SAVE CLIMB22
gosub Climb.Inc deep.crack
goto FAIL22

CLIMB23:
SAVE CLIMB23
match CLIMB24  [Tembat Nai Itan, Ledge]
match FALLEN slip after a few feet
match FALLEN You must be standing
match FAIL23 steepness is intimidating
match FAIL23 can't seem to find purchase
match FAIL23 find it hard going.
match FAIL23 your footing is questionable
match FAIL23 A wave of dizziness hits you
match FAIL23 Struck by vertigo
match retreat engaged
put climb sea vine
matchwait

FAIL23:
pause
goto CLIMB25

CLIMB24:
SAVE CLIMB24
match CLIMB25 [Old Fields Road, A Deep Crack]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match retreat engaged
put climb sea vine
matchwait

CLIMB25:

SAVE CLIMB25
match PASS25  [Old Fields Road, Low Hills]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match retreat engaged
put climb deep crack
matchwait

FAIL22:
PASS25:

put exp survival 
pause
if $Climbing.Ranks > 35 then
	goto KeepGoing
else
	goto TurnBack

KeepGoing:
move w
move w
move nw
move nw
move w
move go thin trail
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb down path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move climb up path
if $stamina < 50 then
{
   pause 10
   echo *** Resting briefly ***
}
move go thin trail
move e
move se
move se
move e
move e
TurnBack:
move se
move se
move e
move se
move se
move e
move se
move e
move e
move e 
move e
move e
move se
move s
move s
move se
move se
move se
move s
ECHO
ECHO *** Entering a muddy section of the Reshalia Trade Road
ECHO
pause
goto fromleucro1

fromleucro1:
save fromleucro1
match fromleucro2 The occasional crunch underfoot
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
match stand type ahead
put se
matchwait

fromleucro2:
save fromleucro2
match fromleucro3 A pedal mill stands astride
match fromleucro3 Two large Gor'Togs,
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
put se
matchwait

fromleucro3:
save fromleucro3
match fromleucro4 The road takes a sharp turn
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
put se
matchwait

fromleucro4:
save fromleucro4
match fromleucro5 It looks like someone discarded
match stand You slip in the mud
match stand You can't do that while
match stand ...wait
put sw
matchwait

fromleucro5:
move sw
pause
move sw
move se
move sw

match waitforfromleucro5cont You can't go there
match fromleucro5cont Just to the northeast
put sw
put look
MATCHWAIT

waitforfromleucro5cont:
ECHO
ECHO *** There is a stupid farmer or farm animals blocking the trade road.
ECHO *** You must wait for them to pass.
ECHO
MATCH startfromleucro5cont traffic starts
MATCH startfromleucro5cont The herd of pigs finally passes
MATCH startfromleucro5cont The stolid farmer slaps the reins on his team one more time
MATCHWAIT

startfromleucro5cont:
move sw
fromleucro5cont: 
move sw
move sw
move se
move se
move sw
move se
move se
move s
move s
move sw
move s
move s
move se
move se
move go gate
move e
move e
move e
move e
move go gate
move n
move ne
move ne
move ne
move e
move e
move e
move ne
move ne
move n
move ne
move ne
move nw
move w
move nw
move n
move ne
move e
move e
move e
move e
move ne
move n
move n
move ne
move n
move ne
move e
move ne
move ne
move n
move ne
move n
move n
move n
move n
move ne
move n
move n
move ne
move ne
move ne
move ne
move e
move e
move ne
move ne
move ne
move e
move ne
move e
move e
move go bridge

CLIMB26:
SAVE CLIMB26
gosub Climb.Inc steep.trail
goto FAIL26

PASS26:
move n
move ne
move ne
move ne
move n
move n
move e
move se

CLIMB27:
SAVE CLIMB27
match CLIMB28 [Reshalia, Boulder]
match FALLEN slip after a few feet
match FALLEN You must be standing
match FAIL27 steepness is intimidating
match FAIL27 can't seem to find purchase
match FAIL27 find it hard going.
match FAIL27 your footing is questionable
match FAIL27 A wave of dizziness hits you
match FAIL27 Struck by vertigo
match retreat engaged
put climb immense boulder
matchwait

CLIMB28:
SAVE CLIMB28
match PASS28 [Reshalia, Coastal Path]
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match retreat engaged
put climb boulder
matchwait

FAIL27:
PASS28:
move nw
move w
move s
move s
move sw
move sw
move sw
move s

CLIMB29:
SAVE CLIMB29
match PASS29 A deep stream rushes through
match FALLEN slip after a few feet
match FALLEN You must be standing
match PAUSE steepness is intimidating
match PAUSE can't seem to find purchase
match PAUSE find it hard going.
match PAUSE your footing is questionable
match PAUSE A wave of dizziness hits you
match PAUSE Struck by vertigo
match retreat engaged
put climb rock gorge
matchwait

FAIL26:
PASS29:
move go bridge
move w
move w
move sw
move w
move sw
move sw
move sw
move w
move w
move sw
move sw
move sw
move sw
move s
move s
move sw
move s
move s
move s
move s
move sw
move s
move sw
move sw
move w
move sw
move s
move sw
move s
move s
move sw
move w
move w
move w
move w
move sw
move s
move se
move e
move se
move sw
move sw
move s
move sw
move sw
move w
move w
move w
move sw
move sw
move sw
move s
move go gate
move w
move w
move s
move s
move s
move s
move s
4th-3rd:
pause
move go grate

500:
save 500
match 501 The walls are narrowly within
match 501 The walls curve into the ceiling
match retreat engaged
put go pipe
matchwait

501:
save 501
match 502 Water flows in from the north
match 502 Water flows into a hole
match retreat engaged
put s
matchwait

502:
save 502
match 503 stream of water falls to the floor.
match retreat engaged
match FAIL-502 steepness is intimidating
match FAIL-502 can't seem to find purchase
match FAIL-502 find it hard going.
match FAIL-502 your footing is questionable
match FAIL-502 slip after a few feet
match FAIL-502 A wave of dizziness hits you
match FAIL-502 Struck by vertigo
put climb rung
matchwait

FAIL-502:
put n
move n
move go grate
ECHO
ECHO *** You failed to climb through the sewers!
ECHO *** Make sure you are fully healed or get help getting down from the 4th tier
ECHO *** You are outside the sewer on the 4th tier
ECHO
EXIT

503:
save 503
match 504 The tunnel walls have been built 
match retreat engaged
put s
matchwait

504:
save 504
match 505 A light flickers to the southwest
match retreat engaged
put s
matchwait

505:
save 505
match 506 the slip of a loose brick
match retreat engaged
put se
matchwait

506:
save 506
match 507 pungent, spicy aroma
match retreat engaged
put e
matchwait

507:
save 507
match 508 A large circular opening
match retreat engaged
put down
matchwait

508:
save 508
match 510 tang of the salt sea
match retreat engaged
put ne
matchwait

510:
save 510
match 511 The dim beams from the southwest
match retreat engaged
put se
matchwait

511:
save 511
match 512 something noiselessly brushing past
match retreat engaged
put ne
matchwait

512:
save 512
match 027 the feel of soft, yielding mud
match retreat engaged
put se
matchwait

027:
save 027
match 028 the touch of a feathery,
match retreat engaged
put down
matchwait

028:
save 028
match 029 pungent, spicy aroma
match retreat engaged
put ne
matchwait

029:
save 029
match 030 the feel of soft, yielding mud
match retreat engaged
put se
matchwait

030:
save 030
match 031 an odd whiff of incense
match retreat engaged
match UNGUARD Although tempted to move,
put e
matchwait

031:
save 031
match 032 [The Sewers, Beneath the Drain]
match retreat engaged
match UNGUARD Although tempted to move,
put go passage
matchwait

032:
move go broken grating
move e
move ne
move se
move s
move se
move se
move ne
move climb stair
move go door
goto CheckLearning




#====================
FAIL-LADDER:
FAIL503:
save FAIL503
match FAIL504 The tunnel walls have been built 
match retreat engaged
match stand You can't do that while
put s
matchwait

FAIL504:
save FAIL504
match FAIL505 A light flickers to the southwest
match retreat engaged
put s
matchwait

FAIL505:
save FAIL505
match FAIL506 the slip of a loose brick
match retreat engaged
put se
matchwait

FAIL506:
save FAIL506
match FAIL507 pungent, spicy aroma
match retreat engaged
put e
matchwait

FAIL507:
save FAIL507
match FAIL508 A large circular opening
match retreat engaged
put down
matchwait

FAIL508:
save FAIL508
match FAIL510 tang of the salt sea
match retreat engaged
put ne
matchwait

FAIL510:
save FAIL510
match FAIL511 The dim beams from the southwest
match retreat engaged
put se
matchwait

FAIL511:
save FAIL511
match FAIL512 something noiselessly brushing past
match retreat engaged
put ne
matchwait

FAIL512:
save FAIL512
match 027 the feel of soft, yielding mud
match retreat engaged
put se
matchwait


FINISHEARLY:
move go narrow crevice

023:
save 023
match 024 tang of the salt sea
match retreat engaged
match UNGUARD Although tempted to move,
put e
matchwait

024:
save 024
match 025 something silent brushing past
match retreat engaged
put se
matchwait

025:
save 025
match 026 the reek of mold
match retreat engaged
put down
matchwait

026:
save 026
match 027 odd whiff of incense
match retreat engaged
put s
matchwait


#========================
CheckLearning:
pause
put skill climbing
match Done bewilder
match Done dazed
match Done mind lock
match StartScript EXP HELP for more information
matchwait

FALLEN:
pause
match STOOD You stand
match STOOD You are already standing
match FALLEN cannot manage to stand.
match FALLEN The weight of all your possessions
match FALLEN ...wait
put StAND
matchwait

UNGUARD:
pause
put guard stop
goto %s

stand:
put stand
pause
goto %s

STOOD:
goto %s

RETREAT:
put mana song 10;song quiet;sing dmrs
match retreat You retreat back to pole range.
match retreat still stunned
match %s You retreat from combat.
match pause ...wait
match pause type ahead
put retreat
matchwait

PAUSE:
pause
goto %s

DONE:
pause
put hide
ECHO
ECHO *** You are at least bewildering in your Climbing Skill.  Break time!
ECHO *** Type 'keep going' to keep running survivals, otherwise press 'esc' to finish ***
ECHO
waitfor keep going
put .rathasurv
exit
