# Cleanup / validate and consider making a gosub

action put #echo >Log Black,Red $2 when ^You.*analyze.*(the|of) (.*) and (nod as your understanding grows|smile knowingly to yourself|pour over its construction)\.
action put #echo >Log Brown $1 when ^This appears to be a type of finished (.*)\.
action put #echo >Log Brown $1 when ^The .* is a (.* piece) to make\.
action put #echo >Log Brown $1 when ^(It was made by .*)
action put #echo >Log Brown $1 when ^About (.*)was used in this item's construction\.
action put #echo >Log Black,WhiteSmoke $1 when ^The metal appears to be composed of: (.*)\.
action put #echo >Log Brown $1 when ^(.* crafted this item)\.
action put #echo >Log Black,LightBlue $1 when ^The grind pattern indicates this (weapon has been honed) down to reduce its weight\.
action put #echo >Log Black,LightBlue $1 when ^The metal appears to have been slowly (tempered) to improve its durability\.
action put #echo >Log Black,LightBlue $1 when ^The grind pattern shows this weapon was (modified to improve its balance)\.
action put #echo >Log Lime $1 when ^A .* is a (.*) weapon\.

action put #echo >Log Gray not (0/14) $3 when ^(The|Some) .* (is|are) not (designed for improving the force of your attacks)\.
action put #echo >Log Gray terribly (1/14) $3 when ^(The|Some) .* (is|are) terribly (designed for improving the force of your attacks)\.
action put #echo >Log Gray dismally (2/14) $3 when ^(The|Some) .* (is|are) dismally (designed for improving the force of your attacks)\.
action put #echo >Log Gray poorly (3/14) $3 when ^(The|Some) .* (is|are) poorly (designed for improving the force of your attacks)\.
action put #echo >Log Gray inadequately (4/14) $3 when ^(The|Some) .* (is|are) inadequately (designed for improving the force of your attacks)\.
action put #echo >Log Gray fairly (5/14) $3 when ^(The|Some) .* (is|are) fairly (designed for improving the force of your attacks)\.
action put #echo >Log Gray decently (6/14) $3 when ^(The|Some) .* (is|are) decently (designed for improving the force of your attacks)\.
action put #echo >Log Gray reasonably (7/14) $3 when ^(The|Some) .* (is|are) reasonably (designed for improving the force of your attacks)\.
action put #echo >Log Gray soundly (8/14) $3 when ^(The|Some) .* (is|are) soundly (designed for improving the force of your attacks)\.
action put #echo >Log Gray well (9/14) $3 when ^(The|Some) .* (is|are) well (designed for improving the force of your attacks)\.
action put #echo >Log Gray very well (10/14) $3 when ^(The|Some) .* (is|are) very well (designed for improving the force of your attacks)\.
action put #echo >Log Gray extremely well (11/14) $3 when ^(The|Some) .* (is|are) extremely well (designed for improving the force of your attacks)\.
action put #echo >Log Gray excellently (12/14) $3 when ^(The|Some) .* (is|are) excellently (designed for improving the force of your attacks)\.
action put #echo >Log Gray superbly (13/14) $3 when ^(The|Some) .* (is|are) superbly (designed for improving the force of your attacks)\.
action put #echo >Log Gray incredibly (14/14) $3 when ^(The|Some) .* (is|are) incredibly (designed for improving the force of your attacks)\.

