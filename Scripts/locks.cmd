#check mindstate of lockpicking (below 32)
if $Locksmithing.LearningRate >=32 then goto DONE_LOCKS
else goto START

include includes.cmd

START:
var BOXLOC_1 backpack
var BOXLOC_2 thigh.bag
var LOCKRING_LOC thigh.bag
var LOCK_LOC cloak

# empty hands
put stow;stow left
pause 0.5
gosub get my lock.ring from my %LOCKRING_LOC
put wear my lock.ring
#get training box 1, set BOX_IN_USE
gosub get my training.box from my %BOXLOC_1
var BOX_IN_USE 1
#get lockpick

LOOP:
    gosub ALMANAC_CHECK
    if $Locksmithing.LearningRate >=32 then goto DONE_LOCKS
    gosub LOCKIT
    gosub PICKIT
    goto LOOP
    
# gosubs
LOCKIT:
    pause 0.5
    put lock my training.box
    return

PICKIT:
    pause 0.5
    match RETURN Roundtime
    match BOX_SWAP The lock feels warm, as if worked too often recently, so you stop your attempt to pick it.
    put pick my training.box
    matchwait 5
    goto PICKIT

#lock box
#pick box
#swap gosub (exit if already on #2)

BOX_SWAP:
  if %BOX_IN_USE = 2 then goto DONE_LOCKS
  gosub put my training.box in my %BOXLOC_1
  var BOX_IN_USE 2
  gosub get my training.box from my %BOXLOC_2
  gosub LOCKIT
  goto PICKIT
  

ALMANAC_CHECK:
  pause 0.5
  if $almanactime > $gametime then return
  if ("$lefthandnoun" <> "") then gosub put my $lefthandnoun in my $pack
  #if ("$righthandnoun" <> "") then gosub put my $righthandnoun in my $pack
  gosub get my almanac
  put study my almanac
  pause 0.5
  put stow my almanac
  pause 0.5
  return

DONE_LOCKS:
    if %BOX_IN_USE = 1 then gosub put my training.box in my %BOXLOC_1
    else gosub put my training.box in my %BOXLOC_2
    put remove my lock.ring
    gosub put my lock.ring in my %LOCKRING_LOC
    put #parse Done Locks
    exit