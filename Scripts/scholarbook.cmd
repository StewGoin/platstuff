# Base it, clean it, etc... if possible

book.start:
	action goto %LAST when ^\.\.\.wait|^Sorry, you may only type|You don't seem able to move to do that
	var LAST book.start
	if !matchre($diffblacksmith, ^\d+$) then put #var diffblacksmith 1
#	if $Scholarship.LearningRate > 10 then goto book.alldone
#	var max.chapter 4
book.start_1:
	var LAST book.start_2
#	var chapter 1
#	var page 1

book.get:
	var LAST book.get
	matchre book.next.chapter ^You get|^You are already holding|^But that is already in your inventory
	put get my blacksmith.book
	matchwait 2
	goto book.get

book.next.chapter:
#	math chapter add 1
#	var page 1
	var chapter 2
	evalmath page $diffblacksmith + 1
	put #var diffblacksmith %page

book.chapter:
	var LAST book.chapter
#	if (%chapter = %max.chapter) then goto book.start_1
	matchre book.page ^You turn
	put turn my book to chapter %chapter
	matchwait 2
	goto book.chapter

book.next.page:
	if %page >= $diffblacksmith then math page subtract 1
	else math page add 1

book.page:
	var LAST book.page
	matchre book.study ^You turn
#	matchre book.next.chapter ^There are only|^This chapter does not have that many pages
	matchre book.done ^There are only|^This chapter does not have that many pages|^You are already on page
	put turn my book to page %page
	matchwait 2
	goto book.page

book.study:
	var LAST book.study
	matchre book.toohard  fail to grasp all but the simplest diagrams on the page|realize the design is far beyond your abilities
	matchre book.exp ^Roundtime
	matchre book.next.chapter ^That's odd
	put study my book
	matchwait 2
	goto book.study

book.toohard:
	math page subtract 1
	put #var diffblacksmith %page

book.exp:
	if $Scholarship.LearningRate > $bookrate then goto book.done
	goto book.next.page

book.done:
	var LAST book.done
	matchre book.done_1 ^You put your|^Stow what
	put put my blacksmith.book in my $craftpack
	matchwait 2
	goto book.done

book.done_1:
	var LAST book.done_1
book.alldone:
	var LAST book.alldone
	pause
	put #parse Script Done
	exit
