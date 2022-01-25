# combine with ingot1 & crucible, etc... and ingotmaker

# Makes a forging ingot of steel
var StackMat linen
var StacksNeeded 1
var CurrStack 1
var OrderVolNeeded 65
IF_1 var OrderVolNeeded %1
var OrderNumber 7

put stow right;stow left

if $zoneid = 30 then
  {
    var LOCATION RIVER
    var MASTER HAGIM
    var SPINROOM 347
    var TOOLROOM 451
    var SUPPLYROOM 450
    var PRESTIGEROOM 449
    if $roomid != %SUPPLYROOM then gosub GO_ROOM %SUPPLYROOM
  }

put get my linen.cloth

BUY_STACK:
	put order %OrderNumber;order %OrderNumber
	pause 0.5
  put combine cloth with other stack
  pause 0.5
  goto STACK_CHECK
STACK_CHECK:
  var StackSize 0
  pause 0.5
  action (stack) var StackVol $1 when You count out (\d+) yards of material there
  action (stack) on
  put count my linen.cloth
  waitforre yards of material there|I could not find what you were referring to\.
  pause
STACK_CHECK_DONE:
  action (stack) off
  if %StackVol < %OrderVolNeeded then goto BUY_STACK
  if %CurrStack >= %StacksNeeded then goto DONE
	else
  {
    math StacksNeeded add 1
    gosub put my cloth in my $craftpack
	  goto BUY_STACK
  }

DONE:
gosub put my cloth in my $craftpack
put #parse Cloth Made
exit


### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

include includes.cmd
