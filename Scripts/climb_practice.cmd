TOP:
	if $Athletics.LearningRate > 32 then goto DONE
	else goto CLIMB

CLIMB:
	if $humming = 0 then put hum concerto masterful
	match TOP You finish practicing your climbing skill and take a well-earned break
	match CHECK You continue to practice your climbing skills.
	match CHECK You should stop practicing your Athletics skill before you do that
	match DONE You can't climb that
	put climb practice %1
	matchwait 15
	goto CLIMB

CHECK:
	if $Athletics.LearningRate > 32 then goto DONE
	match TOP You finish practicing your climbing skill and take a well-earned break
	match CHECK You continue to practice your climbing skills.
	match CHECK You should stop practicing your Athletics skill before you do that
	put glance
	matchwait 15
	goto CLIMB

DONE:
	pause 0.5
	put stop climb
	put stop hum
	pause 0.5
	put #parse Script Done
	pause
	exit