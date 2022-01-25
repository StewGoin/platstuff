# Clean, rename, etc...

#STEALING ? RATHA 
debug off
START: 
IF_1 GOTO BEGIN
GOTO configure 

CONFIGURE: 
ECHO *** This script must be configured at least once. Would you like to configure or reconfigure it now? Type yes if yes, enc if no. If you don't like receiving this message each time, input the script with ANY argument and it will skip this message. *** 
match SETUP A good positive 
match SUPPORT Encumbrance:
matchwait 

SETUP: 
ECHO *** CONFIGURATION *** 
ECHO *** To set items to steal, you must manually edit the vars in the script editor. They should be near the very top of the script. Simply input the name of the item you wish to steal from the shop specified. Remember that you have to specify the whole name of the item to steal ? steal arm won't work, but steal armguards will. You must also input the number of these items you wish to steal. The script also needs your character's name and whether or not you want to mark an item once before stealing it. Once you have done this, re-execute the script and tell it to configure itself. Start this script in the bait shop.*** 

# ---- TABLE THAT YOU MUST EDIT STARTS HERE!!!! ----- 
# Remember you must put in the whole name of the item to be stolen. 
# Steal arm will not work, but steal armguards will, for instance. 
# Replace the word "item" below with the name of the item you want to steal, and the 0 with the times you want to steal it. 

BEGIN:
#BAITSHOP 
var BAITSHOP live minnows
var BAITSHOPNUMBER 2

#CHANDLERY 
var CHANDLERY belt pouch 
var CHANDLERYNUMBER 2

#HERBALIST 
var HERBALIST grain alcohol
var HERBALISTNUMBER 2

#BARD 
var BARD tin whistle
var BARDNUMBER 2

#GROOMING 
var GROOMING comb
var GROOMINGNUMBER 2

#LEATHER 
var LEATHER armguards
var LEATHERNUMBER 3

#TAILOR 
var TAILOR tartan badge 
var TAILORNUMBER 2 

#FORGE 
var FORGE sap
var FORGENUMBER 1

#ORIGAMI 
var ORIGAMI fourth paper on shelf
var ORIGAMINUMBER 2

#MAGIC 
var MAGIC pendant
var MAGICNUMBER 1

#CLERIC 
var CLERIC chamomile
var CLERICNUMBER 2

#JEWLERY 
var JEWELRY eyebrow ring
var JEWELRYNUMBER 2

#YOUR CHARACTER'S NAME ? The script needs to know your character's name. Replace the word name with your character's name. 
var CHARNAME Ryken 

#MARK ? decides whether or not to mark an item. Yes for marking, no for no marking. 
var MARK NO

#HIDINGTIME ? Replace the 4 with your typical hiding roundtime PLUS one second 
var HIDETIME 6

#MARKTIME ? Replace the 7 with your typical marking roundtime PLUS one second. 
var MARKTIME 7 

# ---- TABLE THAT YOU MUST EDIT ENDS HERE!!!! ----- 
goto ONE

SUPPORT:
put inv combat
pause 2
put khri support
match STEALTH You close your eyes
match STEALTH You are already
matchwait

STEALTH:
pause 1
put khri skulk
match ONE sense of stillness
match ONE core of you
match UP You are already
match NYAH You breathe deeply and attempt to focus
matchwait

UP:
echo *** Khri already up.  Is it the right one?  Yes to continue, enc to stop khri and start over. ***
match ONE positive
match KHRISTOP Encumbrance:
matchwait

KHRISTOP:
put khri stop
goto support

NYAH:
echo *** Waiting sixty seconds to try again. ***
pause 60
GOTO STEALTH

ONE:
put glan
match LOCATION You glance down at
match STOW You glance down to see
matchwait

STOW: 
put stow left 
put stow right 
GOTO LOCATION

MARK_YES: 
put hide 
pause %HIDETIME
put mark %STEALTHIS
pause %MARKTIME
GOTO STEAL%c

MARK_NO: 
put hide 
pause %HIDETIME
GOTO STEAL%c

STEAL10:
STEAL9:
STEAL8:
STEAL7:
STEAL6:
STEAL5:
STEAL4:
STEAL3:
STEAL2:
STEAL1:
STEAL: 
match ABORT begins to shout loudly for help
match ABORT begins to shout
match ABORT points to where you lie concealed
match ABORT being watched 
match GUESS you manage to grab
match HANDS You need at least one 
match GUESS positive 
put steal %STEALTHIS 
matchwait 

ABORT: 
match LOCATION Roundtime:
match BOO Perhaps you should
put sneak out
matchwait

HANDS: 
move sneak out 
put unhide 
put stow left 
put stow right 
put hide 
pause %HIDETIME 
match SHOP harbor at this end
match SHOP quartermasters
match SHOP canvas awning
match SHOP water and a distant shore
match SHOP lanterns can be seen tracing
match SHOP craftsmen gather on the stoops
match SHOP patrol this area heavily
match SHOP press in on both sides
match FORGE1 brick and timber building rises
match STRUCTURE travelers can choose
match SHOP shops and guilds
match SHOP brick street runs
match SHOP miniscule red tile-roofed shop
put look
matchwait 

SHOP: 
move sneak shop 
GOTO STEAL 

STRUCTURE: 
move sneak structure 
GOTO STEAL 

FORGE1: 
move sneak forge 
GOTO STEAL 

