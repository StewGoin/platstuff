# TurnBook script
#
# Usage
#  .turnbook (item)
#  .turnbook help
#
#
# written by Hanryu
# Please report any bugs to Hanryu#0052 (Discord) or sauva@play.net
# This script may be reused in whole or in part as long as credit is given
# This script is designed to use Outlander, http://outlanderapp.com
#2020-10-01
#   removeing pauses and cleaning up ...wait handling
#   setup to handle all crafting turnbooking
#2020-11-14
#   leather handles and cords for shields
#2020-12-01
#   leather handles and cords for shields
#2021-03-16
#   lazily hard coding thin sewing needles because I don't want to deal with it
#debug 5

if_1 then {goto start}

help:
usage:
  echo **  You need to specify an item to turn the book to.
  echo **  .turnbook Brigandine scale aventail
  echo **  OR you need to have a script set up and track the global variable $workorder
  exit

start:
  if contains(%0, help) then {goto help}
  var chapter %1
  shift
  var item %0
  if matchre(%chapter, \d) then {goto rechapter}
turn:
  matchre turn \.\.\.wait|^Sorry,
  matchre chapter (?i)Chapter (\d+): .*%chapter
  put turn my book to index
  put read my book
  matchwait
chapter:
  var chapter $1
rechapter:
  matchre rechapter ^\.\.\.wait|^Sorry,
  matchre page Page (\d+): some %item
  matchre page Page (\d+): (?:some |an? )?(?:thin )%item
  matchre page Page (\d+): (?:some |an? )?(?:wood )?%item
  matchre page Page (\d+): (?:some |an? )?(?:metal )?%item
  matchre page Page (\d+): (?:some |an? )?%1 (?:leather )%2
  matchre page Page (\d+): (?:some |an? )?%1 (?:cloth )%2
  matchre page Page (\d+): (?:some |an? )?(?:leather )%1
  put turn my book to chapter %chapter
  put read my book
  matchwait
page:
  var page $1
repage:
  matchre repage ^\.\.\.wait|^Sorry,
  match done You turn your book to page
  match done You are already on page
  put turn my book to page %page
  matchwait
end:
done:
  put #parse ** TURNBOOK DONE **
  exit
