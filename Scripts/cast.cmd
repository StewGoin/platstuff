#debug 5
# The spell pattern resists the influx of Elemental mana overloading your arcane senses and rendering you magically inert.
#Awareness enfolds you like the embrace of a loving parent as your attunement to Elemental mana returns.

var spell ""
var prepmana 1
var camb1mana 0
var camb2mana 0
var cambcharged 0
var ritual 0
var tattoo 0
var casttype ""
var areaspells compost|usol
var rituals word|echo|soul|will
var cyclics botf|pyre|aban|gj|hodi|care|aewo|sanctuary|fae|alb|eye|dalu
var tattoos ignite|phok
var symbioses nexus|name|harm|rage|resonance|drum|botf|repr
var SPELL_READY 0
action (spell) var SPELL_READY 1 when ^You feel fully prepared to cast your spell
action (spell) off
var backlash 0
action var backlash 1 when ^You sense the spell pattern spontaneously extrude a series of uncontrollable ganglia with the influx of Elemental mana\.|^The spell pattern resists the influx of Elemental mana, and a strange burning sensation backwashes from the spell pattern into your body|A sudden and violent explosion of pale, sickly green light ruptures from within your fingertips, cascading up in a dramatic, shuddering display that finally collapses upon you like a tidal wave
action var backfire 1 when ^Your spell.*backfires

if_1 goto START
echo Usage: .cast <spell> (prepmana) (camb1 mana) (camb2 mana) (cast type)
exit

START:
  var spell %1
  shift
  if matchre("%spell", "%areaspells") then var casttype area
  if matchre("%spell", "%rituals") then var ritual 1
  if matchre("%spell", "%tattoos") then var tattoo 1
  if matchre("%spell", "%symbioses") then var symbiosis 1
  if matchre(%1, \d+) then
  {
    var prepmana %1
    shift
  }
  if matchre(%1, \d+) then
  {
    var camb1mana %1
    shift
  }
  if matchre(%1, \d+) then
  {
    var camb2mana %1
    shift
  }
  if matchre(%1, \w+) then
  {
    var casttype %1
    shift
  }
  if matchre ("%spell", "%cyclics") then
  {
    pause 0.5
    put release cyclic
  }
  goto PREP

PREP_DELAY:
  delay 10
PREP:
  var backfire 0
  if $concentration < 90 then goto PREP_DELAY
  if (%symbiosis = 1 && $symbiosis = 1) then
  {
    pause 0.2
    put prep symbiosis
    pause 0.2
  }
