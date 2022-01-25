# Cleanup and diff with Base.cmd

## gosubs

Base.ListExtract:
		var Base.ListVar $1
		var Base.NounListVar $2
		var Base.ItemCountVar $3

		eval %Base.ListVar replace("%%Base.ListVar", ", ", "|")
		eval %Base.ListVar replacere("%%Base.ListVar", "( and )(?:a |an |some )(?!.*and (a |an |some ))","|")
		var %Base.ListVar |%%Base.ListVar
		eval %Base.ItemCountVar count("%%Base.ListVar", "|")
		var %Base.NounListVar %%Base.ListVar
Base.ListExtract.Loop.Trim:
		eval %Base.NounListVar replacere ("%%Base.NounListVar", "\|[\w'-]+ ", "|")
		if contains("%%Base.NounListVar", " ") then goto Base.ListExtract.Loop.Trim
return

ALMANAC_CHECK:
  pause 0.5
  if $almanactime > $gametime then return
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  gosub get my $almanac
  put study my $almanac
  pause 0.5
  put put my $almanac in my backpack;stow my $almanac
  pause 0.5
  return

TARANTULA_CHECK:
	if $tarantulatime > $gametime then return
	pause 0.5
	match return TARANTULA DONE
	put .tarantula
	matchwait 5

THROWN_CLEAN:
pause 0.1
	matchre THROWN_CLEAN You pick up|You pull|You put|you stealthily sheathe|Sheathe what
	matchre RETURN You get some|You get a|You are already holding|Stow what|you stealthily unsheathe|You stop as you realize the|too long to fit|You can only|to fit in the
put stow $1;stow $1
matchwait

repair_waiting:
	if $repairtime < $gametime then return
	put .origami
	repair_waiting_1:
	if $repairtime < $gametime then
	{
		put #script abort origami;#script abort enc
		pause 2
		put stow;stow left
		return
	}
	else
	{
		delay 5
		goto repair_waiting_1
	}

PREP_CYCLIC:
  var casttype ""
  var SPELLTYPE CYCLIC
	matchre PREP_WAIT You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth|You infuse your voice with the elements as you begin to chant the opening notes of
	match PREP_RETURN have to strain
	put prep $1 $2 $3
	matchwait 5
	goto PREP_CYCLIC
	
PREP_SPELL:
  var SPELLTYPE SPELL
  	matchre PREP_WAIT You trace an angular sigil in the air, shaping the pattern|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth|You infuse your voice with the elements as you begin to chant the opening notes of
	match PREP_RETURN have to strain
	put prep $1 $2 $3
	matchwait 5
	goto PREP_SPELL  

PREP_WAIT:
		matchre PREP_CAST You feel fully prepared to cast your spell|The formation of the target pattern around
		matchre PREP_RELEASE patterns dissipate|pattern dissipates 
	matchwait 30
	goto PREP_CAST	

