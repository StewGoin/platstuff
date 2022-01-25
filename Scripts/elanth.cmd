# The hell?

setvariable preposition in
var source $roomname
action exit when ^I could not find what (you|you were) referring to\.$
var numbers first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth|eleventh
var numbers.index 0
send shop $shop
waitfor [Type SHOP [GOOD] to see some details about it.]
pause

action setvariable tap $2 when ^You tap (a|an|some|the) (.+) (atop|inside) (an?|some)
action setvariable short $2 when ^Short: (a|an|some|the) (.+)
action setvariable look $1 when ^Look:  (.+)
action setvariable look - when ^Look:  You see nothing unusual\.$
action setvariable read $1 when ^Read:\s+(.+)$
action setvariable type2 container when ^The .+ (are|is) a container, and can be opened and closed\.$
action setvariable type2 container when ^The .+ (are|is) a container\.$
action setvariable type2 container when ^The .+ (are|is) pocketed, and can be opened and closed\.$
action setvariable type2 container when ^The .+ (are|is) pocketed\.$
action setvariable type2 container when ^The gem pouch is made for easy storage of gems
action setvariable type3 cambrinth when holds? .+ mana\.$
action setvariable special cambrinth when holds? .+ mana\.$
action setvariable wearloc $2 when ^It appears that .+ can be worn (around|in|on) the (.+)\.$
action setvariable wearloc $1 when ^It appears that .+ can be draped over the (.+)\.$
action setvariable wearloc generic when ^It appears that .+ can be worn\.$
action setvariable wearloc belt when ^It appears that .+ can be worn attached to a belt\.$
action setvariable wearloc belt when ^The gem pouch is made for easy storage of gems
action setvariable wearloc ear when ^It appears that .+ can be worn in one ear
action setvariable wearloc ears when ^It appears that .+ can be worn in both ears
action setvariable wearloc hair (placed) when ^It appears that .+ can be worn in the hair\.$
action setvariable wearloc pants when ^It appears that .+ can be worn like pants or a skirt\.$
action setvariable wearloc shirt+ when ^It appears that .+ can be worn as a shirt or robe, even with armor\.$
action setvariable wearloc shirt- when ^It appears that .+ can be worn like a shirt or robe\.$
action setvariable wearloc shoulder when ^It appears that .+ can be slung over one shoulder\.$
action setvariable weight $1 when ^You are certain that .+ weighs exactly (\d+) (stones?)\.$
action setvariable appcosti $2 when ^You are certain that .+ (is|are) worth exactly (\d+) kronars\.$
action setvariable appcosti 1 when ^You are certain that .+ (is|are) worth exactly 1 kronar\.$
action setvariable appcosti 0 when ^You are certain that .+ (is|are) worth exactly nothing\.$
action setvariable appcosti 0 when ^There doesn't appear to be anything in the gem pouch\.$
action setvariable costi $1 when ^Cost:  (\d+)
action setvariable maxcharge $1 when ^You are certain that the .+ holds? exactly (\d+) mana\.$
action setvariable metal yes when ^The .+ (is|are) made with metal\.$

action setvariable wtype1 LE when (is a|are a|and) light edged .+ weapon
action setvariable wtype1 ME when (is a|are a|and) medium edged .+ weapon
action setvariable wtype1 HE when (is a|are a|and) heavy edged .+ weapon
action setvariable wtype1 2HE when (is a|are a|and) two-handed edged .+ weapon
action setvariable wtype1 LB when (is a|are a|and) light blunt .+ weapon
action setvariable wtype1 MB when (is a|are a|and) medium blunt .+ weapon
action setvariable wtype1 HB when (is a|are a|and) heavy blunt .+ weapon
action setvariable wtype1 2HB when (is a|are a|and) two-handed blunt .+ weapon
action setvariable wtype1 2HB when (is a|are a|and) two-handed blunt .+ weapon
action setvariable wtype1 SL when (is|are) a sling .+ weapon
action setvariable wtype1 StS when (is|are) a staff sling .+ weapon
action setvariable wtype1 SB when (is|are) a short bow .+ weapon
action setvariable wtype1 LoB when (is|are) a long bow .+ weapon
action setvariable wtype1 CB when (is|are) a composite bow .+ weapon
action setvariable wtype1 LX when (is|are) a light crossbow .+ weapon
action setvariable wtype1 HX when (is|are) a heavy crossbow .+ weapon
action setvariable wtype1 SS when (is a|are a|and) short staff .+ weapon
action setvariable wtype1 QS when (is a|are a|and) quarter staff .+ weapon
action setvariable wtype1 PI when (is a|are a|and) pike .+ weapon
action setvariable wtype1 HAL when (is a|are a|and) halberd .+ weapon
action setvariable wtype2 LT when (is|are) a light thrown and .+ weapon
action setvariable wtype2 HT when (is|are) a heavy thrown and .+ weapon

