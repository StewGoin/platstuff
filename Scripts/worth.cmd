#debug 10

var total 0
var kronars 0
var lirums 0
var dokoras 0
var plats 0
var gold 0
var silver 0
var bronze 0
var copper 0

action var book.stow $1 when from inside your (\S+|\S+\s+\w+)\.$

action (convert) var add.this $1 when \((\d+) copper Kronars\)
action (convert) off

action (totals) on
action (totals) var kronars $1 when Kronars\s+\: (\d+)
action (totals) var lirums $1 when Lirums\s+\: (\d+)
action (totals) var dokoras $1 when Dokoras\s+\: (\d+)

send get my bank book
pause 0.5
send read my book
pause 0.5
action (totals) off
math total add %kronars

pause 0.5
action (convert) on
send figure my book %lirums Lirums
pause 0.5
math total add %add.this

pause 0.5
send figure my book %dokoras Dokoras
pause 0.5
math total add %add.this

evalmath plats %total / 10000,0

send put book in my %book.stow

echo Total worth is: %total Kronars (%plats Platinum)