PREP_CAST:
		matchre PREP_RETURN You gesture|Your voice settles into slow, rich tones|The gentle notes of Blessing of the Fae waft from you with delicate ease, riddled with low tones that gradually give way to a higher-pitched theme|Low, hummed tones form a soft backdrop for the Eye of Kertigen|With a resounding \"POP\" like the cork from a bottle of effervescent bubbly, a spirited melody suddenly fills the area around you with palpable bands of audible color|A gently glittering series of colored lights appear in the air, winking in and out of existence with your performance of \"Nexus\"|You weave a soft melody, the notes so light and airy they can barely be heard|You softly voice your spell, gradually growing louder as the intricate pattern for Albreda's Balm forms more solidly in your mind|Though softly humming at first, you soon allow your voice to dance along the darkly melodic introduction to Abandoned Heart|Imagination blooms within you as you feel a sudden yearning to create|You chant a mesmerizing cadence designed to improve the study skills of those around you|A soft, rapid melody builds inside your mind as you create a call and response form around it|Your blood rises as images of ferocious battles play across your mind|Energy explodes from you, forming concentric rings of tangible sound of that sweep through the area like the fading ripples in a pond|You feel yourself swaying to an internal beat that hums with the natural rhythm of nature itself as the magic of \"Drums of the Snake\" begins to flow through you|The spell leaves you oddly moved, as though a sublime utterance is within your grasp, yet not easily expressed|With a power that seems to come from deep within yourself, staccato notes rip fiercely through the air|A gentle arpeggio of the enchante's opening notes segues into a softly melodic introduction of Hodierna's Lilt|As the pattern grips you, you are filled with resolve to stand fast and strong against all that assails you|You close your eyes briefly, focusing on the dull thumping of your own heart|With a sharp cut to your voice, you chant the rhythm that heralds the introduction to Caress of the Sun|With a harsh rasp to your voice, you sing the opening passages to the \"Desert's Maelstrom\"|In a low tone you begin your chant, as your voice grows you begin to thread it with traces of Fire which quickly agitate the air about you, causing it to warm almost painfully|As the pattern grips you, you are filled with resolve to stand fast and strong against all that assails you|You lift your right hand, forming your fingers into the shape of a vulture's talons|You relax your eyes in order to focus on the trace amounts of Fire that warm you and the world around you\.
    matchre PREP_RELEASE because your target is dead|patterns dissipate|pattern dissipates because
		match PREP_FACE on yourself!
		match PREP_%SPELLTYPE You don't
    match PREP_CASTAREA You can't cast that at yourself!
	put cast %casttype
	matchwait 5
	goto PREP_CAST

PREP_CASTAREA:
  var casttype area
  goto PREP_CAST

PREP_RELEASE:
  matchre PREP_RETURN RELEASE HELP|energies dissipate|preparing a spell|You release
  if matchre("%SPELLTYPE" , "CYCLIC|SPELL|MANA") then put release SPELL
	else put release all
	matchwait 5
  goto PREP_RELEASE
  
PREP_RETURN:
	pause 0.001
  	return


CAMB_CHARGE:
#if %CAMB_USE = OFF then return
if $mana < 20 then
{
  pause 10
  goto CAMB_CHARGE
}
if ($cam_slipped = 0 && $cam_leeched = 0) then goto CAMB_INVOKE
CAMB_CHARGE_1:
if $Arcana.LearningRate > 32 then return
	matchre CAMB_CHARGE_1 \.\.\.wait|absorbs
	matchre CAMB_INVOKE dissipates|cannot harness
	matchre CAMB_OFF Something in the area|Something is damping
	put charge my $cambrinth_cyclic 25
	matchwait 2
	goto CAMB_CHARGE_1

CAMB_INVOKE:
	match CAMB_INVOKE ...wait
	matchre CAMB_RETURN You reach for its center and forge a magical link to it|Your link.*is intact
	matchre CAMB_RETURN Something in the area|Something is damping
	put invoke my $cambrinth_cyclic cyclic
	matchwait 2
	goto CAMB_INVOKE

CAMB_RETURN:
	pause 0.001
  	return

CAMB_OFF:
	var CAMB_USE OFF
	return

foraging:
	if contains("$roomplayers", "Also here") then
	{
		put #play abort;#play abort;#echo >Events Cyan Waiting for GO ON
		put #echo White,Red Waiting for GO ON
		waitfor GO ON
		put wave
	}
	foraging_pyramids_off:
	put pyroff
	pause 3
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .forage
	waitfor Script Done
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	foraging_pyramids_on:
	put pyron
	pause 3
	if matchre("$roomobjs", "$pyramids") then
	{
		put #echo Cyan pickup your pyramids and type GO ON;
		put #play abort;#echo Cyan pickup your pyramids and type GO ON
		waitfor GO ON
	}
	if matchre("$roomplayers", "Also here") then
	{
		put #play abort;#play abort;#echo >Events Cyan Waiting for GO ON
		put #echo White,Red Waiting for GO ON
		waitfor GO ON
	}
	return


sell_bundles:
	pause 0.5
	match sell_bundles A good positive attitude never hurts
	match done_bundles referring to
	put remove my bund;sell my bund;yes
	matchwait
done_bundles:
	pause
	return

