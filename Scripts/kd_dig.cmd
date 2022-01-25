go_dig:
put get my spade

dig:
put dig trench
match dig Roundtime:
match go_pick The hand spade hits something buried in the dirt.
matchwait

go_pick:
put stow my spade
put get my handpick
put kneel
waitfor You kneel

pick:
put pick trench
match pick Roundtime:
match go_brush now only covered by a fine layer of dirt.
matchwait

go_brush:
put stow my handpick
put get my excavation brush

brush:
put brush trench with brush
match brush Roundtime:
match done You reveal the artifact
matchwait

done:
put stow my brush
put stand
waitfor You stand
	goto go_dig