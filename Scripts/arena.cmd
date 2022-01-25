put #class arena on

action goto exit when ^A pair of surly attendants escorts you from the arena floor
action var critter $1 when portcullis is raised, heralding the arrival of [^!]+\s(\S+)\!
action var evade $1 when You appraise the situation and notice [^,]+, you could try to (\S+) .*\!$
action goto next when $charactername has vanquished|^What are you trying to attack\?|^There is nothing else to face
action put #echo >Log WhiteSmoke Round $1 when Round (\d+), FIGHT\!\"$
action send cast area when ^You feel fully prepared to cast your spell
action send stand when eval $standing = 0
#action send cast when ^Your formation of a targeting pattern
action var tmprep 1 when ^You don't have a spell prepared|^You listen intently to the air about you before voicelessly calling the ever-changing storm|^You let your concentration lapse|^Your pattern dissipates with the loss of your target|^You gesture at
action var tmprep 0 when ^You begin to weave mana lines into a target pattern|^You have already fully prepared
action var tmcast 0 when ^You listen intently to the air about you before voicelessly calling the ever-changing storm|^You trace an angular sigil in the air|^You gesture at|^You don't have a spell prepared
action var tmcast 1 when ^Your formation of a targeting pattern
action put #echo >Log Lime evaded when victim of its own fate\!
action put #echo >Log Black,DarkRed 30 Second Warning when ^An announcer shouts, \"You only have about 30 seconds remaining
action (arena) send 2 bob;#echo >Log Red bob when may charge into you, you could try to bob back and forth\!
action (arena) send 2 jump;#echo >Log Red jump when may drive you into a spiked pit, you could try to jump over it\!
action (arena) send 2 lean;#echo >Log Red lean when may press you into a large spike, you could try to lean out of the way\!
action (arena) send 2 pedal;#echo >Log Red pedal when may push you into a jet of scalding-hot steam, you could try to pedal back out of the way\!
action (arena) send 2 duck;#echo >Log Red duck when may push you into a lit torch, you could try to duck down\!
action (arena) send 2 cower;#echo >Log Red cower when may slam you into a spiked wall, you could try to cower into a smaller target\!
#It's flying out of reach!  You'll need a weapon with longer range if you want to hit it.

#var weapon katana
#var weapon sis
var weapon spear
var tmcast 0
var tmprep 1
var spell bos
#var spell stra
IF_1 then goto %1

first:
  if %weapon = "sis" then put get sis;stance set $shieldstance
  if %weapon = "spear" then put get spear;stance set $shieldstance
  if $SpellTimer.PhoenixsPyre.active = 0 then
  {
    put rel cyclic
    put prep pyre 34
    pause 0.1
  }
  var tmcast 0
  var tmprep 1
  put put slip in my cloak
  put #echo >Log WhiteSmoke Round 1
  pause 0.5
  put get my rag;rub my $righthandnoun with rag;stow rag
  waitfor An iron portcullis is raised
  put #echo >Log Aqua %critter
  if %tmprep = 1 then send prep %spell $arena_tm_mana
  send target
  send watch %critter
  waitfor You appraise the situation and notice
  put #echo >Log Red %evade
  send %evade
  waitfor You set yourself up to
  action (arena) send 2 watch %critter when to fall victim of its own fate\!
  action (arena) send 2 watch %critter when doesn't appear to be up to anything\.\.\.yet\.
  action (arena) on
  goto attack

next:
  put #script abort rep
  action (arena) off
  put rel spell
  var tmcast 0
  if %weapon = "sis" then put get sis
  if %weapon = "spear" then put get spear
  pause 0.5
  put get my rag;rub my $righthandnoun with rag;stow rag
  waitfor An iron portcullis is raised
  put #echo >Log Aqua %critter
  if %tmprep = 1 then send prep %spell $arena_tm_mana
  send target
  send watch %critter
  waitfor You appraise the situation and notice
  put #echo >Log Red %evade
  send %evade
  waitfor You set yourself up to
  action (arena) on
  goto attack
  # put .rep attack
  # waitfor ALL DONE ARENA

attack:
  if %tmcast = 1 then
  {
    put cast
    pause 0.4
    goto attack
  }
  if %tmprep = 1 then
  {
    pause 0.1
    put prep %spell $arena_tm_mana
    put target
    pause 0.1
  }
  if %weapon = "sis" then put get sis;throw
  if %weapon = "spear" then put get spear;lob
  if %weapon = "katana" then
  {
    put maneuver cleave %critter
    put draw
  }
  pause 0.5
  if %weapon = "sis" then put get sis
  if %weapon = "spear" then send get spear
  goto attack

rewatch:
  pause 0.2
  put watch %critter
  pause 0.1
  send watch %critter
  waitfor You appraise the situation and notice
  put #echo >Log Red %evade
  send %evade
  waitforre ^You set yourself up to|^You glance around the arena
  goto attack

exit:
  exit