# combine with aoff and use aliases

action goto start when ^\.\.\.wait|^Sorry, you may only type|You don't seem to be able to move to do that|Roundtime
start:
pause 0.5
put remove my hat;put my hat in my $pack
#pause 0.5
#put remove my $headarmor_alt;stow my $headarmor_alt
pause 0.5
put get my $buckler;wear my $buckler
pause 0.5
put get my $legarmor;wear my $legarmor
pause 0.5
put get my $chestarmor;wear my $chestarmor
pause 0.5
put get my $handarmor;wear my $handarmor
pause 0.5
put get my $headarmor;wear my $headarmor
pause 0.5
put get my $armarmor;wear my $armarmor
pause 0.5
put get my parry.stick;wear my parry.stick
pause 0.5
put get my claws;wear my claws
pause 0.5
put get my footwraps;wear my footwraps
pause 0.5
put get my elbow.spikes;wear my elbow.spikes
pause 0.5
put get my knee.spikes;wear my knee.spikes
pause 0.5
put echo Armor On
