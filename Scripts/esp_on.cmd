var container belt

touch:
match general You touch the stones
match get_gweth You reach out and
match get_gweth The chain snaps
put touch my gweth
matchwait

get_gweth:
match wear_gweth You get a
match no_gweth I could not
match no_gweth What were you
put get gweth from my %container
matchwait

wear_gweth:
match get_gweth The chain snaps
match general You attach a
match general A chorus of
put wear my gweth
matchwait

no_gweth:
ECHO
ECHO YOU GOT NO GWETHS!
ECHO
exit


general:
match general you close
match trade you open
put esp listen general
matchwait

trade:
match trade you close
match guild you open
put esp listen trade
matchwait

guild:
match guild you close
match race you open
put esp listen guild
matchwait

race:
match race you close
match local you open
put esp listen race
matchwait

local:
match local you close
match private you open
put esp listen local
matchwait

private:
match private you close
match personal you open
put esp listen private
matchwait

personal:
match personal you close
match done you open
put esp listen personal
matchwait

done:
exit