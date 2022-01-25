#### UTILITY SUBS
#### Version 5.6
#### Last Update: 06 July, 2018
####
#### Thanks to Shroom, Kathris, Tulkas, Dasffion, Achilles, and others I've likely forgotten for input.
####
#### EMPTY HANDS SUB
EMPTY_HANDS:
     delay 0.0001
     if ("$lefthand" != "Empty") then gosub STOW my $lefthandnoun
     if ("$righthand" != "Empty") then gosub STOW my $righthandnoun
     return
#### EMPTY LEFT HAND
EMPTY_LEFT:
     delay 0.0001
     var LOCATION EMPTY_LEFT_1
     EMPTY_LEFT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You drop
     matchre RETURN ^Having no further use for .*\, you discard it\.
     matchre RETURN ^Your left hand is already empty\.
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^Please rephrase that command\.
     matchre RETURN ^I could not find what you were referring to\.
     send empty left
     matchwait
#### EMPTY RIGHT HAND
EMPTY_RIGHT:
     delay 0.0001
     var LOCATION EMPTY_RIGHT_1
     EMPTY_RIGHT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You drop
     matchre RETURN ^Having no further use for .*\, you discard it\.
     matchre RETURN ^Your right hand is already empty\.
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^Please rephrase that command\.
     matchre RETURN ^I could not find what you were referring to\.
     send empty right
     matchwait
### ORDERING SUB, FOR SHOPS
ORDER:
     delay 0.0001
     var order $0
     var LOCATION ORDER_1
     ORDER_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre ORDER_1 ^The attendant says\,\s*\"You can purchase .*\.\s*Just order it again and we'll see it done\!\"
     matchre RETURN ^The attendant takes some coins from you and hands you .*\.
     send order %order
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN ORDER! (utility.inc) ***
     put #echo >$Log Crimson $datetime Order = %order
     put #log $datetime MISSING MATCH IN ORDER! (utility.inc)
     return
