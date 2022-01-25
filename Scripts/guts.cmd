# rename to HE game and clean if needed

main:
put give crone 500 dok


0:
put get bucket
match 3 You reach into
match 2 Yer've had yer five tosses
matchwait

3:
pause 0.5
put throw $righthandnoun at skeleton
goto 0

1:
pause 1
put glance
match brain brain in your right hand
match tongue tongue in your right hand
match intestine intestine in your right hand
match eyeball eyeball in your right hand
match kidney kidney in your right hand
match esophagus esophagus in your right hand
match lung lung in your right hand
match stomach stomach in your right hand
match liver liver in your right hand
match heart heart in your right hand
matchwait

heart:
put throw heart at skeleton
goto 0

liver:
put throw liver at skeleton
goto 0

stomach:
put throw stomach at skeleton
goto 0

lung:
put throw lung at skeleton
goto 0

esophagus:
put throw esophagus at skeleton
goto 0

2:
put ask ghoul about prize
put stow
move go gap
goto main

brain:
put throw brain at skeleton
goto 0

tongue:
put throw tongue at skeleton
goto 0

intestine:
put throw intestine at skeleton
goto 0

eyeball:
put throw eyeball at skeleton
goto 0

kidney:
put throw kidney at skeleton
goto 0

exit:
exit
