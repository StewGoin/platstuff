if_1 goto loop
echo Usage: .rep <commands>
exit

loop:
 put %0
 pause 0.5
 goto loop
