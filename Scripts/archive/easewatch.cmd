# Buffwatching should be moved to a generic script + global states/triggers, etc...
loop:

waitforre ^You feel a weight settle over you, and realize the magic that has been easing your burden has faded\.
waitforre Roundtime|There is nothing else to face
put .ease
goto loop
