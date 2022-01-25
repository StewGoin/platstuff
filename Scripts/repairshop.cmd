# Integrate & consolidate into repair stuff (use arrays!)

	# Fix current offensive armor/weapons
	put sheath
#	pause
#	put .armorswap headarmor main
#	waitfor Armor Swapped
	pause
	put .aon
	waitfor Armor On
	pause
	put get my stirring rod;give %1;give %1
	pause
	put put my rod in my $craftpack;stow ticket
	pause
	put get my bellows;give %1;give %1
	pause
	put put my bellows in my $craftpack;stow ticket
	pause
	put get my shovel;give %1;give %1
	pause
	put put my shovel in my $craftpack;stow ticket
	pause
	put get my ball.hammer;give %1;give %1
	pause
	put put my ball.hammer in my $craftpack;stow ticket
	pause
	put get my box.tongs;give %1;give %1
	pause
	put put my box.tongs in my $craftpack;stow ticket
	pause
	put get my stamp;give %1;give %1
	pause
	put put my stamp in my $craftpack;stow ticket
	pause
	put get my pickaxe;give %1;give %1
	pause
	put put my pickaxe in my $craftpack;stow ticket
	pause
	put get my pliers;give %1;give %1
	pause
	put put my pliers in my $craftpack;stow ticket
	pause
	put get my $buckler;wear my $buckler
	pause
	put ask %1 about repair all;ask %1 about repair all
	pause
	put sheath;stow ticket
	pause
	put get my $headarmor_alt;give %1;give %1
	pause
	put stow my $headarmor_alt;stow ticket
	pause
	put wield nightstick;give %1;give %1
	pause
	put sheath;stow ticket
	pause
	put wield axe;give %1;give %1
	pause
	put sheath;stow ticket
	pause
	put wield morning.star;give %1;give %1
	pause
	put sheath morning.star;stow ticket
	pause
	put wield throwing.mallet;give %1;give %1
	pause
	put sheath;stow ticket
	pause
	put wield right my cuska;give %1;give %1
	pause
	put sheath;stow ticket
	pause
	put wield right my adze;give %1;give %1
	pause
	put sheath;stow ticket
	pause
	evalmath inttime $gametime + 180
	put #var repairtime %inttime
	put #parse Script Done
	exit