action setvariable range melee when melee-ranged weapon
action setvariable range pole when pole-ranged weapon
action setvariable puncture $1 when ^\s+(.*) puncture damage
action setvariable slice $1 when ^\s+(.*) slice damage
action setvariable impact $1 when ^\s+(.*) impact damage
action setvariable puncturetype Yes when ^\s+(.*) puncture damage increase
action setvariable slicetype Yes when ^\s+(.*) slice damage increase
action setvariable impacttype Yes when ^\s+(.*) impact damage increase
action setvariable balance $1 when .+ is (.*) balanced
action setvariable power $1 when .+ is (.*) suited

action setvariable stype lsh when is large in size\.$
action setvariable stype msh when is medium in size\.$
action setvariable stype ssh when is small in size\.$
action setvariable sprotection $1 when .+ offers (.*) protection
action setvariable smin $1 when ^You are certain that .+ offers (.*) to .+ protection\.
action setvariable smax $1 when ^You are certain that .+ offers .+ to (.*) protection\.
action setvariable shindrance $1 when .+ it imposes? an? (.*) maneuvering hinde?rance

action setvariable atype cloth armor when (is|are) cloth armor\.$|cloth\.$
action setvariable atype leather armor when (is|are) leather armor\.$
action setvariable atype bone armor when (is|are) bone armor\.$
action setvariable atype light chain when (is|are) light chain\.$
action setvariable atype heavy chain when (is|are) heavy chain\.$
action setvariable atype light plate when (is|are) light plate\.$
action setvariable atype heavy plate when (is|are) heavy plate\.$
action setvariable abpuncture $1 when .+ \s(.*) for puncture attacks
action setvariable abslice $1 when .+ \s(.*) for slice attacks
action setvariable abimpact $1 when .+ \s(.*) for impact attacks
action setvariable abfire $1 when .+ \s(.*) for fire attacks
action setvariable abcold $1 when .+ \s(.*) for cold attacks
action setvariable abelectrical $1 when .+ \s(.*) for electrical attacks
action setvariable appuncture $1 when .+ \s(.*) protection and .+ damage absorption for puncture attacks
action setvariable apslice $1 when .+ \s(.*) protection and .+ damage absorption for slice attacks
action setvariable apimpact $1 when .+ \s(.*) protection and .+ damage absorption for impact attacks
action setvariable apfire $1 when .+ \s(.*) protection and .+ damage absorption for fire attacks
action setvariable apcold $1 when .+ \s(.*) protection and .+ damage absorption for cold attacks
action setvariable apelectrical $1 when .+ \s(.*) protection and .+ damage absorption for electrical attacks
action setvariable aapuncture $1 when .+ protection and (.*) damage absorption for puncture attacks
action setvariable aaslice $1 when .+ protection and (.*) damage absorption for slice attacks
action setvariable aaimpact $1 when .+ protection and (.*) damage absorption for impact attacks
action setvariable aafire $1 when .+ protection and (.*) damage absorption for fire attacks
action setvariable aacold $1 when .+ protection and (.*) damage absorption for cold attacks
action setvariable aaelectrical $1 when .+ protection and (.*) damage absorption for electrical attacks
action setvariable ahindrance $1 when .+ appears? to impose (.*), offering
action setvariable mhindrance $1 when .+ appears? to impose (.*) maneuvering hindrance and
action setvariable shindrance $1 when .+ appears? to impose .+ maneuvering hindrance and (.*) stealth hindrance

