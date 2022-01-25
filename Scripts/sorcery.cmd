# Cast till ML in Sorcery
pause 0.5
put rel all
if $SpellTimer.BlessingoftheFae.active = 0 then
{
  put .cast botf 25
  waitfor Spell Cast
}

goto start

start:
  put unhide
  if $humming = 0 then put hum concerto masterful
  var casttype self
  if $mana < 25 then goto spell_wait
  put .cast EM 10 45 40
  waitfor Spell Cast
  if $Sorcery.LearningRate < 33 then goto start
  else goto done

spell_wait:
pause 10
goto start

done:
pause 0.5
put unhide
put stop hum
put #parse Sorcery Complete
pause
exit
