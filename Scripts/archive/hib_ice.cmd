# Validate and cleanup needed if.

shel_room_check:
	pause
	put #script abort enc;stop sing;release all
	pause
	var shel_rooms |24|32|45|46|47|48|49|50|51|52|53|54|55|57|58|59|60|87|168|169|175|
	if contains("%shel_rooms", "|$roomid|") then goto shel_$roomid
	goto shel_room_check	

shel_168:
	var from_shard 0
	var shelnorth 0
	gosub go_room 45
	goto shel_45
	
### Ice Area	
shel_45:
	if %shelnorth = 1 then
	{
		pause
		put unhide
		pause
		if %1 != "" then
		{
			gosub go_room 24
			exit
		}
		else
		{
			gosub go_room 169
			exit
		}
	}
	else
	{
		pause
		put #script abort enc
		put stop sing
		put release all
		pause
		put hide
		pause 2
		gosub move sneak se
	}
shel_46:
	if %shelnorth = 1 then
	{
		gosub move sneak nw
		goto shel_45
	}
	else
	{
		gosub move sneak se
	}
shel_47:
	if %shelnorth = 1 then
	{
		gosub move sneak nw
		goto shel_46
	}
	else
	{
		gosub move sneak e
	}
shel_48:
	if %shelnorth = 1 then
	{
		gosub move sneak w
		goto shel_47
	}
	else
	{
		gosub move sneak e
	}
shel_49:
	if %shelnorth = 1 then
	{
		gosub move sneak w
		goto shel_48
	}
	else
	{
		gosub move sneak ne
	}
shel_50:
	if %shelnorth = 1 then
	{
		gosub move sneak sw
		goto shel_49
	}
	else
	{
		gosub move sneak se
	}
shel_51:
	if %shelnorth = 1 then
	{
		gosub move sneak nw
		goto shel_50
	}
	else
	{
		gosub move sneak sw
	}
shel_52:
	if %shelnorth = 1 then
	{
		gosub move sneak ne
		goto shel_51
	}
	else
	{
		gosub move sneak sw
	}
shel_53:
	if %shelnorth = 1 then
	{
		gosub move sneak ne
		goto shel_52
	}
	else
	{
		gosub move sneak sw
	}
shel_54:
	if %shelnorth = 1 then
	{
		gosub move sneak ne
		goto shel_53
	}
	else
	{
		gosub move sneak w
	}
shel_55:
	if %shelnorth = 1 then
	{
		gosub move sneak e
		goto shel_54
	}
	else
	{
		gosub move sneak sw
	}
shel_57:
	if %shelnorth = 1 then
	{
		gosub move sneak ne
		goto shel_55
	}
	else
	{
		gosub move sneak sw
	}
shel_58:
	if %shelnorth = 1 then
	{
		gosub move sneak ne
		goto shel_57
	}
	else
	{
		gosub move sneak se
	}
shel_59:
	if %shelnorth = 1 then
	{
		gosub move sneak nw
		goto shel_58
	}
	else
	{
		gosub move sneak bridge
	}
shel_60:
	if %shelnorth = 1 then
	{
		pause
		put #script abort enc
		put stop sing
		put release all
		pause
		put hide
		pause 2
		gosub move sneak nw
		goto shel_59
	}
	else
	{
		pause
		put unhide
		pause	
		gosub go_room 175
		exit
	}

shel_87:
	var from_shard 1
	var shelnorth 1
	gosub go_room 60
	goto shel_60
	
include includes.cmd