action put #echo >Log Lime $1 when ^You are certain that the .* weighs exactly (.*)\.
action put #echo >Log Orange no (0/25) $1 damage when /^  no (puncture|slice|impact) damage/i
action put #echo >Log Orange dismal (1/25) $1 damage when /^  dismal (puncture|slice|impact) damage/i
action put #echo >Log Orange poor (2/25) $1 damage when /^  poor (puncture|slice|impact) damage/i
action put #echo >Log Orange low (3/25) $1 damage when /^  low (puncture|slice|impact) damage/i
action put #echo >Log Orange somewhat fair (4/25) $1 damage when /^  somewhat fair (puncture|slice|impact) damage/i
action put #echo >Log Orange fair (5/25) $1 damage when /^  fair (puncture|slice|impact) damage/i
action put #echo >Log Orange somewhat moderate (6/25) $1 damage when /^  somewhat moderate (puncture|slice|impact) damage/i
action put #echo >Log Orange moderate (7/25) $1 damage when /^  moderate (puncture|slice|impact) damage/i
action put #echo >Log Orange somewhat heavy (8/25) $1 damage when /^  somewhat heavy (puncture|slice|impact) damage/i
action put #echo >Log Orange heavy (9/25) $1 damage when /^  heavy (puncture|slice|impact) damage/i
action put #echo >Log Orange very heavy (10/25) $1 damage when /^  very heavy (puncture|slice|impact) damage/i
action put #echo >Log Orange great (11/25) $1 damage when /^  great (puncture|slice|impact) damage/i
action put #echo >Log Orange very great (12/25) $1 damage when /^  very great (puncture|slice|impact) damage/i
action put #echo >Log Orange severe (13/25) $1 damage when /^  severe (puncture|slice|impact) damage/i
action put #echo >Log Orange very severe (14/25) $1 damage when /^  very severe (puncture|slice|impact) damage/i
action put #echo >Log Orange extreme (15/25) $1 damage when /^  extreme (puncture|slice|impact) damage/i
action put #echo >Log Orange very extreme (16/25) $1 damage when /^  very extreme (puncture|slice|impact) damage/i
action put #echo >Log Orange mighty (17/25) $1 damage when /^  mighty (puncture|slice|impact) damage/i
action put #echo >Log Orange very mighty (18/25) $1 damage when /^  very mighty (puncture|slice|impact) damage/i
action put #echo >Log Orange bone-crushing (19/25) $1 damage when /^  bone-crushing (puncture|slice|impact) damage/i
action put #echo >Log Orange very bone-crushing (20/25) $1 damage when /^  very bone-crushing (puncture|slice|impact) damage/i
action put #echo >Log Orange devastating (21/25) $1 damage when /^  devastating (puncture|slice|impact) damage/i
action put #echo >Log Orange very devestating (22/25) $1 damage when /^  very dev[ae]stating (puncture|slice|impact) damage/i
action put #echo >Log Orange overwhelming (23/25) $1 damage when /^  overwhelming (puncture|slice|impact) damage/i
action put #echo >Log Orange annihilating (24/25) $1 damage when /^  annihilating (puncture|slice|impact) damage/i
action put #echo >Log Orange obliterating (25/25) $1 damage when /^  obliterating (puncture|slice|impact) damage/i
action put #echo >Log Aqua not (0/17) $1 when /^You are .* that the .* not (balanced)/i
action put #echo >Log Aqua terribly (1/17) $1 when /^You are .* that the .* terribly (balanced)/i
action put #echo >Log Aqua dismally (2/17) $1 when /^You are .* that the .* dismally (balanced)/i
action put #echo >Log Aqua poorly (3/17) $1 when /^You are .* that the .* poorly (balanced)/i
action put #echo >Log Aqua inadequately (4/17) $1 when /^You are .* that the .* inadequately (balanced)/i
action put #echo >Log Aqua fairly (5/17) $1 when /^You are .* that the .* fairly (balanced)/i
action put #echo >Log Aqua decently (6/17) $1 when /^You are .* that the .* decently (balanced)/i
action put #echo >Log Aqua reasonably (7/17) $1 when /^You are .* that the .* reasonably (balanced)/i
action put #echo >Log Aqua soundly (8/17) $1 when /^You are .* that the .* soundly (balanced)/i
action put #echo >Log Aqua well (9/17) $2 when /^You are .* that the .* (is|are) well (balanced)/i
action put #echo >Log Aqua very well (10/17) $1 when /^You are .* that the .* very well (balanced)/i
action put #echo >Log Aqua extremely well (11/17) $1 when /^You are .* that the .* extremely well (balanced)/i
action put #echo >Log Aqua excellently (12/17) $1 when /^You are .* that the .* excellently (balanced)/i
action put #echo >Log Aqua superbly (13/17) $1 when /^You are .* that the .* superbly (balanced)/i
action put #echo >Log Aqua incredibly (14/17) $1 when /^You are .* that the .* incredibly (balanced)/i
action put #echo >Log Aqua amazingly (15/17) $1 when /^You are .* that the .* amazingly (balanced)/i
action put #echo >Log Aqua unbelieve?ably (16/17) $1 when /^You are .* that the .* unbelieve?ably (balanced)/i
action put #echo >Log Aqua perfectly (17/17) $1 when /^You are .* that the .* perfectly (balanced)/i
action put #echo >Log Maroon not (0/13) $2 when /and (is|are) not (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon terribly (1/13) $2 when /and (is|are) terribly (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon dismally (2/13) $2 when /and (is|are) dismally (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon poorly (3/13) $2 when /and (is|are) poorly (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon inadequately (4/13) $2 when /and (is|are) inadequately (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon fairly (5/13) $2 when /and (is|are) fairly (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon decently (6/13) $2 when /and (is|are) decently (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon reasonably (7/13) $2 when /and (is|are) reasonably (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon soundly (8/13) $2 when /and (is|are) soundly (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon well (9/13) $2 when /and (is|are) well (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon excellently (10/13) $2 when /and (is|are) excellently (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon superbly (11/13) $2 when /and (is|are) superbly (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon incredibly (12/13) $2 when /and (is|are) incredibly (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Maroon unbelievably (13/13) $2 when /and (is|are) unbelieve?ably (suited) to gaining extra attack power from your strength\.$/i
action put #echo >Log Lime extremely weak (1/18) when /(is|are) extremely weak, and (is|are)/i
action put #echo >Log Lime very delicate (2/18) when /(is|are) very delicate, and (is|are)/i
action put #echo >Log Lime quite fragile (3/18) when /(is|are) quite fragile, and (is|are)/i
action put #echo >Log Lime rather flimsy (4/18) when /(is|are) rather flimsy, and (is|are)/i
action put #echo >Log Lime particularly weak (5/18) when /(is|are) particularly weak, and (is|are)/i
action put #echo >Log Lime somewhat unsound (6/18) when /(is|are) somewhat unsound, and (is|are)/i
action put #echo >Log Lime appreciably susceptible to damage (7/18) when /(is|are) appreciably sus?ceptible to damage, and (is|are)/i
action put #echo >Log Lime marginally vulnerable to damage (8/18) when /(is|are) marginally vulnerable to damage, and (is|are)/i
action put #echo >Log Lime of average construction (9/18) when /(is|are) of average construction, and (is|are)/i
action put #echo >Log Lime a bit safeguarded against damage (10/18) when /(is|are) a bit safeguarded against damage, and (is|are)/i
action put #echo >Log Lime rather reinforced against damage (11/18) when /(is|are) rather reinforced against damage, and (is|are)/i
action put #echo >Log Lime quite guarded against damage (12/18) when /(is|are) quite guarded against damage, and (is|are)/i
action put #echo >Log Lime highly protected against damage (13/18) when /(is|are) highly protected against damage, and (is|are)/i
action put #echo >Log Lime very strong (14/18) when /(is|are) very strong, and (is|are)/i
action put #echo >Log Lime extremely resistant to damage (15/18) when /(is|are) extremely resistant to damage, and (is|are)/i
action put #echo >Log Lime unusually resilient to damage (16/18) when /(is|are) unusually resilient to damage, and (is|are)/i
action put #echo >Log Lime nearly impervious to damage (17/18) when /(is|are) nearly impervious to damage, and (is|are)/i
action put #echo >Log Lime practically invulnerable to damage (18/18) when /(is|are) practically invulnerable to damage, and (is|are)/i
action put #echo >Log Lime battered and practically destroyed (0-19%) when /, and (is|are) battered and practically destroyed\./i
action put #echo >Log Lime badly damaged (20-29%) when /, and (is|are) badly damaged\./i
action put #echo >Log Lime heavily scratched and notched (30-39%) when /, and (is|are) heavily scratched and notched\./i
action put #echo >Log Lime several unsightly notches (40-49%) when /, and (is|are) several unsightly notches\./i
action put #echo >Log Lime few dents and dings (50-59%) when /, and (is|are) few dents and dings\./i
action put #echo >Log Lime some minor scratches (60-69%) when /, and (is|are) some minor scratches\./i
action put #echo >Log Lime rather scuffed up (70-79%) when /, and (is|are) rather scuffed up\./i
action put #echo >Log Lime in good condition (80-89%) when /, and (is|are) in good condition\./i
action put #echo >Log Lime practically in mint condition (90-97%) when /, and (is|are) practically in mint condition\./i
action put #echo >Log Lime in pristine condition (98-100%) when /, and (is|are) in pristine condition\./i
action put #echo >Log Black,Yellow $1 when ^You are certain that the .* is worth exactly (.*)\.	


