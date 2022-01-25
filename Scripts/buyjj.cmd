gosub buy earcuff
pause
gosub buy stud
pause
gosub buy armband
pause
gosub buy wristband
pause
gosub buy pendant
pause
gosub buyring first.ring
pause
gosub buyring second.ring
pause
gosub buyring third.ring
pause
gosub buyring fourth.ring
pause
exit

buy:
put buy $1 from case
put put my $1 in my %1
return

buyring:
put buy $1 from case
put put my ring in my %1
return