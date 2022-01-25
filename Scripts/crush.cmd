FIX:
	pause .5
	put .fix mortar
	waitfor ITEM FIXED
  pause .5
	put .fix pestle
	waitfor ITEM FIXED
  pause .5

START:
  gosub get my mortar
  gosub get my pestle

CRUSH:
  if $Alchemy.LearningRate = 34 then goto DONE
  match DONE Crush what?
  match CRUSH Roundtime
  put crush %1 in my mortar with pestle
  matchwait 2
  goto CRUSH

DONE:
  gosub put my pestle in my $craftpack
  gosub put my mortar in my $craftpack
  put #parse Done Crushing
  pause 0.5
  exit

include includes.cmd
