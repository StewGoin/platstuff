# combine with ingot1 & crucible, etc... and ingotmaker

# Makes a forging ingot of steel
var StackMat wolf
var StacksNeeded 1
var CurrStack 1
var OrderVolNeeded 95
IF_1 var OrderVolNeeded %1
var OrderNumber 8

put stow right;stow left

if $zoneid = 30 then
  {
    var LOCATION RIVER
    var MASTER Paarupensteen
    var CARVEROOM 347
    var TOOLROOM 465
    var SUPPLYROOM 466
    var PRESTIGEROOM 461
    if $roomid != %SUPPLYROOM then gosub GO_ROOM %SUPPLYROOM
  }

put get my stack

BUY_STACK:
	put order %OrderNumber;order %OrderNumber
	pause 0.5
  put combine stack with other stack
  pause 0.5
  goto STACK_CHECK
STACK_CHECK:
  var StackSize 0
  pause 0.5
  action (stack) var StackVol $1 when You count out (\d+) pieces of material there
  action (stack) on
  put count my stack
  waitforre pieces of material there|I could not find what you were referring to\.
  pause
STACK_CHECK_DONE:
  action (stack) off
  if %StackVol < %OrderVolNeeded then goto BUY_STACK
  if %CurrStack >= %StacksNeeded then goto DONE
	else
  {
    math StacksNeeded add 1
    gosub put my stack in my $craftpack
	  goto BUY_STACK
  }

DONE:
gosub put my stack in my $craftpack
put #parse Stack Made
exit


### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

include includes.cmd