action setvariable construction $2 when ^You are certain that the .+ (is|are) (.*) (against|to) damage, and
action setvariable construction extremely weak when ^You are certain that the .+ (is|are) extremely weak, and
action setvariable construction very delicate when ^You are certain that the .+ (is|are) very delicate, and
action setvariable construction quite fragile when ^You are certain that the .+ (is|are) quite fragile, and
action setvariable construction rather flimsy when ^You are certain that the .+ (is|are) rather flimsy, and
action setvariable construction particularly weak when ^You are certain that the .+ (is|are) particularly weak, and
action setvariable construction average construction when ^You are certain that the .+ (is|are) of average construction, and
action setvariable construction very strong when ^You are certain that the .+ (is|are) very strong, and

echo
echo ITEM TYPE:
echo
echo 1:	Weapon: Melee/Thrown
echo
echo 2:	Weapon: Ranged
echo
echo 3:	Weapon: Ammunition
echo
echo 4:	Weapon: Brawling
echo
echo 5:	Weapon: Parry Stick
echo
echo 6:	Shield
echo
echo 7:	Armor
echo
echo 8:	Item
echo
echo Enter Type Number:

matchre WeaponApp1 ^1
matchre WeaponApp2 ^2
matchre WeaponApp3 ^3
matchre WeaponApp4 ^4
matchre WeaponApp5 ^5
matchre ShieldApp ^6
matchre ArmorApp ^7
matchre ItemApp ^8
matchwait

WeaponApp1:
var number %numbers(%numbers.index)
gosub AppraiseWeapon1
math numbers.index add 1
if %numbers.index > 11 then goto end
goto WeaponApp1

WeaponApp2:
var number %numbers(%numbers.index)
gosub AppraiseWeapon2
math numbers.index add 1
if %numbers.index > 11 then goto end
goto WeaponApp2

WeaponApp3:
var number %numbers(%numbers.index)
gosub AppraiseWeapon3
math numbers.index add 1
if %numbers.index > 11 then goto end
goto WeaponApp3

WeaponApp4:
var number %numbers(%numbers.index)
gosub AppraiseWeapon4
math numbers.index add 1
if %numbers.index > 11 then goto end
goto WeaponApp4

WeaponApp5:
var number %numbers(%numbers.index)
gosub AppraiseWeapon5
math numbers.index add 1
if %numbers.index > 11 then goto end
goto WeaponApp5

ShieldApp:
var number %numbers(%numbers.index)
gosub AppraiseShield
math numbers.index add 1
if %numbers.index > 11 then goto end
goto ShieldApp

ArmorApp:
var number %numbers(%numbers.index)
gosub AppraiseArmor
math numbers.index add 1
if %numbers.index > 11 then goto end
goto ArmorApp

ItemApp:
var number %numbers(%numbers.index)
gosub AppraiseItem
math numbers.index add 1
if %numbers.index > 11 then goto end
goto ItemApp

number1:
var number first
return
number2:
var number second
return
number3:
var number third
return
number4:
var number fourth
return
number5:
var number fifth
return
number6:
var number sixth
return
number7:
var number seventh
return
number8:
var number eighth
return
number9:
var number ninth
return
number10:
var number tenth
return
number11:
var number eleventh
return

