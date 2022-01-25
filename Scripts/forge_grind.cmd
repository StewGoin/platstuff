# Integrate with the forging scripts, etc...

### Weapons Grinding
### USAGE .grind <weapon> <balance|hone>
#debug 5
### Close inspection of the honing process shows it was ineffective, and caused significant damage to the cane.

#put .enc harmony 40 quiet

if ("%1" = "") then
{
	echo USAGE .grind <weapon> <balance|hone|lighten|reinforce>
	exit
}
else put #var grinditem %1

if matchre(tolower("%2"), "(bal|hon|lig|rei)") then
{
	var tech $1
	if "%tech" = "bal" then
  {
    var tech weapon.balancing
    var book weapon
  }
	elseif "%tech" = "hon" then
  {
    var tech weapon.honing
    var book weapon
  }
  elseif "%tech" = "lig" then
  {
    var tech armor.lightening
    var book armor
  }
  if "%tech" = "rei" then
  {
    var tech armor.reinforcing
    var book armor
  }
}	
else echo USAGE .grind <weapon> <balance|hone|lighten|reinforce>

#if $need_oil = 1 then
#{
#	put .forgebuy oil
#	waitfor Item Bought
#}
#if $need_brush = 1 then
#{
#	put .forgebuy brush
#	waitfor Item Bought
#}

pause
gosub get my $grinditem

BEGIN:
	pause 1
	if matchre(tolower("$lefthandnoun"), "$grinditem") then
	{
		put swap
		goto BEGIN
	}
	gosub put my $lefthandnoun in my $craftpack

GRIND_TECH:
	put .craftbook %book %tech
	waitfor Book Turned
	pause 0.5
	put study my book
	pause
	#gosub put my book in my $craftpack
	if "%book" = "weapon" then
  {
   	gosub get my wire brush
    goto GRINDER
  }
  else goto ARMOR_PREP

ARMOR_PREP:
  gosub get my $grinditem
  gosub get my $pliers
  goto ARMOR_PREP_PULL

ARMOR_PREP_PULL:
  match ARMOR_PREP_POUND Roundtime
	put pull my $grinditem with my $pliers
	matchwait 2
	goto ARMOR_PREP_PULL
  
ARMOR_PREP_POUND:
  gosub put my $pliers in my $craftpack
  gosub put my $grinditem on anvil
  gosub get my $hammer
  gosub get my $tongs
  match ARMOR_PREP_GRIND Roundtime
  put pound $grinditem with hammer
  matchwait 2
  goto ARMOR_PREP_POUND

ARMOR_PREP_GRIND:
	gosub PUT my $lefthandnoun in my $craftpack
	gosub PUT my $righthandnoun in my $craftpack
  gosub get $grinditem from anvil

GRINDER:
	match GRINDER Roundtime
	match GRINDER It seems to be picking up speed now but is still rather slow.
	match GRINDER Ok, it seems to be picking up speed now, though still rather slow.
	match GRIND_IT Straining a bit less you add force to the grindstone, making it spin even faster.
	match GRIND_IT Straining a bit less you maintain force to the grindstone, keeping it spinning fast.
	put turn grind
	matchwait 2
	goto GRINDER

GRIND_IT:
  match ARMOR_POST armor now needs reassembly with a hammer
	match OIL With grinding complete
	match CLEANING that should be cleaned away.
	match GRINDER The grinding wheel is not spinning fast enough
	match GRINDER Roundtime
	put push grindstone with my $grinditem
	matchwait 5
	goto GRIND_IT
	
CLEANING:
	matchre CLEANING_GET_BRUSH ^You rub
	match CLEANING_GET_BRUSH You must be holding
	match OIL With grinding complete
	match GRINDER Roundtime
	put rub my $grinditem with my wire brush
	matchwait 2
	goto CLEANING
	
CLEANING_GET_BRUSH:
  gosub get my wire brush
	goto CLEANING

ARMOR_POST:
  gosub put my $grinditem on anvil
  gosub get my $hammer
  gosub get my $tongs
  
ARMOR_POST_POUND:
  match ARMOR_POST_PREP Roundtime
  put pound $grinditem with hammer
  matchwait 2
  goto ARMOR_POST_POUND

ARMOR_POST_PREP:
	if (("$lefthandnoun" <> "hammer") || ("$lefthandnoun" <> "tongs")) then gosub PUT my $lefthandnoun in my $craftpack
	if (("$righthandnoun" <> "hammer") || ("$righthandnoun" <> "tongs")) then gosub PUT my $righthandnoun in my $craftpack
  gosub get $grinditem from anvil
  if "%tech" = "weapon.honing" then goto ARMOR_POST_PULL
  gosub get my leather strip from $craftpack
  put assemble my $grinditem with my leather strips

ARMOR_POST_PULL:
  gosub get my $pliers
  match ARMOR_POST_DONE oil to preserve and protect it
  match ARMOR_POST_DONE Roundtime
	put pull my $grinditem with my $pliers
	matchwait 2
	goto ARMOR_POST_PULL

ARMOR_POST_DONE:
  gosub put my $pliers in my $craftpack
  goto OIL
	
OIL:
	if ("$lefthandnoun" <> "") then gosub PUT my $lefthandnoun in my $craftpack
	gosub GET oil from my $craftpack
OIL_1:
	match OILED Roundtime
	put pour my oil on my $grinditem
	matchwait 2
	goto OIL_1
OILED:
	gosub PUT my oil in my $craftpack
#	pause 5
#	put .forgeapp
#	pause
#	put anal my $grinditem
#	pause 5
#	put app my $grinditem careful
	pause
	put #parse Item Ground
	exit

include includes.cmd