#### PUT SUB
PUT:
     delay 0.0001
     var command $0
     var LOCATION PUT_1
     PUT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre PUT_STOW ^You need a free hand to pick that up\.
     matchre PUT_STAND ^You should stand up first\.|^Maybe you should stand up\.
     matchre WAIT ^\[Enter your command again if you want to\.\]
     matchre RETURN_CLEAR ^.*Roundtime\s*\:?
     matchre RETURN_CLEAR ^.*\[Roundtime\s*\:?
     matchre RETURN_CLEAR ^.*\(Roundtime\s*\:?
     matchre RETURN_CLEAR ^.*\[Praying for \d+ sec\.\]
     matchre RETURN_CLEAR ^You cannot do that while engaged\!
     matchre RETURN_CLEAR ^I could not find what you were referring to\.
     matchre RETURN_CLEAR ^Please rephrase that command\.
     matchre RETURN_CLEAR ^That (?:is|has) already
     matchre RETURN_CLEAR ^What were you referring to\?
     matchre RETURN_CLEAR ^In the name of love\?
     matchre RETURN_CLEAR ^.* what\?
     matchre RETURN_CLEAR ^I don\'t
     matchre RETURN_CLEAR ^(\S+) has accepted
     matchre RETURN_CLEAR ^You (?:hand|push|move|put|whisper|lean|tap|drop|place|knock|toss|set|add|search|circle|fake|slip|weave|shove|try|must|wave|sit|fail|turn|are already|can\'t|glance|bend|kneel|carefully|quietly|sense|begin|rub|sprinkle|stop|combine|take|decide|insert|lift|retreat|load|open|fumble|exhale|allow|have|are|wring|aren\'t|scan|vigorously|adjust|bundle|ask|form|get|lose|remove|pull|accept|slide|wear|sling|pick|silently|realize|open|close|grab|fade|offer|aren't|kneel|don\'t|close|let|find|attempt|tie|roll|attach|feel|read|come|count|.*analyze|relax|awaken) .*(?:\.|\!|\?)?
     matchre RETURN_CLEAR ^You sense that you are as pure of spirit as you can be\, and you are ready for whatever rituals might face you\.
     matchre RETURN_CLEAR ^Subservient type|^The shadows|^Close examination|^Try though
     matchre RETURN_CLEAR ^USAGE\:
     matchre RETURN_CLEAR ^Allows a Moon Mage
     matchre RETURN_CLEAR ^A slit across the door
     matchre RETURN_CLEAR ^Your (?:actions|dance|nerves) .*(?:\.|\!|\?)?
     matchre RETURN_CLEAR ^Having no further use for .*\, you discard it\.
     matchre RETURN_CLEAR ^Brother Durantine|^Durantine|^Mags|^Ylono|^Malik|^Kilam|^Ragge|^(?:An?|The) attendant|^(?:An?|The) clerk|^(?:An?|The) Teller|^(?:An?|The).*spider|^.*He says\,
     matchre RETURN_CLEAR ^After a moment\, .*\.
     matchre RETURN_CLEAR ^.* (?:is|are) not in need of cleaning\.
     matchre RETURN_CLEAR ^Quietly touching your lips with the tips of your fingers as you kneel\, you make the Cleric's sign with your hand\.
     matchre RETURN_CLEAR ^You hear a soft voice say\, \"Thou should first attend to thy own woes before seeking to help others\.\"
     matchre RETURN_CLEAR ^The gem pouch
     matchre RETURN_CLEAR ^The .* is not damaged enough to warrant repair\.
     matchre RETURN_CLEAR ^There is no more room in .*\.
     matchre RETURN_CLEAR \[Type INVENTORY HELP for more options\]
     matchre RETURN_CLEAR ^There is nothing in there\.
     matchre RETURN_CLEAR ^A vortex
     matchre RETURN_CLEAR ^In a flash
     matchre RETURN_CLEAR ^An aftershock
     matchre RETURN_CLEAR ^The waters
     matchre RETURN_CLEAR ^In the .* you see .*\.
     matchre RETURN_CLEAR ^That is closed\.
     matchre RETURN_CLEAR ^This spell cannot be targeted\.
     matchre RETURN_CLEAR ^You cannot figure out how to do that\.
     matchre RETURN_CLEAR ^You will now store .* in your .*\.
     matchre RETURN_CLEAR ^That tool does not seem suitable for that task\.
     matchre RETURN_CLEAR ^There isn't any more room in .* for that\.
     matchre RETURN_CLEAR ^\[Ingredients can be added by using ASSEMBLE Ingredient1 WITH Ingredient2\]
     matchre RETURN_CLEAR ^\s*LINK ALL CANCEL\s*\- Breaks all links
     matchre RETURN_CLEAR ^This ritual may only be performed on a corpse\.
     matchre RETURN_CLEAR ^There is nothing else to face\!
     matchre RETURN_CLEAR ^Stalking is an inherently stealthy endeavor\, try being out of sight\.
     matchre RETURN_CLEAR ^You're already stalking
     matchre RETURN_CLEAR ^There aren't any .*\.
     matchre RETURN_CLEAR ^You don't think you have enough focus to do that\.
     matchre RETURN_CLEAR ^You have no idea how to cast that spell\.
     matchre RETURN_CLEAR ^An offer
     matchre RETURN_CLEAR ^Obvious (?:exits|paths)
     matchre RETURN_CLEAR ^But the merchant can't see you|are invisible
     matchre RETURN_CLEAR ^The book|Page|^The sconce|^As the world|^The voice|^A ravenous energy
     matchre RETURN_CLEAR ^In the|^The attendant|^That is already open\.|^Your inner
     matchre RETURN_CLEAR ^(\S+) hands you|^Searching methodically|^But you haven\'t prepared a symbiosis\!
     matchre RETURN_CLEAR ^Illustrations of complex\,|^It is labeled|^Your nerves
     matchre RETURN_CLEAR ^The lockpick|^Doing that|is not required to continue crafting
     # matchre RETURN_CLEAR ^
     matchre RETURN ^\s*Encumbrance\s*\:
     send %command
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN PUT! (utility.inc) ***
     put #echo >$Log Crimson $datetime Command = %command
     put #log $datetime MISSING MATCH IN PUT (utility.inc)
     return
PUT_STOW:
     delay 0.0001
     gosub EMPTY_HANDS
     goto PUT_1
PUT_STAND:
     delay 0.0001
     gosub STAND
     goto PUT_1
#### GET SUB
GET:
     delay 0.0001
     var get $0
     var LOCATION GET_1
     GET_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre WAIT ^You struggle with .* great weight but can't quite lift it\!
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre HOLD_1 ^But that is already in your inventory\.
     matchre RETURN ^Get what\?
     matchre RETURN ^I could not find what you were referring to\.
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^You (?:get|grab|pick|carefully|are already) .*(?:\.|\!|\?)?
     matchre RETURN ^As best it can\, .* moves in your direction\.
     send get %get
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN GET! (utility.inc) ***
     put #echo >$Log Crimson $datetime Get = %get
     put #log $datetime MISSING MATCH IN GET (utility.inc)
     return
#### HOLD SUB
HOLD:
     delay 0.0001
     var get $0
     var LOCATION HOLD_1
     HOLD_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre WAIT ^You struggle with .* great weight but can't quite lift it\!
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre RETURN ^You (?:sling|work|loosen|get|take|pull|remove|are already|slide) .*(?:\.|\!|\?)?
     matchre RETURN ^Get what\?
     matchre RETURN ^Hold hands with whom\?
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^I could not find what you were referring to\.
     send hold %get
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN HOLD! (utility.inc) ***
     put #echo >$Log Crimson $datetime Get = %get
     put #log $datetime MISSING MATCH IN HOLD (utility.inc)
     return
#### STOW SUB
STOW:
     delay 0.0001
     var stow $0
     var LOCATION STOW_1
     STOW_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre WEAR_1 ^.* is too long to fit in .*\.
     matchre RETURN ^You put .*\.
     matchre RETURN ^You pick up
     matchre RETURN ^You open your pouch and put .* inside\, closing it once more\.
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^Stow what\?  Type 'STOW HELP' for details\.
     send stow %stow
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN STOW! (utility.inc) ***
     put #echo >$Log Crimson $datetime Stow = %stow
     put #log $datetime MISSING MATCH IN STOW (utility.inc)
     return
#### WEAR SUB
WEAR:
     delay 0.0001
     var stow $0
     var LOCATION WEAR_1
     WEAR_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre STOW_1 ^You can't wear that\!
     matchre STOW_1 ^You can't wear any more items like that\.
     matchre STOW_1 ^You need at least one free hand for that\.
     matchre STOW_1 ^This .* can't fit over the .* you are already wearing which also covers and protects your .*\.
     matchre RETURN ^You (?:sling|put|slide|slip|attach|work|strap|hang|are already) .*(?:\.|\!|\?)?
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^Wear what\?
     send wear %stow
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN WEAR! (utility.inc) ***
     put #echo >$Log Crimson $datetime Stow = %stow
     put #log $datetime MISSING MATCH IN WEAR (utility.inc)
     return
#### DOUBLE PUT SUB
PUT_IT:
     delay 0.0001
     var putit $0
     var LOCATION PUT_IT_1
     PUT_IT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre RETURN ^You (?:put|drop|set|carefully) .*\.
     matchre RETURN ^That's too heavy to go in there\!
     matchre RETURN ^Please rephrase that command\.
     matchre RETURN ^.* what\?
     matchre RETURN ^I could not find what you were referring to\.
     matchre RETURN ^There isn't any more room in .* for that\.
     matchre RETURN ^What were you referring to\?
     send put %putit
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN PUT_IT! (utility.inc) ***
     put #echo >$Log Crimson $datetime PutIt = %putit
     put #log $datetime MISSING MATCH IN PUT_IT (utility.inc)
     return
#### ITEM SWAP SUB
SWAP:
     delay 0.0001
     var LOCATION SWAP_1
     SWAP_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre RETURN ^You move
     matchre RETURN ^You have nothing to swap\!
     send swap
     matchwait
#### COMBAT ATTACK SUBS
ATTACK:
     delay 0.0001
     if ($stamina < 85) then gosub STAMINA_WAIT
     var LOCATION ATTACK_1
     ATTACK_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre RETURN ^You can not slam with .*\!
     matchre RETURN ^There is nothing else to face
     matchre RETURN ^You aren't close enough to attack
     matchre RETURN ^You turn to face
     matchre RETURN ^You spin around to face
     matchre RETURN ^You stop advancing because
     matchre RETURN ^At what are you trying to .*\?
     matchre RETURN ^You need two hands to wield this weapon\!
     send attack
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN ATTACK! (utility.inc) ***
     put #log $datetime MISSING MATCH IN ATTACK (utility.inc)
     goto ATTACK
DRAW:
     delay 0.0001
     var LOCATION DRAW_1
     DRAW_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre RETURN ^There is nothing else to face
     matchre RETURN ^You aren't close enough to attack
     matchre RETURN ^You turn to face
     matchre RETURN ^You spin around to face
     matchre RETURN ^You stop advancing because
     matchre RETURN ^At what are you trying to .*\?
     send draw
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN DRAW! (utility.inc) ***
     put #log $datetime MISSING MATCH IN DRAW (utility.inc)
     goto DRAW
#### DODGE AND PARRY
DODGE:
     delay 0.0001
     var LOCATION DODGE_1
     DODGE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre RETURN ^But you are already dodging\!
     matchre RETURN ^You move into a position to dodge\.
     # matchre DODGE ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send dodge
     matchwait
PARRY:
     delay 0.0001
     var LOCATION PARRY_1
     PARRY_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre RETURN ^You are already in a position to parry\.
     matchre RETURN ^You move into a position to parry\.
     # matchre PARRY ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send parry
     matchwait
#### WAIT FOR STAMINA
STAMINA_WAIT:
     delay 0.0001
     put #echo Crimson **************************************************
     put #echo Crimson ***** STAMINA IS LOW.  WAITING TO REGAIN IT. *****
     put #echo Crimson **************************************************
     if ($stamina < 85) then waiteval ($stamina > 90)
     return
#### RANGED ATTACK SUBS
LOAD:
     delay 0.0001
     if (!$standing) then gosub STAND
     var LOCATION LOAD_1
     LOAD_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned\.
     matchre WEBBED ^You can't do that while entangled in a web\.
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre AIM ^You reach into your .* to load .*\.
     matchre AIM ^You load .* in your hand\.
     matchre AIM ^.* is already loaded with
     matchre LOAD_RETRIEVE ^You don't have the (?:right|proper) ammunition
     matchre LOAD_RETRIEVE ^As you try to
     matchre LOAD_STOW ^.* in your left hand
     send load
     matchwait
LOAD_STOW:
     delay 0.0001
     gosub STOW left
     goto LOAD
LOAD_RETRIEVE:
     delay 0.0001
     gosub RETRIEVE_CHECK
     goto LOAD
AIM:
     delay 0.0001
     if (!$standing) then gosub STAND
     if ($hidden) && ("$Guild" = "Paladin") then gosub UNHIDE
     var LOCATION AIM_1
     AIM_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned\.
     matchre WEBBED ^You can't do that while entangled in a web\.
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre AIM_WAIT ^You begin to target
     matchre AIM_WAIT ^You are already targetting that\!
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre RETURN ^I could not find what you were referring to\.
     matchre RETURN ^What are you trying to attack\?
     matchre RETURN ^\[You're .*balanced?\]
     matchre RETURN ^There is nothing else to face
     matchre RETURN ^You aren't close enough to attack
     matchre RETURN ^You turn to face
     matchre RETURN ^You spin around to face
     matchre RETURN ^You stop advancing because
     send aim
     matchwait
AIM_WAIT:
     delay 0.0001
     matchre FIRE ^You think you have your best shot possible now\.
     matchre AIM ^You stop concentrating on aiming your weapon\.
     matchwait
FIRE:
     delay 0.0001
     if (!$standing) then gosub STAND
     var LOCATION FIRE_1
     FIRE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned\.
     matchre WEBBED ^You can't do that while entangled in a web\.
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre FIRE_1 ^How can you poach if you are not hidden\?
     matchre RETURN ^You were aiming at a different target\, but you fire anyway\.
     matchre RETURN ^I could not find what you were referring to\.
     matchre RETURN ^\[You're .*balanced?\]
     matchre RETURN ^There is nothing else to face
     matchre RETURN ^You aren't close enough to attack
     matchre RETURN ^You turn to face
     matchre RETURN ^You spin around to face
     matchre RETURN ^You stop advancing because
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     if ($hidden) then send poach
     else send fire
     matchwait
#### FACING SUBS
FACE:
     delay 0.0001
     gosub FACE_NEXT
     goto RETURN
FACE_NEXT:
     delay 0.0001
     var LOCATION FACE_NEXT_1
     FACE_NEXT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre RETURN ^You turn
     matchre RETURN ^There is nothing else to face\!
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^Face what\?
     send face next
     matchwait
#### TM SPELL SUBS
TARGET_PREP:
     delay 0.0001
     var targetprep $0
     var LOCATION TARGET_PREP_1
     TARGET_PREP_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre WEBBED ^You can't do that while entangled in a web
     matchre STUNNED ^You are still stunned
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre TARGET_RELEASE ^You are not engaged to anything\, so you must specify a target to focus on\!
     matchre TARGET_RELEASE ^There is no need to target a .*\.  It is already dead\.
     matchre TARGET_RELEASE ^I could not find what you were referring to\.
     matchre TARGET_RELEASE ^This spell cannot be targeted\.
     matchre RETURN ^You begin to weave mana lines into a target pattern around .*\.
     matchre RETURN ^You begin chanting a psalm to invoke the .* spell\.
     send target %targetprep
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN TARGET_PREP! (utility.inc) ***
     put #log $datetime MISSING MATCH IN TARGET_PREP (utility.inc)
     return
TARGET_WAIT:
     delay 0.0001
     matchre TARGET_RELEASE ^Your concentration slips for a moment, and your spell is lost\.
     matchre TARGET_RELEASE ^Your secondary spell pattern dissipates because your target is dead, but the main spell remains intact\.
     matchre TARGET_RELEASE ^Your target pattern dissipates because .* is dead\, but the main spell remains intact\.
     matchre TARGET_RELEASE ^Your pattern dissipates with the loss of your target\.
     matchre TARGET_CAST ^You feel fully prepared to cast your spell\.
     matchre TARGET_CAST ^Your target pattern has finished forming around the area\.
     matchre TARGET_CAST ^The formation of the target pattern around .* has completed\.
     matchre TARGET_CAST ^Your formation of a targeting pattern around .* has completed\.
     matchwait
TARGET_CAST:
     delay 0.0001
     var LOCATION TARGET_CAST_1
     TARGET_CAST_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre CALMED ^Strangely\, you don\'t feel like fighting right now\.
     matchre TARGET_RELEASE ^You don't have a spell prepared\!
     matchre TARGET_RELEASE ^.* is already dead, so that's a bit pointless\.
     matchre TARGET_RELEASE ^Your secondary spell pattern dissipates because your target is dead, but the main spell remains intact\.
     matchre TARGET_RELEASE ^Your target pattern dissipates because the .* is dead\, but the main spell remains intact\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre RETURN ^Focus the power of justice on whom\?
     matchre RETURN ^You gesture
     put -cast;-2 gesture
     matchwait
TARGET_RELEASE:
     delay 0.0001
     gosub RELEASE
     return
#### HUNT SUB
HUNT:
     delay 0.0001
     var LOCATION HUNT_1
     HUNT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You find yourself unable to hunt in this area\.
     matchre RETURN ^You take note of all the tracks in the area\, so that you can hunt anything nearby down\.
     send hunt
     matchwait
#### CRITTER APPRAISAL
APPRAISE_CRITTER:
     pause 0.0001
     if (!$monstercount) then return
     var critterList $monsterlist
     eval critterList replace("%critterList", ", ", "|")
     eval critterList replace("%critterList", " and ", "|")
     eval critterList replace("%critterList", " that is lying down", "")
     eval critterList replace("%critterList", " that appears stunned", "")
     eval critterList replace("%critterList", " that is sleeping", "")
     eval critterList replace("%critterList", " that appears rather calm", "")
     eval critterList replace("%critterList", " which appears dead", "")
     var critterList |%critterList|
     eval total count("%critterList", "|")
     eval Critter element("%critterList", 1)
     eval Critter replacere("%Critter", "\S+\s", "")
     APPRAISE_CRITTER_1:
     pause 0.0001
     var LOCATION APPRAISE_CRITTER_2
     APPRAISE_CRITTER_2:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^It's dead\!
     matchre RETURN ^Appraise what\?
     matchre RETURN ^You cannot appraise that when you are in combat\!
     matchre RETURN ^You can't determine anything about this creature\.
     matchre RETURN ^You ponder that\, briefly\, but decide to let it go for now\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send appraise %Critter careful
     matchwait 10
     return
##### APPRAISAL SUB
APPRAISE:
     delay 0.0001
     var appraise $0
     var LOCATION APPRAISE_1
     APPRAISE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^It's dead\!
     matchre RETURN ^Appraise what\?
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^You cannot appraise that when you are in combat\!
     matchre RETURN ^You can't determine anything about this creature\.
     matchre RETURN ^It's hard to appraise the .* when it's inside something\.
     matchre RETURN ^Appraise what\?  Type APPRAISE HELP for more information\.
     matchre RETURN ^You ponder that\, briefly\, but decide to let it go for now\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send appraise %appraise
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN APPRAISE! (utility.inc) ***
     put #echo >$Log Crimson $datetime Appraise = %appraise
     put #log $datetime MISSING MATCH IN APPRAISE! (utility.inc)
     return
#### STUDYING SUB
STUDY:
     delay 0.0001
     var study $0
     var LOCATION STUDY_1
     STUDY_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send study %study
     matchwait
#### HIDING SUB
HIDE:
     delay 0.0001
     var hideCounter 0
     var LOCATION HIDE_1
     HIDE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre HIDE_INCREMENT ^.* notices your attempt to hide\!
     matchre HIDE_INCREMENT ^.* reveals you, ruining your hiding attempt\!
     matchre HIDE_INCREMENT ^.* discovers you, ruining your hiding place\!
     matchre RETURN ^You slip into a hiding
     matchre RETURN ^You melt into the background
     matchre RETURN ^Eh\?  But you're already hidden\!
     matchre RETURN ^You blend in with your surroundings
     send hide
     matchwait
HIDE_INCREMENT:
     delay 0.0001
     math hideCounter add 1
     if %hideCounter > 1 then return
     goto HIDE_1
#### UNHIDING SUB
UNHIDE:
     delay 0.0001
     var LOCATION UNHIDE_1
     UNHIDE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^But you are not hidden\!
     matchre RETURN ^You come out of hiding\.
     send unhide
     matchwait
##### STANDING SUB
STAND:
     delay 0.0001
     var LOCATION STAND_1
     STAND_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre WAIT ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre WAIT ^The weight of all your possessions prevents you from standing\.
     matchre WAIT ^You are overburdened and cannot manage to stand\.
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre STAND_RETURN ^You stand (?:back )?up\.
     matchre STAND_RETURN ^You are already standing\.
     matchre STAND_RETURN ^As you stand
     send stand
     matchwait
     STAND_RETURN:
     pause 0.1
     pause 0.1
     if (!$standing) then goto STAND
     return
#### UNLOAD RANGED SUB
UNLOAD:
     delay 0.0001
     var LOCATION UNLOAD_1
     UNLOAD_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You unload .*\.
     matchre RETURN ^But your .* isn't loaded\!
     matchre RETURN ^You don't have a ranged weapon to unload\.
     matchre RETURN ^You must be holding the weapon to do that\.
     send unload
     matchwait
#### WEAPON MANAGEMENT SUBS
WIELD:
     delay 0.0001
     var item $0
     var LOCATION WIELD_1
     WIELD_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You draw
     matchre RETURN ^You're already holding .*\!
     matchre RETURN ^Your .* is too injured to draw .*\!
     matchre REMOVE_WEAPON ^Wield what\?
     matchre REMOVE_WEAPON ^What were you referring to\?
     matchre REMOVE_WEAPON ^You're wearing a.*\!  You'll need to remove it first\!
     send wield %item
     matchwait
REMOVE_WEAPON:
     delay 0.0001
     var LOCATION REMOVE_WEAPON_1
     REMOVE_WEAPON_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^Remove what\?
     matchre RETURN ^What were you referring to\?
     matchre RETURN ^You remove .* from your belt\.
     matchre RETURN ^You sling .* off from over your shoulder\.
     send remove %item
     matchwait
SHEATH:
     delay 0.0001
     var item $0
     var LOCATION SHEATH_1
     SHEATH_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You slip
     matchre RETURN ^You sheathe
     matchre RETURN ^Sheathe what\?
     matchre RETURN ^Sheathe your.*where\?
     matchre RETURN ^A .* is too long to fit in .*\.
     matchre RETURN ^The .* is too long to fit in .*\.
     send sheath %item
     matchwait
#### BUNDLE COUNTING SUBS
BUNDLE_COUNT:
     delay 0.0001
     var LOCATION BUNDLE_COUNT_1
     BUNDLE_COUNT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre BUNDLE_SET_ZERO ^What were you referring to\?
     matchre BUNDLE_SET_ZERO ^I could not find what you were referring to\.
     matchre BUNDLE_SET ^You flip through .* and find (\d+) skins? in it\.
     send count my bundle
     matchwait
BUNDLE_SET:
     delay 0.0001
     put #tvar bundleFull 0
     put #tvar bundleCount $1
     if ($bundleCount > 199) then put #tvar bundleFull 1
     return
BUNDLE_SET_ZERO:
     delay 0.0001
     put #tvar bundleFull 0
     put #tvar bundleCount 0
     return
#### FORAGING SUBS
FORAGE:
     delay 0.0001
     var forage $0
     var LOCATION FORAGE_1
     FORAGE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You manage to find .*\.
     matchre RETURN ^The room is too cluttered to find anything here\!
     matchre RETURN ^You really need to have at least one hand free to forage properly\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send forage %forage
     matchwait
COLLECT:
     delay 0.0001
     var collect $0
     var LOCATION COLLECT_1
     COLLECT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You cannot collect anything while in combat\!
     matchre RETURN ^You manage to collect a pile of .*\.
     matchre RETURN ^The room is too cluttered to find anything here\!
     matchre RETURN ^You survey the area and realize that any collecting efforts would be futile\.
     matchre WAIT ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     send collect %collect
     matchwait
KICKEM:
     delay 0.0001
     if matchre("$roomobjs" , "a pile of \S+") then gosub KICKIT
     if matchre("$roomobjs" , "a pile of \S+") then gosub KICKIT
     return
KICKIT:
     delay 0.0001
     var LOCATION KICKIT_1
     KICKIT_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre KICKIT_STAND ^You can't do that from your position\.
     matchre KICKIT_STAND ^You can't quite manage to kick while sitting\.
     matchre RETURN ^I could not find what you were referring to\.
     matchre RETURN ^You take a step back and run up to the pile of .*\.
     send kick pile
     matchwait
KICKIT_STAND:
     delay 0.0001
     if ($standing) then goto KICKIT
     gosub STAND
     goto KICKIT_STAND
#### SPELL CASTING
PREPARE:
     delay 0.0001
     var prepare $0
     var LOCATION PREPARE_1
     PREPARE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre SPELL_CAST_RETURN ^With a resounding .*\!
     matchre SPELL_CAST_RETURN ^You begin to chant .*\.
     matchre SPELL_CAST_RETURN ^With a sharp cut to your voice\, .*\.
     matchre SPELL_CAST_RETURN ^Slow\, rich tones form a somber introduction .*
     matchre SPELL_CAST_RETURN ^You are already preparing the .* spell\!
     matchre SPELL_CAST_RETURN ^You begin chanting .* to invoke the .* spell\.
     matchre SPELL_CAST_RETURN ^You mutter .* to yourself while preparing the .* spell\.
     matchre SPELL_CAST_RETURN ^With .* movements you prepare your body for the .* spell\.
     matchre SPELL_CAST_RETURN ^You raise your .* skyward\, chanting the .* of the .* spell\.
     matchre SPELL_CAST_RETURN ^You trace .* sigil in the air\, shaping the pattern of the .* spell\.
     matchre SPELL_CAST_RETURN ^You rock back and forth\, humming tunelessly as you invoke the .* spell\.
     matchre SPELL_CAST_RETURN ^The wailing of lost souls accompanies your preparations of the .* spell\.
     matchre SPELL_CAST_RETURN ^Your eyes darken to black as a starless night as you prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^You close your eyes and breathe deeply, gathering energy for the .* spell\.
     matchre SPELL_CAST_RETURN ^Your eyes darken to black as a starless night as you prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^The wailing of lost souls accompanies your preparations of the .* spell\.
     matchre SPELL_CAST_RETURN ^A soft breeze surrounds your body as you confidently prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^Tiny tendrils of lightning jolt between your hands as you prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^Heatless orange flames blaze between your fingertips as you prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^Entering a trance-like state\, your hands begin to tremble as you prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^You adeptly sing the incantations for the .* spell\, setting the words to a favorite tune\.
     matchre SPELL_CAST_RETURN ^You bring your hand slowly to your forehead as you begin chanting the words of the .* spell\.
     matchre SPELL_CAST_RETURN ^Low\, hummed tones form a soft backdrop for the opening notes of the Eye of Kertigen enchante\.
     matchre SPELL_CAST_RETURN ^Icy blue frost crackles up your arms with the ferocity of a blizzard as you begin to prepare the .* spell\!
     matchre SPELL_CAST_RETURN ^You have to strain to harness the energy for this spell, and you aren't sure you can get enough to cast it\.
     matchre SPELL_CAST_RETURN ^You giggle to yourself as you move through the syncopated gestures that accompany the preparations of the .* spell\.
     matchre SPELL_CAST_RETURN ^Darkly gleaming motes of sanguine light swirl briefly about your fingertips as you gesture while uttering the .* spell\.
     matchre SPELL_CAST_RETURN ^As you begin to solemnly intone the .* spell a blue glow swirls about forming a nimbus that surrounds your entire being\.
     matchre SPELL_CAST_RETURN ^Your skin briefly withers and tightens\, becoming gaunt as the energies of the .* spell begin to build up through your body\.
     matchre SPELL_CAST_RETURN ^You trace an intricate rune in the air with your finger\, illusory lines lingering several seconds as you prepare the .* spell\.
     matchre SPELL_CAST_RETURN ^You begin reciting a solemn incantation\, causing familiar patterns of geometric shapes to circle your hand as the .* spell forms\.
     matchre SPELL_CAST_RETURN ^You take up a handful of dirt in your palm to prepare the .* spell\.  As you whisper arcane words\, you gently blow the dust away and watch as it becomes swirling motes of glittering light that veil your hands in a pale aura\.
     matchre SPELL_CAST_RETURN ^You recall the exact details of the .* symbiosis\, preparing to integrate it with the next spell you cast\.
     matchre SPELL_CAST_RETURN ^But you've already prepared the .* symbiosis\!
     matchre SPELL_CAST_DONE ^What do you want to prepare\?
     matchre SPELL_CAST_DONE ^That is not a spell you can cast\.
     matchre SPELL_CAST_DONE ^You have no idea how to cast that spell\.
     matchre SPELL_CAST_DONE ^You wouldn't have the first clue how to do that\.
     matchre SPELL_CAST_DONE ^You stop\, convinced that there's no way to control that much mana\.
     matchre SPELL_CAST_FAIL ^You have to strain to harness the energy for this spell, and you aren't sure you can get enough to cast it\.
     matchre SPELL_CAST_FAIL ^You feel intense strain as you try to manipulate the mana streams to form this pattern\, and you are not certain that you will have enough mental stamina to complete it\.
     send prepare %prepare
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN PREPARE! (utility.inc) ***
     put #echo >$Log Crimson $datetime Prepare = %prepare
     put #log $datetime MISSING MATCH IN PREPARE! (utility.inc)
     goto SPELL_CAST_RETURN
SPELL_WAIT:
     delay 0.0001
     if ("$preparedspell" = "None") then return
     matchre SPELL_CAST ^You feel fully prepared to cast your spell\.
     matchre SPELL_CAST_FAIL ^Your concentration slips for a moment\, and your spell is lost\.
     matchwait
SPELL_CAST:
     delay 0.0001
     var LOCATION SPELL_CAST_1
     SPELL_CAST_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre SPELL_CAST_DONE ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre SPELL_CAST_DONE ^You wave your hand\.
     matchre SPELL_CAST_DONE ^You gesture\.
     matchre SPELL_CAST_DONE ^Focus the power of justice on whom\?
     matchre SPELL_CAST_DONE ^A brilliant silver glow surrounds .* for a few moments\, then fades\, leaving it somehow changed\.
     matchre SPELL_CAST_FAIL ^You don't have a spell prepared\!
     matchre SPELL_CAST_FAIL ^Your concentration slips for a moment\, and your spell is lost\.
     put -cast;-2 gesture
     matchwait
SPELL_WAIT_TARGET:
     delay 0.0001
     if ("$preparedspell" = "None") then return
     matchre RETURN ^You feel fully prepared to cast your spell\.
     matchre RETURN ^Your concentration slips for a moment\, and your spell is lost\.
     matchre RETURN ^Your target pattern dissipates because the creature is dead\, but the main spell remains intact
     matchwait
SPELL_CAST_TARGET:
     delay 0.0001
     if ("$preparedspell" = "None") then return
     var target $0
     var LOCATION SPELL_CAST_TARGET_1
     SPELL_CAST_TARGET_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre SPELL_CAST_DONE ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre SPELL_CAST_DONE ^You gesture\.
     matchre SPELL_CAST_DONE ^Focus the power of justice on whom\?
     matchre SPELL_CAST_DONE ^A brilliant silver glow surrounds .* for a few moments\, then fades\, leaving it somehow changed\.
     matchre SPELL_CAST_FAIL ^You don't have a spell prepared\!
     matchre SPELL_CAST_FAIL ^Your concentration slips for a moment\, and your spell is lost\.
     put -cast %target;-2 gesture
     matchwait
SPELL_CAST_DONE:
     delay 0.0001
     put #queue clear
     return
SPELL_CAST_FAIL:
     delay 0.0001
     gosub RELEASE spell
SPELL_CAST_RETURN:
     delay 0.0001
     return
RELEASE_MANA:
     delay 0.0001
     if ("$preparedspell" != "None") then gosub RELEASE spell
     gosub RELEASE mana
     put #echo Crimson *****************************************************
     put #echo Crimson ***** ATTUNEMENT IS LOW.  WAITING TO REGAIN IT. *****
     put #echo Crimson *****************************************************
     if ($mana < 80) then waiteval ($mana > 79)
CHECK_MANA:
     delay 0.0001
     if ($mana < 55) then goto RELEASE_MANA
     return
RELEASE:
     delay 0.0001
     var release $0
     var LOCATION RELEASE_1
     RELEASE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^\s*Encumbrance\s*\:
     put -release %release;-encumbrance
     matchwait
HARNESS:
     delay 0.0001
     var harness $0
     var LOCATION HARNESS_1
     HARNESS_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RELEASE ^You strain\, but cannot harness that much power\.
     matchre RETURN ^You tap into the mana from .* of the surrounding streams and
     send harness %harness
     matchwait
#### ARCANA SUBS
CHARGE:
     delay 0.0001
     var charge $0
     var LOCATION CHARGE_1
     CHARGE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^The .* absorbs? .* of the energy\.
     matchre RETURN ^You fail to channel any energy into the .* \.
     matchre RETURN ^You strain\, but cannot harness that much power\.
     matchre RETURN ^You fail to channel any of the energy into .*\.
     matchre RETURN ^You strain\, but lack the mental stamina to charge .* this much\.
     matchre RETURN ^The .* is already holding as much power as you could possibly charge it with\.
     matchre RETURN ^The .* resists\, only absorbing part of the energy while the rest dissipates harmlessly\.
     send charge %charge
     matchwait
INVOKE:
     delay 0.0001
     var invoke $0
     var LOCATION INVOKE_1
     INVOKE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^Your link to the .* is intact
     matchre RETURN ^The .* dim\, almost magically null\.  A very faint pattern indicates its readiness to absorb .*energy\.
     matchre RETURN ^The .* pulses? .* energy\.  You reach for (?:its|their) centers? and forge a magical link to (?:it|them)\, readying .* mana for your use\.
     matchre INVOKE_1 ^The .* pulses? .* energy\.  You reach for (?:its|their) centers?\, attempting to forge a magical link\, but fail\.
     send invoke %invoke
     matchwait
REMOVE_CAMBRINTH:
     delay 0.0001
     var cambrinth $0
     var LOCATION REMOVE_CAMBRINTH_1
     REMOVE_CAMBRINTH_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You (?:slide|remove|take off)
     send remove my %cambrinth
     matchwait
WEAR_CAMBRINTH:
     delay 0.0001
     var cambrinth $0
     var LOCATION WEAR_CAMBRINTH_1
     WEAR_CAMBRINTH_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You (?:hang|slide|place|attach|put on)
     matchre RETURN ^Wear what\?
     matchre RETURN ^You are already wearing that\.
     send wear my %cambrinth
     matchwait
#### FOCUS SUB
FOCUS:
     delay 0.0001
     var focus $0
     var LOCATION FOCUS_1
     FOCUS_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^You focus your magical senses on .*\.
     send focus %focus
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN FOCUS! (utility.inc) ***
     put #log $datetime MISSING MATCH IN FOCUS! (utility.inc)
     return
#### PERCEIVE POWER SUB
PERCEIVE:
     delay 0.0001
     var perceive $0
     var LOCATION PERCEIVE_1
     PERCEIVE_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre RETURN ^There isn't the slightest trace
     matchre RETURN ^You cannot detect the slightest trace
     matchre RETURN ^You aren't trained in the ways of magic\.
     matchre RETURN ^Roundtime\:?|^\[Roundtime\:?|^\(Roundtime\:?
     matchre RETURN ^You aren't trained in the ways of magic\, but you fake it\.
     matchre RETURN ^Something in the area is interfering with your ability to perceive power\.
     send perceive %perceive
     matchwait 15
     put #echo >$Log Crimson $datetime *** MISSING MATCH IN PERCEIVE! (utility.inc) ***
     put #log $datetime MISSING MATCH IN PERCEIVE! (utility.inc)
     return
#### INFUSE THAT ORB (Thanks to Dasffion)
CHARGE_ORB:
     delay 0.0001
     var ChargeOrb $0
     var LOCATION CHARGE_ORB_1
CHARGE_ORB_1:
     delay 0.0001
     if ($Attunement.Ranks < 600) then
          {
               gosub HARNESS %ChargeOrb
               pause 0.1
               pause 0.1
               pause 0.1
          }
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre CHARGE_ORB_1 ^You sense that you were able to channel .*\.\s*A faint tugging sensation emanates from the orb\, as if it hungers for more\.
     # match CHARGE_ORB_1 You strain
     # match CHARGE_ORB_1 backfire
     matchre RETURN ^You sense that you were able to channel .*\.\s*A faint tingle washes through you as some of the energy is diffused\, the orb having reached its full capacity\.
     matchre RETURN ^You sense that you were able to channel .*\.\s*A sense of fullness emanates from the orb\.
     # match RETURN You sense that it cannot accept any more power
     # match RETURN unable
     # match RETURN You don't have a spell prepared
     # match cast.orb You do not
     put infuse OM %ChargeOrb
     matchwait 5
     goto CHARGE_ORB_1
INFUSE:
     var Infuse $0
     var LOCATION INFUSE_1
     INFUSE_1:
     matchre RETURN ^The spell pattern must be active before you can infuse it\.
     matchre RETURN ^You don't have enough harnessed to infuse that much\.
     matchre RETURN ^You don't have enough harnessed mana to infuse that much\.
     matchre RETURN ^You have no harnessed mana to infuse\.
     matchre RETURN ^\s*Roundtime\:?
     matchre RETURN ^\s*\[Roundtime\:?
     matchre RETURN ^\s*\(Roundtime\:?
     put infuse %Infuse
     matchwait
#### PERCEIVE HEALTH SUBS
PERCEIVE_HEALTH:
     delay 0.0001
     var LOCATION PERCEIVE_HEALTH_1
     PERCEIVE_HEALTH_1:
     matchre WAIT ^\.\.\.wait|^Sorry\,
     matchre STUNNED ^You are still stunned
     matchre WEBBED ^You can't do that while entangled in a web
     matchre IMMOBILE ^You don't seem to be able to move to do that
     matchre PERCEIVE_RETURN ^You sense.*
     matchre PERCEIVE_RETURN ^You fail to sense anything\, however\.
     matchre PERCEIVE_PAUSE ^You're not ready to do that again\, yet\.
     send perceive health
     matchwait
PERCEIVE_RETURN:
     delay 0.0001
     return
PERCEIVE_PAUSE:
     delay 0.0001
     pause 5
     goto PERCEIVE_HEALTH
#### CLEAN YOUR ROOM!
CLEAN_ROOM:
     delay 0.0001
     gosub KICKEM
     var dumpster NULL
     if matchre("$roomobjs", "a bucket of viscous gloop|a waste bucket") then var dumpster bucket
     if matchre("$roomobjs", "a disposal bin|a waste bin|firewood bin") then var dumpster bin
     if matchre("$roomname", "Garden Rooftop\, Medical Pavilion") then var dumpster gutter
     if matchre("$roomobjs", "a large stone turtle") then var dumpster turtle
     if matchre("$roomobjs", "trash receptacle") then var dumpster receptacle
     if matchre("$roomobjs", "a waste basket") then var dumpster basket
     if matchre("$roomobjs", "a tree hollow") then var dumpster hollow
     if matchre("$roomobjs", "a bottomless pit") then var dumpster pit
     if matchre("$roomobjs", "a driftwood log") then var dumpster log
     if matchre("$roomobjs", "an oak crate") then var dumpster crate
     if matchre("$roomobjs", "ivory urn") then var dumpster urn
     pause 0.1
     if ("%dumpster" = "NULL") then return
     CLEAN_ROOM_2:
     delay 0.0001
     var object NULL
     if matchre("$roomobjs", "a rock") then var object rock
     if matchre("$roomobjs", "some grass") then var object grass
     if !matchre("%object", "NULL") then
          {
               gosub GET %object
               gosub PUT_IT my %object in %dumpster
               goto CLEAN_ROOM_2
          }
     else return
#### CATCH AND RETRY SUBS
WAIT:
     delay 0.0001
     pause 0.1
     if (!$standing) then gosub STAND
     goto %LOCATION
WEBBED:
     delay 0.0001
     if ($webbed) then waiteval (!$webbed)
     if (!$standing) then gosub STAND
     goto %LOCATION
IMMOBILE:
     delay 0.0001
     if contains("$prompt" , "I") then pause 20
     if (!$standing) then gosub STAND
     goto %LOCATION
STUNNED:
     delay 0.0001
     if ($stunned) then waiteval (!$stunned)
     if (!$standing) then gosub STAND
     goto %LOCATION
CALMED:
     delay 15
     if ($stunned) then waiteval (!$stunned)
     if (!$standing) then gosub STAND
     goto %LOCATION
#### STANCE SUB
####
####  To use STANCE SET, type STANCE SET [EVASION #] [PARRY #] [SHIELD #] {ATTACK #}.
####  Evasion, Parry, and Shield are all required, while Attack is optional.
####
STANCETO:
     delay 0.0001
     eval stance tolower($1)
     delay 0.2
     if ("%stance" != "set") then
          {
               send stance %stance
               return
          }
     if ("$2" != "NULL") then var stance1 $2
     if ("$3" != "NULL") then var stance2 $3
     if ("$4" != "NULL") then var stance3 $4
     if ("$5" != "NULL") then var stance4 $5
     send stance %stance %stance1 %stance2 %stance3 %stance4
     return
#### HEALTH CHECKING
HEALTH_CHECK:
     delay 0.0001
     put #tvar needHealing 0
     delay 0.5
     matchre HEALTH_GOOD ^You have no significant injuries\.
     matchre HEALTH_BAD ^\s*Encumbrance\s+\:
     put -health;-2 encumbrance
     matchwait 15
     goto HEALTH_CHECK
HEALTH_BAD:
     delay 0.0001
     put #tvar needHealing 1
     delay 0.5
     return
HEALTH_GOOD:
     delay 0.0001
     put #queue clear
     put #tvar needHealing 0
     delay 0.5
     return
#### RETURNS
RETURN_CLEAR:
     delay 0.0001
     put #queue clear
     pause 0.0001
     return
RETURN:
     delay 0.0001
     return
#### END OF INCLUDE