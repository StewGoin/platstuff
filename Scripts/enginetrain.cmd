var ItemMaterial deer-bone

DEED_CHECK:
  var DeedSize 0
  pause 0.5
  action (deeds) var DeedSize $1 when Pieces:\s+(\d+)
  action (deeds) on
  put read my deer deed in my $craftpack
  waitforre PhysicalResist|I could not find what you were referring to\.
  pause
DEED_DONE:
  action (deeds) off
  return

if %DeedSize = 0 then goto STACK_CHECK

UNDEED_INGOT:
  gosub GET %ItemMaterial deed from my $craftpack
  pause 0.5
  put tap my %ItemMaterial deed
  pause 0.5
  gosub get %ItemMaterial stack
  pause 0.5
  gosub PUT my %ItemMaterial stack in my $craftpack

STACK_CHECK:
  if "%ItemMaterial" = "any" then var ItemMaterial deer-bone
  var StackSize 0
  pause 0.5
  action (stack) var StackSize $1 when You count out (\d+) pieces of material there
  action (stack) on
  put count my stack
  waitforre pieces of material there|I could not find what you were referring to\.
  pause
STACK_CHECK_DONE:
  action (stack) off
  if %StackSize < 10 then goto STACK_MAKE
	else goto CARVE_IT

STACK_MAKE:
  gosub put my stack in bucket
  gosub go_room 193
  put withdraw 1 gold dokora
  pause 0.5
  put exchange 1 gold dokora for lirum
  pause 0.5
  put .ptravel RIVERHAVEN
  waitfor Done Portalhax
  put gosub go_room 466
	put .bonestack 70
	waitfor Stack Made
