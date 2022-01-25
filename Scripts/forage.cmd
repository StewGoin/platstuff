# Cleanup/validate and consider Base integration if there is a need

#debug 8
action put #var Guild $1 when Guild: (\S+)
put info
pause 0.5
var goodforage ""

if $Guild = Moon|Ranger|Thief|Necromancer|Empath|Barbarian|Trader then var addon careful 
else var addon 

CONTAINER_CHECK:
match BUCKET a bucket of viscous gloop		
match TURTLE a large stone turtle		
match DISPOSAL_BIN a disposal bin		
match WASTE_BIN a waste bin		
match HOLLOW a tree hollow
match HOLLOW a darkened hollow		
match CRATE an oak crate		
match FIRE_BIN firewood bin	
match STUMP hollow stump	
match URN ivory urn		
match PIT pit		
match RECEPTACLE trash receptacle
matchre CONTAINER_CHECK /...wait|may only type/	
put look	
matchwait

STUMP:
var TRASH_CAN stump
goto xpcheck

PIT:	
var TRASH_CAN pit	
goto xpcheck	

BUCKET:	
var TRASH_CAN bucket	
goto xpcheck

TURTLE:	
var TRASH_CAN turtle	
goto xpcheck  

FIRE_BIN:
DISPOSAL_BIN:
WASTE_BIN: 	
var TRASH_CAN bin	
goto xpcheck

HOLLOW:	
var TRASH_CAN hollow	
goto xpcheck

CRATE:	
var TRASH_CAN crate	
goto xpcheck  

URN:	
var TRASH_CAN urn	
goto xpcheck  	

RECEPTACLE:	
var TRASH_CAN receptacle
goto xpcheck

doneforage:
if $righthand != Empty then goto donedrop
put #parse Script Done
exit
return

donedrop:
matchre done /...wait|may only type/
matchre return /You drop|You put/
put put my %s in %TRASH_CAN	
matchwait

full:	
echo ***************************************************	
echo *** Your hands are full.	
echo ***************************************************	
goto done

clutter:	
echo ***************************************************	
echo *** This area is too cluttered to forage in.	
echo ***************************************************	
goto done

######################################################### 
#Rank Efficiency
#########################################################

xpcheck:
if %goodforage(0) != "" then goto quickstart
if $Foraging.Ranks >= 320 then goto 320	
if $Foraging.Ranks < 320 and $Foraging.Ranks > 280 then goto 300
if $Foraging.Ranks <= 280 and $Foraging.Ranks > 275 then goto 280
if $Foraging.Ranks <= 275 and $Foraging.Ranks > 240 then goto 275
if $Foraging.Ranks <= 240 and $Foraging.Ranks > 220 then goto 240
if $Foraging.Ranks <= 220 and $Foraging.Ranks > 200 then goto 220
if $Foraging.Ranks <= 200 and $Foraging.Ranks > 195 then goto 200
if $Foraging.Ranks <= 195 and $Foraging.Ranks > 175 then goto 195
if $Foraging.Ranks <= 175 and $Foraging.Ranks > 150 then goto 175
if $Foraging.Ranks <= 150 and $Foraging.Ranks > 120 then goto 150
if $Foraging.Ranks <= 120 and $Foraging.Ranks > 110 then goto 120
if $Foraging.Ranks <= 110 and $Foraging.Ranks > 100 then goto 110
if $Foraging.Ranks <= 100 and $Foraging.Ranks > 90 then goto 100
if $Foraging.Ranks <= 90 and $Foraging.Ranks > 80 then goto 90
if $Foraging.Ranks <= 80 and $Foraging.Ranks > 70 then goto 80
if $Foraging.Ranks <= 70 and $Foraging.Ranks > 65 then goto 70
if $Foraging.Ranks <= 65 and $Foraging.Ranks > 60 then goto 65
if $Foraging.Ranks <= 60 and $Foraging.Ranks > 50 then goto 60
if $Foraging.Ranks <= 50 and $Foraging.Ranks > 40 then goto 50
if $Foraging.Ranks <= 40 and $Foraging.Ranks > 30 then goto 40
if $Foraging.Ranks <= 30 and $Foraging.Ranks > 20 then goto 30
if $Foraging.Ranks <= 20 and $Foraging.Ranks > 10 then goto 20
if $Foraging.Ranks <= 10 and $Foraging.Ranks > 0 then goto 10
if $Foraging.Ranks = 0 then goto 0
goto xpcheck