waitforre ^You are .* that the .* is worth .*\.	
exit

action put #echo >Log Lime no (0/8) $1 $2 when /no (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime insignificant (1/8) $1 $2 when /insignificant (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime light (2/8) $1 $2 when /light (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime low (2/8) $1 $2 when /low (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime fair (3/8) $1 $2 when /fair (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime moderate (4/8) $1 $2 when /moderate (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime high (5/8) $1 $2 when /high (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime great (6/8) $1 $2 when /great (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime overwhelming (7/8) $1 $2 when /overwhelming (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime insane (8/8) $1 $2 when /insane (maneuvering|stealth) (hinderance|hindrance)/i
action put #echo >Log Lime $1 no (0/19) $2 when /(offers|to) no (to|protection\.)/i
action put #echo >Log Lime $1 very poor (1/19) $2 when /(offers|to) very poor (to|protection\.)/i
action put #echo >Log Lime $1 poor (2/19) $2 when /(offers|to) poor (to|protection\.)/i
action put #echo >Log Lime $1 rather low (3/19) $2 when /(offers|to) rather low (to|protection\.)/i
action put #echo >Log Lime $1 low (4/19) $2 when /(offers|to) low (to|protection\.)/i
action put #echo >Log Lime $1 fair (5/19) $2 when /(offers|to) fair (to|protection\.)/i
action put #echo >Log Lime $1 better than fair (6/19) $2 when /(offers|to) better than fair (to|protection\.)/i
action put #echo >Log Lime $1 moderate (7/19) $2 when /(offers|to) moderate (to|protection\.)/i
action put #echo >Log Lime $1 moderately good (8/19) $2 when /(offers|to) moderately good (to|protection\.)/i
action put #echo >Log Lime $1 good (9/19) $2 when /(offers|to) good (to|protection\.)/i
action put #echo >Log Lime $1 very good (10/19) $2 when /(offers|to) very good (to|protection\.)/i
action put #echo >Log Lime $1 high (11/19) $2 when /(offers|to) high (to|protection\.)/i
action put #echo >Log Lime $1 very high (12/19) $2 when /(offers|to) very high (to|protection\.)/i
action put #echo >Log Lime $1 great (13/19) $2 when /(offers|to) great (to|protection\.)/i
action put #echo >Log Lime $1 very great (14/19) $2 when /(offers|to) very great (to|protection\.)/i
action put #echo >Log Lime $1 impressive (15/19) $2 when /(offers|to) impressive (to|protection\.)/i
action put #echo >Log Lime $1 very impressive (16/19) $2 when /(offers|to) very impressive (to|protection\.)/i
action put #echo >Log Lime $1 tremendous (17/19) $2 when /(offers|to) tremendous (to|protection\.)/i
action put #echo >Log Lime $1 incredible (18/19) $2 when /(offers|to) incredible (to|protection\.)/i
action put #echo >Log Lime $1 god-like (19/19) $2 when /(offers|to) god-like (to|protection\.)/i
action put #echo >Log Lime no (0/11) protection and when /no protection and/i
action put #echo >Log Lime poor (1/11) protection and when /poor protection and/i
action put #echo >Log Lime low (2/11) protection and when /low protection and/i
action put #echo >Log Lime fair (3/11) protection and when /fair protection and/i
action put #echo >Log Lime moderate (4/11) protection and when /moderate protection and/i
action put #echo >Log Lime good (5/11) protection and when /good protection and/i
action put #echo >Log Lime high (6/11) protection and when /high protection and/i
action put #echo >Log Lime great (7/11) protection and when /great protection and/i
action put #echo >Log Lime extreme (8/11) protection and when /extreme protection and/i
action put #echo >Log Lime incredible (9/11) protection and when /incredible protection and/i
action put #echo >Log Lime impressive (10/11) protection and when /impressive protection and/i
action put #echo >Log Lime god-like (11/11) protection and when /god-like protection and/i
action put #echo >Log Lime no (0/11) damage absorption when /no damage absorption/i
action put #echo >Log Lime poor (1/11) damage absorption when /poor damage absorption/i
action put #echo >Log Lime low (2/11) damage absorption when /low damage absorption/i
action put #echo >Log Lime fair (3/11) damage absorption when /fair damage absorption/i
action put #echo >Log Lime moderate (4/11) damage absorption when /moderate damage absorption/i
action put #echo >Log Lime good (5/11) damage absorption when /good damage absorption/i
action put #echo >Log Lime high (6/11) damage absorption when /high damage absorption/i
action put #echo >Log Lime great (7/11) damage absorption when /great damage absorption/i
action put #echo >Log Lime extreme (8/11) damage absorption when /extreme damage absorption/i
action put #echo >Log Lime incredible (9/11) damage absorption when /incredible damage absorption/i
action put #echo >Log Lime impressive (10/11) damage absorption when /impressive damage absorption/i
action put #echo >Log Lime god-like (11/11) damage absorption when /god-like damage absorption/i
