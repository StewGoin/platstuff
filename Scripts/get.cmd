setvariable START %1
goto %START

setvariable SEQ1
setvariable SEQ2
setvariable SEQ3
setvariable SEQ4
setvariable SEQ5
setvariable SEQ6
setvariable SEQ7
setvariable SEQ8
setvariable SEQ9
setvariable SEQ10
setvariable RETURN

GET:

   setvariable RETURN GET

   Match RTBURN ...wait
   Match %SEQ2 You get
   Match %SEQ2 from inside your
   Match SHIFT I could not find what you were referring to,
   Match SHIFT What were you referring to?
   Match SHIFT You need to be holding
   Match HANDSFULLEND You need a free hand to pick that up.

   if_1 put get %1 from %FROMCONTAINER

   Matchwait


PUT:
put:
echo  =====================================================================================================
echo You will be taking items from %FROMCONTAINER and putting them in %TOCONTAINER.
echo Adjust your variables accordingly (use: .get put <FROMCONTAINER> <TOCONTAINER> <ITEM1> <ITEM2> <ITEM3>..)
echo =====================================================================================================

setvariable FROMCONTAINER %2
setvariable TOCONTAINER %3
shift
shift
shift

setvariable SEQ1 GET
setvariable SEQ2 PUT2
setvariable SEQ3
setvariable SEQ4
setvariable SEQ5
setvariable SEQ6
setvariable SEQ7
setvariable SEQ8
setvariable SEQ9
setvariable SEQ10
goto %SEQ1


PUT2:

   setvariable RETURN PUT2

   Match RTBURN ...wait
   Match %SEQ1 What were you referring to?
   Match %SEQ1 You put
   Match FULLCONTAINER Try as you might
   Match FULLCONTAINER That's too heavy to go in there
   Match FULLCONTAINER is too long to fit

   if_1 put put %1 %TOCONTAINER

   Matchwait


DROP:
drop:
echo =====================================================================================================
echo You are getting items from your %FROMCONTAINER to drop.
echo (use: .get drop <FROMCONTAINER> <ITEM1> <ITEM2> <ITEM3>..)
echo =====================================================================================================

setvariable FROMCONTAINER %2
shift
shift

setvariable SEQ1 GET
setvariable SEQ2 DROP2
setvariable SEQ3
setvariable SEQ4
setvariable SEQ5
setvariable SEQ6
setvariable SEQ7
setvariable SEQ8
setvariable SEQ9
setvariable SEQ10
goto %SEQ1


DROP2:

   setvariable RETURN DROP2

   Match RTBURN ...wait
   Match %SEQ1 You drop
   Match %SEQ1 What were you referring to?

   if_1 put drop %1

   Matchwait


SELL:
sell:
echo =====================================================================================================
echo You are getting items from your %FROMCONTAINER to sell.
echo (use: .get sell <FROMCONTAINER> <ITEM1> <ITEM2> <ITEM3>..)
echo =====================================================================================================

setvariable FROMCONTAINER %2
shift
shift

setvariable SEQ1 GET
setvariable SEQ2 SELL2
setvariable SEQ3 DROP2
setvariable SEQ4
setvariable SEQ5
setvariable SEQ6
setvariable SEQ7
setvariable SEQ8
setvariable SEQ9
setvariable SEQ10
goto %SEQ1


SELL2:

   setvariable RETURN SELL2

   Match RTBURN ...wait
   Match %SEQ1 gives it a quick but thorough examination
   Match %SEQ1 I could not find what you were referring to
   Match %SEQ3 That's not worth anything to me.
   Match %SEQ3 isn't worth my time
   Match %SEQ3 There's folk around here that'd slit a throat for this.
   Match NOMERCHANT There is no merchant here to buy that.

   if_1 put sell my %1

   Matchwait




REGISTER:
register:
setvariable FROMCONTAINER %2
setvariable TOCONTAINER %3
shift
shift
shift
echo =====================================================================================================
echo You are getting items from your %FROMCONTAINER to register.
echo (use: .get register <FROMCONTAINER> <TOCONTAINER> <ITEM1> <ITEM2> <ITEM3>..)
echo =====================================================================================================


setvariable SEQ1 GET
setvariable SEQ2 REGISTER2
setvariable SEQ3 PUT2
setvariable SEQ4 
setvariable SEQ5 
setvariable SEQ6
setvariable SEQ7
setvariable SEQ8
setvariable SEQ9
setvariable SEQ10
goto %SEQ1

