debug 5

PREP:
  put .fix scraper
  waitfor ITEM FIXED
  gosub get my hide.scraper
  gosub get my %1.%2 from my bundle

SCRAPE_IT:
#  match BAD_SKIN You carefully scrape your hide.  Unfortunately, you snag the scraper, marring the hide.
  match DONE_SCRAPE The hide looks as clean as you can make it.
  match DONE_SCRAPE The hide looks as clean as you can make it!
  match SCRAPE_IT Roundtime
  put scrape %2 with scraper careful
  matchwait 2
  goto SCRAPE_IT

DONE_SCRAPE:
  gosub put my hide.scraper in my $craftpack
  gosub get tanning.lotion from my $craftpack

TANN_IT:
  match DONN_TANN The hide looks as clean as you can make it.
  match DONE_TANN Roundtime
  put pour my tanning.lotion on my %1.%2
  matchwait 2
  goto TANN_IT

DONE_TANN:
  gosub put my tanning.lotion in my $craftpack
  gosub put my %1.%2 in my pouch
  goto PREP

BAD_SKIN:
  gosub put my scraper in my $craftpack
  gosub put my %1.%2 in bucket
  goto PREP

exit

include includes.cmd
