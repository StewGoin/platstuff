# Clean this up and keep for playing.

# fishing inclusion
# depends on %bait set in the wrapper
# in the event of running out of bait it will goto morebait in the wrapper
# call with a goto fish.start
# end by going to donefish
# depends on skillcheck include
var bait %1
var loc %2
var polecon $polecon
var baitbox $baitbox
var baitcon $baitcon
var fishcalled no
timer clear
timer start


fish.start:
	var recall.num 0
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	#Handle a strike.
	action goto fish.fastpull when tug on your fishing pole\.|You yank on your fishing pole|There's something on the hook|Your fishing pole tugs rapidly|Your fishing pole tugs downward several times
	#Handle a nibble.
	action put yank my pole when ^You feel a very slight, irregular tremor on your fishing pole\.|^Your fishing pole tugs downward a little|Your fishing pole wiggles slightly|You feel a hard tug on your fishing pole
	action put #send untangle my pole;#send 2 pull my pole when You'll need to untangle the fishing line first|your line gets all tangled up
	
	put stop hum
	put .enc harm 15
	put nod
	if ("$charactername" = "Ryken") then put perc
	pause 2
	put get my fishing pole
	pause
	put open my pole
	pause
goto fish.bait

fish.bait:
	pause 1
	match fish.bait_%loc What were you referring to?
	matchre fish.baitcheck Roundtime|You already have bait on your hook.
	match fish.done You need to put a hook on your fishing pole first
if "%bait" = "bait" then put get %bait
else put get %bait from my %baitbox
	matchwait

fish.baitcheck:
	pause 1
	match fish.cast The pole is baited
	match fish.bait The pole isn't baited.
put look my pole
	matchwait

fish.cast:
	if ((%t > 600) && ("%loc" != "boat")) then goto fish.done
  pause 1
  matchre fish.cast /...wait|Sorry, you/
  matchre fish.prepull /cast your|line overboard,|drop your/
  match fish.prepull You must pull your line in first!
put cast my pole
  matchwait

fish.prepull:
#if ($Scholarship.LearningRate < 11) then
#	{
#		if (%recall.num >= 4) then var recall.num 0
#		else math %recall.num add 1
#		gosub recall.%recall.num
#	}
#else pause 10
pause 5
 fish.pull:
	pause 5
	matchre fish.pull ^You .* of the.*line\.|^\.\.\.wait|^Sorry,
	matchre fish.cast ^The line is already pulled in all the way\.|^That's all of it
	matchre fish.empty ^You've pulled in .*\.  Quickly you grab it and work it free from the hook\.
  put pull my pole
  matchwait

fish.fastpull:
	gosub clear
	matchre fish.fastpull ^You .* of the.*line\.|^\.\.\.wait|^Sorry,
	matchre fish.cast ^The line is already pulled in all the way\.|^That's all of it
	matchre fish.empty ^You've pulled in .*\.  Quickly you grab it and work it free from the hook\.
put pull my pole
	matchwait

fish.empty:
	pause
#	put appraise my $lefthandnoun
#	waitfor Roundtime
#	pause
	if ("$lefthandnoun" = "seaweed") then put empty left
	else put throw my $lefthandnoun
goto fish.check

fish.check:
#	put exp
#	waitfor EXP HELP
	if ($Foraging.LearningRate > 8) then goto fish.done
	else goto fish.bait

fish.done:
	pause
	if ("$lefthandnoun" = "seaweed") then put empty left
	else put throw my $lefthandnoun
	pause
	put close my pole
	pause
	put put my pole in my %polecon
	put #script abort enc
	pause
	if ("%fishcalled" != "no") then return
	put echo Script Finished
	exit

fish.bait_boat:
		match fish.bait_boatmore You get
		match fish.bait_boatout
	put get my %baitbox from my %baitcon
		matchwait

fish.bait_boatmore:
	put drop my %baitbox
	goto fish.bait

fish.bait_boatout:
	echo Out of Bait...
	goto fish.done


fish.bait_hib:
		match fish.bait_hibmore You get
		match fish.bait_hibout
	put get my %baitbox from my %baitcon
		matchwait

fish.bait_hibmore:
	put drop my %baitbox
	goto fish.bait

fish.bait_hibout:
	echo Out of Bait... none in Hib.
	goto fish.done

fish.bait_ratha:
	put close my pole
	put put my pole in my %polecon
	move n
	move n
	move n
	move e
	move ne
	move e
	move se
	move e
	move n
	move n
	move n
	move ne
	move climb stair
	move go door
	put get %baitbox from my %baitcon
	put put my white box in basket
	move go cash
	put withdraw 1 silver
	waitfor The clerk counts out
	move go atrium
	move go door
	move climb stair
	move sw
	move s
	move s
	move s
	move w
	move nw
	move w
	move go shop
	put order live minnows
	waitfor Drorg grins
	put offer 100
	waitfor Drorg scratches
	put offer 100
	waitfor Drorg opens
	put put my white box in my %baitcon
	move out
	move sw
	move w
	move go dock
	move s
	move s
goto fish.start

recall.0:
	random 1 39
	gosub immortal-%r
	pause
	return

recall.1:
	random 1 42
	gosub famous-%r
	pause
	return
	
recall.2:
	random 1 21
	gosub holiday-%r
	pause
	return
	
recall.3:
	random 1 19
	gosub herb-%r
	pause
	return

