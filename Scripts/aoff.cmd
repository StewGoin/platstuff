# combine with aon and use aliases

action goto start when ^\.\.\.wait|^Sorry, you may only type|You don't seem to be able to move to do that|Roundtime
start:
#pause 0.5
#put remove my $buckler;stow my $buckler
pause 0.5
put remove my $headarmor;stow my $headarmor
pause 0.5
put remove $handarmor;stow my $handarmor
#pause 0.5
#put remove $headarmor_alt;stow my $headarmor_alt
pause 0.5
put remove my $chestarmor;stow my $chestarmor
#pause 0.5
#put remove my $legarmor;stow my $legarmor
pause 0.5
put remove my parry.stick;put my parry.stick in my $pack
pause 0.5
put remove my claws;put my claws in my $pack
pause 0.5
put remove my footwraps;put my footwraps in my $pack
pause 0.5
put get my hat;wear my hat
put echo Armor Off
