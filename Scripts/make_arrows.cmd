#arrowmaking (ice adders for now)
#debug 5
goto start

include includes.cmd

CHECK_ITEM:
	match RETURN You tap
	match OOPS I could not find
	put tap my $1
	matchwait 5
	goto CHECK_ITEM

OOPS:
	echo Item Missing!
	exit

start:
put stow left;stow right

gosub CHECK_ITEM flights
gosub CHECK_ITEM shafts
gosub CHECK_ITEM glue
gosub CHECK_ITEM ice.arrowheads
#gosub CHECK_ITEM lolno

put .fix wood.shaper
waitfor ITEM FIXED

put .fix carving.knife
waitfor ITEM FIXED

gosub get shaper from $craftpack
gosub get shafts from my $craftpack

put study my book
pause 3

put shape my shafts with my shaper
pause 3

gosub put my shaper in my $craftpack
pause 0.5
gosub get shafts
gosub put my shafts in my $craftpack
gosub get my ice.arrowheads from my $craftpack
put assemble my ice.arrowheads with my arrows
pause 2
gosub get my glue from my $craftpack

GLUE_THEM:
	match CARVE_THEM A handful of rough edges require carving with a knife to remove
	match SHAPE_THEM Roundtime:
	put apply my glue to my arrows
	matchwait 5
	goto GLUE_THEM

CARVE_THEM:
	gosub put my glue in my $craftpack
	gosub put my shaper in my $craftpack
	gosub get my carving.knife
	match CARVE_THEM A handful of rough edges require carving with a knife to remove
	match FLIGHT_THEM You need another arrow flights to continue crafting some unfinished
	match DONE_THEM Applying the final touches, you complete working on some
	match SHAPE_THEM Roundtime:
	put carve my arrows with my carving.knife
	matchwait 5
	goto CARVE_THEM

SHAPE_THEM:
	gosub put my glue in my $craftpack
	gosub put my carving.knife in my carryall
	gosub get my shaper from my $craftpack
	match CARVE_THEM A handful of rough edges require carving with a knife to remove
	match FLIGHT_THEM You need another arrow flights to continue crafting some unfinished
	match DONE_THEM Applying the final touches, you complete working on some
	match SHAPE_THEM Roundtime:
	put shape my arrows with my wood.shaper
	matchwait 5
	goto SHAPE_THEM

FLIGHT_THEM:
	gosub put my glue in my $craftpack
	gosub put my carving.knife in my carryall
	gosub put my shaper in my $craftpack
	gosub get arrow.flights from my $craftpack
	put assemble my flight with my arrows
	pause 2
	gosub get my glue from my $craftpack
	put apply my glue to my arrows
	pause 2
	gosub put my glue in my $craftpack
	gosub get my carving.knife
	put carve my arrows with my carving.knife
	pause 2
	put stow my carving.knife
	#put analyze my arrows
	pause
	put stow my arrows

exit