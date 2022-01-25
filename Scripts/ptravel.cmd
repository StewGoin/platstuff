## Usage: .ptravel <destination>
## Valid Destinations: Crossing, Aesry, Shard, Merkresh, Kresh, Riverhaven, Ratha, Elbain's, Theren, Muspari, Hibanevergonnaspellitright

#debug 5

start:
  var StartingLoc none
  var Destinations cro|aes|sha|mer|kre|riv|rat|elb|the|mus|hib
  if matchre(tolower("%1"), "(%Destinations)") then
  {
    var FinalDest $1
    if ("%FinalDest" = "cro") then var FinalZone = 1
    if ("%FinalDest" = "aes") then var FinalZone = 99
    if ("%FinalDest" = "sha") then var FinalZone = 67
    if (("%FinalDest" = "mer") || ("%FinalDest" = "kre")) then var FinalZone = 107
    if ("%FinalDest" = "riv") then var FinalZone = 30
    if ("%FinalDest" = "rat") then var FinalZone = 90
    if (("%FinalDest" = "elb") || ("%FinalDest" = "the")) then var FinalZone = 40
    if ("%FinalDest" = "mus") then var FinalZone = 47
    if ("%FinalDest" = "hib") then var FinalZone = 116
  }
  else
  {
    echo Script Error, unable to parse destination location.
    exit
  }

  var CrossExit 483
  var CrossPortal 484
  var AesryExit 93
  var AesryPortal 115
  var ShardExit 148
  var ShardPortal 455
  var KreshExit 78
  var KreshPortal 273
  var RiverExit 73
  var RiverPortal 331
  var RathaExit 463
  var RathaPortal 468
  var ElbainExit 141
  var ElbainPortal 254
  var MuspariExit 245
  var MuspariPortal 97
  var HibExit 163
  var HibPortal 188
  var FangPortal 85

map_check:
  if $zoneid = %FinalZone then goto ARRIVED
	if $zoneid = 1 then goto CROSSING
	if $zoneid = 30 then goto RIVERHAVEN
  if $zoneid = 67 then goto SHARD
  if $zoneid = 99 then goto AESRY
	if $zoneid = 107 then goto KRESH
	if $zoneid = 90 then goto RATHA
	if $zoneid = 40 then goto ELBAIN
	if $zoneid = 47 then goto MUSPARI
	if $zoneid = 116 then goto HIB
  if $zoneid = 150 then goto FANG
  if $zoneid = 66 then
  {
    put #goto east gate
    waitfor YOU HAVE ARRIVED!
    goto map_check
  }

  if $zoneid = 0 then
  {
    echo Lost, Zone 0
    exit
  }
  echo Lost, Unknown Starting Zone
  exit

FANG:
  if $roomid != %FangPortal then gosub go_room %FangPortal
  gosub move go exit portal
  put #mapper reset
  pause 0.5
  goto map_check

CROSSING:
  if $roomid != %CrossPortal then gosub go_room %CrossPortal
  gosub move go shimmering portal
  put #mapper load Map99_Aesry_Surlaenis'a
  pause 0.5
  goto map_check

AESRY:
  if $roomid != %AesryPortal then gosub go_room %AesryPortal
  gosub move go shimmering portal
  put #mapper load Map67_Shard
  pause 0.5
  goto map_check

SHARD:
  if $roomid != %ShardPortal then gosub go_room %ShardPortal
  gosub move go shimmering portal
  put #mapper load Map107_Mer'Kresh
  pause 0.5
  goto map_check

KRESH:
  if $roomid != %KreshPortal then gosub go_room %KreshPortal
  gosub move go shimmering portal
  put #mapper load Map30_Riverhaven
  pause 0.5
  goto map_check

RIVERHAVEN:
  if $roomid != %RiverPortal then gosub go_room %RiverPortal
  gosub move go shimmering portal
  put #mapper load Map90_Ratha
  pause 0.5
  goto map_check

RATHA:
  if $roomid != %RathaPortal then gosub go_room %RathaPortal
  gosub move go shimmering portal
  put #mapper load Map40_Langenfirth_to_Therenborough
  pause 0.5
  goto map_check

ELBAIN:
  if $roomid != %ElbainPortal then gosub go_room %ElbainPortal
  gosub move go shimmering portal
  put #mapper load Map47_Muspar'i
  pause 0.5
  goto map_check

MUSPARI:
  if $roomid != %MuspariPortal then gosub go_room %MuspariPortal
  gosub move go shimmering portal
  put #mapper load Map116_Hibarnhvidar
  pause 0.5
  goto map_check

HIB:
  if $roomid != %HibPortal then gosub go_room %HibPortal
  gosub move go shimmering portal
  put #mapper load Map1_Crossing
  pause 0.5
  goto map_check

ARRIVED:
  pause 0.0001
  put #parse Done Portalhax
  echo Arrived.
  pause 0.5
  exit

################################################################################
################################################################################

include includes.cmd
