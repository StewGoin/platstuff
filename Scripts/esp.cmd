echo Turning on all ESP channels.
ESPGENERAL:
put ESP listen general
match ESPGENERAL you close your mind
match ESPTRADE you open your mind
match ESPGENERAL ...wait
matchwait

ESPTRADE:
put ESP listen trade
match ESPTRADE you close your mind
match ESPGUILD you open your mind
match ESPTRADE ...wait
matchwait

ESPGUILD:
put ESP listen guild
match ESPGUILD you close your mind
match ESPRACE you open your mind
match ESPGUILD ..wait
matchwait

ESPRACE:
put ESP listen race
match ESPRACE you close your mind
match ESPLOCAL you open your mind
match ESPRACE ...wait
matchwait

ESPLOCAL:
put ESP listen local
match ESPLOCAL you close your mind
match ESPPRIVATE you open your mind
match ESPLOCAL ...wait
matchwait

ESPPRIVATE:
put ESP listen private
match ESPPRIVATE you close your mind
match ESPPERSONAL you open your mind
match ESPPRIVATE ...wait
matchwait

ESPPERSONAL:
put ESP listen personal
match ESPPERSONAL you close your mind
match DONE you open your mind
match ESPPERSONAL ...wait
matchwait

DONE:
exit
