# Can this go in includes/base? clean/integrate

## If including in another script
## Please set %jugglie, and %jugcon

var jugglie $jugglie
var jugcon $jugcon
var jugcalled no

jug.start:
jug.inc:
var jugcount 0
if $Perception.LearningRate > $jugexp then goto jug.done
if "$righthand" != "Empty" then 
{
	var rightitem $righthand
	put stow right
}
if "$lefthand" != "Empty" then
{
	var leftitem $lefthand
	put stow left
}
goto jug.begin

jug.begin:
	put stand
	if $Perception.LearningRate >= $jugexp then goto jug.stupid
	else goto jug.git

jug.git:
	match jug.done What were you referring to?
	match jug.do You get
 put get my %jugglie

jug.do:
	if "%jugcounting" = "yes" && %jugcount >=5 then goto jug.done
	else evalmath jugcount %jugcount + 1
 match jug.do ...wait
 match jug.done It's easier to juggle if you start
 match jug.done Your injuries make juggling impossible.
 match jug.expcheck Roundtime
 put juggle my %jugglie
 matchwait

jug.expcheck:
	if $Perception.LearningRate > $jugexp then goto jug.done
	else goto jug.do

jug.stupid:
 echo
 echo Ah, you're already locked in perception.
 echo 
 goto jug.done

jug.done:
 	pause
 	echo *** All done.
	put put my %jugglie in my %jugcon
	if "%jugcalled" = "no" then
	{
		put glance
		exit
	}
	else return
