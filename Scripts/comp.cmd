# clean, and integrate

## If including from another script
## please set %compcon and %componce
var compcalled no
var componce no


##### Compendium!
comp.start:
	var compcon $compcon
	var comp1 $comp1
	var comp2 $comp2
	var compexp 30
	if_1 var compexp %1
	var compnum 1
	var compreads 1
	#if "%humming" != "off" then put stop sing
	pause 0.5
	put open my %compcon
	pause 0.5
	put get my %comp%compnum
	put open my comp
	pause
#goto comp.humcheck
	goto comp.study

comp.humcheck:
	if "%compcalled" != "no" then goto comp.study
#	put exp
#	waitfor EXP HELP
	if "%humming" = "off" then goto comp.study
	if $Vocals.LearningRate > %compexp then put stop hum
	else put hum $hum
	goto comp.study

comp.study:
	if $Scholarship.LearningRate = 32 || $First_Aid.LearningRate > %compexp then goto comp.end
	pause
	matchre comp.study ^\.\.\.wait|^Sorry, you may only type|gradually absorbing more of the knowledge|gradually absorbing the knowledge
	matchre comp.check sudden moment of clarity|difficult time comprehending|but believe that you have discerned all you can from it
#	if %compreads = 4 then match comp.end Why do you need to study this chart again?
#	else match comp.swap Why do you need to study this chart again?
	match comp.end Why do you need to study this chart again?
put study my comp
	matchwait

comp.check:
#	put exp
#	waitfor EXP HELP
	if $Scholarship.LearningRate = 32 || $First_Aid.LearningRate > %compexp then goto comp.end
	else goto comp.turn

comp.turn:
	matchre comp.turn ^\.\.\.wait|^Sorry, you may only type
	match comp.turncheck You turn to the
put turn my comp
	matchwait
	
comp.turncheck:
	if "%componce" = "yes" then goto comp.end
	else goto comp.humcheck

comp.swap:
	pause
	put put my %comp1 in my %compcon;get my %comp2
	pause 0.5
	put open my comp
	if (%compnum = 1) then var compnum 2
	else var compnum 2
	evalmath compreads %compreads + 1
	goto comp.humcheck

comp.end:
	pause
	put close my comp
	put put my comp in my %compcon
	if "%compcalled" != "no" then return
	exit