sell_pouch:
	put remove my gem.pouch
	waitforre You remove|You aren't wearing that|What were you referring to
	put tie my gem.pouch
	waitforre You tie up|has already been tied off|Tie what|Why\?
	sell_pouch_1:
	pause 0.5
	matchre sell_pouch_1 A good positive attitude never hurts|Please forgive the inconvenience
	matchre done_pouch That's worthless to me|then hands you|That holds no value for me
	put sell my gem.pouch;yes
	matchwait
	done_pouch:
	put wear my gem.pouch
	pause
	return

go_room:
		pause 0.2
		match good_move YOU HAVE ARRIVED
		match go_room MOVE FAILED
	put #goto $1 $2
	matchwait
good_move:
	pause
	return

	good_MOVE_2:
		PAUSE 0.2
		MATCH ACTION YOU HAVE ARRIVED
		MATCH good_MOVE_2 MOVE FAILED
		PUT #goto $1 $2
		MATCHWAIT
	ACTION:
		return

go_travel:
	put .travel $1
	waitfor YOU HAVE ARRIVED
	pause
	return

go_trav:
	put .trav $1
	waitfor YOU HAVE ARRIVED AT YOUR LOCATION
	pause
	return

healing:
	pause
	put stop sing
	pause
	put .enc mere 20 quiet on
	put lie
	put .origami
	waitfor You sit up
	healed:
	put #script abort origami
	pause 2
	put stow
	var wounded 0
	action remove eval $sitting = 1
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	put stow;stow left
	pause
	put kneel;stand;stop sing
	return

health_check:
	var wounded 0
	matchre wounded (?!bruis)(\s|\w)*(about the|to the|malformed)+(\s|\w)*head|skull
	matchre wounded (bruis|bloat)(\w|\s)*head
	matchre wounded (,| )((?!bruis(ed|ing))(\s|\w))*(\bchest\b)(\s|\w)*(\.|,|$)
	matchre wounded (\w|\s)*bruis(\w|\s)+chest
	matchre wounded (,| )(some|cut|cuts|slashes) ((?!bruis(ed|ing))(\s|\w))*(\babdomen\b)(\s|\w)*(\.|,|$)
	matchre wounded (\w|\s)*(bruis|disco)(\w|\s)+abdomen
	matchre wounded (,| )(a|some|cut|cuts|slashes) ((?!bruis(ed|ing))(\s|\w))*(\bback\b)(\s|\w)*(\.|,|$)
	matchre wounded (\w|\s)*(bruis|disco)(\w|\s)+back
	matchre wounded (,| )(a|some|cut|cuts|slashes) ((?!(bruis|bloat)(ed|ing))(\s|\w))*(\bneck\b)(\s|\w)*(\.|,|$)
	matchre wounded (\w|\s)*(bruis|disco)(\w|\s)+neck
	matchre wounded (,| )(a|some|cut|cuts|slashes) ((?!(bloat|bruis)(ed|ing))(\s|\w))*((left|right) (leg|arm|hand))(\s|\w)*(\.|,|$)
	matchre wounded (\w|\s)*(bruis|disco|swollen)(\w|\s)+((left|right) (leg|arm|hand))
	matchre wounded (?!bruis)(\s|\w)*(bleed|shatt|to the|for a)+(\s|\w)*eye
	matchre wounded (\w|\s)*(bruis|swollen)(\w|\s)+eye\b
	matchre wounded (slight numbness in your fingers and toes|some minor twitching|severe twitching|difficulty controlling actions|paralysis of the entire body)
	matchre wounded (rash|sores)
	matchre wounded (some minor abrasions to the skin|mangled and malformed|severe scarring|minor scars|some tiny scars|few nearly invisible scars|difficulty getting a breath without pain|scarring|scarred|scarred|painfully mangled|malformed|socket overgrown with bits of odd shaped flesh|punctured and shriveled|paralyzed|clouded|skin tone|skin discoloration|folded skin|shriveled skin|skin loss|faint scuffing|open and bleeding sores all over the skin)
	matchre wounded (difficulty getting a breath without pain|twitching|twitch|somewhat emaciated look|socket overgrown with bits of odd shaped flesh|punctured and shriveled|paralyzed|clouded|numbness)
	match return positive attitude
	PUT heal;yes
	matchwait

wounded:
	var wounded 1
	return

