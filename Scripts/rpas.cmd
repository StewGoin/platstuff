RPA:
var names none
var treznames Trezivia|Ulfsisk|Kariline|Kateryin|Sharon|Karrisa|Kyzain
var assbaggins Beethoven|Obsession|Luscious|Blushingly|Brr|Nda|Zba|Bkeesawn|Jaw|Zenjolia|Slarty|Einaklina|Leddle|Aline|Hus|Die|Valihai|Noot|Duckz|Banacheque|Roxit|Starlingz|Empuff|Ergo|Kla|Eon|Hind|Bonnyleigh|Zba|Ioa|Shocka|Pattywhack|Boogaloo|Nissa|Yaya|Ony|Iskosa|Quelafiction|Atoria|Tarven|Zlindria|Gwenii|Djinnii|Aser|Dveight|Rakem|Oeo|Akee|Ais|Moxie|Atoria|Roxit
var blacklist %treznames|%assbaggins

action (rpa) var names %names|$0 when (([a-zA-Z]+)(\s|$))
action goto DONE when You cannot do that again yet|You do not have enough PIRP points to do that
put who full
pause 0.5

action (rpa) off

eval names replacere("%names", "none\|Brave Adventurers Questing:\|", "")
eval names replacere("%names", "\|Online Players:.*", "")
eval names replacere("%names", "(\s+)", "|")

	var names_count 0
	eval names_size count("%names", "|")
	if %names_size <= 1 then goto DONE
RPA_1:
    if %names_count > %names_size then goto DONE
    pause 0.5
    if !matchre("%names(%names_count)", "%blacklist|$charactername") then put rpa bestow %names(%names_count) 1
    evalmath names_count (%names_count + 1)
    goto RPA_1

DONE:
	put #parse Script Done
	exit