#debug 5
goto start

### Includes
include includes.cmd

start:
## goto priestess
#if $zoneid = 67 then gosub go_room portal
#if $roomid != 44 then gosub go_room 44
if $zoneid = 116 then gosub go_room n gate
if $roomid != 48 then gosub go_room 48
goto ask_priestess

## get task + record #
ask_wait:
    pause 30
ask_priestess:
    match ask_wait you must wait before I can give you a task
    match on_task You are already on a task
    match ask_go_on If you're willing to assist us
    put ask white priestess about task
    matchwait 10
    goto ask_priestess

on_task:
  pause 0.5
  var pieces 0
  action (moar_pieces) var pieces $1 when collected (\d+) more slivers of anathema
  action (moar_pieces) on
  pause 0.5
  put task
  pause 2
  action (moar_pieces) off
  goto to_rift
    
ask_go_on:
  pause 0.5
  var pieces 0
  action (pieces) var pieces $1 when Once you've collected (\d+) pieces of anathema from a rift
  action (pieces) on
  pause 0.5
  put accept task
  pause 2
  action (pieces) off

## goto rift
to_rift:
    echo Finding %pieces pieces!
    gosub move go gate
    #gosub go_room dark temple
    gosub go_room $rift_room

## break pieces
var found 0
break_it:
    put break rift
    pause 0.5
    if "$righthandnoun" = "anathema" then
    {
        put stow my anathema
        evalmath found (%found + 1)
        pause 0.5
    }
if %found <= %pieces then goto break_it

## return to priestess
#gosub go_room portal
gosub go_room n gate

## turn in pieces
give_priestess:
    if %found = 0 then goto loop_it
    put get my anathema;give white priestess
    evalmath found (%found - 1)
    pause 0.5
    goto give_priestess
    
## loop
loop_it:
    put ask white priestess about work
    goto start