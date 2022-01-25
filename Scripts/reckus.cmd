# Cut out crap, clean, and consider turning into includes
#debug 5
###########################################
###      Genie3 super Reckus            ###
###      Adapted by from Aveda's reckus ###
###      by: Ryken(javastout)           ###
###                                     ###
###                                     ###
###      To operate, just type:         ###
###             .reckus                 ###
###		  To forcibly turn off scrolly  ###
###		  stuff, override normal        ###
###       options, and make it travel   ###
###       friendly just type:           ###
###			.reckus quiet               ###
###                                     ###
###########################################

### If you want to recall set these variables (yes/no)
	var immortal no
	var herb no
	var famous no
	var holiday no

### if you want to work cambrinth set these variables
	var cam no
	# The cambrinth item to use (worn or stowed)
	var cambrinth $cambrinth
	var singlecast yes
	var cyclic no

### If you want to read through one chart at a time set these variables
	var readcomp no
	var componce no
	
### Set instruments here, set to "no" if you don't want it used
	var rts yes
	var assess no
	var quiet off
	var vocals-yes-or-no no
	var percu-instrument $percinst
	var string-instrument $stringinst
	var wind-instrument $windinst

### Set intsrument related things here
	# What you clean instruments with
	var cleaning-thing silk.cloth
	# Where you keep your instruments
	var r-container portal
	# Where you keep your cleaning thing
	var cleancontainer portal


## Script below this line
action send $lastcommand when ^\.\.\.wait|^Sorry, you may only type
action var doneplay yes when You finish (humming|playing)

  put #var cam_leeched 1
  put #var cam_slipped 1
  var diffSTR $diffSTR
  var diffWI $diffWI
  var diffPCN $diffPCN
  var diffVO $diffVO
  if ("%cyclic" = "yes" && $SpellTimer.GlythtidesJoy.active = 0) then
  {
  	put rel cyclic
  	put .cast gj 20 engaged
  	waitfor Spell Cast
  }
  if ($SpellTimer.EilliesCry.duration <= 20) then
  {
  	put .cast ecry 10 40 50
  	waitfor Spell Cast
  }
	put open my %r-container
IF_1 goto %1
goto performance

quietvars:
	var immortal no
	var herb no
	var famous no
	var holiday no
	var assess no
	var rts no
	var quiet on

instruments:

winds:
windtest:
	if !matchre($diffWI, ^\d+$) then put #var diffWI 21
	if "%wind-instrument" = "no" then goto stringtest
	var diffnum $diffWI
	var instrument %wind-instrument
	var mskill WI
	var xskill Performance
	gosub begin
	put #var diffWI %diffWI
	put #var save
	action remove ^\.\.\.wait|^Sorry, you may only type
	pause 3
	if "%cam" = "yes" && $Arcana.LearningRate < 34 then gosub cam.start
	pause
	if "%readcomp" = "yes" && $First_Aid.LearningRate < 34 then gosub comp.start
	action send $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	goto finished

strings:
stringtest:
	#put stop hum
	if !matchre($diffSTR, ^\d+$) then put #var diffSTR 21
	if "%string-instrument" = "no" then goto perctest
	var diffnum $diffSTR
	var instrument %string-instrument
	var mskill STR
	var xskill Performance
	gosub begin
	put #var diffSTR %diffSTR
	put #var save
	action remove ^\.\.\.wait|^Sorry, you may only type
	pause 3
	if "%cam" = "yes" && $Arcana.LearningRate < 34 then gosub cam.start
	pause
	if "%readcomp" = "yes" && $First_Aid.LearningRate < 34 then gosub comp.start
	action send $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	goto finished

performance:
percs:
perctest:
	#put stop hum
	if !matchre($diffPCN, ^\d+$) then put #var diffPCN 21
	if "%percu-instrument" = "no" then goto finished
	var diffnum $diffPCN
	var instrument %percu-instrument
	var mskill PCN
	var xskill Performance
	gosub begin
	put #var diffPCN %diffPCN
	put #var save
	action remove ^\.\.\.wait|^Sorry, you may only type
	pause 3
	if "%cam" = "yes" && $Arcana.LearningRate < 34 then gosub cam.start
	pause
	if "%readcomp" = "yes" && $First_Aid.LearningRate < 34 then gosub comp.start
	action send $lastcommand when ^\.\.\.wait|^Sorry, you may only type
  	goto finished

###

