# Genie-ize

################################################################################
################################################################################

#################################TRAVEL SCRIPTS#################################

################################################################################
################################################################################

TRAVEL:

   setvariable STARTINGLOCATION none
   counter set 0

   Match CROSSINGLOCATION [Strand Communal Center, Common Room]
   Match CROSSINGLOCATIONADJUST [Communal Center, Veranda]
   Match AESRYLOCATION [Tona Kertigen, Bank Vault]
   Match AESRYLOCATIONADJUST [Aesry Surlaenis'a, Staho Pivo'hrr'schu'Mus]
   Match SHARDLOCATION [Lady Atladene's Salon, Entryway]
   Match SHARDLOCATIONADJUST [First Bank of Ilithi, Exchange Vault]
   Match MERKRESHLOCATION [Alydendael, Front Gardens]
   Match MERKRESHLOCATIONADJUST [Wharf End, Mer'Kresh]
   Match RIVERHAVENLOCATION [Armiger's Mansion, Foyer]
   Match RIVERHAVENLOCATIONADJUST [Riverhaven, Tree-shaded Lane]
   Match RATHALOCATION [Sshoi-sson Palace, Provincial Bank Foyer]
   Match RATHALOCATIONADJUST [Sshoi-sson Palace, Portico]
   Match ELBAINSLOCATION [Beech Glade, Trail]
   Match ELBAINSLOCATIONADJUST [Outside the Circle, The Ironwoods]
   Match MUSPARILOCATION [Velakan Trade Road]
   Match MUSPARILOCATIONADJUST [Old Lata'arna Keep, Exchange Vault]
   Match HIBLOCATION [The Stony Hub, Entryway]
   Match HIBLOCATIONADJUST [Inner Hibarnhvidar, Tower Base]

   put look

   Matchwait

   CROSSINGLOCATION:

      setvariable STARTINGLOCATION CROSSING
      counter set 1
      goto SELECTLOCATION

   CROSSINGLOCATIONADJUST:

      move go door
      goto TRAVEL

   AESRYLOCATION:

      setvariable STARTINGLOCATION AESRY
      counter set 2
      goto SELECTLOCATION

   AESRYLOCATIONADJUST:

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      goto TRAVEL

   SHARDLOCATION:

      setvariable STARTINGLOCATION SHARD
      counter set 3
      goto SELECTLOCATION

   SHARDLOCATIONADJUST:

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      goto TRAVEL

   MERKRESHLOCATION:

      setvariable STARTINGLOCATION MER'KRESH
      counter set 4
      goto SELECTLOCATION

   MERKRESHLOCATIONADJUST:

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      goto TRAVEL

   RIVERHAVENLOCATION:

      setvariable STARTINGLOCATION RIVERHAVEN
      counter set 5
      goto SELECTLOCATION

   RIVERHAVENLOCATIONADJUST:

      move go gate
      move se
      move climb stair
      move go door
      goto TRAVEL

   RATHALOCATION:

      setvariable STARTINGLOCATION RATHA
      counter set 6
      goto SELECTLOCATION

   RATHALOCATIONADJUST:

      move go door
      move e
      goto TRAVEL

   ELBAINSLOCATION:

      setvariable STARTINGLOCATION ELBAIN'S
      counter set 7
      goto SELECTLOCATION

   ELBAINSLOCATIONADJUST:

      move go tree
      move s
      move s
      goto TRAVEL

   MUSPARILOCATION:

      setvariable STARTINGLOCATION MUSPAR'I
      counter set 8
      goto SELECTLOCATION

   MUSPARILOCATIONADJUST:

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      goto TRAVEL

   HIBLOCATION:

      setvariable STARTINGLOCATION HIBARNHVIDAR
      counter set 9
      goto SELECTLOCATION

   HIBLOCATIONADJUST:

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      goto TRAVEL

   SELECTLOCATION:

      pause
      ECHO ######################################################################
      ECHO ################You are currently in %STARTINGLOCATION###############
      ECHO ######################################################################

      ECHO ############################################################
      ECHO Please select your destination from the following:
      ECHO 1.CROSSING
      ECHO 2.AESRY
      ECHO 3.SHARD
      ECHO 4.MERKRESH
      ECHO 5.RIVERHAVEN
      ECHO 6.RATHA
      ECHO 7.ELBAINS
      ECHO 8.MUSPARI
      ECHO 9.HIBARN
      ECHO Type out the location without the number in CAPS! (ie HIBARN)
      ECHO #############################################################

      Match %cCROSSING CROSSING
      Match %cAESRY AESRY
      Match %cSHARD SHARD
      Match %cMERKRESH MERKRESH
      Match %cRIVERHAVEN RIVERHAVEN
      Match %cRATHA RATHA
      Match %cELBAINS ELBAINS
      Match %cMUSPARI MUSPARI
      Match %cHIBARN HIBARN

      Matchwait     

   1CROSSING:

      ECHO #####################
      ECHO #Already in CROSSING#
      ECHO #####################
      exit

   1AESRY:

      move go portal
      exit

   1SHARD:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   1MERKRESH:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   1RIVERHAVEN:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   1RATHA:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   1ELBAINS:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      exit

   1MUSPARI:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   1HIBARN:

      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      exit

   2CROSSING:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   2AESRY:

      ECHO #####################
      ECHO ###Already in AESRY##
      ECHO #####################
      exit

   2SHARD:

      move go portal
      exit

   2MERKRESH:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   2RIVERHAVEN:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   2RATHA:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   2ELBAINS:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      exit

   2MUSPARI:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   2HIBARN:

      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      exit

   3CROSSING:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   3AESRY:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      exit

   3SHARD:

      ECHO #####################
      ECHO ###Already in SHARD##
      ECHO #####################
      exit

   3MERKRESH:

      move go portal
      exit

   3RIVERHAVEN:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   3RATHA:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   3ELBAINS:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      exit

   3MUSPARI:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   3HIBARN:

      move go portal

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      exit

   4CROSSING:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   4AESRY:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      exit

   4SHARD:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   4MERKRESH:

      ECHO #######################
      ECHO ##Already in MERKRESH##
      ECHO #######################
      exit

   4RIVERHAVEN:

      move go portal
      exit

   4RATHA:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   4ELBAINS:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      exit

   4MUSPARI:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   4HIBARN:

      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   5CROSSING:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   5AESRY:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      exit

   5SHARD:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   5MERKRESH:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   5RIVERHAVEN:

      ECHO ###########################
      ECHO ###Already in RIVERHAVEN###
      ECHO ###########################
      exit

   5RATHA:

      move go portal
      exit

   5ELBAINS:

      move go portal

      move go door
      move e
      move go portal
      exit

   5MUSPARI:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   5HIBARN:

      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      exit

   6CROSSING:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   6AESRY:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      exit

   6SHARD:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   6MERKRESH:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   6RIVERHAVEN:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   6RATHA:

      ECHO #####################
      ECHO ###Already in RATHA##
      ECHO #####################
      exit

   6ELBAINS:

      move go portal
      exit

   6MUSPARI:

      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   6HIBARN:

      move go portal

      move go tree
      move s
      move s
      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      exit

   7CROSSING:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   7AESRY:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      exit

   7SHARD:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   7MERKRESH:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   7RIVERHAVEN:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   7RATHA:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   7ELBAINS:

      ECHO ########################
      ECHO ###Already in ELBAINS###
      ECHO ########################
      exit

   7MUSPARI:

      move go portal
      exit

   7HIBARN:

      move go portal

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal
      exit

   8CROSSING:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal
      exit

   8AESRY:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal
      exit

   8SHARD:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   8MERKRESH:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   8RIVERHAVEN:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   8RATHA:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   8ELBAINS:

      move go portal

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      exit

   8MUSPARI:

      ECHO ########################
      ECHO ###Already in MUSPARI###
      ECHO ########################
      exit

   8HIBARN:

      move go portal
      exit

   9CROSSING:

      move go portal
      exit

   9AESRY:

      move go portal

      move go door
      move go portal
      exit

   9SHARD:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal
      exit

   9MERKRESH:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port
      exit

   9RIVERHAVEN:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal
      exit

   9RATHA:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal
      exit

   9ELBAINS:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal
      exit

   9MUSPARI:

      move go portal

      move go door
      move go portal

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

      move go gate
      move se
      move climb stair
      move go door
      move go portal

      move go door
      move e
      move go portal

      move go tree
      move s
      move s
      move go portal
      exit

   9HIBARN:

      ECHO ####################
      ECHO ###Already in HIB###
      ECHO ####################
      exit

##################################################################################

      ECHO #########################################################
      ECHO Please select your destination from the following:
      ECHO CROSSING
      ECHO AESRY
      ECHO SHARD
      ECHO MERKRESH
      ECHO RIVERHAVEN
      ECHO RATHA
      ECHO ELBAINS
      ECHO MUSPARI
      ECHO HIBARN
      ECHO Simply say outloud where you wish to go (ie say SHARD) and 
      ECHO capitalize the location!
      ECHO ##########################################################

      ECHO #####################
      ECHO ###Already in ###
      ECHO #####################
      exit

#(crossing arrival)

      move go door
      move go portal

#(crossing departure)
#(aesry arrival)

      move n
      move e
      move go gate
      move go door
      move n
      move w
      move go vault
      move go portal

#(aesry departure)
#(shard arrival)

      move out
      move w
      move out
      move e
      move go brid
      move e
      move e
      move e
      move n
      move ne
      move e
      move n
      move go home
      move go port

#(shard departure)
#(merkeresh arrival)

      move nw
      move nw
      move ne
      move ne
      move n
      move n
      move n
      move n
      move go gate
      move go portal

#(merkeresh departure)
#(riverhaven arrival)

      move go gate
      move se
      move climb stair
      move go door
      move go portal

#(riverhaven departure)
#(ratha arrival)

      move go door
      move e
      move go portal

#(ratha departure)
#(elbains arrival)

      move go tree
      move s
      move s
      move go portal

#(ebains departure)
#(muspari arrival)

      move w
      move n
      move climb stair
      move s
      move climb stair
      move se
      move sw
      move climb stair
      move go gate
      move se
      move se
      move se
      move se
      move go gate
      move w
      move go portal

#(muspari departure)
#(hibarn arrival)

      move climb stair
      move nw
      move ne
      move ne
      move se
      move climb stair
      move se
      move s
      move go recess
      move sw
      move nw
      move nw
      move n
      move ne
      move ne
      move go door
      move climb stair
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move s
      move e
      move go entryway
      move go portal

#(hibarn departure)
#(crossing arrival)

      exit
################################################################################
################################################################################

