#put loot all
put loot %1
match box was carrying
match box You find nothing
match box I could not find
matchwait

box:
put stow box
match gem You pick up
match gem Stow what?
matchwait

gem:
put stow gem
match gem You pick up
match coins Stow what?
matchwait

coins:
if matchre("$roomobjs", "(platinum|gold|silver|bronze|copper) (coin|coins)") then
{
	put stow $1 $2
	waitfor You pick up
		goto coins
}
else
{
	goto metal
}

metal:
if matchre("$roomobjs", "(platinum|gold|silver|bronze|brass|electrum|pewter) (nugget|bar)") then
{
	put stow $1 $2
	waitfor You pick up
		goto coins
}
else
{
	goto extras
}

extras:
if matchre("$roomobjs", "(seishaka leaf|scroll|tablet|vellum|sheiska leaf|ostracon|hhr'lav'geluhh bark|papyrus roll|smudged parchment|lockpick|map|dira|card)") then
{
	put stow $1
	waitfor You pick up
		goto extras
}
else
{
	goto powder
}

powder:
if matchre("$roomobjs", "(deep violet powder|bright green powder)") then
{
	put stow powder
	waitfor You pick up
		goto powder
}
else
{
	goto gweth
}

gweth:
if matchre("$roomobjs", "(kyanite gwethdesuan|jadeite gwethdesuan)") then
{
	put get gweth
	put stow gweth
	waitfor You pick up
		goto gweth
}
else
{
	goto special
}


special:
if matchre("$roomobjs", "(rackensprocket|nut|gear|glarmencoupler|spangleflange|flarmencrank|scrip|metal strip|wire-bristled brush|tooth)") then
{
	put stow $1
	waitfor You pick up
		goto special
}
else
{
	goto gear
}

gear:
if matchre("$roomobjs", "(bola|throwing blade|obsidian shard|quartzite shard|stone shard)") then
{
	put stow $1
	waitfor You pick up
		goto special
}
else
{
	exit
}