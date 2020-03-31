if_1 goto start
echo "Supply the skintype as an argument"
exit

start:
var skin %1
var targe 0

put #script pause geniehunter
pause
put drop %skin
if ("$lefthandnoun" = "targe") then
{
	var targe 1
	put wear my targe
}
put stow right;stow left
pause 0.5
put remove my bundle;tie my bundle;tie my bundle;stow my tight.bundle
pause 0.5
put get my bund.rope;get %skin;bundle;wear my bundle
pause 0.5
if %targe = 1 then put remove my targe
put #echo >Log Lime Bundle Swapped
put #script resume geniehunter
pause 0.5
exit