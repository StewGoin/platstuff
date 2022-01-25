## Reveler's HE Spider Gift Script
## contact DISCORD Reveler#6969 with any problems
## 12/30/19
## Version 2.0
## Adjusted wait time due to early activation to tie to the game output
## Created variables for your tarantula - update your variable if you've gotten your tarantula altered
##
## 11/21/10
##  - Reduced wait time when not enough learning and too early activation
##  - Fixed bug where it would lose track of itself if the last skill checked was in the prior skillset activated
## 
## MUST BE NAMED spider.cmd IN YOUR SCRIPTS FOLDER

#debug 10
debug 5
## NOTE: if you want your pool absorption turned OFF you must do this manually!
##################################################

## Set your chosen minimum learning rate for sacrificing skills
var LearningRate 32

## If any of your characters don't have a tarantula, set below
##if ("$charactername" = "####") then goto end

if ("$charactername" = "Ryken") then 
{
	##  Set your tarantula noun if you had it altered
	var tarantula tarantula

	##  Set your chosen skills to sacrifice below, use ExpTracker output
	var Magic.skillstocheck Primary_Magic|Targeted_Magic|Debilitation
	var Lore.skillstocheck Appraisal|Tactics
	var Survival.skillstocheck Perception|Skinning|Evasion
	var Armor.skillstocheck Defending|Shield_Usage|Chain_Armor|Brigandine|Plate_Armor
	var Weapons.skillstocheck Melee_Mastery|Missile_Mastery|Parry_Ability

	##  Set your pools to fill - Match the skills above
	var PoolsToFill Survival|Weapons|Armor|Magic
}

if ("$charactername" = "####") then 
{
	##  Set your tarantula noun if you had it altered
	var tarantula tarantula

	##  Set your chosen skills to sacrifice below, use ExpTracker output
	var Magic.skillstocheck Primary_Magic
	var Lore.skillstocheck Appraisal|Tactics
	var Survival.skillstocheck Perception|Skinning
	var Armor.skillstocheck Defending|Shield_Usage|Light_Armor
	var Weapons.skillstocheck Melee_Mastery|Missile_Mastery

	##  Set your pools to fill - Match the skills above
	var PoolsToFill Magic|Lore|Survival|Armor|Weapons
}

##################################################
## Do not change anything below this line
## Counters and other variables
var PoolsToFillCount 0
action put #var SpiderSacrifice $1;put #var SpiderLastPool $2;put #echo >log orange Sacrificed $1 for $2 pool when It is mere moments afterward that you feel an itching\, tingling\, and crawling sensation all across the inside of your skull\.  In a mind-wracking flurry of sensation\, you find yourself forgetting your recent progress on (.*)\, but somehow unbidden knowledge into other (.*) tasks are mapped into your psyche\.$

eval TotalPools count("%PoolsToFill", "|")

# sets the counters for each of the pools to check the skills being sacrificed
getskillcounts:
{
	eval Total.%PoolsToFill(%PoolsToFillCount) count ("%PoolsToFill(%PoolsToFillCount).skillstocheck", "|")
	if (%PoolsToFillCount < %TotalPools) then
	{
		math PoolsToFillCount add 1
		goto getskillcounts
	}
	var PoolsToFillCount 0
}
gosub getskill

spidertimer:
	pause 610
	gosub getskill
	goto spidertimer
 
 
getskill:
	var skillcounter 0
	var sacrifice NULL
	var Checked 0
	var beginningPool %PoolsToFillCount
getskill_1:
	var temppool %PoolsToFill(%PoolsToFillCount)
	if (%Checked >= %TotalPools) then goto noskills
	if ("%temppool" = "$SpiderLastPool") then
	{
		math PoolsToFillCount add 1
		math Checked add 1
		if (%Checked > %TotalPools) then goto noskills
		goto getskill_1
	}
	var tempskill %%PoolsToFill(%PoolsToFillCount).skillstocheck(%skillcounter)
	var tempnumberskills %Total.%PoolsToFill(%PoolsToFillCount)
	if (($%tempskill.LearningRate >= %LearningRate) then
	{
		var sacrifice %tempskill
		goto getskill_2
	}
	if (($%tempskill.LearningRate < %LearningRate) && ("%sacrifice" = "NULL")) then
	{
		if (%PoolsToFillCount < %TotalPools) && (%skillcounter >= %tempnumberskills) then
		{
			var skillcounter 0
			math PoolsToFillCount add 1
			math Checked add 1
			if ((%PoolsToFillCount > %TotalPools)&&(%TotalPools >= %Checked)) then var PoolsToFillCount 0
			goto getskill_1
		}
		if (%skillcounter < %tempnumberskills) then
		{
			math skillcounter add 1
			goto getskill_1
		}
		if (%PoolsToFillCount >= %TotalPools) then
		{
			var skillcounter 0
			var PoolsToFillCount 0
			if (%Checked >= %TotalPools) then goto noskills
			goto getskill_1
		}
	}
getskill_2:
	eval sacrifice replacere("%%PoolsToFill(%PoolsToFillCount).skillstocheck(%skillcounter)", "_", " ")
	goto activatespider
 
activatespider:
{
    var lastaction $lastcommand
    put #script pause all except spider
    pause .1
    activatespider_1:
		matchre activatespider_1 ^\.\.\.wait|^Sorry\,|^Please wait\.
		matchre activatespider_1 ^You don't seem to be able to move to do that
		matchre activatespider_1 ^You can't do that while entangled in a web
		matchre activatespider_1 ^You are still stunned
		matchre activatespider_2 ^You fiddle with the tiny levers and dials
    send turn my %tarantula to %sacrifice
    matchwait 5
    activatespider_2:
		matchre activatespider_2 ^\.\.\.wait|^Sorry\,|^Please wait\.
		matchre activatespider_2 ^You don't seem to be able to move to do that
		matchre activatespider_2 ^You can't do that while entangled in a web
		matchre activatespider_2 ^You are still stunned
		matchre resume It is mere moments afterward that you feel an itching
		matchre lastskillseterror ^You try\, but it does nothing.
		matchre tooearly ^You try\, but the (.+) is unresponsive\.  It needs approximately ([0-9]) roisaen to generate enough venom again.
    send rub my %tarantula
    matchwait 5
    pause .1
    resume:
    put #script resume all
	pause 1
	put %lastaction
    math PoolsToFillCount add 1
    if  (%PoolsToFillCount > %TotalPools) then var PoolsToFillCount 0
    goto spidertimer
 
lastskillseterror:
	put #var SpiderLastPool %PoolsToFill(%PoolsToFillCount)
	put #script resume all
	pause 1
	put %lastaction
	goto getskill
 
noskills:
	put #echo >log orange No skills with enough learning - checking in 3 minutes
	var PoolsToFillCount %beginningPool
	var Checked 0
	pause 180
	goto getskill
 
 
tooearly:
	var minutes $2
	if (%minutes = 0) then 
	{
		var wait 60
		var minutes 1
	}
	else evalmath wait $2 * 63
	put #echo >log orange Spider activated too early - trying again in about %minutes minutes
	put #script resume all
	pause 1
	put %lastaction
	pause %wait
	goto getskill
 
end:
done:
  put exp bonus
  waitforre Your %tarantulaSkillSets? pool could fill one empty skill to (\d+) ranks
  put exp 0
  put #echo >user [$time] Traded %skill.LR %skill mindstates for $1 bonus %tarantulaSkillSet ranks
  put #var tarantulaSkillSet %tarantulaSkillSet
  var temp $gametime
  math temp add 605
  put #var tarantulaTime %temp
  put #parse ** TARANTULA DONE **
exit