AppraiseWeapon1:
var metal no
var maxcharge delete this line
var wearloc -
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
echo http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
echo
echo {{Weapon
echo |name=%tap
echo |newapp=Yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |range=%range
echo |type=%wtype1
echo |type2=%wtype2
echo |puncture=%puncture
echo |slice=%slice
echo |impact=%impact
echo |balance=%balance
echo |suitedness=%power
echo |construction=%construction
echo |metal=%metal
echo |weight=%weight
echo |appcost=%appcost
echo |wearloc=%wearloc
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
put #log >Appraisal.txt {{Weapon
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |range=%range
put #log >Appraisal.txt |type=%wtype1
put #log >Appraisal.txt |type2=%wtype2
put #log >Appraisal.txt |puncture=%puncture
put #log >Appraisal.txt |slice=%slice
put #log >Appraisal.txt |impact=%impact
put #log >Appraisal.txt |balance=%balance
put #log >Appraisal.txt |suitedness=%power
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |wearloc=%wearloc
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseWeapon2:
var metal no
var maxcharge delete this line
var wearloc -
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
if (matchre ("%wtype1", "(SB|LoB|CB)")) then var ammo arrow
if (matchre ("%wtype1", "(LX|HX)")) then var ammo bolt
if (matchre ("%wtype1", "(SL|StS)")) then var ammo rock
if (matchre ("%wtype1", "(LT|HT)")) then var ammo thrown
echo http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
echo
echo {{Weapon
echo |name=%tap
echo |newapp=Yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |range=ranged
echo |ammo=%ammo
echo |ammocap=
echo |rangedRT=
echo |type=%wtype1
echo |puncture=-
echo |balance=%balance
echo |suitedness=%power
echo |construction=%construction
echo |metal=%metal
echo |weight=%weight
echo |appcost=%appcost
echo |wearloc=%wearloc
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
put #log >Appraisal.txt {{Weapon
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |range=ranged
put #log >Appraisal.txt |ammo=%ammo
put #log >Appraisal.txt |ammocap=
put #log >Appraisal.txt |rangedRT=
put #log >Appraisal.txt |type=%wtype1
put #log >Appraisal.txt |puncture=-
put #log >Appraisal.txt |balance=%balance
put #log >Appraisal.txt |suitedness=%power
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |wearloc=%wearloc
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseWeapon3:
var metal no
var maxcharge delete this line
var wearloc -
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
if (matchre ("%1", "(arrows?)")) then var wtype1 arrow
if (matchre ("%1", "(bolts?|quadrellos?|quarrels?|pulzones?)")) then var wtype1 bolt
if (matchre ("%1", "(bullets?|clumps?|lumps?|rocks?)")) then var wtype1 rock
echo http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
echo
echo {{Weapon
echo |name=%tap
echo |newapp=Yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |type=%wtype1
echo |puncture=%puncture
echo |slice=%slice
echo |impact=%impact
echo |balance=-
echo |construction=%construction
echo |metal=%metal
echo |weight=%weight
echo |appcost=%appcost
echo |wearloc=%wearloc
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
put #log >Appraisal.txt {{Weapon
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |type=%wtype1
put #log >Appraisal.txt |puncture=%puncture
put #log >Appraisal.txt |slice=%slice
put #log >Appraisal.txt |impact=%impact
put #log >Appraisal.txt |balance=-
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |wearloc=%wearloc
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseWeapon4:
var metal no
var maxcharge delete this line
var puncturetype No
var slicetype No
var impacttype No
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
if (matchre ("%1", "(handwraps?|knuckleguards?|knuckles?)")) then var wtype1 hands
if (matchre ("%tap", "(elbow)")) then var wtype1 elbows
if (matchre ("%tap", "(knee)")) then var wtype1 knees
if (matchre ("%1", "(footwraps?)")) then var wtype1 feet
echo http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
echo
echo {{Weapon
echo |name=%tap
echo |newapp=Yes
echo |brawl=yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |type=%wtype1
echo |puncture=%puncture
echo |puncturetype=Yes
echo |slice=%slice
echo |slicetype=Yes
echo |impact=%impact
echo |impacttype=Yes
echo |balance=-
echo |construction=%construction
echo |metal=%metal
echo |weight=%weight
echo |appcost=%appcost
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
put #log >Appraisal.txt {{Weapon
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |brawl=yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |type=%wtype1
put #log >Appraisal.txt |puncture=%puncture
put #log >Appraisal.txt |puncturetype=Yes
put #log >Appraisal.txt |slice=%slice
put #log >Appraisal.txt |slicetype=Yes
put #log >Appraisal.txt |impact=%impact
put #log >Appraisal.txt |impacttype=Yes
put #log >Appraisal.txt |balance=-
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |wearloc=%wearloc
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseWeapon5:
var metal no
var maxcharge delete this line
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
echo http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
echo
echo {{Weapon
echo |brawl=yes
echo |name=%tap
echo |newapp=Yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |type=parry
echo |puncture=-
echo |puncturetype=No
echo |slicetype=No
echo |impacttype=No
echo |balance=%balance
echo |suitedness=%power
echo |construction=%construction
echo |metal=%metal
echo |weight=%weight
echo |appcost=%appcost
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Weapon:%tap&action=edit
put #log >Appraisal.txt {{Weapon
put #log >Appraisal.txt |brawl=yes
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |type=parry
put #log >Appraisal.txt |puncture=-
put #log >Appraisal.txt |puncturetype=No
put #log >Appraisal.txt |slicetype=No
put #log >Appraisal.txt |impacttype=No
put #log >Appraisal.txt |balance=%balance
put #log >Appraisal.txt |suitedness=%power
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |wearloc=%wearloc
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseShield:
var metal no
var maxcharge delete this line
var wearloc -
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
echo http://www.elanthipedia.com/wiki/Shield:%tap&action=edit
echo
echo {{Shield
echo |name=%tap
echo |newapp=Yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |type=%stype
echo |hindrance=%shindrance
echo |minprotection=%smin
echo |maxprotection=%smax
echo |puncture=%puncture
echo |slice=%slice
echo |impact=%impact
echo |balance=%balance
echo |suitedness=%power
echo |construction=%construction
echo |metal=%metal
echo |weight=%weight
echo |appcost=%appcost
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Shield:%tap&action=edit
put #log >Appraisal.txt {{Shield
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |type=%stype
put #log >Appraisal.txt |hindrance=%shindrance
put #log >Appraisal.txt |minprotection=%smin
put #log >Appraisal.txt |maxprotection=%smax
put #log >Appraisal.txt |puncture=%puncture
put #log >Appraisal.txt |slice=%slice
put #log >Appraisal.txt |impact=%impact
put #log >Appraisal.txt |balance=%balance
put #log >Appraisal.txt |suitedness=%power
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseArmor:
var metal no
var maxcharge delete this line
var wearloc -
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
echo http://www.elanthipedia.com/wiki/Armor:%tap&action=edit
echo
echo {{Armor
echo |name=%tap
echo |newapp=Yes
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |type=%atype
echo |area=head,eyes,neck,chest,back,abdomen,arms,legs,hands
echo |hindrance=%mhindrance
echo |stealth=%shindrance
echo |puncture=%appuncture
echo |slice=%apslice
echo |impact=%apimpact
echo |fire=%apfire
echo |cold=%apcold
echo |electric=%apelectrical
echo |absorbance=%aapuncture
echo |punctureab=%aapuncture
echo |sliceab=%aaslice
echo |impactab=%aaimpact
echo |fireab=%aafire
echo |coldab=%aacold
echo |electricab=%aaelectrical
echo |construction=%construction
echo |metal=%metal
echo |appcost=%appcost
echo |weight=%weight
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |special=%special
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Armor:%tap&action=edit
put #log >Appraisal.txt {{Armor
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |newapp=Yes
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |type=%atype
put #log >Appraisal.txt |area=head,eyes,neck,chest,back,abdomen,arms,legs,hands
put #log >Appraisal.txt |hindrance=%mhindrance
put #log >Appraisal.txt |stealth=%shindrance
put #log >Appraisal.txt |puncture=%appuncture
put #log >Appraisal.txt |slice=%apslice
put #log >Appraisal.txt |impact=%apimpact
put #log >Appraisal.txt |fire=%apfire
put #log >Appraisal.txt |cold=%apcold
put #log >Appraisal.txt |electric=%apelectrical
put #log >Appraisal.txt |absorbance=%aapuncture
put #log >Appraisal.txt |punctureab=%aapuncture
put #log >Appraisal.txt |sliceab=%aaslice
put #log >Appraisal.txt |impactab=%aaimpact
put #log >Appraisal.txt |fireab=%aafire
put #log >Appraisal.txt |coldab=%aacold
put #log >Appraisal.txt |electricab=%aaelectrical
put #log >Appraisal.txt |construction=%construction
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |special=%special
put #log >Appraisal.txt }}
return

AppraiseItem:
var type1 -
var wearloc -
var maxcharge delete this line
var metal no
pause 2
send tap %number %1 %preposition $shop
waitforre ^You
send shop %number %1 %preposition $shop
waitforre ^Short
send appraise %number %1 %preposition $shop careful
wait
pause
gosub CommaAppcost
gosub CommaCost
if (matchre ("%1", "(aggahhpel|amulet|anklet|armband|armlet|badge|band|bangle|barrette|bead|bracelet|bracer|brooch|chain|charm|choker|circlet|clasp|claw|crown|cuff|earcuff|earring|feather|fetish|haircomb|hairnet|hairpin|locket|medal|medallion|necklace|pendant|periapt|pilonu|pin|por'nidrel|ring|stud|sur'nidrel|tailband|torque|trinket|venda|wristband|wristcuff)")) then var type1 jewelry
if (matchre ("%1", "(bandeau|belt|beret|blouse|bodice|bonnet|boots|breeches|caftan|cape|cassock|chemise|cloak|clogs|coat|corset|dirndl|drape|dress|fabric|fedora|frock|gamantang|gloves|gown|hat|hose|jacket|jerkin|josta|kilt|kimono|krekls|leggings|loincloth|mantle|mask|moccasins|mra'sin|nauda|odaj|overalls|pall|pants|pelt|ribbon|robe|safros|sandals|sarong|sarrak|sash|scarf|shawl|shirt|shoes|skirt|skullcap|slippers|smock|sochi|socks|stockings|stole|tabard|tam|tights|toga|trousers|tunic|turban|uaro's'sugi|veil|vest|vikses|vluze|wing|wrap)")) then var type1 clothing
if (matchre ("%1", "(aggahhpel|gamantang|pel'hhsmur|pilonu|por'nidrel|rasha'hhsograth|sur'nidrel|uaro's'sugi)")) then var type3 skra mur style
if (matchre ("%1", "(cassock|censer)")) then var type3 cleric style
if (matchre ("%1", "(feedbag)")) then var type1 trader style
if (matchre ("%1", "(kimono)")) then var type3 elothean style
if (matchre ("%1", "(mra'sin|josta|krekls|rugursora|safros|sarrak|sega|sochi|vikses|vluze)")) then var type3 prydaen style
if (matchre ("%1", "(nauda|odaj)")) then var type3 rakash style
if (matchre ("%1", "(starchart)")) then var type1 moon mage style
if (matchre ("%1", "(warhorn)")) then var type1 barbarian style
if (matchre ("%1", "(warhorn)")) then var type2 bard style
if (matchre ("%look", "(Curiously, no cord, chain or other binding links the small trinkets together)")) then var type1 jewelry
if (matchre ("%tap", "(anloral|pilgrim's badge)")) then var type2 cleric style
if (matchre ("%tap", "(anloral|pilgrim's badge)")) then var type3 paladin style
if (matchre ("%tap", "(Barbarian|chakrel|warpaint)")) then var type2 barbarian style
if (matchre ("%tap", "(Bard|Bardic|neithrel)")) then var type3 bard style
if (matchre ("%tap", "(Cleric|clergy|clerical|devotional|ecclesiastic|Inquisition|Inquisitor|libation|minister|monastic|monk|\bnun\b|pastor|prayer|preach|priest|sham[ae]n|vestment)")) then var type3 cleric style
if (matchre ("%tap", "(Dwarf|Dwarve[ns]|Haakish)")) then var type3 dwarf style
if (matchre ("%tap", "(Elf|Elve[ns]|Elvish|Ilithic|sana'ati dyaus)")) then var type3 elf style
if (matchre ("%tap", "(Eloth|Gerenshuge)")) then var type3 elothean style
if (matchre ("%tap", "(Empath|apothecaries|apothecary|doctor|empathic|healer|healing|medicine|medic|nurse|physician|surgeon)")) then var type3 empath style
if (matchre ("%tap", "(gaethzen)")) then var type2 gaethzen
if (matchre ("%tap", "(Gnome|Gnomic|Gnomish|Gizzbolf|Krigglin|Spangklud)")) then var type3 gnome style
if (matchre ("%tap", "(Gor'Tog|Toggish|Toggler)")) then var type3 gortog style
if (matchre ("%tap", "(Halfling|Olvi)")) then var halfling race style
if (matchre ("%tap", "(Human|Gamgweth)")) then var human race style
if (matchre ("%tap", "(Kaldar|Gorbesh|Aliesa|Aniek|Eimeuz|Merion|Misiumos|Orisas|Sieben|Sraxaec|Tieheq|Xosiurion)")) then var type3 kaldar style
if (matchre ("%tap", "(Moon Mage|Arid Steppe|astrologer|astrology|Celestial Compact|constellation|Crystal Hand|Fortune's Path|G'nar Pethian|Heritage House|lunar|planet|Progeny|telescope|Tezirah)")) then var type3 moon mage style
if (matchre ("%tap", "(Paladin|soulstone)")) then var type3 paladin style
if (matchre ("%tap", "(Prydaen|Demrris|\bEu\b|Faiyka|Iladza|Shariza|Tenemlor)")) then var type3 prydaen style
if (matchre ("%tap", "(Rakash|Moonskin|Coshivi|Enelne|Mrod)")) then var type3 rakash style
if (matchre ("%tap", "(Ranger)")) then var type3 ranger style
if (matchre ("%tap", "(S'?Kra|Eth'ral'khh|ama'hhrsk|Hav'roth|Indakar|Irhhnth|Malk|mehath|Mhhg|Nehgris|Peri'el|Rasha|ru'at|sharmiit'mhhg|Smolg|Sraan|tail drape|T'Lar Venda)")) then var type3 skra mur style
if (matchre ("%tap", "(Thief|Thieves|brigand|burglar|highwaym[ae]n|pirate|robber|smuggler)")) then var type3 thief style
if (matchre ("%tap", "(Trader|auction|bazaar|caravan|contract|merchant)")) then var type3 trader style
if (matchre ("%tap", "(Warrior Mage|aether|element|talisman)")) then var type3 warrior mage style
echo http://www.elanthipedia.com/wiki/Item:%tap&action=edit
echo
echo {{Item
echo |name=%tap
echo |noun=%1
echo |look=%look
echo |MTag=
echo |CTag=
echo |STag=
echo |type=%type1
echo |type2=%type2
echo |type3=%type3
echo |type4=
echo |wearloc=%wearloc
echo |weight=%weight
echo |appcost=%appcost
echo |sourcetype=sold by
echo |source=%source
echo |cost=%cost $currency
echo |maxcharge=%maxcharge
echo |metal=%metal
echo }}
put #log >Appraisal.txt http://www.elanthipedia.com/wiki/Item:%tap&action=edit
put #log >Appraisal.txt {{Item
put #log >Appraisal.txt |name=%tap
put #log >Appraisal.txt |noun=%1
put #log >Appraisal.txt |look=%look
put #log >Appraisal.txt |MTag=
put #log >Appraisal.txt |CTag=
put #log >Appraisal.txt |STag=
put #log >Appraisal.txt |type=%type1
put #log >Appraisal.txt |type2=%type2
put #log >Appraisal.txt |type3=%type3
put #log >Appraisal.txt |type4=
put #log >Appraisal.txt |wearloc=%wearloc
put #log >Appraisal.txt |weight=%weight
put #log >Appraisal.txt |appcost=%appcost
put #log >Appraisal.txt |sourcetype=sold by
put #log >Appraisal.txt |source=%source
put #log >Appraisal.txt |cost=%cost $currency
put #log >Appraisal.txt |maxcharge=%maxcharge
put #log >Appraisal.txt |metal=%metal
put #log >Appraisal.txt }}
return

CommaAppcost:
var commanumber %appcosti
eval length len(%commanumber)
var appcost %commanumber
if %length < 4 then goto return
evalmath length %length - 3
eval temp substr(%commanumber, %length, 3)
var appcost %temp
topapp:
if %length < 3 then goto lastapp
evalmath length %length - 3
eval temp substr(%commanumber, %length, 3)
var appcost %temp,%appcost
goto topapp
lastapp:
if %length > 0 then
{
eval temp substr(%commanumber, 0, %length)
var appcost %temp,%appcost
}
goto return

CommaCost:
var commanumber %costi
eval length len(%commanumber)
var cost %commanumber
if %length < 4 then goto return
evalmath length %length - 3
eval temp substr(%commanumber, %length, 3)
var cost %temp
topcost:
if %length < 3 then goto lastcost
evalmath length %length - 3
eval temp substr(%commanumber, %length, 3)
var cost %temp,%cost
goto topcost
lastcost:
if %length > 0 then
{
eval temp substr(%commanumber, 0, %length)
var cost %temp,%cost
}
goto return

return:
return

end:
exit
