# Clean, update, etc...

put ret;ret
if_1 goto RETREAT_%1

RETREAT_ON:
	action send retreat when ^\*.*at you\..*You|closes to melee range on you
	action send retreat when closes to pole weapon range on you|You retreat back to pole range
	action put #queue clear when You retreat from combat\.|You try to back away
	waitfor All Done Retreating

RETREAT_OFF:
done:
exit
