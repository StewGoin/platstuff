# Integrate & consolidate into repair stuff (use arrays!)
#debug 5
var shop 0
if_1 var shop 1
#vars items $buckler|$legarmor|$chestarmor|$handarmor|$headarmor|$armarmor|parry.stick|stirring.rod|bellows|shovel|ball.hammer|articulated.tongs|stamp|pickaxe|pliers|nightstick|mirror.axe|mirror.flail|throwing.mallet|iltesh|cuska|throwing.axe|throwing.axe|throwing.axe|throwing.axe|throwing.axe|throwing.axe|akabo|mirror.greatsword|latchbow|crossbow|arbalest|schiavona|thrusting.blade|mace|gladius|katana|quarterstaff
vars items light.spear|mirror.axe|mirror.flail|throwing.mallet|iltesh|cuska|throwing.axe|akabo|mirror.greatsword|pelletbow|latchbow|mace|gladius|katana|quarterstaff|longsword|wakizashi|nodachi|pole.axe|naginata|allarh|chakram
var wornitems pole.axe|naginata
eval items_size count("%items", "|")

# Fix current offensive armor/weapons
#put carryall

if %shop = 1 then goto repairshop
else goto repairsolo

repairsolo:
  var item_count 0
  gosub get throwing.axe from my carryall
  gosub put my throwing axe in my back
  gosub get throwing.axe from my carryall
  gosub put my throwing axe in my back
  gosub get throwing.axe from my carryall
  gosub put my throwing axe in my back
  gosub get throwing.axe from my carryall
  gosub put my throwing axe in my back
  gosub get throwing.axe from my carryall
  gosub put my throwing axe in my back
  gosub get throwing.axe from my carryall
  gosub put my throwing axe in my back
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
  pause
	put .aon
	waitfor Armor On
	pause
	put ask %1 about repair all;ask %1 about repair all
	pause
	put carryall;stow ticket
	pause
var item_count 1
repairshop_loop:
  if %item_count > %items_size then goto repairshop_get
  pause .5
  #if "%items(%item_count)" = "throwing.axe" then gosub get my %items(%item_count) from my back
  if matchre("%items(%item_count)", "%wornitems") then 
  {
    put remove my %items(%item_count)
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
	put #parse Stuff Repaired
  exit

include includes.cmd
