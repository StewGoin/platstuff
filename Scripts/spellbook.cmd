# Cleanup and see if I even have one anymore (or buy one)

var max.chapter 7

if $spellbooktime < $gametime then goto start
else goto alldone

observe:
	matchre observe ^\.\.\.wait|^Sorry
	matchre bad.weather rain|raining|snow|snowing|blizzard|Snow|Rain|Raining|Snowing|Blizzard|drizzle|drizzling|overcast|quite cloudy
	matchre return That's a bit hard to do while inside|You glance up at the sky|You glance outside
	put obs wea
	matchwait 3
	goto bad.weather

bad.weather:
	echo bad weather
	goto alldone
	exit

return:
	return

start:
	evalmath inttime $gametime + 3660
	put #var spellbooktime %inttime
	var chapter 1
	var page 1

get:
	gosub observe
	if "$righthandnoun" = "spellbook" then goto open.book
	put get my spellbook case
	wait
	put open my spell case
	waitforre ^You open|^That is already
	put turn my spell case to spellbook
	waitforre ^You shift|^The compartment
	put get my spellbook
	waitforre ^You get
	put stow my spellbook case
	waitforre ^You put your

open.book:
	matchre open.book ^\.\.\.wait|^Sorry,
	matchre chapter ^You open|^That is already
	matchre open.lock ^You'll need to
	matchre unlock ^You try to
	put open my spellbook
	matchwait

open.lock:
	matchre open.lock ^\.\.\.wait|^Sorry,
	matchre open.book ^You carefully detach
	matchre unlock ^The platinum dragon
	put open my bloodlock
	matchwait

unlock:
	put turn my spellbook case to misc
	waitforre ^You shift|^The compartment
	put get key in my spellbook case
	waitforre ^You get
	put unlock my spellbook with my key
	waitforre ^You insert
	put put my key in my spellbook case
	waitforre ^You tuck|^You put
	goto open.lock

next.chapter:
	#put hum $hum
	gosub observe
	math chapter add 1
	var page 1
	chapter:
	if %chapter = %max.chapter then goto done
	matchre chapter ^\.\.\.wait|^Sorry,
	matchre page ^You turn
	put turn my spellbook to chapter %chapter
	matchwait

next.page:
	math page add 1

page:
	matchre page ^\.\.\.wait|^Sorry,
	matchre study ^You turn
	matchre next.chapter ^There are only
	put turn my spellbook to page %page
	matchwait

study:
	matchre study ^\.\.\.wait|^Sorry,
	matchre exp ^You carefully
	matchre next.chapter ^That's odd
	put study my spellbook
	matchwait

exp:
	if $Scholarship.LearningRate > 30 then goto done
	goto next.page

done:
	put close my spellbook
	waitforre ^You close
	put get my spellbook case
	waitforre ^You get
	#put turn my spellbook case to misc
	#waitforre ^You shift|^The compartment
	#put get key in my spellbook case
	#waitforre ^You get
	#put close my bloodlock
	#waitforre ^You pull|^It's already
	#put lock my spellbook with my key
	#waitforre ^You insert
	#put put my key in my spellbook case
	#waitforre ^You tuck|^You put
	#put turn my spellbook case to spellbook
	#waitforre ^You shift|^The compartment
	put put my spellbook in my spellbook case
	waitforre ^You tuck|^What were
	put close my spellbook case
	put remove my spellbook case
	wait
	put stow my spellbook case
	wait

alldone:
	pause
	put #parse Script Done
	exit
