# Update for 3.0, clean, and integrate includes, etc...

#debug 5
#critter -- ape = 1 (boar) | malchata = 2 (str)| shalswar = 3 (west gate)
#if $critter = "" then put #var critter ape
put #script abort all except train
put .afk on
#var twiddle off
var from_mining 1
put #var backhunting 1
pause 2
put unload
pause 2
put awaken
put #var GH_RANGED OFF;#var GH_MAGIC_TYPE OFF;#var GH_AMBUSH OFF;#var GH_MAGIC OFF;#var GH_XPTYPE "";#var GH_BACKTRAIN OFF;#var GH_SETUP 0
put stance set $shieldstance
var wounded 0
var repaired 0
gosub health_check
put #var save
if_1 put #var hunting 2

pause
put sheath;stow;stow left
pause

if $roomid = 481 then goto map_check
if $roomid = 205 then
{
	put .aoff
	waitfor Armor Off
	goto map_check
}

#put .armorswap headarmor main
#waitfor Armor Swapped
#pause
put .aon
waitfor Armor On

action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
goto map_check
exit

### Includes
include includes.cmd


map_check:
	if "$zoneid" = "66" then goto str_room_check
	if "$zoneid" = "67" then goto shard_room_check
	if "$zoneid" = "68" then goto south_room_check
	if "$zoneid" = "69" then goto west_room_check
	if "$zoneid" = "68a" then goto cave_prospect
	if "$zoneid" = "116" then goto hib_room_check
	if "$zoneid" = "123" then goto shel_room_check
	if "$zoneid" = "126" then goto hawk_room_check
	if "$zoneid" = "127" then goto boar_room_check

exit

### Himineldar Shel Portion
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
	gosub go_room 24
	goto shel_24
shel_24:	
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .prospect scan
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	waitfor Script Done
shel_32:
	gosub go_room 45
	goto shel_45
	

	
### Ice Area	
shel_45:
	if %shelnorth = 1 then
	{
		pause
		put unhide
		pause
		gosub go_room 169
		goto hib_room_check
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
		goto west_room_check
	}

shel_87:
	var from_shard 1
	var shelnorth 1
	gosub go_room 60
	goto shel_60
	
### Hibarnhvidar Portion
hib_room_check:

	var hib_rooms |1|3|24|66|193|194|218|298|320|336|400|
	if contains("%hib_rooms", "|$roomid|") then goto hib_$roomid

	else gosub go_room 400
	goto hib_room_check

hib_193:
hib_194:
hib_298:
hib_336:	

hib_1:
hib_3:
	goto hib_from_mining
	
hib_from_mining:
	gosub go_room 217
	goto hawk_room_check


hib_400:
	if %wounded = 1 then
	{
		if contains("$roomplayers", "Also here") then
		{
			put wave
			put #play abort;#play abort
			put #echo >Events Red ROOM OCCUPIED
			put #echo White,Red ROOM OCCUPIED
			gosub go_room 173
			exit
		}
		else gosub healing
	}
	if %repaired = 0 then
	{
		gosub go_room 218
		goto hib_fur
	}
	goto hib_to_twiddle

hib_to_twiddle:
	gosub go_room 66
	goto hib_twiddle

hib_fur:
hib_218:
	pause
	put get hide from bundle
	pause
	put stow hide
	pause
	put remove my bundle
	pause
	put sell my bundle
	pause
	put get rope from my cloak
	pause
	put get my hide
	pause
	put bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put wear my bundle
	pause
	gosub go_room 320
	goto hib_repair
	
hib_repair:
hib_320:
	put sheath
	pause
	put .repairstuff Tuzra
	waitfor Script Done
	pause
	match hib_repair_waiting You tap
	match hib_equipped I could not find
	put tap my ticket
	matchwait 2
	hib_repair_waiting:
	gosub repair_waiting
	pause
	put stow right;stow left;sheath
	pause
	hib_equipping:
		match hib_items_stow You get
		match hib_equipped What were you referring to
			put get my ticket
		matchwait
	hib_items_stow:
	put give Tuzra
	waitforre You hand
	waitfor Script Done
	goto hib_equipping
	hib_equipped:
	var repaired 1
	pause
	goto hib_to_twiddle
	
hib_24:
	if %wounded = 1 then
	{
		gosub go_room 400
		goto hib_400
	}
	goto hib_to_twiddle
	
hib_twiddle:
hib_66:
	pause