PREP_SPELL:
  if %tattoo = 1 then goto PREP_TATT
  var SPELL_READY 0
  action (spell) on
  pause 0.5
 	matchre PREP_WAIT You trace an angular sigil in the air|fully prepared|already preparing|Tiny tendrils of lightning jolt between your hands|You rock back and forth|You infuse your voice with the elements as you begin to chant the opening notes of
    matchre PREP_WAIT ^(Wrapped in winter you begin to chant the Phoenix's Pyre, filling it with your frigid will\.|You weave a soft melody, as you begin Sanctuary, the notes so light and airy they can barely be heard\.|You begin to hum the soothing introduction to Damaris' Lullaby, modulating the volume of each phrase for hypnotic effect|You begin to chant a mesmerizing cadence designed to improve the study skills of those around you|The first gentle notes of Blessing of the Fae waft from you with delicate ease, riddled with low tones that gradually give way to a higher-pitched theme|With a harsh rasp to your voice, you begin the opening passages to the Desert\'s Maelstrom|Slow, rich tones form a somber introduction as you begin to sing the Aether Wolves enchante|Low, hummed tones form a soft backdrop for the opening notes of the Eye of Kertigen enchante|With a resounding \"POP\" like the cork from a bottle of effervescent bubbly, a spirited melody suddenly fills the area around you with palpable bands of audible color|A gently glittering series of colored lights appear in the air, winking in and out of existence with the start of your performance of Nexus|You begin your enchante by humming softly to yourself, gradually growing louder as the intricate pattern for Albreda\'s Balm forms more solidly in your mind|Though softly humming at first, you soon allow your voice to dance along the darkly melodic introduction to Abandoned Heart|You begin to sing, a gentle arpeggio of notes that segues into the softly melodic introduction to Hodierna\'s Lilt|With a sharp cut to your voice, you begin to chant the rhythm that heralds the introduction to Caress of the Sun|In a low tone you begin to chant the Phoenix\'s Pyre, as your voice grows you begin to thread it with traces of Fire which quickly agitate the air about you, causing it to warm almost painfully)
    matchre CASTED Something in the area|Something is damping|You have no idea how to cast that spell\.
	match PREP_MANA_WAIT have to strain
	put prep %spell %prepmana
	matchwait 5
	goto PREP_SPELL

PREP_TATT:
  var SPELL_READY 0
  action (spell) on
  pause 0.5
  matchre PREP_WAIT Closing your eyes, you carefully bend some mana streams through the tattoo on your arm\. 
  matchre CASTED Something in the area|Something is damping|You have no idea how to cast that spell\.
  match PREP_MANA_WAIT have to strain
  put invoke tattoo
  matchwait 5
  goto PREP_TATT

PREP_MANA_WAIT:
  delay 10
  if $mana > 30 then goto PREP_SPELL
  else goto PREP_MANA_WAIT

INVOKE:
  pause 0.5
  if "$foci" = "ethereal.naga" then put remove my $foci
  else gosub get my $foci
    match INVOKED Roundtime
  put invoke $foci
  matchwait 5
  goto INVOKE

INVOKED:
  pause 0.5
  if "$foci" = "ethereal.naga" then put wear my $foci
  else gosub put my $foci in my cloak
  goto PREP_WAIT_1

PREP_WAIT:
  put #parse Spell Prepped
  if %ritual = 1 then goto INVOKE
  if %camb1mana > 0 then goto CAMB_CHARGE
PREP_WAIT_1:
    if %SPELL_READY = 1 then goto PREP_CAST
	  matchre PREP_CAST You feel fully prepared to cast your spell|The formation of the target pattern around
	  matchre PREP_RELEASE patterns dissipate|pattern dissipates
	matchwait 30
	goto PREP_CAST

CAMB_CHARGE:
  if $mana < 20 then
  {
    if $mana < 10 then goto CAMB_INVOKE
    delay 10
    goto CAMB_CHARGE
  }
CAMB_CHARGE_1:
	  matchre CAMB_CHARGE_1 \.\.\.wait
    matchre CAMB_INVOKE dissipates|cannot harness
	  if %camb2mana = 0 then matchre CAMB_INVOKE absorbs
    else matchre CAMB_CHARGE_2 absorbs
	  matchre PREP_WAIT_1 Something in the area|Something is damping
	put charge my $cambrinth1 %camb1mana
 	matchwait 2
	goto CAMB_CHARGE

CAMB_CHARGE_2_WAIT:
  if $mana < 20 then
  {
    if $mana < 10 then goto CAMB_INVOKE
    delay 10
    goto CAMB_CHARGE
  }
CAMB_CHARGE_2:
    matchre CAMB_CHARGE_2 \.\.\.wait
    matchre CAMB_INVOKE dissipates|cannot harness|absorbs
    matchre PREP_WAIT_1 Something in the area|Something is damping
  put charge my $cambrinth1 %camb2mana
  matchwait 2
  goto CAMB_CHARGE_2_WAIT

CAMB_INVOKE:
	match CAMB_INVOKE ...wait
	matchre CAMB_DONE ^\[You can use INVOKE to activate the mana held in this device|You reach for its center and forge a magical link to it|Your link.*is intact|A very faint pattern indicates its readiness to absorb Elemental energy\.
	matchre PREP_WAIT_1 Something in the area|Something is damping
	put invoke my $cambrinth1 spell
  matchwait 2
	goto CAMB_INVOKE

CAMB_DONE:
  goto PREP_WAIT_1

PREP_CAST:
  put #parse Spell Fully Prepped
  if (%symbiosis = 1 && $symbiosis = 1) then delay 6
  if %backlash = 1 then goto BACKLASHED
  pause 0.5
    matchre PREP_CAST \.\.\.wait
    matchre PREP_SPELL The spell pattern resists the influx of Elemental mana overloading your arcane senses in a torrent of uncontrolled power.
    matchre PREP_SPELL You don't|backfire
    matchre BACKLASHED ^You sense the spell pattern spontaneously extrude a series of uncontrollable ganglia with the influx of Elemental mana\.|^The spell pattern resists the influx of Elemental mana, and a strange burning sensation backwashes from the spell pattern into your body|A sudden and violent explosion of pale, sickly green light ruptures from within your fingertips, cascading up in a dramatic, shuddering display that finally collapses upon you like a tidal wave
    matchre CASTED ^You gaze about seeking the trace flows of Water within the air|^With a power that seems to come from deep within yourself, staccato notes rip fiercely through the air\.|^You release an accompaniment of elemental|^You give sudden voice to the|You gesture|You lift your right hand, forming your fingers into the shape of a vulture's talons|You relax your eyes in order to focus on the trace amounts of Fire that warm you and the world around you\.|You gather your will and infuse it into your enchante making it manifest\.|^You whisper wordlessly to|^Having located a suitably abundant flow of Air, you inhale sharply filling yourself with the tranquil element\.|^Mentally steeling yourself in preparation for the unnatural action, you inhale sharply filling yourself with the frigid element\.|^You clap you hands together, willing a conjunction of Air and Earth compressed in the rapidly decreasing space between
    matchre CASTED You gesture\.|^You release a duet of elemental fire and water into your chanting, intensifying the callous syllables\.|^Mentally steeling yourself in preparation for the unnatural action, you inhale sharply refilling yourself with the frigid element reinforcing your determination\.|^You release an accompaniment of elemental air into your cadence|^Tendrils of flame dart along your hand toward|^The flames dancing along your fingertips flash with intensity|^The very air around you grows chill as you rekindle the Fire within you, reveling in the comforting warmth of its wild passions\.|^You reach with both your hands and your senses for the wisdom of the earth|^Your mind races as it seeks places of possible concealment
    matchre PREP_RELEASE because your target is dead|patterns dissipate|pattern dissipates because
#	  match PREP_FACE on yourself!
    match PREP_CASTAREA You can't cast that at yourself!
	put cast %casttype
	matchwait 5
	goto PREP_CAST

PREP_CASTAREA:
  var casttype area
  goto PREP_CAST

PREP_RELEASE:
    matchre PREP_SPELL RELEASE HELP|energies dissipate|preparing a spell|You release
  put release SPELL; release MANA
	matchwait 5
  goto PREP_RELEASE

CASTED:
  pause 0.1
  if %backlash = 1 then goto BACKLASHED
  if %backfire = 1 then goto PREP
  put #parse Spell Cast
  pause 0.5
  exit

BACKLASHED:
  var orig_room $roomid
  pause
  gosub go_room hospital
  pause
  put lie
  waitfor You sit up
  var backlash 0
  pause
  put stand
  gosub go_room %orig_room
  goto CASTED


go_room:
		pause 1
		match good_move YOU HAVE ARRIVED
		match go_room MOVE FAILED
	put #goto $1 $2
	matchwait
good_move:
	pause
	return

	good_MOVE_2:
		PAUSE 1
		MATCH ACTION YOU HAVE ARRIVED
		MATCH good_MOVE_2 MOVE FAILED
		PUT #goto $1 $2
		MATCHWAIT
	ACTION:
		return

PUT:
  var put $0
PUT.1:
  pause .1
  matchre PUT.1 ^\.\.\.wait|^Sorry
  matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
  send put %put
  matchwait 1
  goto PUT.1

DROP:
  var drop $0
DROP.1:
  pause .1
  matchre DROP.1 ^\.\.\.wait|^Sorry
  matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
  send DROP %drop
  matchwait 1
  goto DROP.1

GET:
   var Get $0
GET.2:
   pause .2
   matchre GET.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^|You get (a|an|some|your|the)|^You are already holding that\.|^You pick up|^What were you referring to\?|^But that is already in your inventory\.
   match RETURN You carefully remove
   send get %Get
   matchwait 2
   goto GET.2

STOW:
   var Stow $0
STOW.2:
   pause .1
   matchre STOW.2 ^\.\.\.wait|^Sorry
   matchre RETURN ^You put (a|an|some|your|the)|Stow what\?
   send stow %Stow
   matchwait 1
   goto STOW.2

RETURN:
  pause 0.001
  return
