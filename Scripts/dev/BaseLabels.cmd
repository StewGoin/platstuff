# Diff w/ Base.cmd and includes.cmd -- does this have anything those don't?

## BaseLabels.cmd

   #debuglevel 5
   

## Moon Mage Stuff ###############################
ASTROLIZE:
   put stop play
   pause .2
   pause .2
   if "$spellCV" != "ON" then gosub BUFF CV 4
   #if "$spellPG" != "ON" then gosub BUFF PG 4
   if !contains ("TapFan|MoonMagery|Cast", "$CurrentScript") then put hum $Song
   #if !contains ("Braid|Forage|Compendium|Juggle|Origami|TapFan", "$CurrentScript") then if "$Scope" = "YES" then gosub OBSERVE.SCOPE
   gosub STUDY.SKY
   math AstroWhat add 1
   if $Time.isDay = 1 then if %AstroWhat > 3 then var AstroWhat 0
   if %AstroWhat > $ObsCount then var AstroWhat 0
   #if "%Predict" = "ON" then gosub PREDICT
   return

OBSERVE:
   pause .2
   matchre OBSERVE ^\.\.\.wait|^Sorry
   matchre OBSERVE.NEXT turns up fruitless\.|^Clouds obscure the sky|foiled by the
   matchre RETURN ^Roundtime\:
   #if !contains ("Braid|Forage|Compendium|Juggle|Origami|TapFan", "$CurrentScript") then if "$Scope" = "YES" then put peer telescope
   send obs %Astrobles(%AstroWhat)
   matchwait

OBSERVE.SCOPE:
   gosub GET telescope
   send open telescope
   pause .2
   gosub CENTER.SCOPE
   if "$Scope" = "NO" then
   {
      send close telescope
      pause .2
      gosub STOW telescope
      gosub OBSERVE
      return
   }
   gosub FOCUS.SCOPE
   gosub OBSERVE
   send close telescope
   pause .2
   gosub STOW telescope
   return

OBSERVE.NEXT:
   math GiveUp add 1
   math AstroWhat add 1
   if $Time.isDay = 1 then if %AstroWhat > 3 then var AstroWhat 0
   if %AstroWhat > $ObsCount then var AstroWhat 0
   if %GiveUp > $ObsCount then
   {
      var GiveUp 0
      return
   }
   goto OBSERVE

CENTER.SCOPE:
   pause .2
   matchre CENTER.SCOPE ^\.\.\.wait|^Sorry
   matchre OBSERVE.NEXT Your search for .* turns up fruitless\.
   matchre RETURN ^You put your eye to|The pain is too much\.
   send center my telescope on %Astrobles(%AstroWhat)
   matchwait

FOCUS.SCOPE:
   pause .2
   matchre RETURN Ah\!  That\'s a bit better\!
   matchre FOCUS.SCOPE ^\.\.\.wait|^Sorry|^Roundtime\:
   send focus my telescope
   matchwait

PREDICT:
   #gosub STUDY.SKY
PREDICT.EVENT:
   math StopPredict add 1
PREDICT.EVENT.2:
   pause .2
   var Predict OFF
   matchre PREDICT.EVENT ^\.\.\.wait|^Sorry|^The future remains dark to you\.
   matchre RETURN ^You see|^Your foresight|You focus inwardly searching for insight into your future\.
   send predict event
   matchwait

STUDY.SKY:
   pause .2
   matchre STUDY.SKY ^\.\.\.wait|^Sorry
   matchre STUDY.SKY.WAIT ^You feel it is too soon
   matchre PREDICT ^You are unable to sense additional information\.
   matchre RETURN ^Roundtime\:|You are unable to sense additional information\.|You should try that where you can see the sky\.
   send study sky
   matchwait

STUDY.SKY.WAIT:
   pause 3
   goto STUDY.SKY
   

## Spell Buffing #################################
BUFF:
   gosub BUFF.PREP $0
   gosub BUFF.CAST
   return

BUFF.PREP:
   var BuffSpell $0
BUFF.PREP.2:
   pause .2
   matchre BUFF.PREP.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You raise your arms skyward\,
   send prep %BuffSpell
   matchwait

BUFF.CAST:
   pause 12
   matchre BUFF.CAST ^\.\.\.wait|^Sorry
   matchre RETURN ^You gesture\.
   send cast
   matchwait
   

## Misc Action Labels ############################
GET:
   var Get $0
GET.2:
   pause .2
   matchre GET.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You get (a|an|some|your|the)|^You are already holding that\.
   send get %Get
   matchwait

STOW:
   var Stow $0
STOW.2:
   pause .2
   matchre STOW.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You put (a|an|some|your|the)
   send stow %Stow
   matchwait
   
FALLEN:
   pause .2
   matchre FALLEN ^\.\.\.wait|^Sorry
   matchre CLIMB.FAIL You stand|You are already standing
   matchre FALLEN cannot manage to stand\.|The weight of all your possessions
   send stand
   matchwait

   
## Movement ################################
MOVE:
   var Dir $0
MOVE2:
   matchre MOVE2 ^\.\.\.wait|^Sorry
   matchre RETURN ^Obvious
   send %Dir
   matchwait
   
CLIMB:
   if "$CurrentScript" = "ClimbCross" then gosub EXP.CHECK
   var ClimbSpot $0
CLIMB2:
   if (("$Guild" = "ranger") && ("$spellSPC" != "ON")) then gosub BUFF spc 15
   pause .2
   matchre CLIMB2 ^\.\.\.wait|^Sorry
   matchre CLIMB.SUCCESS ^\[
   matchre CLIMB.FAIL You must be standing|steepness is intimidating|can\'t seem to find purchase|find it hard going\.|your footing is questionable|you climb back down|wave of dizziness|Struck by vertigo
   matchre CLIMB.REST ^You are too tired to
   matchre FALLEN slip after a few feet
   send climb %ClimbSpot
   matchwait
CLIMB.REST:
   pause 1
   if $stamina >= 50 then goto CLIMB2
   goto CLIMB.REST
CLIMB.SUCCESS:
   var ClimbOutcome PASS
   goto RETURN
CLIMB.FAIL:
   var ClimbOutcome FAIL
   goto RETURN

SWIM:
   var Dir $0
SWIM2:
   pause .2
   matchre SWIM2 ^\.\.\.wait|^Sorry|make much headway|can\'t get anywhere|blunder around
   matchre RETURN ^\[
   put %Dir
   matchwait
   
   
## Generic Labels ##########################
RETURN:
   return
   
EXIT:
   put #parse END SCRIPT
   put #parse Script Done
   put #script abort %ScriptName
