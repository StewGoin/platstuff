#debug 5
# combine with aon and use aliases
# add detection for swapping?

pause 0.5

IF_1 goto TOP
else goto EXIT

TOP:
if "%2" = "$curr_armor" then
{
	echo "Already wearing that!"
	goto EXIT
}
IF_2 goto %2

MAIN:
gosub MAIN_ARMOR
var curr_armor main
if "$curr_armor" != "main" then goto SWAP
else goto %1
MAIN_ARMOR:
	var handarmor ring.gloves
	var headarmor ring.balaclava
	var chestarmor ring.shirt
	var legarmor ring.greaves
	return

CLOWN:
gosub CLOWN_ARMOR
var curr_armor clown
if "$curr_armor" != "clown" then goto SWAP
else goto %1
CLOWN_ARMOR:
	#var handarmor leather.gloves
	#var headarmor scale.balaclava
	#var chestarmor ring.shirt
	var handarmor ring.gloves
	var headarmor ring.balaclava
	var chestarmor ring.shirt
	var legarmor leather.pants
	return

DEFENSE:
gosub DEFENSE_ARMOR
var curr_armor defense
if "$curr_armor" != "defense" then goto SWAP
else goto %1
DEFENSE_ARMOR:
	#var handarmor leather.gloves
	#var headarmor scale.balaclava
	#var chestarmor ring.shirt
	var handarmor chain.gloves
	var headarmor chain.balaclava
	var chestarmor chain.hauberk
	var legarmor null
	return

OFF:
	action goto off_start when ^\.\.\.wait|^Sorry, you may only type|You don't seem to be able to move to do that|Roundtime
	off_start:
	pause 0.5
	put look in my portal
	#put remove my $buckler;stow my $buckler
	pause 0.5
	put remove my %headarmor
	gosub put my %headarmor in my portal
	pause 0.5
	put remove %handarmor
	gosub put my %handarmor in my portal
	pause 0.5
	put remove my %chestarmor
	gosub put my %chestarmor in my portal
	pause 0.5
	if "$curr_armor" != "defense" then put remove my $armor_legs
	if "$curr_armor" != "defense" then gosub put my $armor_legs in my portal
	#pause 0.5
	#put remove my armguard
	#gosub put my armguard in my portal
	pause 0.5
	put remove my claws
	gosub put my claws in my portal
	pause 0.5
	put remove my footwraps
	gosub put my footwraps in my portal
	pause 0.5
	put get my hat;wear my hat
	put echo Armor Off
	put #var curr_armor none
	goto EXIT

ON:
	action goto on_start when ^\.\.\.wait|^Sorry, you may only type|You don't seem to be able to move to do that|Roundtime
	start:
	#pause 0.5
	#put remove my $buckler;stow my $buckler
	pause 0.5
	put look in my portal
	pause 0.5
	put get my %headarmor from my portal; get my %headarmor
	put wear my %headarmor
	pause 0.5
	put get my %handarmor from my portal; get my %handarmor
	put wear my %handarmor
	pause 0.5
	put get my %chestarmor from my portal; get my %chestarmor
	put wear my %chestarmor
	pause 0.5
	if "%curr_armor" != "defense" then put get my %legarmor from my portal; get my %legarmor
	if "%curr_armor" != "defense" then put wear my %legarmor
	pause 0.5
	put get my armguard from my portal; get my armguard
	put wear my armguard
	pause 0.5
	put get my claws from my portal; get my claws
	put wear my claws
	pause 0.5
	put get my footwraps from my portal; get my footwraps
	put wear my footwraps
	pause 0.5
	put get my hat;wear my hat
	put echo %curr_armor On
	put #var curr_armor %curr_armor
	put sort auto head
	goto EXIT

SWAP:
	if ("%curr_armor" = "$curr_armor" ) then
	{
		echo "Already wearing %curr_armor!"
		goto EXIT		
	}
	if ("$curr_armor" = "main") then gosub MAIN_ARMOR
	if ("$curr_armor" = "clown") then gosub CLOWN_ARMOR
	if ("$curr_armor" = "defense") then gosub DEFENSE_ARMOR
	action goto swapp_off when ^\.\.\.wait|^Sorry, you may only type|You don't seem to be able to move to do that|Roundtime
	swapp_off:
	##pause 0.5
	##put remove my $buckler;stow my $buckler
	pause 0.5
	put look in my portal
	if ("$curr_armor" = "defense" || "%curr_armor" = "defense") then
	{
		pause 0.5
		put remove my %headarmor
		gosub put my %headarmor in my portal
		pause 0.5
		put remove %handarmor
		gosub put my %handarmor in my portal
		pause 0.5
		put remove my %chestarmor
		gosub put my %chestarmor in my portal
	}
	pause 0.5
	put remove my $armor_legs
	gosub put my $armor_legs in my portal
	pause 0.5
	if ("%curr_armor" = "main") then gosub MAIN_ARMOR
	if ("%curr_armor" = "clown") then gosub CLOWN_ARMOR
	if ("%curr_armor" = "defense") then gosub DEFENSE_ARMOR
	pause 0.5
	put get my %headarmor from my portal; get my %headarmor
	put wear my %headarmor
	pause 0.5
	put get my %handarmor from my portal; get my %handarmor
	put wear my %handarmor
	pause 0.5
	put get my %chestarmor from my portal; get my %chestarmor
	put wear my %chestarmor
	pause 0.5
	put get my %legarmor from my portal; get my %legarmor
	put wear my %legarmor
	pause 0.5
	put get my armguard from my portal; get my armguard
	put wear my armguard
	pause 0.5
	put get my claws from my portal; get my claws
	put wear my claws
	pause 0.5
	put get my footwraps from my portal; get my footwraps
	put wear my footwraps
	pause 0.5
	put echo %curr_armor On
	put #var curr_armor %curr_armor
	put sort auto head
	goto EXIT

include includes.cmd