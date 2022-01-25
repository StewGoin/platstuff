### edit the variables in the "LOAD VARS" section
### If you want to choose your guild's Primary Magic, use Primary_Magic and not the specific type
### this script really likes these trigger (won't work much without them)
#trigger {e/$gametime >= $tarantulatime/} {#echo >Log Cyan You can use your tarantula.;#class tarantula_timer off} {tarantula_timer}
#trigger {^The tarantula comes alive in your hand!  It skitters to the top of your spine, moving with far more agility than its metallic heaviness should allow\.  A sharp stab of pain erupts at the base of your neck as it injects venom into your nervous system!} {#var tarantulatime $gametime} {tarantula}
#trigger {^You try, but the biomechanical tarantula is unresponsive\.  It needs approximately (\d+) roisen to generate enough venom again\.} {#var tarantulatime $gametime - (5 + 60 * $1)} {reminder}
#trigger {forgetting your recent progress on (.*), but somehow unbidden knowledge into other (\w+) tasks are mapped into your psyche\.$} {#var tarantulaSkillAbsorb $1;#var tarantulaLastSkillset $2;#var tarantulatime {#evalmath $gametime+605};#class tarantula_timer on;#echo >Log blue,white TARANTULA sacrificed $1 for $2 Skillset bonus pool.} {reminder}

#debug 5

#### LOAD VARS #####
tarantula_top:
  # #var tarantulaExp controls the minimum learning rate to swipe a skills
  var tarantulaLearningRate $tarantulaExp
  if "%tarantulaLearningRate" = "" then
  {
    put #var tarantulaExp 30
    goto tarantula_top
  }

  ##  Set your tarantula noun if you had it altered
  var tarantula tarantula

  ##  Set your chosen skills to sacrifice below in order of preference (left to right), use ExpTracker output
  var Magic_skillstocheck Primary_Magic|Debilitation|Targeted_Magic|Arcana
  var Lore_skillstocheck Performance|Bardic_Lore|Appraisal|Tactics
  var Survival_skillstocheck Perception|Evasion|Skinning|Outdoorsmanship
  var Armors_skillstocheck Defending|Shield_Usage|Chain_Armor|Brigandine|Plate_Armor|Light_Armor
  var Weapons_skillstocheck Bow|Parry_Ability|Melee_Mastery|Missile_Mastery

  ##  Set your pools to fill in order of preference (left to right) - Match the skills above
  var PoolsToFill Lore|Weapons|Survival|Armors|Magic

### NO TOUCHY BELOW HERE ###

tarantula_check:
  if $gametime < $tarantulatime then goto tarantula_toosoon

tarantula_skillset_count:
  var tarantulaPools %PoolsToFill.length
  var tarantulaPoolCount 0

tarantula_skillset_choose:
  if %tarantulaPoolCount >= %tarantulaPools then goto tarantula_nopool
  if "%PoolsToFill(%tarantulaPoolCount)" = "$tarantulaLastSkillset" then
  {
    math tarantulaPoolCount add 1
    goto tarantula_skillset_choose
  }
  var tarantulaSkillset %PoolsToFill(%tarantulaPoolCount)
  math tarantulaPoolCount add 1
  goto tarantula_skill_count

tarantula_skill_count:
  var tarantulaSkills %%tarantulaSkillset_skillstocheck.length
  #echo %tarantulaSkills
  var tarantulaSkillCount 0

tarantula_skillloop:
    pause 0.001
    if %tarantulaSkillCount >= %tarantulaSkills then goto tarantula_skillset_choose
    var activeskill %%tarantulaSkillset_skillstocheck(%tarantulaSkillCount)
    #echo %activeskill
    if ($%activeskill.LearningRate >= %tarantulaLearningRate) then goto tarantula_turn
    tarantula_skillloop_1:
    math tarantulaSkillCount add 1
    goto tarantula_skillloop

tarantula_turn:
    eval activeskill replacere("%activeskill", "_", " ")
        matchre tarantula_turn ^\s*\.\.\.wait|^You are still stunned
        matchre tarantula_skillset_oops ^But you currently aren't learning|^\[You need to vary which skillset you select with every use\.  .* was your last used skillset\.\]
        matchre tarantula_rub ^With a \*click\*, your changes snap into place\.  The biomechanical tarantula will now consume .* knowledge
    put turn my %tarantula to %activeskill
    matchwait 3
    goto turntarantula

tarantula_rub:
    pause 0.001
        matchre tarantula_rub ^\s*\.\.\.wait|^You are still stunned
        matchre tarantula_skillset_oops ^But you currently aren't learning|^\[You need to vary which skillset you select with every use\.  .* was your last used skillset\.\]
        matchre tarantula_setlastskillset ^The tarantula comes alive in your hand!  It skitters to the top of your spine, moving with far more agility than its metallic heaviness should allow\.  A sharp stab of pain erupts at the base of your neck as it injects venom into your nervous system!
        matchre tarantula_skillloop_1 ^You try, but the biomechanical tarantula is unresponsive
    put rub my %tarantula
    matchwait 3
    goto tarantula_rub

tarantula_skillset_oops:
  echo Repeated last skillset... oops.
  #put #var $tarantulaLastSkillset %tarantulaSkillset
  pause 0.001
  put experience 0
  goto tarantula_skillset_count

tarantula_setlastskillset:
  pause 0.001
  send exp 0
  goto tarantula_done

tarantula_nopool:
  echo No Skills Qualify, delaying a minute
  goto tarantula_delay
tarantula_toosoon:
  echo Too soon to use the tarantula again, delaying a minute
tarantula_delay:
  var temp $gametime
  math temp add 65
  put #var tarantulatime %temp
  goto tarantula_done
tarantula_end:
tarantula_done:
  put #parse TARANTULA DONE
exit