## Famous recalls
famous-1:
put recall famous Sirolarn
return
famous-2:
put recall famous Lanival
return
famous-3:
put recall famous Nissa
return
famous-4:
put recall famous Teiro
return
famous-5:
put recall famous Trimbolt
return
famous-6:
put recall famous Grell
return
famous-7:
put recall famous Mibgluc
return
famous-8:
put recall famous Glacis
return
famous-9:
put recall famous Twando
return
famous-10:
put recall famous Dunshade
return
famous-11:
put recall famous Tatia
return
famous-12:
put recall famous Ralel
return
famous-13:
put recall famous Lasarhhtha
return
famous-14:
put recall famous Sidhlot
return
famous-15:
put recall famous Arhat
return
famous-16:
put recall famous Grishnok
return
famous-17:
put recall famous Yabul
return
famous-18:
put recall famous Arinni
return
famous-19:
put recall famous Vorclaf
return
famous-20:
put recall famous World Dragon
return
famous-21:
put recall famous Tezirah
return
famous-22:
put recall famous Jeladric Theren
return
famous-23:
put recall famous Wren
return
famous-24:
put recall famous Siryn
return
famous-25:
put recall famous Corik
return
famous-26:
put recall famous Ocular
return
famous-27:
put recall famous Amfitro
return
famous-28:
put recall famous Andraethu
return
famous-29:
put recall famous Tenebraus
return
famous-30:
put recall famous Emuin
return
famous-31:
put recall famous Sadiaer
return
famous-32:
put recall famous Sorrow
return
famous-33:
put recall famous Daralaendra
return
famous-34:
put recall famous Braushocra
return
famous-35:
put recall famous Wooly
return
famous-36:
put recall famous Octa
return
famous-37:
put recall famous Darkensi
return
famous-38:
put recall famous Kukalakai
return
famous-39:
put recall famous Prayk
return
famous-40:
put recall famous Morganae
return
famous-41:
put recall famous Bembo
return
famous-42:
put recall famous Ragge
return

## Holiday recalls
holiday-1:
put recall holiday Eluned
return
holiday-2:
put recall holiday Hodierna
return
holiday-3:
put recall holiday Tamsine
return
holiday-4:
put recall holiday Faenella
return
holiday-5:
put recall holiday Kertigen
return
holiday-6:
put recall holiday Divyaush
return
holiday-7:
put recall holiday Everild
return
holiday-8:
put recall holiday Truffenyi
return
holiday-9:
put recall holiday Hav'roth
return
holiday-10:
put recall holiday Glythtide
return
holiday-11:
put recall holiday Chadatru
return
holiday-12:
put recall holiday Blufandu
return
holiday-13:
put recall holiday Shosandu
return
holiday-14:
put recall holiday Lormandu
return
holiday-15:
put recall holiday Anlandu
return
holiday-16:
put recall holiday Jeolandu
return
holiday-17:
put recall holiday Surmirae Anladorlo
return
holiday-18:
put recall holiday Aurilae's Sacrifice
return
holiday-19:
put recall holiday Aesthene's Close
return
holiday-20:
put recall holiday Day of Mourning
return
holiday-21:
put recall holiday Sicle Grove
return

## Immortal recalls

immortal-1:
put recall immortal Kertigen
return
immortal-2:
put recall immortal Divyaush
return
immortal-3:
put recall immortal Zachriedek
return
immortal-4:
put recall immortal Hodierna
return
immortal-5:
put recall immortal Berengaria
return
immortal-6:
put recall immortal Asketi
return
immortal-7:
put recall immortal Meraud
return
immortal-8:
put recall immortal Firulf
return
immortal-9:
put recall immortal Kerenhappuch
return
immortal-10:
put recall immortal Damaris
return
immortal-11:
put recall immortal Phelim
return
immortal-12:
put recall immortal Dergati
return
immortal-13:
put recall immortal Everild
return
immortal-14:
put recall immortal Kuniyo
return
immortal-15:
put recall immortal Trothfang
return
immortal-16:
put recall immortal Truffenyi
return
immortal-17:
put recall immortal Alamhif
return
immortal-18:
put recall immortal Huldah
return
immortal-19:
put recall immortal Hav'roth
return
immortal-20:
put recall immortal Peri'el
return
immortal-21:
put recall immortal Ushnish
return
immortal-22:
put recall immortal Eluned
return
immortal-23:
put recall immortal Lemicus
return
immortal-24:
put recall immortal Drogor
return
immortal-25:
put recall immortal Glythtide
return
immortal-26:
put recall immortal Saemaus
return
immortal-27:
put recall immortal Be'ort
return
immortal-28:
put recall immortal Tamsine
return
immortal-29:
put recall immortal Albreda
return
immortal-30:
put recall immortal Harawep
return
immortal-31:
put recall immortal Faenella
return
immortal-32:
put recall immortal Murrula
return
immortal-33:
put recall immortal Idon
return
immortal-34:
put recall immortal Chadatru
return
immortal-35:
put recall immortal Rutilor
return
immortal-36:
put recall immortal Botolf
return
immortal-37:
put recall immortal Urrem'tier
return
immortal-38:
put recall immortal Eylhaar
return
immortal-39:
put recall immortal Aldauth
return

## Herb recalls
herb-1:
put recall herb blocil berries
return
herb-2:
put recall herb eghmok moss
return
herb-3:
put recall herb genich stem
return
herb-4:
put recall herb georin grass
return
herb-5:
put recall herb hulnik grass
return
herb-6:
put recall herb hisan salve
return
herb-7:
put recall herb jadice flower
return
herb-8:
put recall herb jadice pollen
return
herb-9:
put recall herb muljin sap
return
herb-10:
put recall herb nemoih root
return
herb-11:
put recall herb nilos grass
return
herb-12:
put recall herb nuloe stem
return
herb-13:
put recall herb plovik leaf
return
herb-14:
put recall herb qun pollen
return
herb-15:
put recall herb riolur leaf
return
herb-16:
put recall herb sufil sap
return
herb-17:
put recall herb yelith root
return
herb-18:
put recall herb cebi root
return
herb-19:
put recall herb junliar stem
return
