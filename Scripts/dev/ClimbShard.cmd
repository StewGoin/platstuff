#debug 10
var LearningRate 20

Start:
if $Athletics.LearningRate > %LearningRate then goto end
var Next InsideEGate
matchre ELadder \[Shard, East Battlements\]
matchre %Next ^Roundtime
send climb ladder
matchwait

ELadder:
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 131
var Next EastGateReturn
matchre %Next ^Roundtime
matchre EGate ^\[Shard, East Bridge\]
send climb embrasure
matchwait

EastGateReturn:
if $standing != 1 then
{
	send stand
	waitfor You stand
}
pause 0.1
pause 0.1
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 130
matchre InsideEGate ^\[Shard, East City Gates\]
send climb ladder
matchwait

EGate:
gosub Move 216
InsideEGate:
if $standing != 1 then
{
	send stand
	waitfor You stand
}
if $Athletics.LearningRate > %LearningRate then goto end
send climb gate
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 33
send climb door
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
send climb gate
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 34
send climb shop
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 35
send climb bridge
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
send climb path
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
send climb tower
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 36
send climb shop
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 26
send climb bridge
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb

SBarricade:
var Next SGate
matchre %Next ^Roundtime
send climb barricade
matchwait

SGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 38
send climb build
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 40
send climb arch
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
send climb bridge
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 41
send climb build
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 42
send climb tower
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb

WGateWall:
var Next MoveWGate
matchre %Next ^Roundtime
matchre WGateBattlements ^\[Shard, West Battlements\]
send climb wall
matchwait

MoveWGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 43
send climb gate
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
var Next MoveNGate
matchre %Next ^Roundtime
matchre WLadder ^\[Shard, West Battlements\]
send climb ladder
matchwait

WLadder:
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 128
WGateBattlements:
if $Athletics.LearningRate > %LearningRate then goto end
var Next GetToWGate
matchre %Next ^Roundtime
matchre ReturnToWGate ^\[Shard, West Bridge\]
send climb embrasure
matchwait

GetToWGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
gosub Move 127
if $Athletics.LearningRate > %LearningRate then goto end
matchre MoveNGate ^\[Shard, West City Gates\]
send climb ladder
matchwait

ReturnToWGate:
gosub Move 1
gosub Move 216
gosub Move 43
goto MoveNGate

MoveNGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 46
send climb bridge
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
send climb tower
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 48
var Next GoNGate
matchre %Next ^Roundtime
matchre NGateBattlements ^\[Shard, North Battlements\]
send climb wall
matchwait

GoNGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 1
send climb gate
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
var Next MoveEGate
matchre %Next ^Roundtime
matchre NLadder ^\[Shard, North Battlements\]
send climb ladder
matchwait

NLadder:
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 134
NGateBattlements:
if $Athletics.LearningRate > %LearningRate then goto end
var Next MoveToNGate
matchre %Next ^Roundtime
matchre ReturnToNGate ^\[Shard, North Bridge\]
send climb embrasure
matchwait

MoveToNGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
gosub Move 133
if $Athletics.LearningRate > %LearningRate then goto end
matchre MoveEGate ^\[Shard, North City Gates\]
send climb ladder
matchwait

ReturnToNGate:
gosub Move 216
if $Athletics.LearningRate > %LearningRate then goto end
gosub Move 1
MoveEGate:
pause 0.1
pause 0.1
if $standing != 1 then
{
	send stand
	waitfor You stand
}
gosub Move 29
send climb bridge
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
send climb tower
if $Athletics.LearningRate > %LearningRate then goto end
waitforre ^You can't climb
gosub Move 32
goto Start

Move:
var move.skip 0
var move.retry 0
var move.fail 0
var move.room $0
move.goto:
pause 0.5
matchre MoveReturn ^YOU HAVE ARRIVED
matchre move.goto ^MOVE FAILED
send #goto %move.room
matchwait

MoveReturn:
return

end:
put #parse CLIMB DONE
pause 1
put #parse CLIMB DONE
exit