setforage:
if $Perception.LearningRate >= 32 then goto doneforage
match full hands are full		
match clutter cluttered	
match setempty You manage to find		
matchre setforage /...wait|may only type/		
match return Roundtime:	
put forage %s %addon	
matchwait

setempty:
if %goodforage(0) = "" then var goodforage %s
else var goodforage %goodforage|%s
matchre setempty /...wait|may only type/
matchre return /You drop|You put|What were you referring to/
put put my %s in %TRASH_CAN	
matchwait

return:
return

quickstart:
var foragecurrent 0
goto quickforage

quickforage:
if $Perception.LearningRate >= 32 then goto doneforage
if "%goodforage(%foragecurrent)" = "" then goto quickstart
else save %goodforage(%foragecurrent)
match full hands are full		
match clutter cluttered	
match quickempty You manage to find		
matchre quickforage /...wait|may only type/		
match quicknext Roundtime:	
put forage %s %addon	
matchwait

quicknext:
math foragecurrent add 1
goto quickforage

quickempty:
pause
matchre quickempty /...wait|may only type/
matchre quicknext /You drop|You put|What were you referring to/
put put my %s in %TRASH_CAN
matchwait

######################################################### 
#Forage List from Foraging Compendium
#########################################################

320:
silverwoodstick:
save silverwood stick	
gosub setforage

silverwoodlimb:	
save silverwood limb	
gosub setforage

300:
silverwoodbranch:	
save silverwood branch	
gosub setforage

coin:	
save coin		
gosub setforage

copperwoodstick:
save copperwood stick
gosub setforage

copperwoodlimb:	
save copperwood limb	
gosub setforage
if $Foraging.Ranks >= 320 then goto xpcheck

280:
copperwoodbranch:	
save copperwood branch	
gosub setforage
if $Foraging.Ranks >= 300 then goto xpcheck

275:
nuloestem:	
save nuloe stem	
gosub setforage

genichstem:	
save genich stem		
gosub setforage

cebiroot:	
save cebi root		
gosub setforage

qunpollen:	
save qun pollen	
gosub setforage

jadicepollen:	
save jadice pollen		
gosub setforage
if $Foraging.Ranks >= 280 then goto xpcheck

240:
butterflyorchid:	
save butterfly orchid	
gosub setforage

bloodwoodstick:	
save bloodwood stick	
gosub setforage

bloodwoodlimb:	
save bloodwood limb		
gosub setforage
if $Foraging.Ranks >= 275 then goto xpcheck

220:
bloodwoodbranch:	
save bloodwood branch	
gosub setforage

osagestick:	
save osage stick		
gosub setforage

osagelimb:	
save osage limb		
gosub setforage

osagebranch:	
save osage branch		
gosub setforage
if $Foraging.Ranks >= 240 then goto xpcheck

200:
honeycomb:	
save honey comb		
gosub setforage

mistwoodstick:	
save mistwood stick	
gosub setforage

mistwoodlimb:	
save mistwood limb	
gosub setforage

mistwoodbranch:	
save mistwood branch	
gosub setforage
if $Foraging.Ranks >= 220 then goto xpcheck

195:
yewstick:	
save yew stick		
gosub setforage

yewlimb:	
save yew limb		
gosub setforage

yewbranch:	
save yew branch		
gosub setforage
if $Foraging.Ranks >= 200 then goto xpcheck

175:
coffeebean:	
save coffee bean		
gosub setforage

muljinsap:	
save muljin sap		
gosub setforage

wildorchid:	
save wild orchid		
gosub setforage

eghmokmoss:	
save eghmok moss		
gosub setforage
if $Foraging.Ranks >= 195 then goto xpcheck

150:
mistletoe:	
save mistle toe		
gosub setforage

willowbranch:	
save willow branch		
gosub setforage	
if $Foraging.Ranks >= 175 then goto xpcheck

120:
redrose:	
save red rose		
gosub setforage

redwoodstick:	
save redwood stick		
gosub setforage