#	put .pyramids off
#	waitfor Pyramids Off
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .twiddle off
	waitfor Twiddle Done
	put #script abort noafk
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put .pyramids on
		waitfor Pyramids On
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
	gosub go_room 3
	goto shel_room_check

### Hawkstaal Road Portion
hawk_room_check:

	var hawk_rooms |102|48|
	if contains("%hawk_rooms", "|$roomid|") then goto hawk_$roomid

	else gosub go_room 103
	goto boar_room_check

hawk_48:
	gosub go_room 103
	goto boar_room_check

hawk_102:
	gosub go_room 49
	goto hib_room_check
	
### Boar Clan Portion
boar_room_check:

	var boar_rooms |2|14|32|49|50|97|109|163|117|176|510|
	if contains("%boar_rooms", "|$roomid|") then goto boar_$roomid

	else
	{
		gosub go_room 2
		gosub go_room 32
	}
	goto boar_room_check
	
boar_14:
	gosub go_room 32
	goto boar_32

boar_twiddle:
boar_32:
	pause
#	put .pyramids off
#	waitfor Pyramids Off
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .twiddle off
	waitfor Twiddle Done
	put #script abort noafk
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put .pyramids on
		waitfor Pyramids On
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
	if $hunting = 0 then goto boar_to_hawk
	gosub go_room 2
	goto boar_2

boar_2:
boar_163:
	if $hunting = 0 then goto boar_to_hawk
#	if $Mechanical_Lore.LearningRate <= 2 then goto boar_to_twiddle
	pause
	put stop sing
	put .maf;.mafwatch
	waitfor Face what?
	pause
	put .armorswap headarmor primary
	waitfor Armor Swapped
	pause
	put .aon
	waitfor Armor On
	pause
	gosub go_room 163
	gosub go_room 166
	gosub go_room 167
	gosub go_room 168
	gosub go_room 171
	pause 6
	gosub move e
	gosub go_room 176
	put #var hunting 1
	put .combat
	exit

boar_97:
boar_176:
boar_109:
	pause
	if matchre("$roomobjs", "an elongated granite stone") then
	{
		gosub stow elong.stone
		goto str_481
	}
	if matchre("$roomobjs", "a dark bronze blade") then
	{
		gosub THROWN_CLEAN dark.blade
		goto str_481
	}
	if matchre("$roomobjs", "some dark bronze blades") then
	{
		gosub THROWN_CLEAN dark.blade
		goto str_481
	}
	if matchre("$roomobjs", "throwing club") then
	{
		gosub THROWN_CLEAN club
		goto str_481
	}
	if matchre("$roomobjs", "war hammer") then
	{
		gosub THROWN_CLEAN war.hammer
		goto str_481
	}
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put .pyramids on
		waitfor Pyramids On
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
	pause
	put stop sing
	put .retreat
	pause
	put #var hunting 1

	gosub go_room 171
	pause 6
	gosub move se
	gosub go_room 167
	gosub go_room 166
	gosub go_room 163
	gosub go_room 117
	goto boar_117
	
boar_117:
	gosub go_room 2
	gosub go_room 49
	goto boar_fur

boar_49:
boar_fur:
	pause
	put get hide from bundle
	pause
	put stow hide
	pause
	put remove my bundle
	pause
	put sell my bundle
	pause
	put get rope from my cloak
	pause
	put get my hide
	pause
	put bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put wear my bundle
	pause
	if $wounded = 1 then goto boar_to_hawk
	gosub go_room 50
	goto boar_repair
	
boar_repair:
boar_50:
	put sheath
	pause
	put .repairstuff Tuzra
	waitfor Script Done
	pause
	match boar_repair_waiting You tap
	match boar_equipped I could not find
	put tap my ticket
	matchwait 2
	boar_repair_waiting:
	gosub go_room 37
	gosub repair_waiting
	gosub go_room 50
	pause
	put stow right;stow left;sheath
	pause
	boar_equipping:
		match boar_items_stow You get
		match boar_equipped What were you referring to
			put get my ticket
		matchwait
	boar_items_stow:
	put give Tuzra
	waitforre You hand
	waitfor Script Done
	goto boar_equipping
	boar_equipped:
	var repaired 1
	pause
	goto boar_to_hawk
	
boar_to_twiddle:
	gosub go_room 32
	goto boar_twiddle

boar_to_hawk:
		gosub go_room 510
		goto hawk_room_check	
	
