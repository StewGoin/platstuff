action var LIST $1 when ^You rummage .* and see (.*)\.$

if matchre ("%1","u|un|und|unde|under") then var VERB under
if matchre ("%1","i|in") then var VERB in
if matchre ("%1","o|on") then var VERB on
if matchre ("%1","b|be|beh|behi|behin|behind") then var VERB behind
var NOUN %2
if_2 then goto SEARCH

ERROR:
echo
echo
echo Usage: .l on, in, behind, under [object]
echo
echo
exit

SEARCHPAUSE:
pause 

SEARCH:
pause 0.001
put rummage %VERB %NOUN
matchre SEARCHPAUSE ^\.\.\.wait|^Sorry|^System|^You are still stunned
matchre DOLIST ^You rummage .* (in|on|behind|under)
matchre DONE ^You can't rummage
matchwait 5
goto ERROR

DOLIST:
put #clear Rummage
put #window show Rummage
pause 0.001
eval FIXLIST replacere("%LIST", "\,\s", "|")
pause 0.001
eval TOTAL count("%FIXLIST","|")
math TOTAL add 1
var COUNT 0

LOOP:
pause 0.001
eval ITEM element("%FIXLIST","%COUNT")
put #echo >Rummage %ITEM
math COUNT add 1
if %COUNT = %TOTAL then goto DONE
goto LOOP

DONE: