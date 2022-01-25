# this script will find the item you request within a crafting book.
# usage is .craftbook <weapon|blacksmith> <item name>, e.g. .craftbook weapon dire mace
# when first used for a book, or when a book changes, it should be reset with: .craftbook <weapon|blacksmith> rebuild

# variables this script needs to know ahead of time: n/a

#debug 5
var BooksShort \b(bl|we|arm|car|tail|rem|tin|sha)(.+)?
var BooksLong blacksmith|weapon|armor|carving|tailoring|remedy|tinkering|shaping
TOP:
	if %0 = "" then goto USAGE
	# pull out first word for weapon/blacksmith and then shift and check $0 again
	eval BookMatch tolower("%1")
	if matchre(("%BookMatch"), "(%BooksShort)") then
	{
		if matchre("%BooksLong", "($1(\w+)?)") then var BookType $1
		else exit
		shift
	}
	else goto USAGE
	if matchre(tolower("%1"), "build") then
	{
		var Item build
		goto BUILD
	}
	eval Item replace("%0", " ", ".")
#	eval Item tolower("%Item")
	eval Item replacere("%Item", " an\.", " ")
	eval Item replacere("%Item", " a\.", " ")
	eval Item replace("%Item", " some.", " ")
	eval Item replace("%Item", "metal.", "")
#	eval Item replace("%Item", "cloth.", "")
  eval Item replace("%Item", "pair.of.", "")
  eval Item replace("%Item", "'s", "")
	eval Item replace("%Item", "stone.", "")

	goto BOOK_FIND

USAGE:
	echo USAGE .book <item name with spaces or .>
	exit

BOOK_FIND:
	if $%BookType_chapter_list = "" then goto BUILD
	eval ChapterMax count("$%BookType_chapter_list", "|")
	math ChapterMax add 1
	var ChapterCount 0

BOOK_CHAPTER_CHECK:
	if %ChapterCount <= %ChapterMax then
	{

		var CurrentChapter $%BookType_chapter_list(%ChapterCount)
		var CurrentChapter %BookType_%CurrentChapter
		if matchre("|$%CurrentChapter|", "\|(\d+) %Item\|") then
		{
			math ChapterCount add 1
			var chapter %ChapterCount
			var page $1
			goto BOOK_TURN
		}
		else
		{
			math ChapterCount add 1
			goto BOOK_CHAPTER_CHECK
		}
	}
	else
	{
		echo Item Not Found!
		exit
	}

BOOK_TURN:
	#if "$righthandlong" != "a book of master crafting instructions" then gosub get my book from bright.pouch
	gosub BOOK_TYPE %BookType
	gosub BOOK_CHAPTER %chapter
	gosub BOOK_PAGE %page
	gosub BOOK_READ
	goto BOOK_DONE

BOOK_TYPE:
	pause
	match return You turn the book to the section on
	put turn my book to discipline $1
	matchwait 2
	goto BOOK_TYPE

BOOK_INDEX:
	matchre return ^You turn|already at the index
	put turn my book to index
	matchwait 2
	goto BOOK_INDEX

BOOK_CHAPTER:
	matchre return ^You turn|^The book is already turned to
	put turn my book to chapter $1
	matchwait 2
	goto BOOK_CHAPTER

BOOK_PAGE:
	matchre return ^You turn|^You are already on page
	matchre book_error ^There are only|^This chapter does not have that many pages|^A book of.*does not have a chapter
	put turn my book to page $1
	matchwait 2
	goto BOOK_PAGE

BOOK_READ:
	action (ParsePageItem) var ParsePageItem $1 when Page \d+: Instructions for crafting ((\S+(\s)?)+)    =-
	action (ParsePageItem) var ParsePageItem weapon.balancing when You begin to study the instructions and slowly understand how to balance metal weapons
	action (ParsePageItem) var ParsePageItem weapon.tempering when You begin to study the instructions and slowly understand how metal weapon tempering works
	action (ParsePageItem) var ParsePageItem weapon.honing when how to hone metal weapons
	action (ParsePageItem) var ParsePageItem $1 when instructions for metal (armor lightening)
	action (ParsePageItem) var ParsePageItem $1 when instructions for metal (armor tempering)
	action (ParsePageItem) var ParsePageItem $1 when instructions for metal (armor reinforcing)
	action (ParsePageItem) var ParsePageItem $1 when instructions for metal (armor repair)
	action (ParsePageItem) var ParsePageItem $1 when instructions for metal (rare-metal armor tempering)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for making (leather crafts)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (cutting and counting leather)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (cutting and counting fabrics)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (knitting clothing from yarn)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (tailored armor sealing)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (tailored armor lightening)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (rare tailored armor sealing)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (tailored armor reinforcing)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (knitting clothing from yarn)
  action (ParsePageItem) var ParsePageItem $1 when Instructions for (making leather crafts)
