# See if this can be modded to handle new spells (or if they should be in Base/includes)

#debug 5
start:
action (SpellWatch) goto SPELLCHECKING when eval $spell_maf_isactive = 0
action (SpellWatch) goto SPELLCHECKING when eval $spell_drum_isactive = 0
action (SpellWatch) goto SPELLCHECKING when eval $spell_harmony_isactive = 0
#action (SpellWatch) goto SPELLCHECKING when eval $spell_mis_isactive = 0
action (SpellWatch) goto SPELLCHECKING when eval $spell_name_isactive = 0
action (SpellWatch) goto SPELLCHECKING when eval $spell_rage_isactive = 0
action (SpellWatch) goto SPELLCHECKING when eval $spell_repr_isactive = 0

SPELLCHECKING:
	action (SpellWatch) off
#  if (("$GH_BUFF" = "ON") && ("$GH_CYCLIC" = "OFF") && ($spell_$GH_BUFF_SPELL_isactive = 0)) then
#  {
#    put .cast $GH_BUFF_SPELL $GH_BUFF_MANA creature
#    waitfor Spell Cast
#  }
  if ($spell_maf_isactive = 0 || $SpellTimer.ManifestForce.duration < 3) then
  {
  	pause 0.5
  	if $SpellTimer.ManifestForce.duration < 3 then
  	{
  		put #script pause all except buffs
  		put .cast maf 10 45 45
  		waitfor Spell Cast
  	}
  }
  if ($spell_drum_isactive = 0 || $SpellTimer.DrumsoftheSnake.duration < 3) then
  {
  	pause 0.5
  	if $SpellTimer.DrumsoftheSnake.duration < 3 then
	  {
	  	put #script pause all except buffs
	    put .cast drum 10 45 45
	    waitfor Spell Cast
	  }
	}
  if ($spell_harmony_isactive = 0 || $SpellTimer.Harmony.duration < 3) then
  {
  	pause 0.5
  	if $SpellTimer.Harmony.duration < 3 then
	  {
	  	put #script pause all except buffs
	    put .cast harmony 10 45 45
	    waitfor Spell Cast
	  }
	}
#  if ($spell_mis_isactive = 0 || $SpellTimer.Misdirection.duration < 3) then
#  {
#  	pause 0.5
#  	if $SpellTimer.Misdirection.duration < 3 then
#	  {
#	    put .cast name 10 45 45
#	    waitfor Spell Cast
#	  }
#	}
  if ($spell_name_isactive = 0 || $SpellTimer.NamingofTears.duration < 3) then
  {
  	pause 0.5
  	if $SpellTimer.NamingofTears.duration < 3 then
	  {
	  	put #script pause all except buffs
	    put .cast name 10 45 45
	    waitfor Spell Cast
	  }
	}
  if ($spell_rage_isactive = 0 || $SpellTimer.RageoftheClans.duration < 3) then
  {
  	pause 0.5
  	if $SpellTimer.RageoftheClans.duration < 3 then
	  {
	  	put #script pause all except buffs
	    put .cast rage 10 45 45
	    waitfor Spell Cast
	  }
	}
  if ($spell_repr_isactive = 0 || $SpellTimer.RedeemersPride.duration < 3) then
  {
  	pause 0.5
  	if $SpellTimer.RedeemersPride.duration < 3 then
	  {
	  	put #script pause all except buffs
	    put .cast repr 10 45 45
	    waitfor Spell Cast
	  }
	}
#  if ($spell_lw_isactive = 0 || $SpellTimer.LayWard.duration < 3) then
#  {
#  	pause 0.5
#  	if $SpellTimer.LayWard.duration < 3 then
#  	{
#   	put .cast lw 10 45 45
#    	waitfor Spell Cast
#  	}
#  }
	put #script resume all
	goto SPELL_WAIT

SPELL_WAIT:
	action (SpellWatch) on
	delay 30
	goto SPELLCHECKING