### Southern Traderoute Portion
str_room_check:

	var str_rooms |26|43|44|64|65|69|70|234|481|496|
	if contains("%str_rooms", "|$roomid|") then goto str_$roomid

	else gosub go_room 65
	goto str_room_check	

str_43:
str_44:
	if $Mechanical_Lore.LearningRate <= 5 then goto str_481
	gosub go_room 26
	goto str_26

str_26:
	if $Mechanical_Lore.LearningRate <= 5 then goto str_481
	pause
	put stop sing
	put .maf;.mafwatch
	waitfor Face what?
	pause
	put .armorswap headarmor primary
	waitfor Armor Swapped
	pause
	put .aon
	waitfor Armor On
	pause
	gosub go_room 481
	put #var hunting 1
	put .combat
	exit
	
str_481:
	pause
	if matchre("$roomobjs", "an elongated granite stone") then
	{
		gosub stow elong.stone
		goto str_481
	}
	if matchre("$roomobjs", "a dark bronze blade") then
	{
		gosub THROWN_CLEAN dark.blade
		goto str_481
	}
	if matchre("$roomobjs", "some dark bronze blades") then
	{
		gosub THROWN_CLEAN dark.blade
		goto str_481
	}
	if matchre("$roomobjs", "throwing club") then
	{
		gosub THROWN_CLEAN club
		goto str_481
	}
	if matchre("$roomobjs", "war hammer") then
	{
		gosub THROWN_CLEAN war.hammer
		goto str_481
	}
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put .pyramids on
		waitfor Pyramids On
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
	pause
	put stop sing
	put .retreat
	pause
	put #var hunting 1
	gosub go_room fur
	goto str_fur

### Add matchtables here
str_fur:
str_234:
	pause
	put get hide from bundle
	pause
	put stow hide
	pause
	put remove my bundle
	pause
	put sell my bundle
	pause
	put get rope from my cloak
	pause
	put get my hide
	pause
	put bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put pull my bundle
	pause
	put wear my bundle
	pause
	gosub go_room ylono
	goto str_ylono
	
str_65:
	if $backhunting = 1 then put #var hunting 2
	else put #var hunting 1
	gosub go_room fur
	goto str_fur

str_ylono:
str_496:
	# Fix current offensive armor/weapons
	put sheath
	pause
	put .repairstuff Ylono
	waitfor Script Done
	pause
	match str_repair_waiting You tap
	match str_equipped I could not find
	put tap my ticket
	matchwait 2
	str_repair_waiting:
	gosub go_room 235
	gosub repair_waiting
	gosub go_room 496
	pause
	put stow right;stow left;sheath
	pause
	str_equipping:
		match str_items_stow You get
		match str_equipped What were you referring to
			put get my ticket
		matchwait
	str_items_stow:
	put give Ylono
	waitforre You hand
	waitfor Script Done
	goto str_equipping
	str_equipped:
	pause
	gosub go_room north gate
	gosub move s
	goto shard_room_check

str_70:
	put stop sing
	gosub go_room 496
	goto str_496


### West Gate portion
west_room_check:

	var west_rooms |2|9|10|270|274|282|286|321|496|
	if contains("%west_rooms", "|$roomid|") then goto west_$roomid

	else gosub go_room 270
	goto west_room_check

west_2:
west_10:
west_9:
	if "$critter" = "ape" then
	{
		gosub go_room 283
		goto shel_room_check
	}
	if $Mechanical_Lore.LearningRate <= 5 then goto west_274
	if $hunting = 2 && $backhunting = 1 then
	{
		gosub go_room 270
		goto west_270
	}
	else
	{
		gosub go_room 283
		goto shel_room_check
	}

west_270:
	if $backhunting = 1 then put #var hunting 2
	if $Mechanical_Lore.LearningRate <= 5 then goto west_274
	if $backhunting = 0 then goto west_274
	goto west_pre_hunt

west_282:
	if $backhunting = 0 then goto west_to_shard
	else put #var hunting 1

west_pre_hunt:
	put .aon
	waitfor Armor On
	put .maf
	put .mafwatch
	waitfor Face what?
	gosub go_room 274
	put #var hunting 2
	put .backcombat
	exit

