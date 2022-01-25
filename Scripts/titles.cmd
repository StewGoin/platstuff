put #gag ^titlecheck$
put #gag >
action var 41 $1 when Guild: (.+)
put info
var 1 Blunt
var 2 Ranged 
var 3 Brawling 
var 4 GenEdged 
var 5 SpecEdged 
var 6 Thrown 
var 7 Pole 
var 8 Shield 
var 9 Slings 
var 10 Weapons 
var 11 WeaponMaster 
var 12 Performer 
var 13 PrimaryMagic 
var 14 Magic 
var 15 Money 
var 16 Ownership 
var 17 Survival1 
var 18 Survival2 
var 19 Survival3 
var 20 Lore 
var 21 Criminal 
var 22 Generic 
var 23 Racial 
var 24 Premium 
var 25 Order 
var 26 Novice 
var 27 Practitioner 
var 28 Dilettante 
var 29 Aficionado 
var 30 Adept 
var 31 Expert 
var 32 Professional 
var 33 Authority 
var 34 Genius 
var 35 Savant 
var 36 Master 
var 37 GrandMaster 
var 38 Guru 
var 39 Legend 
var 40 Custom
var counter 0
var title 0
var exit 0
action matchre titles (.+);matchwait when The following titles of the (.+) category are available to you:
put #gag {The following titles of the (.+) category are available to you:}
put #gag {There are no titles you may choose from that category\.}

start:
if %counter != 42 then math counter add 1
if %counter = 42 then goto exit
put title list %%counter
match start There are no titles you may choose from that category.
matchwait

titles:
math title add 1
math exit add 1
var %title $0
goto start

exit:
if 1 <= %exit then 
{
echo %1
echo
}
if 2 <= %exit then 
{
echo %2
echo
}
if 3 <= %exit then 
{
echo %3
echo
}
if 4 <= %exit then 
{
echo %4
echo
}
if 5 <= %exit then 
{
echo %5
echo
}
if 6 <= %exit then 
{
echo %6
echo
}
if 7 <= %exit then 
{
echo %7
echo
}
if 8 <= %exit then 
{
echo %8
echo
}
if 9 <= %exit then 
{
echo %9
echo
}
if 10 <= %exit then 
{
echo %10
echo
}
if 11 <= %exit then 
{
echo %11
echo
}
if 12 <= %exit then 
{
echo %12
echo
}
if 13 <= %exit then 
{
echo %13
echo
}
if 14 <= %exit then 
{
echo %14
echo
}
if 15 <= %exit then 
{
echo %15
echo
}
if 16 <= %exit then 
{
echo %16
echo
}
if 17 <= %exit then 
{
echo %17
echo
}
if 18 <= %exit then 
{
echo %18
echo
}
if 19 <= %exit then 
{
echo %19
echo
}
if 20 <= %exit then 
{
echo %20
echo
}
if 21 <= %exit then 
{
echo %21
echo
}
if 22 <= %exit then 
{
echo %22
echo
}
if 23 <= %exit then 
{
echo %23
echo
}
if 24 <= %exit then 
{
echo %24
echo
}
if 25 <= %exit then 
{
echo %25
echo
}
if 26 <= %exit then 
{
echo %26
echo
}
if 27 <= %exit then 
{
echo %27
echo
}
if 28 <= %exit then 
{
echo %28
echo
}
if 29 <= %exit then 
{
echo %29
echo
}
if 30 <= %exit then 
{
echo %30
echo
}
if 31 <= %exit then 
{
echo %31
echo
}
if 32 <= %exit then 
{
echo %32
echo
}
if 33 <= %exit then 
{
echo %33
echo
}
if 34 <= %exit then 
{
echo %34
echo
}
if 35 <= %exit then 
{
echo %35
echo
}
if 36 <= %exit then 
{
echo %36
echo
}
if 37 <= %exit then 
{
echo %37
echo
}
if 38 <= %exit then 
{
echo %38
echo
}
if 39 <= %exit then 
{
echo %39
echo
}
if 40 <= %exit then 
{
echo %40
echo
}
if 41 <= %exit then 
{
echo %41
echo
}
if 42 <= %exit then 
{
echo %42
echo
}
put #ungag {The following titles of the (.+) category are available to you:}
put #ungag {There are no titles you may choose from that category\.}
put #ungag ^titlecheck$
put #ungag >