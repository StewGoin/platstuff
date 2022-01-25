# CLean this up and consider if it can be put into Base

### Ryken's Origami Script
### Please make sure the variables listed below are set
	# If including this in another script
	# please set %origami, %originstloc, and %singlefold in the parent
	# origami == the pattern name (cat, etc...)
	# originstloc == the instruction / primer / grimoire location (in my cloak, etc...)
	# origcalled == controls how the script ends (return vs. exit)
	# singlefold == One complete fold or keep going
	# envcont == container with more envelopes in it
	#
	# $origexp == the LearningRate in # format that this script should stop at.
	# This is a global so that it can be changed on the fly
	#

	put #var GH_BACKTRAIN OFF
	var origcalled no
	var singlefold 0
  var casttype ""
  if "%1" = "single" then
  {
    var singlefold 1
    shift
  }
	var cyclic 1
	IF_1 var cyclic 0
  var DOTS 1
  IF_2 var DOTS 0

origami.start:
	var origami $origami
	var originstloc $originstloc
	var envcont $originstloc
pause	
if $Outfitting.LearningRate > $origexp then goto origami.done
if ("$righthand" != "Empty") then 
{
	var rightitem $righthand
	put put my $righthandnoun in my $pack
}
if ("$lefthand" != "Empty") then
{
	var leftitem $lefthand
	put put $lefthandnoun in my $pack
}

origami.cyclic:
  if %cyclic = 0 then goto origami.DOTS
  put #var cam_leeched 1
  put #var cam_slipped 1
  if $SpellTimer.FaenellasGrace.active = 0 then
  {
    put .cast fae 30
    waitfor Spell Cast
  }

origami.start.2:
if $Outfitting.LearningRate > $origexp then goto origami.done
#if ((%drumming = 1) && ("$lefthand" != "blackened zills")) then
#{
#	var leftitem $lefthand
#	put stow left
#	put get zills;swap
#	put .enc drum 20 40 loud play
#	pause 5
#}

origami.DOTS:
  if %DOTS = 0 then goto origami.begin
  if $SpellTimer.DrumsoftheSnake.active = 0 then
  {
    put .cast drum 10 45 45
    waitfor Spell Cast
  }
  #if $SpellTimer.WhispersoftheMuse.active = 0 then
  #{
  #  put .cast wotm 10 45 45
  #  waitfor Spell Cast
  #}   
#  put .cast COMPOST $compost_mana
#  waitfor Spell Cast

origami.begin:
  if (($cam_slipped = 1 || $cam_leeched = 1) && %DOTS = 1) then gosub CAMB_CHARGE
	matchre origami.begin ...wait 
	matchre origami.pull.envelope You must be either|What were you
	matchre origami.study You get a|You are already holding that
	put get my paper
	matchwait

origami.pull.envelope:
	match origami.pull.envelope ...wait 
	matchre origami.new The envelope is|You must be either|afraid that you
	match origami.study You get a
	match origami.pull.envelope Roundtime
	put pull my env
	matchwait

origami.new:
	pause 0.5
	put poke my env
	waitforre You|What were you referring

origami.get.envelope:
	match origami.get.envelope ...wait 
	match origami.new But that is
	match origami.outof.envelopes What were you
	match origami.wear.envelope You get
	put get env from my %envcont
	matchwait

origami.outof.envelopes:
	echo **** YOU HAVE RUN OUT OF ENVELOPES, GET MORE ****
	put #echo >Log **** YOU HAVE RUN OUT OF ENVELOPES, GET MORE ****
	goto origami.done

origami.wear.envelope:
	pause 0.5
	put wear my env
	waitfor You attach
	goto origami.begin

origami.study:
	if "%originstloc" = "grimoire" then goto origami.grim.get
	match origami.study ...wait 
	match origami.start.2 You need to be holding 
	matchre origami.check.exp You study|You've already started
	match origami.study Roundtime
	put study my $origami instru in my $originstloc
	matchwait 2
	goto origami.study

origami.grim.get:
	put get my origami grimoire
	waitforre You get|You are
	put open my grimoire
	waitforre open your|already open
	goto origami.grim.study
	
origami.grim.study:
	match origami.grim.study ...wait
	match origami.start.2 You need to be holding 
	matchre origami.grim.exp You study|You've already started
	match origami.grim.study Roundtime
	put study my %origami instru
	matchwait

origami.grim.exp:
	put close my grimoire
	waitforre close your|already closed
	put stow my grimoire
	waitforre You put|What were you|Stow what
	goto origami.check.exp

origami.check.exp:
	if $Outfitting.LearningRate > $origexp then goto origami.done
	pause
	else goto origami.fold

origami.fold:
  if $SpellTimer.DrumsoftheSnake.active = 0 then
  {
    put .cast drum 10 45 45
    waitfor Spell Cast
  }
  if $SpellTimer.WhispersoftheMuse.active = 0 then
  {
    put .cast wotm 10 45 45
    waitfor Spell Cast
  }  
	match origami.fold ...wait
	matchre origami.start.2 You must|what
  matchre origami.failed your project is ruined\.$|^You need to use origami paper for this
	matchre origami.fold.complete You make the final fold|What were you
	match origami.check.exp Roundtime
	put fold my paper
	matchwait 2
	goto origami.fold

origami.failed:
  match origami.fold.complete You poke a piece of paper, and realizing it has no value whatsoever, toss it away.
  match origami.fold.complete What were you referring to?
  put poke my paper
  matchwait 2
  goto origami.failed

origami.fold.complete:
	pause
	match origami.fold.complete ...wait 
	matchre origami.fold.complete.2 You drop|tattered remains|You crumple up|You slowly and deliberately empty your filled lungs|Smoking commands
	if "$origami" = "owl" then put exhale my horned
	else put exhale my $righthandnoun
	matchwait 2
	goto origami.fold.complete
	
	origami.fold.complete.2:
	if %singlefold = 1 then goto origami.done
	else goto origami.start.2

origami.done:
	pause
	if "$righthand" != "Empty" then
	{
		put put my $righthandnoun in my $pack
		goto origami.done
	}
	if "$lefthand" != "Empty" then
	{
		put put my $lefthandnoun in my $pack
		goto origami.done
	}
  put #parse Origami Complete
	pause 0.5
	if "%origcalled" != "no"  then return
	else exit
	
  include includes.cmd
