counter set 1

goto ASSESSCOMBAT


######echo FIRST MOVE: $combatmove1, SECOND MOVE: $combatmove2, THIRD MOVE: $combatmove3, FOURTH MOVE: $combatmove4

ASSESSCOMBAT:
#ECHO ######ASSESSCOMBAT FUNCTION

######	Matchre SETMOBCOUNTER ^You.*are facing.*\((\w+)\).*$
	Matchre SETMOBCOUNTER ^You.* (\w+)\b \((\w+)
	Matchre FACENEXT ^An|A.*\((?:1|2|3|4)\:.*range.
	Matchre WAIT5 You can't do that while entangled in a web.

	put asses

	Matchwait

FACENEXT:
#ECHO ######FACENEXT FUNCTION

	Match DEADTARGET There is nothing else to face!
	Match ASSESSCOMBAT You turn to face
	Match ADVANCE Face what?

	put face next

	Matchwait

SETMOBCOUNTER:
#ECHO ######SETMOBCOUNTER FUNCTION (MOBCOUNTER IS $2)

	if $2 = 1 then
		{
			setvariable mobcounter first
			#ECHO ###### LOOKING FOR %mobcounter MOB
		}

	if $2 = 2 then
		{
			setvariable mobcounter second
			#ECHO ###### LOOKING FOR %mobcounter MOB
		}

	if $2 = 3 then
		{
			setvariable mobcounter third
			#ECHO ###### LOOKING FOR %mobcounter MOB
		} 

	if $2 = 4 then
		{
			setvariable mobcounter fourth
			#ECHO ###### LOOKING FOR %mobcounter MOB
		}

	if $2 = 5 then
		{
			setvariable mobcounter fifth
			#ECHO ###### LOOKING FOR %mobcounter MOB
		}

	goto STOREMOB

######IDMOB:
#ECHO ######IDMOB

######	Matchre STOREMOB ^You.* (\w+)\b \(

######	put asses

######	Matchwait

STOREMOB:
#ECHO ######STOREMOB, STORING $1

	setvariable mob $1
	goto ANALYZEMOB

ANALYZEMOB:
#ECHO ######ANALYZEMOB

	Matchre STOREMOVES ^(?:\w+ reduction|A chance for a stun) can be inflicted (?:upon the enemy\s)?by landing (?:a(?:n)?) (\w+)(?:\, |\.| and )(?:a(?:n)?)?\s?(\w+)?(?:(?:\, |\.| and )(?:a(?:n)?) (\w+))?(?:(?:\, |\.| and )(?:a(?:n)?) (\w+))?
	Matchre FACENEXT already quite dead.|Analyze what?|I could not find what you were referring to.
	Match WAIT10 You can't do that while entangled in a web.
	Matchre WAIT2 ...wait|You fail to find any holes
	Matchre FACENEXT You must be closer to use tactical abilities on your opponent.

	put analyze %mobcounter %mob

	Matchwait

ADVANCE:
#ECHO ######ADVANCE FUNCTION

	put advance
	goto WAIT2

WAIT10:
#ECHO ######WAIT10

	pause 10
	goto ANALYZEMOB

WAIT2:
#ECHO ######WAIT2

	pause 2
	goto ANALYZEMOB

WAIT5:
#ECHO ######WAIT5

	pause 5
	goto ASSESSCOMBAT

STOREMOVES:
#ECHO ######STOREVARIABLES FUNCTION
if len("$1") > 1 then
		{
			setvariable combatmove1 $1
			#ECHO 1ST COMBATMOVE IS - %combatmove1 ($1)
		}
		else
		{
			setvariable combatmove1
			#ECHO 1ST COMBATMOVE DOES NOT EXIST ($1)
		}

if len("$2") > 1 then
		{
			setvariable combatmove2 $2
			#ECHO 2ND COMBATMOVE IS - %combatmove2 ($2)
		}
		else
		{
			setvariable combatmove2
			#ECHO 2ND COMBATMOVE DOES NOT EXIST ($2)
		}

if len("$3") > 1 then
		{
			setvariable combatmove3 $3
			#ECHO 3RD COMBATMOVE IS - %combatmove3 ($3)
		}
		else
		{
			setvariable combatmove3
			#ECHO 3RD COMBATMOVE DOES NOT EXIST ($3)
		}

if len("$4") > 1 then
		{
			setvariable combatmove4 $4
			#ECHO 4TH COMBATMOVE IS - %combatmove4 ($4)
		}
		else
		{
			setvariable combatmove4
			#ECHO 4TH COMBATMOVE DOES NOT EXIST ($4)
		}

COMBATMOVE1:
#ECHO ######COMBATMOVE1
COMBATMOVE2:
#ECHO ######COMBATMOVE2
COMBATMOVE3:
#ECHO ######COMBATMOVE3
COMBATMOVE4:
#ECHO ######COMBATMOVE4
#ECHO ######COUNTER IS %c, DOING %combatmove%c
#ECHO FIRST MOVE: %combatmove1, SECOND MOVE: %combatmove2, THIRD MOVE: %combatmove3, FOURTH MOVE: %combatmove4

	Match PAUSE ...wait
	Match PAUSE5 You can't do that while entangled in a web.
	Matchre ENDFUN Utilizing good tactics you outmaneuver
	Matchre DEADTARGET after a couple of spasms, is still.|already quite dead.
##	Matchre PAUSE lands a gentle hit|lands a grazing blow|lands a grazing strike
##	Matchre PAUSE evade, receiving a glancing blow|dodge, receiving a glancing blow
##	Matchre PAUSE lands a harmless strike|lands a harmless blow|lands an ineffective strike|lands a skimming strike
##	Matchre PAUSE evades, barely|evades, leaning|evades, stepping|evades, just |evades, ducking|barely blocks with
##	Matchre PAUSE dodges, barely|dodges, leaning|dodges, stepping|dodges, just |dodges, ducking
##	Matchre PAUSE beats off little
	Matchre COUNTERADD lands a light hit|lands a good hit|lands a good strike|lands a solid hit|lands a hard hit
	Matchre COUNTERADD lands a strong hit|lands a heavy strike|lands a very heavy hit|lands an extremely heavy hit
	Matchre COUNTERADD lands a powerful strike|lands a massive strike|lands an awesome strike|lands a vicious strike
	Matchre COUNTERADD lands an earth-shaking strike|lands a demolishing hit|lands a spine-rattling strike|lands a devastating hit
	Matchre COUNTERADD lands an overwhelming strike|lands an obliterating hit|lands an annihilating strike
	Matchre COUNTERADD lands a cataclysmic strike|lands an apocalyptic strike
	Match PAUSE [Roundtime
	Matchre FACENEXT Face what?

	put %combatmove%c

	matchwait


< With the precision and elegance of a plunging goshawk, you punch your rencate knuckle at an adult desert armadillo.  An adult desert armadillo attempts to dodge, receiving a glancing blow.  
The knuckle lands a solid hit to the armadillo's right leg.

PAUSE:
#ECHO ######PAUSE FUNCTION
	pause .5
	goto COMBATMOVE%c

PAUSE5:
#ECHO ######PAUSE 5 FUNCTION
	pause 5
	goto COMBATMOVE%c

COUNTERADD:
#ECHO ######COUNTERADD FUNCTION
	counter add 1
	goto COMBATMOVECHECK

COMBATMOVECHECK:
#ECHO ######COMBATMOVECHECK FUNCTION (COUNTER IS = %c, GOING TO DO = %combatmove%c VIA COMBATMOVE%c)
	if len("%combatmove%c") > 1 then
		{
			#ECHO ######GOING TO COMBATMOVE%c
			goto COMBATMOVE%c
		}
		else
		{
			#ECHO ######GOING TO COMBATEND
			goto COMBATEND
		}

COMBATMOVE5:
#ECHO ######COMBATMOVE5
COMBATEND:
#ECHO ######COMBATEND
	#ECHO ####################################################
	#ECHO NO ADDITIONAL COMBAT MOVES LEFT! MANEUVERS COMPLETED
	#ECHO ####################################################
	goto ENDFUN

DEADTARGET:
#ECHO ######DEADTARGET
	ECHO #########################################
	ECHO YOUR MOB IS DEAD, LOOKING FOR ANOTHER ONE
	ECHO #########################################
	goto ENDFUN

ENDFUN:
#ECHO ######ENDFUN
	put exp tactics
	put loot
	pause 2
	counter set 1
	goto ASSESSCOMBAT

 
