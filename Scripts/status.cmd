#your entry determines the status, options are:
# SLEEP / LIGHTSLEEP / AWAKE

setvariable STATUSTOAWAKE
setvariable STATUSTOLIGHTSLEEP
setvariable STATUSTOSLEEP

RTTEST:

	Match RTTESTPAUSE ...wait
	Match STATUSTEST Obvious

	put look

	Matchwait

RTTESTPAUSE:

	pause 1.1
	goto RTTEST

STATUSTEST:

	Match SETSTATUSDEEPSLEEP You are relaxed and your mind has entered a deep state of rest.
	Match SETSTATUSLIGHTSLEEP You are relaxed and your mind has entered a light state of rest.
	Match SETSTATUSAWAKE EXP HELP for more information

	put exp

	Matchwait

SETSTATUSDEEPSLEEP:

	setvariable STATUSTOAWAKE awake
	setvariable STATUSTOawake awake
	setvariable STATUSTOLIGHTSLEEP sleep;sleep
	setvariable STATUSTOlightsleep sleep;sleep
	setvariable STATUSTOSLEEP yawn
	setvariable STATUSTOsleep yawn
	goto CHANGESTATUS

SETSTATUSLIGHTSLEEP:

	setvariable STATUSTOAWAKE awake
	setvariable STATUSTOawake awake
	setvariable STATUSTOLIGHTSLEEP yawn
	setvariable STATUSTOlightsleep yawn
	setvariable STATUSTOSLEEP sleep
	setvariable STATUSTOsleep sleep
	goto CHANGESTATUS

SETSTATUSAWAKE:

	setvariable STATUSTOAWAKE yawn
	setvariable STATUSTOawake yawn
	setvariable STATUSTOLIGHTSLEEP sleep
	setvariable STATUSTOlightsleep sleep
	setvariable STATUSTOSLEEP sleep;sleep
	setvariable STATUSTOsleep sleep;sleep
	goto CHANGESTATUS

CHANGESTATUS:

	Match CHANGESTATUSPAUSE ...wait
	Match ENDSTATUS You relax and allow your mind to enter a state of rest.
	Match ENDSTATUS You draw deeper into rest, trying to destress from a hard
	Match ENDSTATUS You awaken from your reverie and begin to take in the world around you
	Match ENDSTATUS You yawn

	put %STATUSTO%1

	Matchwait

CHANGESTATUSPAUSE:

	pause 1.1
	goto CHANGESTATUS

ENDSTATUS:

	pause 300
	goto RTTEST