# developed from scripts by pbombard, Dasffion, Copernicus, Saet and BakedMage
# an include file providing some common subroutines for list manipulation
# anywhere referenced, the name of the list and any return variables
# supplied to these should be just the variable name, without the % preceeding it.
#
# subroutines included:
#
# list_add $1 $2 - adds an item($2) to the end(right) of a list($1)
#
# list_getlast - returns the end(rightmost) item from a list($1) in a variable($2) but does NOT remove the item from the list
#
# list_push $1 $2 - adds an item($2) to the front(left) of a list($1)
#
# list_pop $1 $2 - removes the frontmost(leftmost) item of a list($1) and stores it in a variable($2)
#
# list_replace $1 $2 $3 - replaces all occurences of an item($2) with another item($3) in a list($1)
#
# list_replaceat $1 $2 $3 - replaces an item at postion($2) with an item($3) in a list($1)
#
# list_remove $1 $2 - removes all occurences of item($2) from a list($1)
# 
# list_removeat $1 $2 - removes item at position($2) from a list($1)
#
# list_reverse $1 - reverses the order of the items in a list($1)

list_add:
	# expects $1 to be the list name (no %), $2 to be the item to add to the list.
	if (("%$1" = "\%$1") || ("%$1" = "")) then var $1 $2
	else var $1 %$1|$2
	return

list_getlast:
	# expects $1 to be the list name (no %), $2 to be the returned variable name (no %)
	eval list_size count("%$1", "|")
	var $2 %$1(%list_size)
	return

list_push:
	# expects $1 to be the list name (no %), $2 to be first item to push into the array
	if (("%$1" = "\%$1") || ("%$1" = "")) then var $1 $2
	else var $1 $2|%$1
	return

list_pop:
	#expects $1 to be the list name (no %), $2 to be the returned variable name (no %)
	eval list_size count("%$1", "|")
	var list_contents %$1
	var list_pop_count 0
	var $2 %list_contents(0)
	var list_temp_contents %list_contents(1)
	evalmath list_pop_count %list_pop_count + 2
	list_pop2:
		if (%list_pop_count <= %list_size) then
		{
			var list_temp_contents %list_temp_contents|%list_contents(%list_pop_count)
			evalmath list_pop_count %list_pop_count + 1
			goto list_pop2
		}
	list_pop_return:
		if ("%list_temp_contents" = "") then unvar $1
		else var $1 %list_temp_contents
		return

list_replace:
	# expects $1 to be the list name (no %), $2 to be the item to replace in it, $3 the stuff to replace it with
	var list_contents |%$1|
	list_replace2:
		eval list_contents replace("%list_contents", "|$2|", "|$3|")
		if contains("%list_contents", "|$2|") then goto list_replace2
	list_replace_return:
		eval list_contents replacere("%list_contents", "(^\||\|$)", "")
		var $1 %list_contents
		return

list_replaceat:
	# expects $1 to be the list name (no %), $2 to be the numerical location in the list to replace, $3 to be the stuff to replace it with
	eval list_size count("%$1", "|")
	var list_contents %$1
	var list_replaceat_position $2
	var list_replaceat_contents $3
	var list_replaceat_count 0
	list_replaceat2:
		if (%list_replaceat_count = %list_replaceat_position) then
		{
			if %list_replaceat_count = 0 then var list_temp_contents %list_replaceat_contents
			else var list_temp_contents %list_temp_contents|%list_replaceat_contents
			evalmath list_replaceat_count %list_replaceat_count + 1
			goto list_replaceat2
		}
		else if (%list_replaceat_count <= %list_size) then
		{
			if %list_replaceat_count = 0 then var list_temp_contents %list_contents(0)
			else var list_temp_contents %list_temp_contents|%list_contents(%list_replaceat_count)
			evalmath list_replaceat_count %list_replaceat_count + 1
			goto list_replaceat2
		}
	list_replaceat_return:
	var $1 %list_temp_contents
	return