redwoodlimb:	
save redwood limb		
gosub setforage

walnutbranch:	
save walnut branch		
gosub setforage

redwoodbranch:	
save redwood branch		
gosub setforage

glayskerflower:	
save glaysker flower	
gosub setforage

blocilberries:	
save blocil berries		
gosub setforage

willowstick:	
save willow stick		
gosub setforage

walnutstick:	
save walnut stick		
gosub setforage

teakstick:	
save teak stick
gosub setforage

rosewoodstick:	
save rosewood stick		
gosub setforage

oakstick:	
save oak stick		
gosub setforage

emaplestick:	
save maple stick	
gosub setforage

mahoganystick:	
save mahogany stick		
gosub setforage

elmstick:	
save elm stick		
gosub setforage

ebonystick:	
save ebony stick		
gosub setforage

sufilsap:	
save sufil sap		
gosub setforage
if $Foraging.Ranks >= 150 then goto xpcheck

110:
pigroot:	
save pig root	
gosub setforage

briarberryroot:	
save briarberry root
gosub setforage

willowlimb:	
save willow limb		
gosub setforage

walnutlimb:	
save walnut limb		
gosub setforage

teaklimb:	
save teak limb		
gosub setforage

rosewoodlimb:	
save rosewood limb		
gosub setforage	
if $Foraging.Ranks >= 120 then goto xpcheck

100:
oaklimb:	
save oak limb		
gosub setforage

maplelimb:	
save maple limb	
gosub setforage

mahoganylimb:	
save mahogany limb		
gosub setforage

elmlimb:	
save elm limb		
gosub setforage

ebonylimb:	
save ebony limb		
gosub setforage

riolurleaf:	
save riolur leaf		
gosub setforage

hulnikgrass:	
save hulnik grass		
gosub setforage

teakbranch:	
save teak branch	
gosub setforage

rosewoodbranch:	
save rosewood branch
gosub setforage

oakbranch:	
save oak branch		
gosub setforage

maplebranch:	
save maple branch	
gosub setforage

mahoganybranch:	
save mahogany branch
gosub setforage

elmbranch:	
save elm branch		
gosub setforage

ebonybranch:	
save ebony branch		
gosub setforage

greenmoss:	
save green moss		
gosub setforage
if $Foraging.Ranks >= 110 then goto xpcheck

90:
whiterose:	
save white rose	
gosub setforage

tealeaf:	
save tea leaf		
gosub setforage

oldbutton:	
save old button		
gosub setforage

junliarstem:	
save junliar stem		
gosub setforage

sage:	
save sage		
gosub setforage

plovikleaf:	
save plovik leaf		
gosub setforage

nilosgrass:	
save nilos grass	
gosub setforage

almond:	
save almond		
gosub setforage

hickorystick:	
save hickory stick		
gosub setforage

cherrystick:	
save cherry stick		
gosub setforage

hickorylimb:	
save hickory limb		
gosub setforage

cherrylimb:	
save cherry limb		
gosub setforage

hickorybranch:	
save hickory branch		
gosub setforage
if $Foraging.Ranks >= 100 then goto xpcheck

80:
cherrybranch:	
save cherry branch
gosub setforage

moss:	
save moss		
gosub setforage

lavendar:	
save lavendar		
gosub setforage

draconaeiablossom:	
save draconaeia blossom
gosub setforage

turnip:	
save turnip	
gosub setforage

gooseberries:	
save gooseberries	
gosub setforage

chamomile:	
save chamomile		
gosub setforage

firstick:	
save fir stick		
gosub setforage

birchstick:	
save birch stick		
gosub setforage
if $Foraging.Ranks >= 90 then goto xpcheck

70:
ashstick:	
save ash stick	
gosub setforage

rose:	
save rose		
gosub setforage

firlimb:	
save fir limb		
gosub setforage

birchlimb:	
save birch limb		
gosub setforage

ashlimb:	
save ash limb	
gosub setforage

firbranch:	
save fir branch	
gosub setforage

birchbranch:	
save birch branch		
gosub setforage

ashbranch:	
save ash branch	
gosub setforage

clover:	
save clover	
gosub setforage

seolarnweed:	
save seolarn weed		
gosub setforage

toadstool:	
save toadstool		
gosub setforage

