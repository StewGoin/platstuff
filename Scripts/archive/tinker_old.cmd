#Engineering - Tinkering

# .tinker <item> <number of times repeat>
#
# Make sure tinkering book is turned to the correct page for what you plan
# to do.
# Make sure you have all the supplies you need (string, lens, lumber, 
# fangs, shafts...)
# 
#
# Making bolthead can use 1 instead of bolthead
# Making shafts can use 2 instead of shaft
#  - shaft does not repeat
# Making mechanisms can use 3 instead of mechanism
#  have dial set accordingly
#  leaving the number blank for the number of mechanism will repeat until out of material
# Making bolts can use 4 instead of bolts
#
# .tinker telescope
# .tinker crossbow 3
# .tinker 3 3
# .tinker mechanism





var itemcontainer pannier
var boltheadtool shaper
var boltheadcontainer pannier
var ingotcontainer haversack
var mechanismcontainer pannier
var shaftcontainer pannier

start:
counter set %2
  if %1 = "bolthead" then goto part
  if %1 = "shaft" then goto shaft
  if %1 = "mechanism" then goto mechanism
  if %1 = "bolt" then goto bolt
  if %1 = 1 then goto part
  if %1 = 2 then goto shaft
  if %1 = 3 then goto mechanism
  if %1 = 4 then goto shaft  
goto book



book:
  put get book
  put study book
  match draw You now feel ready
matchwait

draw:
  put stow book
waitfor You put
  put get drawknife from my pack
waitfor You get
  put scrape lumber with my drawknife
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife 
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
matchwait

shaper:
  put stow right
  match shaper2 You put
  match shaper2 Stow what
matchwait

shaper2:
  put get shaper from my pack
wait for You get
  put shape my %1 with my shaper
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
  match end you complete working on
  match lens You need another lens
matchwait

carve:
  put stow right
  match carve2 You put
  match carve2 Stow what
matchwait

carve2:
  put get my knife from my pack
waitfor You get
  put carve my %1 with my knife
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
  match lens You need another lens
  match end you complete working on
matchwait

adjust:
  put stow right
  match adjust2 You put
  match adjust2 Stow what
matchwait

adjust2:
  put get my tool from my pack
waitfor You get
  put adjust my %1 with my tool
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
  match lens You need another lens
  match end you complete working on
matchwait

assemble:
  put stow right
waitfor You put
  put get my mechanism
waitfor You get
  put assemble mechanism with my %1
waitfor You place
  put stow right
  put get clamp
waitfor You get
  put push my %1 with my clamp  
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
  match carve That tool does not seem
  match lens You need another lens
matchwait



pliers:
  put stow right
  match pliers2 You put
  match pliers2 Stow what?
matchwait

pliers2:
  put get my plier from my pack
waitfor You get
  put pull my %1 with my plier
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
  match stain wood stain 
  match lens You need another lens
  match end you complete working on
matchwait

clamp:
  put stow right
  match clamp2 You put
  match clamp2 Stow what
matchwait

clamp2:
  put get my clamp from my pack
waitfor You get
  put push my %1 with my clamp
  match shaper Shaping with a wood shaper
  match shaper shaping with a wood shaper
  match shaper wood shaper should even
  match carve is ready to have more fine detail carved with a carving knife
  match carve grain looks solid and ready for continued knife carving
  match carve further carving with a knife
  match clamp must be pushed with clamps or a vise to hold it in place
  match adjust adjusting with some tinker
  match assemble You need another finished mechanism to continue crafting
  match pliers The mechanisms must be affixed into the stock 
  match bowstring You need another finished bow string to continue 
  match lens You need another lens
  match end you complete working on
matchwait

bowstring:
  put stow right
waitfor You put
  put get my bow string
waitfor You get
  put assemble my bow string with my %1
  put ana %1
  match pliers by pulling them into place with pliers
  match stain wood stain 
  match stain application of stain
matchwait

lens:
  put stow right 
waitfor You put
  put get my lens
waitfor You get
  put assemble my lens with my %1
  put ana %1
  match shaper wood shaper should even
  match shaper ready for continued shaping
  match shaper shaping with a wood shaper
  match carve for continued knife carving
  match carve further carving with a knife
matchwait


stain:
  put stow right
  put get stain from pack
waitfor You get
  put apply my stain to my %1
  match bowstring You need another finished bow string to continue 
  match end you complete working
matchwait

end:
  put stow right
  counter subtract 1
  if %c > 0 then put stow %1
  if %c > 0 then goto book
 
exit




###########################################################