list_remove:
	# expects $1 to be the list name (no %), $2 to be the item to remove from it
	var list_contents |%$1|
	list_remove2:
		eval list_contents replace("%list_contents", "|$2|", "|")
		eval list_contents replace("%list_contents", "||" "|")
		if contains("%list_contents", "|$2|") then goto list_remove2
	list_remove_return:
		eval list_contents replacere("%list_contents", "(^\||\|$)", "")
		if ("%list_contents" = "") then unvar $1
		else var $1 %list_contents
		return

list_removeat:
	# expects $1 to be the list name (no %), $2 to be the numerical location in the list to remove
	eval list_size count("%$1", "|")
	var list_removeat_contents %$1
	var list_removeat_position $2
	var list_removeat_count 0
	list_removeat2:
		if (%list_removeat_count = 0) then
		{
			gosub list_pop list_removeat_contents list_throwaway
			var list_temp_contents %list_removeat_contents
			unvar list_throwaway
			goto list_removeat_return
		}
		if (%list_removeat_count = %list_removeat_position) then
		{
			evalmath list_removeat_count %list_removeat_count + 1
			goto list_removeat2
		}
		else if (%list_removeat_count <= %list_size) then
		{
			if %list_removeat_count = 0 then var list_temp_contents %list_removeat_contents(0)
			else var list_temp_contents %list_temp_contents|%list_removeat_contents(%list_removeat_count)
			evalmath list_removeat_count %list_removeat_count + 1
			goto list_removeat2
		}
	list_removeat_return:
	if ("%list_temp_contents" = "") then unvar $1
	else var $1 %list_temp_contents
	return
	
list_reverse:
	eval list_reverse_count count("%$1", "|")
	if (%list_reverse_count = 0) then return
	var list_contents %$1
	var list_temp_contents %list_contents(%list_reverse_count)
	evalmath list_reverse_count %list_reverse_count - 1
	var list
	list_reverse2:
		if (%list_reverse_count >= 0) then 
		{
			var list_temp_contents %list_temp_contents|%list_contents(%list_reverse_count)
			evalmath list_reverse_count %list_reverse_count - 1
			goto list_reverse2
		}
	list_reverse_return:
	var $1 %list_temp_contents
	return

list_do:
	var list_do_command $2
	var list_contents %$1
	eval list_size count("%$1", "|")
	var list_do_count 0
	list_do2:
		if (%list_do_count <= %list_size) then
		{
			put %list_do_command %list_contents(%list_do_count)
			pause
			evalmath list_do_count %list_do_count + 1
			goto list_do2
		}
	return

## BaseLabels.cmd

   #debuglevel 5
   
## Bard Stuff
   
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
PUT:
	var put $0
PUT.1:
  pause .1
  matchre PUT.1 ^\.\.\.wait|^Sorry
	matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	send put %put
	matchwait 1
	goto PUT.1

DROP:
	var drop $0
DROP.1:
  pause .1
  matchre DROP.1 ^\.\.\.wait|^Sorry
	matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	send DROP %drop
	matchwait 1
	goto DROP.1	
	
GET:
   var Get $0
GET.2:
   pause .2
   matchre GET.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up|^What were you referring to\?|^But that is already in your inventory\.
   match RETURN You carefully remove
   send get %Get
   matchwait 2
	 goto GET.2

STOW:
   var Stow $0
STOW.2:
   pause .1
   matchre STOW.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You put (a|an|some|your|the)|Stow what\?
   send stow %Stow
   matchwait 1
	 goto STOW.2
   
FALLEN:
   pause .1
   matchre FALLEN ^\.\.\.wait|^Sorry
   matchre CLIMB.FAIL You stand|You are already standing
   matchre FALLEN cannot manage to stand\.|The weight of all your possessions
   send stand
   matchwait 1
   goto FALLEN

   
## Movement ################################
MOVE:
   var Dir $0
MOVE2:
   matchre MOVE2 ^\.\.\.wait|^Sorry
   match MOVE_GATE The gate is closed.  Try KNOCKing instead.
   matchre RETURN ^Obvious
   send %Dir
   matchwait

MOVE_GATE:
   var Dir knock gate
   goto MOVE2
   
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
	pause 0.001
   	return
   
EXIT:
   pause 0.001
   put #parse END SCRIPT
   put #parse Script Done
   put #script abort %ScriptName
   pause 0.5