REGISTER2:

   setvariable RETURN REGISTER2

   Match RTBURN ...wait
   Match RTBURN There is a nominal cost of
   Match %SEQ3 I have recorded the fact that you are in possession
   Match REGISTERED However, I did the paperwork for
   Match REGISTERED2 The one who registered it will need to speak to me.
   Match REGISTERED2 You need them to unregister it before I can do the paperwork
   Match REGISTERED2 Eventually, you hear a triumphant, "Found it!  Registered to
   Match REGISTERED2 Already told you who owns this,
   Match REGISTERMONEY it seems that you do not have enough
   Match REGISTERLOCATION You cannot register here.

   put register my %1

   Matchwait




KEY:
key:
echo =====================================================================================================
echo You are getting items from your %FROMCONTAINER to unlock.
echo (use: .get key <FROMCONTAINER> <ITEM1> <ITEM2> <ITEM3>..)
echo =====================================================================================================

setvariable FROMCONTAINER %2
shift
shift

setvariable SEQ1 GET
setvariable SEQ2 USEKEY
setvariable SEQ3 GETGEMS
setvariable SEQ4 GETCOINS
setvariable SEQ5 DROP2
setvariable SEQ6
setvariable SEQ7
setvariable SEQ8
setvariable SEQ9
setvariable SEQ10


GETKEY:

   setvariable RETURN GETKEY

   Match RTBURN ...wait
   Match %SEQ1 You get a vardite skeleton key
   Match %SEQ1 You are already holding that.
   Match NOKEYFOUND What were you referring to?

   put open my leather bag
   put get skeleton key from my leather bag

   Matchwait


USEKEY:

   setvariable RETURN USEKEY

   Match RTBURN ...wait
   Match %SEQ3 A sharp click emanates from the locking mechanism.

   if_1 put turn my skeleton key at my %1
   if_1 put open my %1

   Matchwait


GETGEMS:

   setvariable RETURN GETGEMS

   Match RTBURN ...wait
   Match %SEQ4 You fill your
   Match %SEQ4 There aren't any gems in the
   Match OUTOFGEMROOM The suede gem pouch is too full to fit any more gems!

   put fill my pouch with my %1

   Matchwait


GETCOINS:

   pause 0.2

   setvariable RETURN GETCOINS

   Match RTBURN ...wait
   Match GETCOINS You pick up
   Match %SEQ5 What were you referring to?

   put get coin

   Matchwait


SHIFT:

   shift
   if_1 goto %RETURN
   goto ENDOFITEMS


RTBURN:

   pause 0.5
   goto %RETURN


OUTOFGEMROOM:

   echo =====================================================================================================
   echo Your gem pouch is full and cannot stow any more gems, get another one and start over.
   echo =====================================================================================================

   exit

NOKEYFOUND:

   echo =====================================================================================================
   echo CANNOT LOCATE YOUR SKELETON KEY!!
   echo =====================================================================================================

   exit


NOMERCHANT:

   echo =====================================================================================================
   echo You must first find a pawnshop to buy your items before trying to sell them.
   echo =====================================================================================================

   exit


HANDSFULLEND:

   echo =====================================================================================================
   echo Both your hands are full, stopping.
   echo =====================================================================================================

   exit


ENDOFITEMS:

   echo =====================================================================================================
   echo You've run out of items.
   echo =====================================================================================================

   exit


REGISTERMONEY:

   echo =====================================================================================================
   echo You are out of money, go get more money and come back to register your stuff.
   echo =====================================================================================================

   exit


REGISTERED:

   echo =====================================================================================================
   echo This item is already registered. Putting it in your %TOCONTAINER and continuing on.
   echo =====================================================================================================

   goto PUT2

REGISTERED2:

   echo ============================================================================================================
   echo === SOMEONE ELSE! === has already registered this item. Putting it in your %TOCONTAINER and continuing on.
   echo ============================================================================================================

   goto PUT2


REGISTERLOCATION:

   echo =====================================================================================================
   echo You are not in the correct location to register items. Please relocate and start the script again.
   echo =====================================================================================================

   exit


FULLCONTAINER:

   echo ===========================================================================================================
   echo You have run out of room in your %TOCONTAINER or your %1 will not fit. Please choose a different container.
   echo ===========================================================================================================

   exit