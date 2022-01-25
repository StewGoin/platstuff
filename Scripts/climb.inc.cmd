# Validate this is already in includes or Base and then delete.

Climb.Inc:
	var diff normal
	action goto retreat when engaged
	if "$charactername" = "Ryken"  then put perc
	if "$charactername" = "Ryken"  then pause 1
	put exp
	waitfor EXP HELP
	if $Vocals.LearningRate > 8 then gosub HUMNO
	else gosub HUMYES
	if $Climbing.LearningRate > 8 then return
	
	match toohard This climb is too difficult
	match justright You finish practicing your climbing
	match tooeasy so you stop practicing
	put climb practice $1
	matchwait
	
	toohard:
	var diff high
	action remove when engaged
	return
	
	justright:
	var diff good
	action remove when engaged
	return
	
	tooeasy:
	var diff low
	action remove when engaged
	return

HUMNO:
put stop hum
return

HUMYES:
put hum $hum
return
