#mix v1.4
#debug 5
####################################################
#v1.1-Added percentages of the total make-up each metal comprises (rounded to hundredths).
#v1.2-Fixed typo with "spiked knuckles" in two places. Also put boundaries on "pike", as it was getting triggered from other weapon names containing that.
#	-Changed weapons that ended in "spikes" to "spike", "knuckles" to "knuckle", and "claws" to "claw".
#v1.3-Fixed an issue that could cause negative volumes to appear.
#v1.4-Fixed issue with very low volume weapons.
#
####################################################
#=============================================================================================
#=============================================================================================
# -Written by Ozban, 8/25/2014- #
##_____________________________##
#
#
# --Information for weapon volumes taken from:
#     - https://elanthipedia.play.net/mediawiki/index.php/Weaponsmithing_Products
#
#
# --Information for material densities taken from:
#     - https://elanthipedia.play.net/mediawiki/index.php/Crafting_Materials
#
#=============================================================================================
# -To use, put the full weapon name, the weight, and main metal to use on the command line.
#	-Example: .mix 35 scimitar steel, Or .mix flanged mace 35 glaes
#
# -For weapons that have the metal in between two words, just put the two words
#	-Example: spiked <metal> gauntlet, just use spiked gauntlet
#	  -.mix spiked gauntlet 30 steel
#
# -The order doesn't matter (except for multi-word weapon names), as long as all 3 pieces of information are there.
#
# -Will not use mixed ingots (like a 1 volume ingot that's 33% covellite, 67% haralun), will 
#    round to nearest full volumes, keeping things easy folks!
#
#=============================================================================================
#=============================================================================================
#=============================================================================================
start:
   eval command tolower("%0")
   gosub get.totals
   evalmath main.volume (%total.volume*.67)
   evalmath main.volume ceiling(%main.volume)
   evalmath filler.volume (%total.volume-%main.volume)
   evalmath weapon.density (%total.weight/%total.volume)
   if (%weapon.density < 3) then goto not.dense.enough
   evalmath main.weight (%main.volume*%main.density)
   evalmath filler.weight (%total.weight-%main.weight)
   if (%main.weight > %total.weight) then goto weight.not.possible
   if (("%filler.volume" = "1") && (%filler.weight > 9)) then goto too.heavy
   if (("%filler.weight" = "1") && (%filler.volume > 1)) then goto too.light
   gosub get.filler