part:
echo What type of part?
echo tusk  - 1
echo claw  - 2
echo fang  - 3
echo tooth - 4
echo horn  - 5
  match tusk tusk
  match tusk 1
  match fang fang
  match fang 3
  match claw claw
  match claw 2
  match tooth tooth
  match tooth 4
  match horn horn
  match horn 5
matchwait

tusk:
  var part tusk
goto bolthead

fang: 
  var part fang
goto bolthead

claw:
  var part claw
goto bolthead

tooth: 
  var part tooth
goto bolthead

horn:
  var part horn
goto bolthead

bolthead:
  put get %boltheadtool
  put get %part
waitfor You get
  put shape %part into bolthead
wait
  put stow shaper
waitfor You put
  put put bolthead in my %boltheadcontainer
waitfor You put
goto endpart

endpart:
  counter subtract 1
  if %c > 0 then goto bolthead
exit






##########################################

mechanism:
  if %c < 1 then goto mechanismloop 
  if %c > 0 then goto mechanismcount
  
mechanismloop:
  put get shovel
waitfor You get
  put get ingot from %ingotcontainer
  match mechanismloop2 You get
  match endmech What were you referring to
matchwait

mechanismloop2:
  put push fuel with shovel
pause
  put push fuel with shovel
pause
  put stow shovel
  put get pliers
waitfor You get
  put push ingot with press
pause
  put pull mech with press
pause
  put put mech in %mechanismcontainer
  put stow plier
waitfor You put
  put inv
  match ingot at your feet
matchwait 1
goto mechanismloop

ingot:
  put get ingot
  put swap
waitfor You move
  put get shovel
waitfor You get
goto mechanismloop2 


mechanismcount:
  put get shovel
  put get ingot from %ingotcontainer
waitfor You get
  put push fuel with shovel
pause
  put push fuel with shovel
pause
  put stow shovel
  put get pliers
waitfor You get
  put push ingot with press
pause
  put pull mech with press
pause
  put put mech in %mechanismcontainer
  put stow plier
waitfor You put
  counter subtract 1
  if %c > 0 then goto mechanismcount
  if %c = 0 then goto mechanismcount
goto endmech

endmech:
  stow right
  stow left
exit

##################################################

shaft: 
  put get shaper
  put get lumber
waitfor You get
  put shape my lumber into bolt shaft
wait
  put stow shaper
  put put shaft in %shaftcontainer
exit


##################################################

bolt:
  put get tinker book
waitfor You get
  put study my book
wait
  put stow book
waitfor You put
  put get shaper
waitfor You get
  put get shafts from %shaftcontainer
waitfor You get
  put shape shafts with my shaper
wait
  put stow shaper
waitfor You put
  put get bolthead from my %boltheadcontainer
waitfor You get
  put assemble bolthead with second bolt
  put put bolthead in my %boltheadcontainer
  match bolt2 You put
  match bolt2 What were you
matchwait

bolt2:
  put get glue
waitfor You get
  put apply glue to bolt
wait
  put stow glue
  match bolt3 You put
  match bolt3 What were you referring to
  match bolt3 Stow what
matchwait

bolt3:
  put ana bolt
  match carvebolt carving it with a knife
  match carvebolt carving with a knife
  match shapebolt ready for shaping
matchwait

shapebolt:
  put stow right
  match shapebolt2 You put
  match shapebolt2 What were you referring to
  match shapebolt2 Stow what
matchwait

shapebolt2:
  put get my shaper
waitfor You get
  put shape my bolt with my shaper
  match carvebolt carving with a knife
  match flights ready for an application of glue to attach the flights
  match shapebolt Roundtime
matchwait
  
carvebolt:
  put stow right
  match carvebolt2 You put
  match carvebolt2 What were you referring to
  match carvebolt2 Stow what
matchwait

carvebolt2:
  put get my carving knife 
waitfor You get
  put carve my bolt with my knife
  match carvebolt carving with a knife
  match flights ready for an application of glue to attach the flights
  match shapebolt Roundtime
matchwait

flights:
  put stow right
waitfor You put
  put get bolt flights 
waitfor You get
  put assemble my bolt with my flights
  put stow flight
pause 1
  put get glue 
waitfor You get
  put apply my glue to my bolt
wait
  put stow glue
  match flights2 You put
  match flights2 What were you referring to
  match flights2 Stow what
matchwait

flights2:
  put get my carving knife
waitfor You get
  put carve my bolt with my knife
wait
  put stow knife
  put get shaft
pause 1
  put put shafts in %shaftcontainer
goto boltend

boltend:
  counter subtract 1
  if %c > 0 then put stow %1
  if %c > 0 then goto bolt
exit

