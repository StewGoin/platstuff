# Integrate & consolidate into repair stuff (use arrays!)
#debug 5
var shop 0
if_1 var shop 1
#vars items $buckler|$legarmor|$chestarmor|$handarmor|$headarmor|$armarmor|armguard|stirring.rod|bellows|shovel|ball.hammer|articulated.tongs|stamp|pickaxe|pliers|nightstick|mirror.axe|mirror.flail|throwing.mallet|iltesh|cuska|throwing.axe|throwing.axe|akabo|mirror.greatsword|latchbow|crossbow|arbalest|schiavona|thrusting.blade|mace|gladius|katana|quarterstaff|trident
#throwing.axe|throwing.axe|throwing.axe|throwing.axe|throwing.axe|throwing.axe|
#var metal ring.gloves|ring.balaclava|ring.shirt|ring.greaves|scale.greaves|coarse.greaves|light.greaves|chain.gloves|chain.balaclava|chain.hauberk|mirror.axe|mirror.flail|throwing.mallet|cuska|glaes.stars|glaes.stars|glaes.stars|glaes.stars|akabo|mirror.greatsword|mace|katana|longsword|wakizashi|allarh|svidaw.sis|pole.axe|nodachi|tachi|riste
#var leather leather.pants|coarse.greaves|pelletbow|latchbow|stonebow|staff|quarterstaff|Imperial.spear|sling

var all ring.gloves|ring.balaclava|ring.shirt|ring.greaves|scale.greaves|coarse.greaves|light.greaves|chain.gloves|chain.balaclava|chain.hauberk|armguard|mirror.axe|mirror.flail|cuska|glaes.stars|glaes.stars|glaes.stars|glaes.stars|akabo|stonebow|mace|katana|staff|wakizashi|Imperial.spear|allarh|sling|svidaw.sis|nodachi|tachi|riste|hirdu.bow|damaris.$damaris_current
var wornitems pole.axe|naginata
var portalitems ring.gloves|ring.balaclava|ring.shirt|ring.greaves|scale.greaves|coarse.greaves|light.greaves|leather.pants|chain.gloves|chain.balaclava|chain.hauberk

# Fix current offensive armor/weapons
#put carryall

var items %all
if_2 var items %%2
eval items_size count("%items", "|")
#echo %items
#exit

pause 0.5
put look in my portal
put store default backpack

if $humming = 0 then put hum concerto masterful

if %shop = 1 then goto repairshop
else goto repairsolo

repairsolo:
  var item_count 0
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
repairsolo_loop:
  if %item_count > %items_size then goto done
  pause .5
	put .fix %items(%item_count)
	waitfor ITEM FIXED
  evalmath item_count (%item_count + 1)
  goto repairsolo_loop


repairshop:
var item_count 0
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
#  gosub get throwing.axe from my carryall
#  gosub put my throwing axe in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  gosub get glaes.stars from my carryall
  gosub put my glaes.stars in my back
  pause 0.5
  put .armor swap main
  waitfor Script Done
	pause 0.5
	put ask %1 about repair all;ask %1 about repair all
	pause 0.5
	put carryall;stow ticket
	pause 0.5
var item_count 0
repairshop_loop:
  if %item_count > %items_size then goto repairshop_get
  pause .5
  if "%items(%item_count)" = "throwing.axe" then gosub get my %items(%item_count) from my back
  if "%items(%item_count)" = "glaes.stars" then gosub get my %items(%item_count) from my back
  if matchre("%items(%item_count)", "%wornitems") then 
  {
    put remove my %items(%item_count)
  }
  if matchre("%items(%item_count)", "%portalitems") then 
  {
    put get my %items(%item_count) from my portal
  }
  gosub get my %items(%item_count)
  put give %1;give %1
  pause .5
  if matchre("%items(%item_count)", "stirring.rod|bellows|shovel|ball.hammer|articulated.tongs|stamp|pickaxe|pliers") then put stow my %items(%item_count) in my $craftpack;stow ticket
  else put stow ticket;stow my %items(%item_count);wear my %items(%item_count)
  pause 0.5
  evalmath item_count (%item_count + 1)
  goto repairshop_loop

repairshop_get:
 	evalmath inttime $gametime + 180
	put #var repairtime %inttime
  
repairshop_get_1:
  if $gametime < $repairtime then
  {
    gosub ALMANAC_CHECK
    pause 20
    goto repairshop_get_1
  }
  else
  {
    put .getstuff %1
    waitfor Script Done
  }
  goto done  


done:
  var item_count 0
  eval items_size count("%portalitems", "|")
  gosub get glaes.stars from my backpack
  gosub put my glaes.stars in my carryall
  gosub get glaes.stars from my backpack
  gosub put my glaes.stars in my carryall
  gosub get glaes.stars from my backpack
  gosub put my glaes.stars in my carryall
  gosub get glaes.stars from my backpack
  gosub put my glaes.stars in my carryall
  PORTAL_ITEMS:
    if %item_count > %items_size then goto DONE_PORTAL
    pause 0.5
    put get my %portalitems(%item_count)
    pause 0.5
    put put my %portalitems(%item_count) in my portal
    evalmath item_count (%item_count + 1)
    goto PORTAL_ITEMS
DONE_PORTAL:
	put #parse Stuff Repaired
  exit

include includes.cmd