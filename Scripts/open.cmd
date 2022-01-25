var box %1
var boxes coffer|crate|strongbox|caddy|casket|skippet|trunk|chest|\bbox

pause 0.5
put get my skele key from my cloak
pause 0.5
put get my %box
pause 0.5
put get my %box from my portal
pause 0.5
put turn my key at my %box
pause
put put my skele key in my cloak
put open my %box
pause 0.5
put fill my gem pouch with my %box
pause 0.5
put get coin from my %box
pause 0.5
put get coin from my %box
pause 0.5
put get coin from my %box
pause 0.5
put get coin from my %box
pause 0.5
put get coin from my %box
pause 0.5
put .moveitems my.%box my.sash
waitfor Done Moving Items.
pause 0.5
put put my %box in bucket
put #parse Box Opened