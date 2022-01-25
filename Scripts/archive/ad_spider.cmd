#exit
#Written by the Boo
# 11/9/2020
# If you have helpful tidbits to make it better, would love to hear them. :)
# Spider must be worn for this to work, I"m not fucking with taking it out/putting it away/etc.
	# It's gen worn, if you cant wear it, re-asses your chars life choices.
	
# This script will allow you to set which Skill Sets to cycle through every 10 minutes and then which skills that you're willing to sacrifice in each skill set.
# It will pick the skill with the highest learning rate in the skillset to sacrifice.

#DEBUG 10
## *****
SPIDER_VARS_INIT:
	if (matchre("$charactername","Bill|Bob|Frank")) then {
		# https://elanthipedia.play.net/Category:Skills
		# Define what skillsets you want to train (Options are: LORE|MAGIC|ARMOR|WEAPON|SURVIVAL)
		# Can be as many as you want, will go from beginning to end then loop through.
		var cs2_Spider.Train ARMOR|MAGIC|ARMOR|LORE|ARMOR|SURVIVAL
		
		# Define what skills in each exp set you want to use. It will pick the highest one.
		# Skills need to be entered in completeness with CamelCase, spaces.
			# Using Spelltimer to determine learningRates to take highest one.
		var cs2_Spider.LORE Scholarship|Tactics|Appraisal
		var cs2_Spider.MAGIC Primary Magic|Arcana|Attunement
		var cs2_Spider.ARMOR Defending|Chain Armor|Light Armor
		var cs2_Spider.WEAPON Melee Mastery|Missle Mastery|Brawling|Offhand
		var cs2_Spider.SURVIVAL Skinning|Evasion|Perception
	}
	###########################################################################################################
	if (matchre("$charactername","SnarfSnarf")) then {
		# https://elanthipedia.play.net/Category:Skills
		# Define what skillsets you want to train (Options are: LORE|MAGIC|ARMOR|WEAPON|SURVIVAL)
		# Can be as many as you want, will go from beginning to end then loop through.
		var cs2_Spider.Train ARMOR|MAGIC|ARMOR|LORE
		
		# What learning rank must skill be above to be used by spider? (for ML only skills put 33)
		var cs2_Spider.MinSkill 32
	 
		# Define what skills in each exp set you want to use. It will pick the highest one.
		# Skills need to be entered in completeness with CamelCase, spaces.
			# Using Spelltimer to determine learningRates to take highest one.
		var cs2_Spider.LORE Scholarship|Tactics|Appraisal
		var cs2_Spider.MAGIC Primary Magic|Arcana|Attunement
		var cs2_Spider.ARMOR Defending|Chain Armor|Light Armor
		var cs2_Spider.WEAPON Melee Mastery|Missle Mastery|Brawling|Offhand
		var cs2_Spider.SURVIVAL Skinning|Evasion|Perception
	}
	###########################################################################################################
	# No touchy these...
	eval cs2_Spider.Train_length count("%cs2_Spider.Train","|")
	if !def(cs2_Spider.CurrentLocation) then put #var cs2_Spider.CurrentLocation 0
	#Check to make sure you're not past the end of the TrainList array
	if ($cs2_Spider.CurrentLocation > %cs2_Spider.Train_length) then put #var cs2_Spider.CurrentLocation 0
	if !def(cs2_Spider.NextUse) then put #var cs2_Spider.NextUse $gametime

	action put #var cs2_Spider.CurrentLocation {#evalmath ($cs2_Spider.CurrentLocation + 1)}; goto SPIDER_DETERMINE_SKILL when vary which skillset you select with every use.
	action var extra_wait_time $1 when is unresponsive.  It needs approximately (\d)
	###########################################################################################################
	
	
## *****
SPIDER_WAIT:
	# Subtracs gametime from last used time and waits that long.
	if ($gametime > $cs2_Spider.NextUse) then goto SPIDER_DETERMINE_SKILL
	else {
		evalmath tmp ($cs2_Spider.NextUse - $gametime)
		wait %tmp
		goto SPIDER_WAIT
	}
	