GUESS: 
put look %CHARNAME 
match BOO You are 
match YAY I could not find 
matchwait 

YAY: 
pause 1 
counter subtract 1 
GOTO STEAL%c 

BOO: 
put o 
pause 4 
GOTO LOCATION 

STEAL0: 
move sneak out 
pause 1 
put unhi 
GOTO LOCATION  

LOCATION:
match BAIT Built from pieces
match CHANDLER harbor at this end
match HERBALIST Quartermasters
match BARD canvas awning
match PRETTY water and a distant shore
match PRETTY lanterns can be seen tracing
match LEATHER craftsmen gather on the stoops
match TAILOR patrol this area heavily
match FORGE press in on both sides
match ORIGAMI brick and timber building rises
match MAGIC travelers can choose
match JEWELER deep within the shadows
match JEWELER miniscule red tile-roofed shop
match CLERIC brick street runs
match GUILD the eastern end of Promenade
put look 
matchwait 

BAIT: 
var STEALTHIS %BAITSHOP
counter set %BAITSHOPNUMBER
GOTO MARK_%MARK

CHANDLER: 
var STEALTHIS %CHANDLERY
counter set %CHANDLERYNUMBER
move e 
move se 
move e 
move e 
move e 
put stow left 
put stow right 
pause 1 
move e 
move e 
move e 
move n 
move go shop 
GOTO MARK_%MARK

HERBALIST: 
var STEALTHIS %HERBALIST
counter set %HERBALISTNUMBER
move n 
move n 
move n 
move nw 
move n 
move nw 
move n 
move nw 
move nw 
move w 
move w 
move sw 
move w 
move sw 
put stow right 
put stow left 
pause 1 
move go shop 
GOTO MARK_%MARK

BARD: 
var STEALTHIS %BARD
counter set %BARDNUMBER
move nw 
move n 
move w 
put drop pyramid 
pause 1 
move nw 
move n 
move n 
move nw 
move w 
move n 
move n 
move w 
move sw 
move w 
put stow right 
put stow left 
pause 1 
move cli fence 
move ne 
move cli cliff 
move cli cliff 
move cli wall 
move nw 
move w 
move sw 
move nw 
move w 
move sw 
move n 
move ne 
move n 
move ne 
move n 
move ne 
move n 
move nw 
move go ar 
move n 
move go shop 
GOTO MARK_%MARK

PRETTY: 
var STEALTHIS %GROOMING
counter set %GROOMINGNUMBER
move n 
move ne 
move se 
move se 
move sw 
put stow left 
put stow right 
pause 1 
move e 
move go shop 
GOTO MARK_%MARK

LEATHER: 
var STEALTHIS %LEATHER
counter set %LEATHERNUMBER
move e 
move s 
move se 
put stow left 
put stow right 
pause 1 
move e 
#move go shop 
#GOTO MARK_%MARK

TAILOR: 
var STEALTHIS %TAILOR
counter set %TAILORNUMBER
move e 
move ne 
move e 
move e 
move e 
move e 
move e 
put stow right 
put stow left
pause 1 
move e 
move go shop 
GOTO MARK_%MARK

FORGE: 
var STEALTHIS %FORGE
counter set %FORGENUMBER
move w 
move se 
move se 
move s 
move se 
move se 
put stow right 
put stow left 
pause 1 
move se 
move go forge 
GOTO MARK_%MARK

ORIGAMI: 
var STEALTHIS %ORIGAMI
counter set %ORIGAMINUMBER
move nw 
move nw 
move nw 
move n 
move nw 
move nw 
move w 
move sw 
pause
move go gilded drain 
move go obscure opening

033:
save 033
match 034 the reek of mold
match RETREAT engaged
match UNGUARD Although tempted to move,
put n
matchwait

034:
save 034
match 035 something silent brushing past
match RETREAT engaged
put up
matchwait

035:
save 035
match 036 the tang of the salt sea
match RETREAT engaged
put nw
matchwait

036:
save 036
match 037 the smell of fish, fresh
match RETREAT engaged
put w
matchwait

037:
save 037
match 038 [The Sewers, Beneath the Grating]
match RETREAT engaged
put go narrow crevice
matchwait

038:
pause
move go sewer grating
GOTO ORIGAMI2

RETREAT:
match retreat You retreat back to pole range.
match retreat still stunned
match %s You retreat from combat.
match pause ...wait
match pause type ahead
put retreat
matchwait

UNGUARD:
pause
put guard stop
goto %s

ORIGAMI2:
move sw 
put stow right 
put stow left 
pause 1 
move go structure 
GOTO MARK_%MARK

MAGIC: 
var STEALTHIS %MAGIC
counter set %MAGICNUMBER
move w 
move w 
move nw 
move nw 
put stow right 
put stow left 
pause 1 
move nw 
move n 
#move go shop 
#GOTO MARK_%MARK

JEWELER: 
var STEALTHIS %JEWELRY
counter set %JEWELRYNUMBER
move e 
move ne 
move ne 
move ne 
put stow right 
put stow left 
pause 1 
move se 
move se 
move ne 
move go shop 
GOTO MARK_%MARK

CLERIC: 
var STEALTHIS %CLERIC
counter set %CLERICNUMBER
move sw 
move se 
put stow right 
put stow left 
pause 1 
move e 
move s 
move go shop 
GOTO MARK_%MARK

GUILD: 
move n
move e
move e
move go shop
put look