done:
   if ("%main.volume" = "%total.volume") then
	{
	  evalmath weapon.density (%main.weight/%total.volume)
	  if (%main.weight < %total.weight) then goto too.heavy
	}
   #evalmath total.weight (%main.weight+%filler.weight+%filler.weight1+%filler.weight2)
   evalmath weapon.density round(%weapon.density, 2)
   evalmath minimum.weight (%total.volume*3)
   evalmath maximum.weight (%total.volume*7.5)
   #evalmath maximum.weight ceiling(%maximum.weight)
   gosub hone
   gosub percents
   echo
   echo *****************************************
   echo
   echo   -You asked for a %total.weight stone %weapon made from %main.metal.
   echo   -Your weapon's density would be %weapon.density.
   echo   -%main.volume volume of %main.metal (%main.weight stones, %main.percent%)
   if (("%filler.metal1" = "NONE") && ("%filler.metal2" = "NONE") && ("%filler.volume" != "0" then)) then echo   -%filler.volume volume of %filler.metal (%filler.weight stones, %filler.percent%)
   if ("%filler.metal1" != "NONE") then echo   -%filler.volume1 of %filler.metal1 (%filler.weight1 stones, %filler.percent1%)
   if ("%filler.metal2" != "NONE") then echo   -%filler.volume2 of %filler.metal2 (%filler.weight2 stones, %filler.percent2%)
   echo
   echo -Honed Weight: %honed.
   echo -Minimum weight for this weapon: %minimum.weight (3.0 density minimum X weapon's volume).
   echo -Maximum weight for this weapon: %maximum.weight (7.5 density maximum X weapon's volume).
   echo -Lower than that range is not possible, higher and you're just adding weight without adding stats.
   echo
   echo *****************************************
   echo
   exit
#=============================================================================================
#=============================================================================================
#=============================================================================================
too.light:
echo
echo ************************
echo
echo That weight is too light to achieve with your specified metal (excluding honing).
echo Try adding 1 stone and see if we can get close, honing removes ~8% weight or a maximum of 5 stones, but won't drop weapons below the 3 density mark.
echo If you hone a weapon, you can not balance it or reverse the honing.
echo
echo ************************
echo
exit
#=============================================================================================
too.heavy:
echo
echo ************************
echo
echo That weight is too heavy to achieve with your specified metal or the weapon.
echo
echo ************************
echo
exit
#=============================================================================================
not.dense.enough:
evalmath weapon.density floor(%weapon.density)
echo
echo ************************
echo
echo Sorry, that weight isn't possible. Ingots need to have a minimum density of 3.
echo Your weapon is %total.volume volume, and you wish a weight of %total.weight.
echo Your weight (%total.weight) divided by the total volume (%total.volume) would be %weapon.density density (rounded down).
echo
echo ************************
echo
exit
#=============================================================================================
weight.not.possible:
echo
echo ************************
echo
echo Sorry, that weight isn't possible (excluding honing possibly).
echo Your desired metal is %main.metal, the weapon requires a minimum volume of
echo %main.volume of the desired metal, which totals a weight of %main.weight stones.
echo
echo ************************
echo
exit
#=============================================================================================
get.totals:
if matchre("%command", "(brass|bronze|copper|covellite|iron|lead|nickel|oravir|pewter|\bsilver\b|\bsteel\b|\btin\b|zinc|animite|audrualm|damite|darkstone|electrum|glaes|haralun|icesteel|kadepa|kertig|lumium|muracite|niello|niniam|orichalcum|platinum|silversteel|tyrium|vardite|gold)") then var main.metal $1
   else {
	  echo
	  echo ************************
	  echo
	  echo No material specified, is it spelled right?
	  echo
	  echo ************************
	  echo
	  exit
	}
if matchre("%command", "(\d+)") then var total.weight $0
   else {
	  echo
	  echo ************************
	  echo
	  echo Couldn't find a weight on the command line.
	  echo
	  echo ************************
	  echo
	  exit
	}
gosub get.volume
   if ("%total.volume" = "0") then {
	  echo
	  echo ************************
	  echo
	  echo No clue what you're attempting to do, is everything spelled right?
	  echo
	  echo ************************
	  echo
	  exit
	}
gosub get.weapon
   if ("%weapon" = "NONE") then {
	  echo
	  echo ************************
	  echo
	  echo I have no idea which weapon you're trying to make, is it spelled right?
	  echo
	  echo ************************
	  echo
	}
gosub get.density
   if ("%density" = "0") then {
	  echo
	  echo ************************
	  echo
	  echo Couldn't find your metal, is it spelled right?
	  echo
	  echo ************************
	  echo
	  exit
	}
	else var main.density %density
   var filler.metal1 NONE
   var filler.metal2 NONE
   var filler.weight1 NONE
   var filler.weight2 NONE
   return
#=============================================================================================
get.volume:
   var total.volume 0
   if matchre("%command", "mace") then var total.volume 8
   if matchre("%command", "riste") then var total.volume 9
#-Small_Edged-#
   if matchre("%command", "\bdart\b") then var total.volume 1
   if matchre("%command", "dagger|misericorde|briquet|carving knife|poignard|stiletto|pugio|throwing dagger|telek") then var total.volume 2
   if matchre("%command", "short sword|kasai|takouba|katar|sunblade") then var total.volume 3
   if matchre("%command", "jambiya|leaf blade sword|nehlata|kris") then var total.volume 4
   if matchre("%command", "falcata|dao|thrusting blade|rapier|koummya|kythe|foil|oben|pasabas") then var total.volume 5
   if matchre("%command", "parang|mambeli|hanger|light throwing axe|scimitar|gladius|curlade|baselard|adze|sashqa|sabre") then var total.volume 6
   if matchre("%command", "shotel|hatchet|hand axe|cutlass") then var total.volume 7
#-Large_Edged-#
   if matchre("%command", "arzfilt|broadsword|condottiere|kudalata|longsword|nehdalata|round axe|spatha") then var total.volume 7
   if matchre("%command", "abassi|back-sword|cinqueda|dagasse|hunting sword|namkomba|nimsha|recade|hurling axe") then var total.volume 8
   if matchre("%command", "falchion|battle axe|robe sword|schiavona") then var total.volume 9
#-TwoHanded_Edged-#
   if matchre("%command", "greataxe|marauder blade|two-handed sword|warring axe") then var total.volume 12
   if matchre("%command", "karambit|claymore|twin-point axe") then var total.volume 14
   if matchre("%command", "igorat axe|kaskara|shh'oi'ata") then var total.volume 15
   if matchre("%command", "greatsword|flamberge|double axe|periperiu sword") then var total.volume 18
#-Small_Blunt-#
   if matchre("%command", "boko|boomerang") then var total.volume 3
   if matchre("%command", "gavel|prod|cudgel|cosh") then var total.volume 4
   if matchre("%command", "scepter|zubke|short hammer|spiked gauntlet|bola|bulhawf|hand mallet|bludgeon|throwing club|cuska") then var total.volume 5
   if matchre("%command", "club|garz|hand mace|ridged gauntlet") then var total.volume 6
   if matchre("%command", "hhr'tami|komno|mallet|war club") then var total.volume 7
   if matchre("%command", "war hammer|belaying pin|marlingspike|spiked club|spiked hammer|spiked mace") then var total.volume 8
   if matchre("%command", "flanged mace|k'trinni sha-tai") then var total.volume 9
#-Large_Blunt-#
   if matchre("%command", "ball and chain|heavy chain|horseman's flail") then var total.volume 9
   if matchre("%command", "heavy mace|greathammer|imperial war hammer|double-headed hammer|\bhara\b|heavy mallet|sledgehammer|hhr'ata|hurlable war hammer|throwing hammer|throwing mallet") then var total.volume 10
   if matchre("%command", "spiked ball and chain|spiked hara|morning star|ukabi") then var total.volume 11
#-TwoHanded_Blunt-#
   if matchre("%command", "akabo|double-sided ball and chain|footman's flail") then var total.volume 13
   if matchre("%command", "vilks kodur|war mattock") then var total.volume 14
   if matchre("%command", "giant mallet|two-headed hammer") then var total.volume 15
   if matchre("%command", "dire mace|heavy sledgehammer|maul") then var total.volume 16
#-Polearms-#
   if matchre("%command", "javelin|light spear|allarh|hunthsleg") then var total.volume 7
   if matchre("%command", "bardiche|guisarme|lochaber axe|scythe|spear|duraka skefne|military fork") then var total.volume 10
   if matchre("%command", "halberd|tzece|awgravet ava|coresca") then var total.volume 12
   if matchre("%command", "khuj|glaive|partisan|two-pronged halberd|fauchard|ngalio|pole axe") then var total.volume 13
   if matchre("%command", "ilglaiks skefne|lance|\bpike\b|ranseur|spetum") then var total.volume 15
#-Martial-#
   if matchre("%command", "knuckle|elbow spike|knee spike|spiked knuckle|hand claw") then var total.volume 4
   if matchre("%command", "nightstick") then var total.volume 7
   if matchre("%command", "cane") then var total.volume 8
   if matchre("%command", "quarterstaff") then var total.volume 10
   if matchre("%command", "pike staff") then var total.volume 11
#-Swappable-#
   if matchre("%command", "throwing spike|thin-bladed fan") then var total.volume 4
   if matchre("%command", "thick-bladed fan") then var total.volume 6
   if matchre("%command", "half-handled riste") then var total.volume 7
   if matchre("%command", "broadaxe|war sword|bastard sword") then var total.volume 9
   if matchre("%command", "boarding axe") then var total.volume 10
   if matchre("%command", "bar mace") then var total.volume 12
   if matchre("%command", "splitting maul") then var total.volume 15
#-Specials-#
   if matchre("%command", "hawkbill") then var total.volume 1
   if matchre("%command", "serrated kudalata") then var total.volume 7
   if matchre("%command", "serrated recade") then var total.volume 8
   if matchre("%command", "sterak axe") then var total.volume 9
   if matchre("%command", "katana") then var total.volume 12
   if matchre("%command", "tekkan") then var total.volume 14
   return
#=============================================================================================
get.density:
   var density 0
   if matchre("%command", "oravir") then var density 1
   if matchre("%command", "covellite") then var density 2
   if matchre("%command", "silversteel") then var density 2.2
   if matchre("%command", "tin|lumium|audrualm") then var density 3
   if matchre("%command", "zinc|glaes|animite") then var density 4
   if matchre("%command", "icesteel") then var density 4.5
   if matchre("%command", "muracite") then var density 4.7
   if matchre("%command", "iron|\bsteel\b|pewter|darkstone|niniam") then var density 5
   if matchre("%command", "kadepa") then var density 5.2
   if matchre("%command", "brass") then var density 5.8
   if matchre("%command", "nickle|damite|orichalcum|tyrium") then var density 6
   if matchre("%command", "vardite") then var density 6.1
   if matchre("%command", "bronze") then var density 6.2
   if matchre("%command", "copper|kertig") then var density 7
   if matchre("%command", "lead|\bsilver\b|haralun|electrum|niello") then var density 8
   if matchre("%command", "platinum|gold") then var density 9
   return
#=============================================================================================
get.filler:
   var filler.metal NONE
   if ("%filler.volume" = "0") then return
   evalmath temp.density (%filler.weight/%filler.volume)
   if ("%temp.density" = "1") then var filler.metal Oravir
   if ("%temp.density" = "2") then var filler.metal Covellite
   if ("%temp.density" = "3") then var filler.metal Tin
   if ("%temp.density" = "4") then var filler.metal Zinc
   if ("%temp.density" = "5") then var filler.metal Iron, Steel, or Pewter
   if ("%temp.density" = "6") then var filler.metal Nickle
   if ("%temp.density" = "6.2") then var filler.metal Bronze
   if ("%temp.density" = "7") then var filler.metal Copper
   if ("%temp.density" = "8") then var filler.metal Lead or Silver
   if ("%temp.density" = "9") then var filler.metal Gold or Platinum
   evalmath temp.metal (%temp.density*%filler.volume)
   if (%temp.metal > %filler.weight) then var filler.metal NONE
   if ("%filler.metal" = "NONE") then goto get.filler1
   return

get.filler1:
   evalmath filler.volume1 (%filler.volume-1)
   var filler.metal1 NONE
   gosub math1 9 "Gold or Platinum"
   gosub math1 8 "Lead or Silver"
   gosub math1 7 Copper
   gosub math1 6.2 Bronze
   gosub math1 6 Nickle
   gosub math1 5 "Iron, Steel or Pewter"
   gosub math1 4 Zinc
   gosub math1 3 Tin
   gosub math1 2 Covellite
   gosub math1 1 Oravir
   goto too.light

	math1:
	  var temp.density $1
	  var filler.metal1 $2
	  evalmath temp.weight (%temp.density*%filler.volume1)
	  if (%temp.weight >= %filler.weight) then return
	  evalmath filler.weight1 %temp.weight
	  goto get.filler2

get.filler2:
  var filler.volume2 1
  evalmath filler.weight2 (%total.weight-%main.weight-%filler.weight1)
  gosub math2 9 "Gold or Platinum"
  gosub math2 8 "Lead or Silver"
  gosub math2 7 Copper
  gosub math2 6.2 Bronze
  gosub math2 6 Nickle
  gosub math2 5 "Iron, Steel or Pewter"
  gosub math2 4 Zinc
  gosub math2 3 Tin
  gosub math2 2 Covellite
  gosub math2 1 Oravir
  if ("%filler.metal2" != "NONE") then
	{
	  var filler.weight2 %temp.density
	  goto done
	}
  goto error2

	math2:
	  var temp.weight $1
	  var temp.density $1
	  var filler.metal2 $2
	  if (%temp.weight = %filler.weight2) then goto done
	  if (%temp.weight > %filler.weight2) then return
	  if (%temp.weight < %filler.weight2) then goto too.heavy
	  return

#=============================================================================================
get.weapon:
   var weapon NONE
   if matchre("%command", "(mace|riste|\bdart\b|dagger|misericorde|briquet|carving knife|poignard|stiletto|pugio|throwing dagger|telek|short sword|kasai|takouba|katar|sunbladejambiya|leaf blade sword|nehlata|kris|falcata|dao|thrusting blade|rapier|koummya|kythe|foil|oben|pasabas)") then var weapon $0
   if matchre("%command", "(parang|mambeli|hanger|light throwing axe|scimitar|gladius|curlade|baselard|adze|sashqa|sabre|shotel|hatchet|hand axe|cutlass|arzfilt|broadsword|condottiere|kudalata|longsword|nehdalata|round axe|spatha|abassi|back-sword|cinqueda|dagasse|hunting sword)") then var weapon $0
   if matchre("%command", "(namkomba|nimsha|recade|hurling axe|falchion|battle axe|robe sword|schiavona|greataxe|marauder blade|two-handed sword|warring axe|karambit|claymore|twin-point axe|igorat axe|kaskara|shh'oi'ata|greatsword|flamberge|double axe|periperiu sword|boko|boomerang)") then var weapon $0
   if matchre("%command", "(gavel|prod|cudgel|cosh|scepter|zubke|short hammer|spiked gauntlet|bola|bulhawf|hand mallet|bludgeon|throwing club|cuska|club|garz|hand mace|ridged gauntlet|hhr'tami|komno|mallet|war club|war hammer|belaying pin|marlingspike|spiked club)") then var weapon $0
   if matchre("%command", "(spiked hammer|spiked mace|flanged mace|k'trinni sha-tai|ball and chain|heavy chain|horseman's flail|heavy mace|greathammer|imperial war hammer|double-headed hammer|\bhara\b|heavy mallet|sledgehammer|hhr'ata|hurlable war hammer|throwing hammer|throwing mallet)") then var weapon $0
   if matchre("%command", "(spiked ball and chain|spiked hara|morning star|ukabi|akabo|double-sided ball and chain|footman's flail|vilks kodur|war mattock|giant mallet|two-headed hammer|dire mace|heavy sledgehammer|maul|javelin|light spear|allarh|hunthsleg|bardiche|guisarme|lochaber axe)") then var weapon $0
   if matchre("%command", "(scythe|spear|duraka skefne|military fork|halberd|tzece|awgravet ava|coresca|khuj|glaive|partisan|two-pronged halberd|fauchard|ngalio|pole axe|ilglaiks skefne|lance|\bpike\b|ranseur|spetum|knuckle|elbow spike|knee spike|spiked knuckle|hand claw|nightstick|cane)") then var weapon $0
   if matchre("%command", "(quarterstaff|pike staff|throwing spike|thin-bladed fan|thick-bladed fan|half-handled riste|broadaxe|war sword|bastard sword|boarding axe|bar mace|splitting maul|hawkbill|serrated kudalata|serrated recade|sterak axe|katana|tekkan)") then var weapon $0
   return
#=============================================================================================
hone:
evalmath hone1 (%total.weight*.92)
evalmath hone2 (%total.weight-5)
if (%hone1 < %hone2) then var honed %hone1
if (%hone2 < %hone1) then var honed %hone2
if (%honed < %minimum.weight) then var honed %minimum.weight
return
#=============================================================================================
percents:
evalmath main.percent (%main.volume/%total.volume)
evalmath main.percent (%main.percent*100)
evalmath main.percent round(%main.percent, 2)
if (("%filler.metal1" = "NONE") && ("%filler.metal2" = "NONE")) then
	{
	  evalmath filler.percent (%filler.volume/%total.volume)
	  evalmath filler.percent (%filler.percent*100)
	  evalmath filler.percent round(%filler.percent, 2)
	}
	else
	{
	  evalmath filler.percent1 (%filler.volume1/%total.volume)
	  evalmath filler.percent1 (%filler.percent1*100)
	  evalmath filler.percent1 round(%filler.percent1, 2)
	  evalmath filler.percent2 (%filler.volume2/%total.volume)
	  evalmath filler.percent2 (%filler.percent2*100)
	  evalmath filler.percent2 round(%filler.percent2, 2)
	}
return
#=============================================================================================