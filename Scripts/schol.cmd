#debug 5
var chap 1
var page 1
var playing 0
action var playing 0 when ^You finish playing

save elegy
put stow right;stow left
pause 1

GetBook:
  put turn my book to discipline weapon
  put get my tabla
  gosub get my tabla from my portal
  if $Scholarship.LearningRate > 32 then goto Done

Chap:
  gosub app tabla
  gosub assess tabla
    match Chap ...wait
    match Page You turn your book
    match Page The book is already
    match Done does not have a chapter
  put turn my book to chapter %chap
  matchwait 2
  goto Chap

Page:
    match Page ...wait
    match Study You turn your book
    match Study You are already on
    match Study You begin to study the instructions
    match AddChap This chapter does not have
  put turn my book to page %page
  matchwait 2
  goto Page

AddChap:
  var page 1
  math chap add 1
  if %chap > 9 then goto Done
  goto Chap

AddPage:
  math page add 1
  goto Page

Study:
  if $Scholarship.LearningRate > 32 then goto Done
  pause 0.5
  if %playing = 0 then
  {
    pause 0.5
    gosub ALMANAC_CHECK
    gosub get my tabla
    put play %s on tabla
    var playing 1
  }
Study_1:
    match Study ...wait
    match AddPage You now feel ready
  put study my book
  matchwait 2
  goto Study_1

APP:
  match return Roundtime
  put app my tabla
  matchwait 2
  goto APP

ASSESS:
  match return Roundtime
  put assess my tabla
  matchwait 2
  goto ASSESS

Done:
  #gosub put my book in my $craftpack
  pause
  put stop play;stop play
  gosub put my tabla in my portal
  put #parse Done Scholarship
  pause 0.5
  exit

include includes.cmd
