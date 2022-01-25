action var rexp $1 when Rested EXP Stored:\s(\S+\s\S+|none)
action var usable $1 when Usable This Cycle:\s(\S+\s\S+|none)
action var refresh $1 when Cycle Refreshes:\s(\S+\s\S+|none)

delay 1
put exp
delay 2

put #echo >Log REXP: %rexp | USABLE: %usable | REFRESH: %refresh
if ("%rexp" == "less than" || "%rexp" == "none") then
{
	put #echo >Log Red Out of REXP
}
if ("%usable" == "less than" || "%usable" == "none") then
{
	put #echo >Log Red Out of USABLE
}

exit