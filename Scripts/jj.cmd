# Matchup to my jj.txt file and check JJ, then get someone to charge them up.

put #var save
pause

if $Time.isKatambaUp = 1 then setvariable katamba yes
if $Time.isXibarUp = 1 then setvariable xibar yes
if $Time.isYavashUp = 1 then setvariable yavash yes
if $Time.isKatambaUp = 0 then setvariable katamba no
if $Time.isXibarUp = 0 then setvariable xibar no
if $Time.isYavashUp = 0 then setvariable yavash no
evalmath katambatime round($Time.katambaSeconds/60)
evalmath xibartime round($Time.xibarSeconds/60)
evalmath yavashtime round($Time.yavashSeconds/60)

echo
echo Katamba: %katamba (for %katambatime more minutes)
echo Xibar: %xibar (for %xibartime more minutes)
echo Yavash: %yavash (for %yavashtime more minutes)
echo
echo DESTINATION
echo
echo 1. Crossing (%yavash)
echo 2. Leth Deriel (%yavash)
echo 3. Muspar'i (%katamba)
echo 4. Riverhaven (%xibar)
echo 5. Therenborough (%katamba)
echo 6. Shard (%katamba)
echo 7. Aesry Surlaenis'a (%yavash)
echo 8. Mer'Kresh (%katamba)
echo 9. Ratha (%xibar)
echo
echo Enter Destination Number:

matchre Crossing ^1
matchre LethDeriel ^2
matchre Muspari ^3
matchre Riverhaven ^4
matchre Therenborough ^5
matchre Shard ^6
matchre AesrySurlaenisa ^7
matchre MerKresh ^8
matchre Ratha ^9
matchwait

Crossing:
send get my ruby stud
waitforre ^You get|^You are already|^But that
send wear my ruby stud
waitforre ^You hang|^You are already
send rub my ruby stud
waitforre ^You rub your
put #mapper load Map1_Crossing
if $stunned = 1 then waiteval $stunned = 0
send remove my ruby stud
waitforre ^You remove|^You aren't|^Remove what
send stow my ruby stud
waitforre ^You put|^Stow what
goto end

LethDeriel:
send get my sapphire ring
waitforre ^You get|^You are already|^But that
send wear my sapphire ring
waitforre ^You slide|^You are already
send rub my sapphire ring
waitforre ^You rub your
put #mapper load Map61_Leth_Deriel
if $stunned = 1 then waiteval $stunned = 0
send remove my sapphire ring
waitforre ^You slide|^You aren't
send stow my sapphire ring
waitforre ^You put|^Stow what
goto end

Muspari:
send get my ebonwood earcuff
waitforre ^You get|^You are already|^But that
send wear my ebonwood earcuff
waitforre ^You hang|^You are already
send rub my ebonwood earcuff
waitforre ^You rub your
put #mapper load Map47_Muspar'i
if $stunned = 1 then waiteval $stunned = 0
send remove my ebonwood earcuff
waitforre ^You remove|^You aren't|^Remove what
send stow my ebonwood earcuff
waitforre ^You put|^Stow what
goto end

Riverhaven:
send get my jade pendant
waitforre ^You get|^You are already|^But that
send wear my jade pendant
waitforre ^You hang|^You are already
send rub my jade pendant
waitforre ^You rub your
put #mapper load Map30_Riverhaven
if $stunned = 1 then waiteval $stunned = 0
send remove my jade pendant
waitforre ^You remove|^You aren't|^Remove what
send stow my jade pendant
waitforre ^You put|^Stow what
goto end

Therenborough:
send get my pearl ring
waitforre ^You get|^You are already|^But that
send wear my pearl ring
waitforre ^You slide|^You are already
send rub my pearl ring
waitforre ^You rub your
put #mapper load Map40_Langenfirth_to_Therenborough
if $stunned = 1 then waiteval $stunned = 0
send remove my pearl ring
waitforre ^You slide|^You aren't
send stow my pearl ring
waitforre ^You put|^Stow what
goto end

Shard:
send get my gold wristband
waitforre ^You get|^You are already|^But that
send wear my gold wristband
waitforre ^You attach|^You are already
send rub my gold wristband
waitforre ^You rub your
put #mapper load Map67_Shard
if $stunned = 1 then waiteval $stunned = 0
send remove my gold wristband
waitforre ^You remove|^You aren't|^Remove what
send stow my gold wristband
waitforre ^You put|^Stow what
goto end

AesrySurlaenisa:
send get my garnet ring
waitforre ^You get|^You are already|^But that
send wear my garnet ring
waitforre ^You slide|^You are already
send rub my garnet ring
waitforre ^You rub your
put #mapper load Map99_Aesry_Surlaenis'a
if $stunned = 1 then waiteval $stunned = 0
send remove my garnet ring
waitforre ^You slide|^You aren't
send stow my garnet ring
waitforre ^You put|^Stow what
goto end

MerKresh:
send get my alexandrite ring
waitforre ^You get|^You are already|^But that
send wear my alexandrite ring
waitforre ^You slide|^You are already
send rub my alexandrite ring
waitforre ^You rub your
put #mapper load Map107_Mer'Kresh
if $stunned = 1 then waiteval $stunned = 0
send remove my alexandrite ring
waitforre ^You slide|^You aren't
send stow my alexandrite ring
waitforre ^You put|^Stow what
goto end

Ratha:
send get my silver armband
waitforre ^You get|^You are already|^But that
send wear my silver armband
waitforre ^You attach|^You are already
send rub my silver armband
waitforre ^You rub your
put #mapper load Map67_Shard
if $stunned = 1 then waiteval $stunned = 0
send remove my silver armband
waitforre ^You remove|^You aren't|^Remove what
send stow my silver armband
waitforre ^You put|^Stow what
goto end

end:
send hum $hum
exit
