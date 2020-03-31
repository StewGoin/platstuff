var ADJUST 0
var BONE 0
setvariable is_bone %1

ACTION var ADJUST 1 WHEN an uneven texture along its surface.
ACTION var ADJUST 1 WHEN determine it is no longer level.
ACTION var ADJUST 2 WHEN jagged edges protruding
ACTION var ADJUST 2 WHEN jagged shards protruding
ACTION var ADJUST 3 WHEN finishing you see some discolored areas 
ACTION var ADJUST 9 WHEN you complete working on

book:
if (%is_bone = stack) then
{
	echo HEY, BONE!
	var BONE 1
	var item bone.%2
	put .craftbook carving %item
	waitfor Book Turned
	put study my book
	waitfor Roundtime
	put stow book
	waitfor You put
		goto get_primary
}
elseif (%is_bone = stack) then
{
	echo HEY, STONE!
	var item %2
	put .craftbook carving %item
	waitfor Book Turned
	put study my book
	waitfor Roundtime
	put stow book
	waitfor You put
		goto get_primary
}

get_primary:
if (%BONE = 0) then
{
	put get my chisel from my toolbox
}
elseif (%BONE = 1) then
{
	put get my saw from my backpack
}

Waitfor You get

if (%BONE = 0) then
{
	put carve %1 with my chisel
}
else
{
	put carve %1 with my saw
}
waitfor Roundtime
put drop %2
pause 1
	goto carve

carve:
	if (%ADJUST = 0) then
	{
		echo %ADJUST
		if (%BONE = 0) then
		{
			put carve %2 with my chisel
		}
		elseif (%BONE = 1) then
		{
			put carve %2 with my saw
		}
		waitfor Roundtime
			goto carve
	}
  	elseif (%ADJUST = 1) then
	{
		echo %ADJUST
		var ADJUST 0
		put get my rasp
		waitfor You get
		put scrape %2 with rasp
		waitfor Roundtime
		put put my rasp in my toolbox
		waitfor You put your
			goto carve
	}
	elseif (%ADJUST = 2) then
	{
		echo %ADJUST
		var ADJUST 0
		put get my riffler
		waitfor You get
		put rub %2 with my riffler
		waitfor Roundtime
		put put my riffler in my toolbox
		waitfor You put your
			goto carve
	}
	elseif (%ADJUST = 3) then
	{
		echo %ADJUST
		var ADJUST 0
		put get my surface polish
		waitfor You get
		put apply polish to %2
		waitfor Roundtime
		put put my surface polish in my toolbox
		waitfor You put your
			goto carve
	}
	else
	{
		if (%BONE = 0) then
		{
			put put chisels in my toolbox
		}
		elseif (%BONE = 1) then
		{
			put put saw in my backpack
		}	
		
		waitfor You put
		put get my stamp
		waitfor You get
		put mark %2 with my stamp
		waitfor Roundtime
		put put my stamp in my toolbox
		waitfor You put
		put get %2
			goto end
	}
end:
exit