begin:
	gosub ALMANAC_CHECK
	pause
	gosub getinst
	pause
	if "%rts" = "yes" then gosub clean 
	pause
	if "%rts" = "yes" then gosub tune 
	pause
	gosub toolcheck 
	var play-or-hum play
	pause
	gosub initialdiff
	pause
	gosub play
	
	pause
	if "%doneplay" != "yes then put stop play
	if "%mskill" != "VO" then 
	{
		#if "%instrument" = "silver.txistu" then send wear my txistu
		send put my %instrument in my %r-container
		if "%mskill" = "STR" then send remove my pick
		if "%mskill" = "STR" then send put my pick in my %r-container
		if "%mskill" = "STR" then send put my bow in my %r-container		
	}
	var diff%mskill %diffnum	
return

### play related ###
play:
	gosub ALMANAC_CHECK
	gosub getinst
	matchre play /\.\.\.wait|Sorry, you may only type ahead/
	#match fix The damage to your instrument affects your performance.
	match sweet masterful concerto
	matchre harder You effortlessly begin|your skill in your craft
	matchre sweet masterful concerto|off-key ruff|off-key scales|with only the slightest hint of difficulty|You are already|You're already playing
	matchre easier You fumble slightly as you begin|You struggle to begin
	matchre recheck What type of song did you want to play?|PLAY: Instrumental Performances
	matchre harder You begin a|You begin some|You begin to hum
	match stupidtool You will need the proper tool
	match armoroff while wearing armor
	match end You can't play your
	put %play-or-hum %diff;#var currsong %diff
	matchwait

playwait:
	waitforre You finish (playing|humming)
	goto play

recheck:
	var diffnum 18
	gosub 18
	goto play

armoroff:
	echo
	echo *** Please remove your armor.
	echo *** Type encumbrance to proceed.
	echo
	waitfor Encumbrance
	goto play
	
sweet:
	var doneplay no
	if "%xskill" = "Vocals" then gosub playvocals
	else gosub playinstrument
	goto lockcheck

lockcheck:
	action remove eval $%xskill.LearningRate > 32
#	put exp
#	waitfor EXP HELP
	if $%xskill.LearningRate > 32 then
	{
			if "%doneplay" != "yes" then goto earlystop
			else goto endplay
	}
	elseif "%doneplay" != "yes" then goto sweet
	else goto play

earlycheck:
#	put exp
#	waitfor EXP HELP
	return

earlystop:
	pause 0.5
	put stop play
	matchre earlystop \.\.\.wait|Sorry, you may only type ahead
	matchre return ^You stop
	return

endplay:
	return

easier:
	put stop play
	evalmath diffnum %diffnum - 1
	gosub %diffnum
	goto play

harder:
	put stop play
	evalmath diffnum %diffnum + 1
	gosub %diffnum
	goto play

###

#return:
#	return

### finished
finished:
echo *** Finished ***
put #var diffSTR %diffSTR
put #var diffWI %diffWI
put #var diffPCN %diffPCN
put #var diffVO	%diffVO
put #var save
send stop sing
send remove my pick
send put my pick in my %cleancontainer
#send close my %r-container
pause 0.5
put get my $handarmor;get my $handarmor from my portal;wear my $handarmor
#pause
#put get my $headarmor;wear my $headarmor
pause
if $gametime >= $tattootime then
{
	pause 0.1
	if $gametime >= $tattootime then put invoke my tattoo
	pause 0.1
}
#send exp
#waitfor EXP HELP
#put echo Script Done
put #parse Reckus Complete
exit

### Gosubs follow
playvocals:
	action return when eval $%xskill.LearningRate = 34
	if $Mechanical_Lore.LearningRate < 34 then gosub origami.start
	else pause 10
	if "%doneplay" = "yes" then return
#	gosub earlycheck
	if $Vocals.LearningRate > 32 then return
	if $Arcana.LearningRate < 34 then gosub cam.start
	else pause 10
	if "%doneplay" = "yes" then return
#	gosub earlycheck
	if $Vocals.LearningRate > 32 then return
	if $Perception.LearningRate < 34 then gosub jug.start
	else pause 10
	if "%doneplay" = "yes" then return
#	gosub earlycheck
	if $Vocals.LearningRate > 32 then return
	if $First_Aid.LearningRate < 34 then gosub comp.start
	else pause 10
return

playinstrument:
	pause 0.5
	action return when eval $%xskill.LearningRate = 34
	if "%quiet" = "on" then
	{
		waitforre You finish (humming|playing)
		return
	}
	if $Appraisal.LearningRate < 34 then
	{
		gosub appinstr
		pause 0.5
		gosub assessinstr
		pause
	}
	if "%immortal" = "yes" && $Scholarship.LearningRate < 34 then
	{
		gosub recall.immortal
		waitforre Your memory seems a bit too clouded|You recall|you don't seem to recall|You don't recall anything|Roundtime
	}
	else pause 14
	pause
