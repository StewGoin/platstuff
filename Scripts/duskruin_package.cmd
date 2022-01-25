goto TOP
include includes.cmd

action put #echo >Log Gem Pouch Full when ^The pouch is too full to fit any more, and will need to be sold before using it again\.

TOP:
	put open my package
	pause 0.5
	put get my bloodscrip;redeem my bloodscrip
	pause 0.5
	put fill my gem pouch with my package
	pause 0.5
	put .moveitems my.package my.bright.pouch
	waitfor Done Moving Items.
	pause 0.5
	put put my package in bucket
exit