alderstick:	
save alder stick		
gosub setforage

alderlimb:	
save alder limb		
gosub setforage

alderbranch:	
save alder branch	
gosub setforage

applestick:	
save apple stick	
gosub setforage

orange:	
save orange		
gosub setforage

applelimb:	
save apple limb		
gosub setforage	
if $Foraging.Ranks >= 80 then goto xpcheck

65:
lemon:	
save lemon	
gosub setforage

clam:	
save clam		
gosub setforage

wildcarrot:	
save wild carrot		
gosub setforage

applebranch:	
save apple branch	
gosub setforage

apple:	
save apple		
gosub setforage
if $Foraging.Ranks >= 70 then goto xpcheck

60:
yelithroot:	
save yelith root		
gosub setforage

nemoihroot:	
save nemoih root	
gosub setforage

asarwudenshell:	
save asarwuden shell		
gosub setforage

phelimshell:	
save phelim shell		
gosub setforage

briarberries:	
save briar berries		
gosub setforage

sprucestick:	
save spruce stick		
gosub setforage

pinestick:	
save pine stick		
gosub setforage

sprucelimb:	
save spruce limb		
gosub setforage

pinelimb:	
save pine limb		
gosub setforage
if $Foraging.Ranks >= 65 then goto xpcheck

50:
aloeleaf:	
save aloe leaf	
gosub setforage

sprucebranch:	
save spruce branch		
gosub setforage

pinebranch:	
save pine branch	
gosub setforage
if $Foraging.Ranks >= 60 then goto xpcheck

40:
jasmineblossom:	
save jasmine blossom		
gosub setforage

nedorenshell:	
save nedoren shell		
gosub setforage

fanashell:	
save fana shell		
gosub setforage

sharktooth:	
save shark tooth		
gosub setforage
if $Foraging.Ranks >= 50 then goto xpcheck

30:
treeroot:	
save tree root		
gosub setforage

redflower:	
save red flower		
gosub setforage

blueflower:	
save blue flower		
gosub setforage

clamshell:	
save clam shell	
gosub setforage

cherry:	
save cherry		
gosub setforage

strawberry:	
save strawberry		
gosub setforage

blueberries:	
save blueberries		
gosub setforage

oringrass:	
save georin grass		
gosub setforage

torncloth:	
save torn cloth	
gosub setforage

weed:	
save weed		
gosub setforage

vine:	
save vine		
gosub setforage

taffelberries:	
save taffelberries		
gosub setforage

snailshell:	
save snail shell		
gosub setforage
if $Foraging.Ranks >= 40 then goto xpcheck

20:
scallion:	
save scallion	
gosub setforage

sap:	
save sap	
gosub setforage

peat:	
save peat		
gosub setforage

rustynail:	
save rusty nail	
gosub setforage

log:	
save log	
gosub setforage

limb:	
save limb		
gosub setforage

corn:	
save corn	
gosub setforage

jadiceflower:	
save jadice flower		
gosub setforage

stem:	
save stem		
gosub setforage

seaweed:	
save seaweed		
gosub setforage

grungyfeather:	
save grungy feather	
gosub setforage
if $Foraging.Ranks >= 30 then goto xpcheck

10:
dirt:	
save dirt		
gosub setforage

cattail:	
save cattail	
gosub setforage

acorn:	
save acorn		
gosub setforage

ashell:	
save sea shell		
gosub setforage

shoetack:	
save shoe tack	
gosub setforage

torch:	
save torch	
gosub setforage
if $Foraging.Ranks >= 20 then goto xpcheck

0:
twig:	
save twig		
gosub setforage

stick:	
save stick		
gosub setforage

woodsplinter:	
save wood splinter		
gosub setforage

brokenshell:	
save broken shell	
gosub setforage

shell:	
save shell		
gosub setforage

root:	
save root		
gosub setforage

rock:	
save rock	
gosub setforage

leaf:	
save leaf	
gosub setforage

grass:	
save grass		
gosub setforage

breadcrumb:	
save bread crumb		
gosub setforage

woodchip:	
save wood chip		
gosub setforage

dustbunny:	
save dust bunny	
gosub setforage

branch:
save branch
gosub setforage
goto xpcheck
