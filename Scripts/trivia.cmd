debug 10

    action goto Question.Asked when You can use SUBMIT to record your answer
    action goto Timer.Up when The reward period has ended.

Loop:
    if (($health < 60) || ($dead = 1)) then goto Quit
    pause 30
    put health
    goto Loop

Question.Asked:
    var triviastart $gametime
    put #play quiz; put #flash
    goto Loop

Timer.Up:
    var triviaend $gametime
    pause .1


Time.Total:
    evalmath triviatime %triviaend-%triviastart
    pause .1
    echo Triviatime was %triviatime seconds.
    put #echo >Log Green Trivia time was %triviatime seconds.
    pause
    goto Loop

Quit:
    put quit
    exit