#	gosub earlycheck
	if $%xskill.LearningRate > 32 then return
	if "%doneplay" = "yes" then return
	pause
	if "%assess" = "yes" then gosub assessinstr
	if "%doneplay" = "yes" then return
	pause
#	gosub earlycheck
	if $%xskill.LearningRate > 32 then return
	if "%famous" = "yes" && $Scholarship.LearningRate < 34 then
	{
		gosub recall.famous
		waitforre Your memory seems a bit too clouded|You recall|you don't seem to recall|You don't recall anything|Roundtime
	}
	else pause 14
	pause
	if "%doneplay" = "yes" then return
#	gosub earlycheck
	if $%xskill.LearningRate > 32 then return
	if "%holiday" = "yes" && $Scholarship.LearningRate < 34 then
	{
		gosub recall.holiday
		waitforre Your memory seems a bit too clouded|You recall|you don't seem to recall|You don't recall anything|Roundtime
	}
	else pause 14
	pause
	if "%doneplay" = "yes" then return
#	gosub earlycheck
	if $%xskill.LearningRate > 32 then return
	if "%herb" = "yes" && $Scholarship.LearningRate < 34 then
	{
		gosub recall.herb
		waitforre Your memory seems a bit too clouded|You recall|you don't seem to recall|You don't recall anything|Roundtime
	}
	else pause 14
	return

appinstr:
	pause 0.1
	put appraise my %instrument careful
	pause 2
	return

assessinstr:
	pause 0.1
	put assess my %instrument
	pause 2
	return

recall.immortal:
	pause 0.5
	random 1 39
	gosub immortal-%r
	return

recall.famous:
	pause 0.5
	random 1 42
	gosub famous-%r
	return
	
recall.holiday:
	pause 0.5
	random 1 21
	gosub holiday-%r
	return
	
recall.herb:
	pause 0.5
	random 1 19
	gosub herb-%r
	return

### getinst related ###
getinst:
	pause
	matchre gotinst You get|You are already holding that|You remove|You aren't wearing that
	matchre getinstg \.\.\.wait|Sorry, you may only type ahead
	match stowit You need a free hand to pick that up
	match getinst1 What were you referring to?
send get %instrument from my %r-container
	matchwait

getinst1:
	pause
	#if "%instrument" != "silver.txistu" then goto getinst2
	matchre gotinst You get|You are already holding that|You remove|You aren't wearing that
	matchre getinst1 \.\.\.wait|Sorry, you may only type ahead
	match stowit You need a free hand to pick that up
	matchre getinst2 What were you referring to|Remove what
send remove my %instrument
	matchwait

getinst2:
	pause
	matchre gotinst You get|You are already holding that|You remove|You aren't wearing that
	matchre getinst2 \.\.\.wait|Sorry, you may only type ahead
	match stowit You need a free hand to pick that up
	match missing What were you referring to?
send get my %instrument
	matchwait


gotinst:
return

stowit:
	pause
	if "$lefthand" != "Empty" then 
	{ 
		put put my $lefthandnoun in my %r-container
		waitfor You put your
	}
	if "$righthand" != "Empty" then 
	{ 
		put put my $righthandnoun in my %r-container
		waitfor You put your
	}
	goto getinst

missing:
	echo *** You seem to be missing your $1 ***
	exit
###

### clean related ###
clean:
	if "%rts" = "no" then goto cleandone
clean1:
	matchre clean1 Roundtime:|\.\.\.wait|Sorry, you may only type ahead
	match clean2 with what?
	match clean3 not in need of cleaning.
	match clean4 Maybe you should dry
	send clean my %instrument
	matchwait
clean2:
	if ("%mskill" = "STR" || "%mskill" = "PCN") then send get my %cleaning-thing from my %cleancontainer
	else goto 
	matchre clean2 Roundtime:|\.\.\.wait|Sorry, you may only type ahead
	match clean3 not in need of cleaning.
	match clean4 Maybe you should dry
	send clean my %instrument with my %cleaning-thing
	matchwait
clean3:
	if "$lefthand" = "Empty" then goto cleandone
	match clean3 ...wait
	match cleandone You put your
	send put my %cleaning-thing in my %cleancontainer
	matchwait
clean4:
	send get my %cleaning-thing from my %cleancontainer
	matchre clean4 Roundtime:|\.\.\.wait|Sorry, you may only type ahead
	match clean5 not in need of drying.
	send wipe my %instrument with my %cleaning-thing
	matchwait
clean5:
	matchre clean5 Roundtime:|\.\.\.wait|Sorry, you may only type ahead|water dribbling down
	matchre clean1 squeezing out the last bit of water.|then shake it out again.
	send wring my %cleaning-thing
	matchwait
cleandone:
return

###

