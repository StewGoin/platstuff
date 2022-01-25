debug 5

DEED_CHECK:
  var deed_darkstone 0
  var deed_darkstone-alloy 0
  var deed_bronze 0
  var deed_bronze-alloy
  var deed_steel 0
  var DeedMaterials |
  action (deeds) var DeedMaterials %DeedMaterials$1| when a ingot (\w+) deed
  action (deeds) on
DEED_CHECK_1:
  put look in my $craftpack
  pause
  eval DeedMaterials replacere("%DeedMaterials", "^\|", "")
  eval DeedMaterialsListSize count("%DeedMaterials", "|")
  eval DeedMaterials replacere("%DeedMaterials", "\|$", "")
DEED_READ:
  pause 0.5
  if %DeedMaterialsListSize < 1 then goto DEED_DONE
  var DeedReadCounter 0
DEED_READ_1:
  if %DeedReadCounter >= %DeedMaterialsListSize then goto DEED_DONE
  pause 0.5
  if %DeedMaterialsListSize = 1 then var DeedType %DeedMaterials
  else var DeedType %DeedMaterialsList(%DeedReadCounter)
  action (deeds) var deed_%DeedType $1 when Volume:\s+(\d+)
  put read my %DeedType deed in my $craftpack
  evalmath DeedReadCounter (%DeedReadCounter + 1)
  goto DEED_READ_1
DEED_DONE:
  pause
  action (deeds) off

exit

include includes.cmd
