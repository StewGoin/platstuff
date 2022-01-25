# Check existing classes / variables

waitforre Obvious paths|Obvious exits
pause
put #class almanac_timer True
put #class app False
put #class chatter True
put #class combat False
put #class disabled False
put #class first_aid True
put #class highlight True
put #class mana False
put #class silence False
put #class wounds False
put #class circuit false
put #class almanac_timer True
put #class egg_timer True
put #class hunt_timer True
put #class tarantula_timer True
put #class tattoo_timer True
put #var GH_CYCLE_HUNT 0
vars bardspellsshort aban|aewo|alb|botf|care|dalu|drum|echo|ecry|eye|fae|gj|harmony|hodi|mis|name|nexus|pyre|rage|repr|sanctuary|soul|wotm|will|word
vars bardspellslong AbandonedHeart|AetherWolves|AlbredasBalm|BlessingoftheFae|CaressoftheSun|DamarisLullaby|DrumsoftheSnake|EchoesofAether|EilliesCry|EyeofKertigen|FaenellasGrace|GlythtidesJoy|Harmony|HodiernasLilt|Misdirection|NamingofTears|Nexus|PhoenixsPyre|RageoftheClans|RedeemersPride|Sanctuary|SoulAblaze|WhispersoftheMuse|WillofWinter|WordsoftheWind
var otherspellsshort ease|ghs|ignite|lw|maf|pfe
var otherspellslong EaseBurden|GhostShroud|Ignite|LayWard|ManifestForce|ProtectionfromEvil
var damarisweapons sledgehammer|pike|stonebow|sling|quarterstaff|maul|greatsword|shortbow
eval damarissize count("%damarisweapons", "|")
var triggerspells %bardspellsshort|%otherspellsshort
var timerspells %bardspellslong|%otherspellslong
eval spellsize count("%triggerspells", "|")
action var armor "leather.pants" when ^You tap some stylish black diamond-hide leather pants belted with a swathe of dreamweave that you are wearing\.
action var armor $1.greaves when ^You tap some (?:\w+ )?(ring|coarse|scale|light)(?: plate)? greaves that you are wearing\.

var spellcount 0
disable_loop:
	if %spellcount <= %spellsize then
	{
		put #var spell_%triggerspells(%spellcount)_isactive 0
		if (not(matchre($SpellTimer.%timerspells(%spellcount).active, "0|1"))) then
			{
				put #var SpellTimer.%timerspells(%spellcount).active 0
				put #var SpellTimer.%timerspells(%spellcount).duration 0
			}
		math spellcount add 1
		goto disable_loop
	}

pause 2
put sort auto head; rub gweth
put #layout load default
var spellcount 0
check_loop:
	if %spellcount <= %spellsize then
	{
		put #var spell_%triggerspells(%spellcount)_isactive $SpellTimer.%timerspells(%spellcount).active
		math spellcount add 1
		goto check_loop
	}
put tap my greaves;tap my pants
pause 0.5
if %armor = "" then
{
	echo %armor
	exit
}
else put #var armor_legs %armor
pause
put look in my eddy
pause 0.5
put look in my portal
pause 0.5
var damariscount 0
damaris_loop:
	pause 0.5
	if %damariscount <= %damarissize then
	{
		put tap my Damaris %damarisweapons(%damariscount)
		math damariscount add 1
		goto damaris_loop
	}
exit