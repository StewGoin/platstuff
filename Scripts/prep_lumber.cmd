pause

put get serr.saw from pouch
put get %1 from bright.pouch
put cut my %1 with my serr.saw
waitfor Roundtime
pause 0.5
put cut my %1 with my serr.saw
waitfor Roundtime
pause 0.5
put cut my %1 with my serr.saw
waitfor Roundtime
pause 0.5
put stow my serr.saw
put get my drawknife
put scrape my %1 with my drawknife
waitfor Roundtime
pause 0.5
put scrape my %1 with my drawknife
waitfor Roundtime
pause 0.5
put scrape my %1 with my drawknife
waitfor Roundtime
pause 0.5
put stow drawknife
pause 0.5
put get lumber from my bright.pouch;combine;stow my lumber
exit