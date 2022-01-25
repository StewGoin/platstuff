# Call with either
# script: .moveitems <from_container> <to_container> <put type (in|on|under)>
# included in another script: gosub moveitems <from_container> <to_container> <put type (in|on|under)>
#
# for containers, use "." format aka "my blue pouch" would be "my.blue.pouch"
# if you specify "drop" for the <to_container> you will drop the items
# if you specifty "sell" for the container you will sell the items
# for the third variable it just changes from a default of putting things IN to putting them <whatever>
#
#debug 5

var moveitems_called 0
var moveitems_putit in
if_3 var moveitems_putit %3
var moveitems_from %1
var moveitems_container %2

goto MOVEITEMS_START

# Only applied when called as a gosub within another script.
MOVEITEMS:
     var moveitems_called 1
     var moveitems_putit in
     if_3 var moveitems_putit $3
     var moveitems_from $1
     var moveitems_container $2

MOVEITEMS_START:
     action (movingitems) var moveitems_contents $1 when ^In the .+ you see (.*)\.
     action (movingitems) on 

MOVEITEMS_CHECK:
     unvar moveitems_contents
     match MOVEITEMS_DONE There is nothing in there.
     matchre MOVEITEMS_RESTART ^In the .+ you see
     put look in %moveitems_from 
     matchwait 3
     goto MOVEITEMS_CHECK

MOVEITEMS_RESTART:
     eval moveitems_contents replace("%moveitems_contents", ", ", "|")  
     eval moveitems_contents replace("%moveitems_contents", " and ", "|")  
     eval moveitems_contents replace("%moveitems_contents", " " ".") 
     var moveitems_contents |%moveitems_contents| 
     eval moveitems_total count("%moveitems_contents", "|")  

MOVEITEMS_LOOP:
     var moveitems_number 0
     eval moveitems_item element("%moveitems_contents", 1)
MOVEITEMS_LOOP_1:
     eval moveitems_number count("%moveitems_contents", "|%moveitems_item|")
     eval moveitems_contents replace("%moveitems_contents", "|%moveitems_item|", "|")
     eval moveitems_contents replace("%moveitems_contents", "||" "|") 
     var moveitems_origitem %moveitems_item
     gosub MOVEITEMS_MOVEIT
     if %moveitems_contents != "|" then goto MOVEITEMS_LOOP
MOVEITEMS_DONE_CHECK:
     unvar moveitems_contents
     match MOVEITEMS_DONE There is nothing in there.
     matchre MOVEITEMS_RESTART ^In the .+ you see
     put look in %moveitems_from 
     matchwait 3
     goto MOVEITEMS_DONE_CHECK
MOVEITEMS_DONE:
     action (movingitems) off
     if %moveitems_called = 1 then return 
     else
     {
          put #parse Done Moving Items.
          echo Done Moving Items.
          exit
     }
       
MOVEITEMS_MOVEIT:
     evalmath moveitems_number %moveitems_number - 1

MOVEITEMS_MOVENOUN:
     if matchre("%moveitems_item", "\.([^.]+)$") then var moveitems_moveitem $1
     else
     {
          echo Unable to move item %moveitems_origitem
          exit
     }
     if ("%moveitems_container" != "drop" && "%moveitems_container" != "sell") then var moveitems_move put my %moveitems_moveitem %moveitems_putit %moveitems_container
     if ("%moveitems_container" = "drop") then var moveitems_move drop my %moveitems_moveitem
     if ("%moveitems_container" = "sell") then var moveitems_move sell my %moveitems_moveitem
MOVEITEMS_GET:
     matchre MOVEITEMS_GET ^\.\.\.wait|^Sorry
     matchre MOVEITEMS_PUT ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up|^But that is already in your inventory\.|You carefully remove
     matchre MOVEITEMS_CHANGENOUN ^What were you referring to\?|^I could not find what you were referring to\.|^Please rephrase that command\.
     put get %moveitems_moveitem from %moveitems_from
     matchwait 5
     goto MOVEITEMS_GET

MOVEITEMS_CHANGENOUN:
     if matchre("%moveitems_item", "^(\S+)\.[^.]+$") then
     {
          var moveitems_item $1
          goto MOVEITEMS_MOVENOUN
     }
     else
     {
          echo Unable to move item %moveitems_origitem
          exit
     }

MOVEITEMS_PUT:
     pause 0.1
     matchre MOVEITEMS_PUT ^\.\.\.wait|^Sorry
     matchre MOVEITEMS_DONEPUT ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the|^You ask \S+ to buy
     put %moveitems_move
     matchwait 2
     goto MOVEITEMS_PUT

MOVEITEMS_DONEPUT:
     pause 0.1
     if %moveitems_number = 0 then return
     else
     {
          evalmath moveitems_number %moveitems_number - 1
          goto MOVEITEMS_GET     
     }