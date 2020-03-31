goto hib_$roomid


hib_410:
  if $roomid != 410 then gosub go_room 410
#  goto hib_411
  if $Alchemy.LearningRate < 25 then
  {
	  gosub go_room 193
	  put withdraw 3 gold dokora
	  pause 0.5
	  put exchange 3 gold dokora for kronar
	  pause 0.5
 	  put .ptravel CROSSING
	  waitfor Done Portalhax
	  gosub go_room 82
    gosub move go building
    gosub move s
    gosub move s
    gosub move s
    put order 2;order 2
    gosub put my alcohol in my $craftpack
    put order 11;order 11
    pause
    put order 11;order 11
    pause 
    put combine
    gosub put my grenich in my $craftpack
    gosub move n
    gosub move n
    gosub move n
    gosub move go door
 	  put .ptravel HIBARN
	  waitfor Done Portalhax
    gosub go_room 415
    put order 2;order 2
    gosub put my coal.nugget in my $craftpack
    gosub go_room 410
    put .alchemy remed body.ointment grenich 10 dump
    waitfor Done Alchemy
    gosub get my grenich
    put put my grenich in bucket
    gosub get my alcohol
    put put my alcohol in bucket
    gosub get my coal nugget
    put put my coal nugget in bucket
  }
  STACK_DEED_CHECK:
    var StackDeedSize 0
    pause 0.5
    action (deeds) var StackDeedSize $1 when Pieces:\s+(\d+)
#    action (deeds) var ClothDeedSize $1 when Yards:\s+(\d+)
    action (deeds) on
    put read my wolf deed in my $craftpack
    waitforre PhysicalResist|I could not find what you were referring to\.
    pause
  STACK_DEED_DONE:

  STACK_CHECK:
    var StackSize %StackDeedSize
    pause 0.5
    action (stack) var StackSize $1 when You count out (\d+) pieces of material there
#    action (stack) var ClothSize $1 when You count out (\d+) yards of material there
    action (stack) on
    if %StackSize > 0 then goto CLOTH_DEED_CHECK
    put count my stack
    waitforre pieces of material there|I could not find what you were referring to\.
  STACK_CHECK_DONE:

  CLOTH_DEED_CHECK:
    goto CLOTH_CHECK_DONE

    var ClothDeedSize 0
    pause 0.5
    put read my linen deed in my $craftpack
    waitforre Physical Resist|I could not find what you were referring to\.
    pause
  CLOTH_DEED_DONE:
    action (deeds) off

  CLOTH_CHECK:
    pause 0.5
    var ClothSize %ClothDeedSize
    if %ClothSize > 0 then goto CLOTH_CHECK_DONE
    put count my linen.cloth
    waitforre yards of material there|I could not find what you were referring to\.
    pause
  CLOTH_CHECK_DONE:
    action (stack) off
#   if ((%StackSize <= 20) || (%ClothSize <= 29)) then goto STACK_MAKE
    if %StackSize <= 20 then goto STACK_MAKE
    else goto CARVE_IT


  STACK_MAKE:
    if %StackSize <= 20 then
    {
      gosub get my wolf deed
      gosub put my wolf deed in bucket
      gosub get my stack
      gosub put my stack in bucket
    }
    else gosub put my stack in my $craftpack
#   if %ClothSize <= 29 then
#    {
#      gosub get my linen deed
#      gosub put my linen deed in bucket
#      gosub get my linen cloth
#      gosub put my linen cloth in bucket
#    }
#    else gosub put my linen cloth in my $craftpack
    gosub go_room 193
    put withdraw 1 plat dokora
    pause 0.5
    put exchange 1 plat dokora for lirum
    pause 0.5
    put .ptravel RIVERHAVEN
    waitfor Done Portalhax
   goto STACK_MAKE_1
  STACK_MAKE_1:
    if (%StackSize <= 20) then
    {
      put gosub go_room 466
      put .bonestack 95
      waitfor Stack Made
      var StackDeedSize 0
    }
    gosub go_room 465
  POLISHBUY_1:
    match POLISHBUY_DONE You tap a
    match POLISHBUY_2 I could not find what you were referring to.
    put tap my second surface.polish in my $craftpack
    matchwait 2
    goto POLISHBUY_1
  POLISHBUY_2:
    pause
    put order 8;order 8
    gosub put my surface.polish in my $craftpack
    goto POLISHBUY_1
  POLISHBUY_DONE:
    goto STACK_MAKE_RETURN

  CLOTH_MAKE:
    gosub go_room 450
    if (%ClothSize <= 29) then
    {
      put .clothstack 195
      waitfor Cloth Made
      var ClothDeedSize 0
    }
  THREADBUY_1:
    match THREADBUY_DONE You tap some
    match THREADBUY_2 I could not find what you were referring to.
    put tap my fourth thread in my $craftpack
    matchwait 2
    goto THREADBUY_1
  THREADBUY_2:
    pause
    put order 6;order 6
    gosub put my thread in my $craftpack
    goto THREADBUY_1
  THREADBUY_DONE:
    gosub go_room 451
  PINSBUY_1:
    match PINSBUY_DONE You tap some
    match PINSBUY_2 I could not find what you were referring to.
    put tap my fourth pins in my $craftpack
    matchwait 2
    goto PINSBUY_1
  PINSBUY_2:
    pause
    put order 5;order 5
    gosub put my pins in my $craftpack
    goto PINSBUY_1
  PINSBUY_DONE:


  STACK_MAKE_RETURN:
    put .ptravel HIBARN
    waitfor Done Portalhax
    gosub go_room 410
  CARVE_IT:
    goto STACK_UNDEED

  CLOTH_UNDEED:
    if ($Outfitting.LearningRate > 30) then goto STACK_UNDEED
    if %ClothDeedSize > 0 then
    {
      gosub GET linen deed from my $craftpack
      pause 0.5
      put tap my linen deed
      pause 0.5
      gosub get linen cloth
      gosub put my linen cloth in my craftpack
    }
    put .outfit tailor $fitting_train_item linen.cloth 20 dump
    waitfor Done Outfitting
    gosub get my linen.cloth
    gosub get my packet
    put push my cloth with my packet
    pause 0.5
    gosub put my deed in my $craftpack
    gosub put my packet in my carryall

  STACK_UNDEED:
    if ($Engineering.LearningRate > 30) then goto SCHOL
    if %StackDeedSize > 0 then
    {
      gosub GET wolf deed from my $craftpack
      pause 0.5
      put tap my wolf deed
      pause 0.5
      gosub get wolf stack
      gosub put my wolf stack in my $craftpack
    }
    put .engineer carv $engineer_train_item wolf 20 dump
    waitfor Done Engineering
    gosub get my stack
    gosub get my packet
    put push my stack with my packet
    pause 0.5
    gosub put my deed in my $craftpack
    gosub put my packet in my carryall

  SCHOL:
  if $Performance.LearningRate < 32 then
    {
      put .schol
      waitfor Done Scholarship
    }
    if $Mechanical_Lore.LearningRate < 32 then
    {
      put .origami
      waitfor Origami Complete
    }

hib_411:
  if $roomid != 411 then gosub go_room 410
  if $Forging.LearningRate < 28 then
  {
#    if $Forging.LearningRate < 20 then put .workorder weapon 2
#    else put .workorder weapon 1
    put .workorder weapon 1
    waitfor Workorder Complete
  }
  goto hib_410

include includes.cmd