# add matchtable here
	send read my book;yes
  waitforre A list of ingredients is provided|A good positive attitude
	action (ParsePageItem) off
	eval ParsePageItem replacere("%ParsePageItem", "(\ban|\ba|some|metal|stone|pair of) ", "")
  eval ParsePageItem replacere("%ParsePageItem", "('s)", "")
	eval ParsePageItem replacere("%ParsePageItem", " ", ".")
	if "%ParsePageItem" = "%Item" then return
	elseif "%Item" = "build" then return
  else
	{
		echo Item Mismatch, suggest building the book again
		echo %ParsePageItem
		exit
	}

BOOK_DONE:
	pause 0.5
	put #parse Book Turned
	exit

book_error:
	echo Error.
	exit

build:
	# Book Index Parsing
	#gosub get my %BookType book
	#gosub get my book from my bright.pouch
	gosub BOOK_TYPE %BookType
	var ParseList null
	action var ParseList %ParseList|$1 when Chapter \d+(.*)
	gosub BOOK_INDEX
	gosub BOOK_READ
	pause 3
	action remove Chapter \d+(.*)

	eval ParseList replace("%ParseList", "null|", "")
	eval ParseList replace("%ParseList", " ", "_")
	eval ParseList replace("%ParseList", ":_", "")
	eval ParseList tolower("%ParseList")
	put #var %BookType_chapter_list %ParseList
	eval ParseListMax count("%ParseList", "|")
	math ParseListMax add 1
	var ParseListCount 1

CHAPTER_PARSE:
if %ParseListCount <= %ParseListMax then
{
	gosub BOOK_CHAPTER %ParseListCount
	var ParseList null
	action var ParseList %ParseList|$1 when Page (\d+:(\s\S+)+)\s+Page
	action var ParseList %ParseList|$1 when Page (\d+:(\s\S+)+)(\s+)?$
	gosub BOOK_READ
	pause 3
	action remove Page (\d+:(\s\S+)+)\s+Page
	action remove Page (\d+:(\s\S+)+)(\s+)?$

	eval ParseList replace("%ParseList", " ", ".")
	eval ParseList replace("%ParseList", ":.", " ")
	eval ParseList replacere("%ParseList", " an\.", " ")
	eval ParseList replacere("%ParseList", " a\.", " ")
	eval ParseList replace("%ParseList", " some.", " ")
	eval ParseList replace("%ParseList", "metal.", "")
	eval ParseList replace("%ParseList", "stone.", "")
	eval ParseList replace("%ParseList", "pair.of.", "")
	eval ParseList replace("%ParseList", "'s", "")
	eval ParseList replace("%ParseList", "slender.stirring.ro", "slender.stirring.rod")
	eval ParseList replace("%ParseList", "null|", "")
	math ParseListCount subtract 1
	var ChapterName $%BookType_chapter_list(%ParseListCount)
	eval ChapterName tolower("%ChapterName")
	put #var %BookType_%ChapterName %ParseList


	math ParseListCount add 2
	goto CHAPTER_PARSE
}
exit


if "%BookType" = "weapon" then
	{
		var ChapterName $weapon_chapter_list(%ParseListCount)
		eval ChapterName tolower("%ChapterName")
		put #var weapon_%ChapterName %ParseList
#		echo $weapon_%ChapterName
	}
	elseif "%BookType" = "blacksmith" then
	{
		var ChapterName $blacksmith_chapter_list(%ParseListCount)
		eval ChapterName tolower("%ChapterName")
		put #var blacksmith_%ChapterName %ParseList
#		echo $blacksmith_%ChapterName
	}
	elseif "%BookType" = "carving" then
	{
		var ChapterName $carving_chapter_list(%ParseListCount)
		eval ChapterName tolower("%ChapterName")
		put #var carving_%ChapterName %ParseList
#		echo $carving_%ChapterName
	}
	elseif "%BookType" = "tailoring" then
	{
		var ChapterName $tailoring_chapter_list(%ParseListCount)
		eval ChapterName tolower("%ChapterName")
		put #var tailoring_%ChapterName %ParseList
#		echo $tailoring_%ChapterName
	else exit

### The gosubs below are part of my standard include, but I've pulled them out individually here to avoid having nested scripts

PUT:
	var put $0
PUT.1:
  matchre PUT.1 ^\.\.\.wait|^Sorry
	matchre RETURN ^You drop|^You put|^You reverently place|^As you start to place|^What were you referring to\?|^You briefly twist the top|^As you put the
	put put %put
	matchwait 2
	goto PUT.1

GET:
   var Get $0
GET.2:
   pause .2
   matchre GET.2 ^\.\.\.wait|^Sorry
	 match ERROR What were you referring to?
   matchre RETURN ^You get (a|an|some|your|the)|^You are already holding that\.|^You pick up
   send get %Get
   matchwait 2
	 goto GET.2

RETURN:
	return

ERROR:
	echo There was an error in the script.
	exit