### toolcheck related ###
toolcheck:
if matchre("$righthand", "faenellica") then goto pick
if matchre("$righthand", "marimba") then goto mallet
if matchre("$righthand", "damaru") then goto donetool
if matchre("$righthand", "fife") then goto donetool
	matchre toolcheck /\.\.\.wait|Sorry, you may only type ahead/
	match bow bow
	match pick requires a pick
	match stick requires a stick
	match hammer requires a hammer
	match tipper requires a tipper
	match donetool requires no tool
	put help my %instrument
	matchwait
bow:
	pause
	put get my bow in my %r-container
	put get my bow
	return
pick:
	put get my pick from my %cleancontainer
	put get my pick from my %r-container
	put wear my pick
	return
stick:
	put get my drum stick
	return
hammer:
	put get my hammer from my %r-container
	put get my hammer
	return
tipper:
	put get my tipper
	return
mallet:
	put get my mallet from my %r-container
	put get my mallet
	return
donetool:
	return
###

### tune related ###
tune:
	if "%rts" = "no" then goto tunedone
	match tunedone This is not
	match tunesharp flat
	match tuneflat sharp
	matchre tunedone in tune|in perfect tune
	if "$stringinst" = "harp" then put tune %instrument
	else put tune my %instrument
	matchwait
tunesharp:
	match tunesharp ...wait
	matchre tunedone in tune|in perfect tune
	match tunesharp flat
	match tuneflat sharp
	if "$stringinst" = "harp" then put tune %instrument sharp
	else put tune %instrument sharp
	matchwait
tuneflat:
	match tuneflat ...wait
	matchre tunedone in tune|in perfect tune
	match tuneflat sharp
	match tunesharp flat
	if "$stringinst" = "harp" then put tune %instrument flat
	else put tune %instrument flat
	matchwait
tunedone:
return

###

### initialdiff ###
initialdiff:
	if %diffnum < 51 then evalmath diffnum %diffnum + 1
	gosub %diffnum
	return
###

### diffnums ###
0:
	var diffnum 21
	goto %diffnum
1:
	setvariable diff ruff off-key
	echo
	echo You may wish to find an easier instrument.
	echo The easiest string, percussion, and wind instruments:
	echo Lyre, guiro, and txistu, respectively
	echo
	return
2:
	setvariable diff rudiments off-key
	return
3:
	setvariable diff ruff halting
	return
4:
	setvariable diff ditty off-key
	return
5:
	setvariable diff rudiments halting
	return
6:
	setvariable diff ruff
	return
7:
	setvariable diff folk off-key
	return
8:
	setvariable diff ditty halting
	return
9:
	setvariable diff rudiments
	return
10:
	setvariable diff ruff confident
	return
11:
	setvariable diff ballad off-key
	return
12:
	setvariable diff waltz off-key
	return
13:
	setvariable diff folk halting
	return
14:
	setvariable diff ditty
	return
15:
	setvariable diff rudiments confident
	return
16:
	setvariable diff ruff masterful
	return
17:
	setvariable diff lullaby off-key
	return
18:
	setvariable diff ballad halting
	return
19:
	setvariable diff folk
	return
20:
	setvariable diff march off-key
	return
21:
	setvariable diff waltz halting
	return
22:
	setvariable diff ballad
	return
23:
	setvariable diff jig off-key
	return
24:
	setvariable diff waltz
	return
25:
	setvariable diff lullaby
	return
26:
	setvariable diff march
	return
27:
	setvariable diff jig
	return
28:
	setvariable diff lament
	return
29:
	setvariable diff wedding
	return
30:
	setvariable diff hymn
	return
31:
	setvariable diff rumba
	return
32:
	setvariable diff polka
	return
33:
	setvariable diff battle
	return
34:
	setvariable diff elegy
	return
35:
	setvariable diff reel
	return
36:
	setvariable diff serenade
	return
37:
	setvariable diff minuet
	return
38:
	setvariable diff psalm
	return
39:
	setvariable diff dirge
	return
40:
	setvariable diff gavotte
	return
41:
	setvariable diff tango
	return
42:
	setvariable diff tarantella
	return
43:
	setvariable diff bolero
	return
44:
	setvariable diff nocturne
	return
45:
	setvariable diff requiem
	return
46:
	setvariable diff fantasia
	return
47:
	setvariable diff rondo
	return
48:
	setvariable diff aria
	return
49:
	setvariable diff sonata
	return
50:
	setvariable diff concerto
	return
51:
	setvariable diff concerto confident
	return
52:
	setvariable diff concerto masterful
	return
###

percit:
	put exp
	waitfor EXP HELP
	if $Power_Perceive.LearningRate > 32 then return
	put perc
	pause 1
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
#put recall famous Wren
#return
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

include includes.cmd
