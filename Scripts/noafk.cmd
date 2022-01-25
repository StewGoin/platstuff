# Can this be integrated into Base? Cleanup.

#noafk.cmd

loop:
	echo *****************************************
	echo *********** NOAFK proteciton active ***********
	echo *****************************************
pause 180
gosub you_there
goto loop

you_there:
	match return Yes, I am indeed still here at the keyboard.
	put #echo >Log Red AFK Check
	echo *****************************************
	echo *********** Please type F5 to go on ***********
	echo *****************************************
	matchwait 15
	put #script pause all except noafk;-2 stop sing;-stop play;-2 sleep
	put #echo >Log Red AFK Protection Activated
shard_check:
	if ($zoneid = 67 && $roomid = 205) then
	{
		pause
		put stow
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put pyron
			pause 6
			if matchre("$roomobjs", "pyramid|Pyramid") then goto shard_check
		}
		gosub go_room 684
		put hide
	}
	waitfor Yes, I am indeed still here at the keyboard.
	put awake;-2#script resume;#parse You stop performing
	return

include includes.cmd