west_274:
	pause
	if matchre("$roomobjs", "an elongated granite stone") then
	{
		gosub stow elong.stone
		goto west_274
	}
	
	if matchre("$roomobjs", "a dark bronze blade") then
	{
		gosub THROWN_CLEAN dark.blade
		goto west_274
	}
	if matchre("$roomobjs", "some dark bronze blades") then
	{
		gosub THROWN_CLEAN dark.blade
		goto west_274
	}
	if matchre("$roomobjs", "throwing club") then
	{
		gosub THROWN_CLEAN club
		goto west_274
	}
	if matchre("$roomobjs", "war hammer") then
	{
		gosub THROWN_CLEAN war.hammer
		goto west_274
	}
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put .pyramids on
		waitfor Pyramids On
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
	pause
	put stop sing
	put .retreat
	pause
	gosub go_room gem
	goto west_gem

west_gem:
west_286:
	if $backhunting = 1 then put #var hunting 2
	put get my gem pouch;remove my gem pouch
	pause
	put sell my gem pouch;sell my gem pouch
	pause
	put wear my gem pouch
	gosub go_room 1
	gosub move ne
	goto str_room_check

west_to_shard:
	gosub go_room 1
	gosub move ne
	gosub go_room 215
	gosub move s
	goto shard_room_check
	
### Shard Portion
shard_room_check:
	
	var shard_rooms |2|32|93|55|506|147|149|148|172|409|204|205|206|214|
	if contains("%shard_rooms", "|$roomid|") then goto shard_$roomid
	
	else gosub go_room 506
	goto shard_room_check


shard_2:	
shard_32:
shard_55:
	if %wounded = 1 then
	{
		gosub go_room 506
		goto shard_506
	}
	else
	{
		gosub go_room 148
		goto shard_148
	}

shard_gem:
	gosub go_room west gate
	gosub go_room gem
	gosub sell_pouch
	gosub go_room west gate
	gosub go_room 148
	goto shard_148
	
shard_148:
	var gemcount 0
	action var gemcount $1 when pouch and find (\d+) gems in it\.
	pause
	put -count my gem pouch
	pause 3
	if %gemcount > 400 then goto shard_gem
	put excd
	pause 3
	gosub go_room 149
	goto shard_149

shard_149:
	put depall;withdraw 5 plat
	pause

shard_climb:
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .shardclimb
	waitfor Script Done
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	
shard_to_bard:
	put .workorder weapon
	waitfor Workorders Complete
	gosub go_room 205
	goto shard_bard

shard_bard:
shard_205:
	### skipping while working out west
	goto shard_skip_bard

	if (("$critter" = "ape") && ($backhunting = 0)) then goto shard_skip_bard
	pause
#	put .pyramids off
#	waitfor Pyramids Off
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .twiddle off
	waitfor Twiddle Done
	put #script abort noafk
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	pause
	if matchre("$roomobjs", "pyramid|Pyramid") then
	{
		put .pyramids on
		waitfor Pyramids On
		if matchre("$roomobjs", "pyramid|Pyramid") then
		{
			put #echo Cyan pickup your pyramids and type GO ON;
			put #play abort;#echo Cyan pickup your pyramids and type GO ON
			waitfor GO ON
		}
	}
shard_skip_bard:
	gosub go_room 206
	pause
shard_206:
	put knock gate;go gate
	pause
	goto south_room_check

shard_409:
shard_173:
shard_204:
shard_214:
shard_from_mining:
	if %wounded = 1 then
	{
		var from_mining 1
		gosub go_room 506
		goto shard_506
	}

	### All done in Shard
	gosub go_room west gate
	gosub move west
	goto west_room_check
		
shard_506:
	if %wounded = 1 then
	{
		if contains("$roomplayers", "Also here") then
		{
			put wave
			put #play abort;#play abort
			put #echo >Events Red ROOM OCCUPIED
			put #echo White,Red ROOM OCCUPIED
			gosub go_room 173
			exit
		}
		else gosub healing
	}
	if %from_mining = 1 then goto shard_from_mining
	gosub go_room 148
	goto shard_148

### South Gate Portion	
south_room_check:
	
	var south_rooms |2|34|213|211|212|210|
	if contains("%south_rooms", "|$roomid|") then goto south_$roomid
	
	else gosub go_room 2
	goto south_room_check
	
south_2:
	put .aon
	waitfor Armor On
	pause
	gosub go_room 214
cave_prospect:
	action remove ^\.\.\.wait|^Sorry, you may only type
	put .shardprospect
	action put $lastcommand when ^\.\.\.wait|^Sorry, you may only type
	waitfor Script Done
	gosub go_room 30
	gosub move sw
	gosub go_room 2
	pause
south_gate:
	put knock gate;go gate
	pause
	gosub move n
	goto shard_room_check
