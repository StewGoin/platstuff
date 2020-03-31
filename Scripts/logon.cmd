# Check existing classes / variables

waitforre Obvious paths|Obvious exits
pause
put #class almanac_timer True
put #class afk False
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
put #var GH_CYCLE_HUNT 0
vars bardspellsshort aban|aewo|alb|botf|care|dalu|drum|echo|ecry|eye|fae|gj|harmony|hodi|mis|name|nexus|pyre|rage|repr|sanctuary|soul|wotm|will|word
vars bardspellslong AbandonedHeart|AetherWolves|AlbredasBalm|BlessingoftheFae|CaressoftheSun|DamarisLullaby|DrumsoftheSnake|EchoesofAether|EilliesCry|EyeofKertigen|FaenellasGrace|GlythtidesJoy|Harmony|HodiernasLilt|Misdirection|NamingofTears|Nexus|PhoenixsPyre|RageoftheClans|RedeemersPride|Sanctuary|SoulAblaze|WhispersoftheMuse|WillofWinter|WordsoftheWind
var otherspellsshort ease|ghs|ignite|lw|maf|pfe
var otherspellslong EaseBurden|GhostShroud|Ignite|LayWard|ManifestForce|ProtectionfromEvil
var triggerspells %bardspellsshort|%otherspellsshort
var timerspells %bardspellslong|%otherspellslong
eval spellsize count("%triggerspells", "|")

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
put sort auto head
put #layout load default
var spellcount 0
check_loop:
	if %spellcount <= %spellsize then
	{
		put #var spell_%triggerspells(%spellcount)_isactive $SpellTimer.%timerspells(%spellcount).active
		math spellcount add 1
		goto check_loop
	}