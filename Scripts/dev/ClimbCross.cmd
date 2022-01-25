# clean and rename
## Climb Crossing Walls
## Created by Czidvar
debuglevel 10

   put #var CurrentScript ClimbCross
#   include BaseInit.cmd
  
## Script Actions ################################
   action instant var RoTi $1 when ^Roundtime\: (.*) sec
   action send sing lilt when ^Since you\'ve reached the end of the song\, you stop performing
   if "$Guild" = "Bard" then
   {
      put mana song 3
      put sing lilt
   }
   pause .2
   pause .2
   
## Script Variables ##############################
   var Obstacle START|break|embrasure|wall|wall|wall|wall|embrasure|break|embrasure|embrasure|wall|embrasure|break|embrasure|wall|wall|wall|END
   var RoTi 0

## EXP Goal Settings #############################
   var SkillGoal 0
   evalmath SkillGoal $Climbing.LearningRate + 15
   if %SkillGoal > 33 then var SkillGoal 33
   
TOP:
   match EMPTYHANDS You glance down to see
   match MAIN You glance down at your empty hands.
   send glance
   matchwait

MAIN:
   if $roomid != 418 then gosub go_room 418
   send set roomname
   send awake
   pause .2
#   gosub MOVE go gate
#   gosub MOVE west
#   gosub MOVE go stair
#   gosub MOVE south
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub MOVE south
   gosub MOVE down
   gosub MOVE south
   gosub MOVE south
   gosub MOVE southwest
   gosub CLIMB.IT
   gosub MOVE south
   gosub CLIMB.IT
#   gosub MOVE south
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub MOVE north
   gosub CLIMB.IT
   gosub CLIMB.IT
   put #goto 121
   waitfor YOU HAVE ARRIVED
   gosub MOVE go stair
   gosub MOVE south
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
   gosub CLIMB.IT
#   put #goto 172
#   waitfor YOU HAVE ARRIVED
   counter set 0
   goto MAIN

## Successes #####################################
PASS.1:
   gosub MOVE north
   gosub MOVE go gate
   gosub MOVE west
   gosub MOVE go stair
   gosub MOVE south
   goto RETURN
PASS.2:
   gosub MOVE go footpath
   goto RETURN
PASS.3:
   gosub MOVE north
   gosub MOVE go stair
   gosub MOVE east
   gosub MOVE go gate
   gosub MOVE go footpath
   goto RETURN
PASS.4:
   gosub MOVE south
   gosub MOVE go stair
   gosub MOVE go gate
   gosub MOVE go bush
   gosub MOVE north
   goto RETURN
PASS.5:
   gosub MOVE south
   gosub MOVE go stair
   gosub MOVE go gate
   goto RETURN
PASS.6:
   goto RETURN
PASS.7:
   gosub MOVE go gate
   gosub MOVE go stair
   goto RETURN
PASS.8:
   gosub MOVE south
   gosub MOVE go gate
   gosub MOVE go stair
   gosub MOVE north
   goto RETURN
PASS.9:
   gosub MOVE south
   gosub MOVE south
   gosub MOVE go gate
   goto RETURN
PASS.10:
   goto RETURN
PASS.11:
   gosub MOVE north
   goto RETURN
PASS.12:
   gosub MOVE go gate
   gosub MOVE go stair
   gosub MOVE east
   goto RETURN
PASS.13:
   gosub MOVE south
   gosub MOVE go gate
   gosub MOVE go stair
   gosub MOVE east
   goto RETURN
PASS.14:
   gosub MOVE east
   gosub MOVE west
   goto RETURN
PASS.15:
   gosub MOVE west
   gosub MOVE go stair
   gosub MOVE go gate
   gosub MOVE go trail
   goto RETURN
PASS.16:
   gosub MOVE west
   gosub MOVE go stair
   gosub MOVE go gate
   goto RETURN
PASS.17:
   gosub MOVE go stair
   goto RETURN

## Failures ######################################
FAIL.1:
   goto RETURN
FAIL.2:
   gosub MOVE north
   gosub MOVE go stair
   gosub MOVE east
   gosub MOVE go gate
   gosub MOVE go footpath
   goto RETURN
FAIL.3:
   goto RETURN
FAIL.4:
   goto RETURN
FAIL.5:
   goto RETURN
FAIL.6:
   gosub MOVE go gate
   gosub MOVE go stair
   goto RETURN
FAIL.7:
   goto RETURN
FAIL.8:
   goto RETURN
FAIL.9:
   gosub MOVE south
   gosub MOVE go stair
   goto RETURN
FAIL.10:
   gosub MOVE north
   gosub MOVE go stair
   gosub MOVE go gate
   gosub MOVE northwest
   goto RETURN
FAIL.11:
   gosub MOVE southeast
   gosub MOVE go gate
   gosub MOVE go stair
   goto RETURN
FAIL.12:
   gosub MOVE east
   goto RETURN
FAIL.13:
   goto RETURN
FAIL.14:
   gosub MOVE west
   gosub MOVE go stair
   gosub MOVE go gate
   gosub MOVE go trail
   gosub MOVE northeast
   goto RETURN
FAIL.15:
   gosub MOVE southwest
   goto RETURN
FAIL.16:
   gosub MOVE south
   goto RETURN
FAIL.17:
   gosub MOVE go gate
   goto RETURN
   
## Misc ##########################################
CLIMB.IT:
   counter add 1
   if "%ClimbOutcome" = "PASS" then pause 4
   gosub CLIMB %Obstacle(%c)
   evalmath XPause 12 - %RoTi
   pause %XPause
   gosub %ClimbOutcome.%c
   goto RETURN

EXP.CHECK:
   if $Climbing.LearningRate > %SkillGoal then goto MAP.CHECK
   goto RETURN
   
MAP.CHECK:
   if "$zoneid" = "1" then
   {
      put #goto 146
      waitfor YOU HAVE ARRIVED
      put #goto 172
   }
   if "$zoneid" = "8" then put #goto 53
   if "$zoneid" = "4" then 
   {
      put #goto 14
      waitfor YOU HAVE ARRIVED
      put #goto 172
   }
   if "$zoneid" = "7" then goto ALREADY.THERE
   waitfor YOU HAVE ARRIVED
ALREADY.THERE:
   put stop play
   goto EXIT

EMPTYHANDS:
   send stow $righthand
   pause .2
   send stow $lefthand
   goto TOP
   
## Climb subroutine now in BaseLabels.cmd
   include includes.cmd
#   include BaseLabels.cmd
