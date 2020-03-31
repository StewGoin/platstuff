# Cast compost till ML in Sorcery
pause 0.5
put rel all
if spell_botf_isactve = 0 then
{
  put .cast botf 20
  waitfor Spell Cast
}

goto start

start:
  var casttype area
  if $mana < 25 then goto spell_wait
  put .cast COMPOST $compost_mana
  waitfor Spell Cast
  if $Sorcery.LearningRate < 33 then goto start
  else goto done

spell_wait:
pause 10
goto start

done:
put #parse Sorcery Complete
pause
exit