## *****
SPIDER_DETERMINE_SKILL:
	var tmp 0
			# Gets the current skillSet to train and shortens the variable to make it easier to use.
	var current_skillSet %cs2_Spider.Train($cs2_Spider.CurrentLocation)
			# Sets the length of the current skillSet array for comparison.
			# adds 1 as i'm doing an if X < length to get to end of string.
	eval current_skillSet_length count("%cs2_Spider.%current_skillSet","|")
	math current_skillSet_length add 1
			#Replaces spaces with a "_" so that Spelltimer.LearningRates will work for comparison.
			# Use this array for comparing LEarningRates on CurrentSKillset to use.
	eval tmp_skills_array replacere("%cs2_Spider.%current_skillSet", " ", "_")
			#Sets skill 0 as current high skill & LearningRate to have a baseline comparison.
	var current_skill %tmp_skills_array(%tmp)
	var current_highskill $%tmp_skills_array(%tmp).LearningRate
	## *****
	SPIDER_USE_SUB:
		#Get the skill with highest learningRate to sacrifice to the Spider God, ... spider.
		math tmp add 1
		if (%tmp < %current_skillSet_length) then {
			if ($%tmp_skills_array(%tmp).LearningRate > %current_highskill) then {
				var current_skill %tmp_skills_array(%tmp)
				var current_highskill $%tmp_skills_array(%tmp).LearningRate
				pause .1
			}
			goto SPIDER_USE_SUB
		}

	#Replaces the "_" back to a space so that the game recognizes the skill
	eval current_skill replacere("%current_skill", "_", " ")

	ECHO SKILL to use is %current_skill
	goto SPIDER_USE_SKILL
		
## *****
SPIDER_USE_SKILL:
	## *****
	SPIDER_TURN:
		matchre SPIDER_TURN Sorry, you may only type ahead 1 command.|your changes fail to lock into place.
		matchre SPIDER_TURNED your changes snap into place.
	send -1 turn my spider to %current_skill
	matchwait 3
	goto SPIDER_TURN
	
	## *****
	SPIDER_TURNED:
		matchre SPIDER_TURNED Sorry, you may only type ahead 1 command.
		matchre SPIDER_USED The spider comes alive in your hand
		matchre SPIDER_UNRESPONSIVE You try, but the harvester spider is unresponsive.
		matchre SPIDER_NOSKILLS_TOLEARN But you currently aren't learning any
	send -1 rub my spider
	matchwait 3
	GOTO SPIDER_TURNED
	
## *****	
SPIDER_USED:
	send #ECHO >WeaponOutput **SPIDER-%current_skill @time@**
	pause .5
	# Increment the SkillSet to use variable
	put #var cs2_Spider.CurrentLocation {#evalmath ($cs2_Spider.CurrentLocation + 1)}
	pause .5
	if ($cs2_Spider.CurrentLocation > %cs2_Spider.Train_length) then put #var cs2_Spider.CurrentLocation 0
	
	# Increment the NextUse timer variable
	put #var cs2_Spider.NextUse {#evalmath ($gametime + 630)};
	goto SPIDER_WAIT
	
## *****	
SPIDER_UNRESPONSIVE:
	# Spider is unresponsive, didn't wait long enough. So IMPATIENT!!!
	if (%extra_wait_time = 0) then var extra_wait_time 1
	evalmath extra_wait_time %extra_wait_time * 60
	math extra_wait_time add 10
	wait %extra_wait_time
	goto SPIDER_USE_SKILL
	
## *****	
SPIDER_NOSKILLS_TOLEARN:
	# The selected skill is empty, will try another skillset. 
	# Will also see if you have any exp to learn, if not it'll exit the script.
		matchre SPIDER_NOSKILLS_TOLEARN Sorry, you may only type ahead 1 command.
		matchre EXIT_OUT No skills have field experience or none meet your criteria!
	send -1 exp
	matchwait 15
	
	put #var cs2_Spider.CurrentLocation {#evalmath ($cs2_Spider.CurrentLocation + 1)}
	goto SPIDER_DETERMINE_SKILL
	
#You try, but the harvester spider is unresponsive.  It needs approximately 2 minutes to generate enough venom again.
