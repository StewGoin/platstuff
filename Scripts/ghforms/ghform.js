var data = {
	"form": {
		"general_commands": {
			"type": "h1",
			"text": "General Commands"
		},
		"analyze": {
			"type": "select",
			"text": "Analyze Creature",
			"title": "Analyzes monsters to get debuff combos",
			"options": [{
					"text": "None",
					"value": ""
				},
				{
					"text": "1",
					"value": "ANALYZE 1"
				},
				{
					"text": "2",
					"value": "ANALYZE 2"
				},
				{
					"text": "3",
					"value": "ANALYZE 3"
				},
				{
					"text": "4",
					"value": "ANALYZE 4"
				},
				{
					"text": "5",
					"value": "ANALYZE 5"
				},
				{
					"text": "6",
					"value": "ANALYZE 6"
				},
				{
					"text": "7",
					"value": "ANALYZE 7"
				},
				{
					"text": "8",
					"value": "ANALYZE 8"
				},
				{
					"text": "9",
					"value": "ANALYZE 9"
				},
				{
					"text": "10",
					"value": "ANALYZE 10"
				}
			]
		},
		"appraise": {
			"type": "select",
			"text": "Appraise Creature",
			"title": "Appraise quick (3s RT) or MARK ALL after a kill or when a monster enters an empty room",
			"options": [{
					"text": "None",
					"value": ""
				},
				{
					"text": "Appraise",
					"value": "APPR"
				},
				{
					"text": "Mark (Thief only)",
					"value": "MARK"
				}
			]
		},
		"buff": {
			"type": "checkbox",
			"text": "Self Buff",
			"title": "Maintain buffs as needed"
		},
		"construct": {
			"type": "checkbox",
			"text": "Construct (Empath)",
			"title": "Try to use only damaging attacks/magic on constructs and non-damaging for non-constructs"
		},
		"danger": {
			"type": "checkbox",
			"text": "Dangerous Area Buffing",
			"title": "Try to retreat while casting buffs in dangerous areas"
		},
		"exp": {
			"type": "checkbox",
			"text": "Experience Check",
			"title": "Use with MULTI or TRAIN to cycle weapons after locking"
		},
		"hunt": {
			"type": "checkbox",
			"text": "Hunt (Perception)",
			"title": "Hunt every 90s to train perception and stalking (and scouting for Rangers)"
		},
		"juggle": {
			"type": "checkbox",
			"text": "Juggle (empty room)",
			"title": "Juggle while waiting for monsters to show up"
		},
		"search_type": {
			"type": "select",
			"text": "Search Type",
			"title": "The kind of loot to search for",
			"options": [{
					"text": "Default",
					"value": ""
				},
				{
					"text": "Treasure",
					"value": "SEARCH TREASURE"
				},
				{
					"text": "Boxes",
					"value": "SEARCH BOXES"
				},
				{
					"text": "Equipment",
					"value": "SEARCH EQUIPMENT"
				},
				{
					"text": "Goods",
					"value": "SEARCH GOODS"
				},
				{
					"text": "All",
					"value": "SEARCH ALL"
				}
			]
		},
		"manip": {
			"type": "checkbox",
			"text": "Manipulate (Empath only)",
			"title": "Adds manipulation"
		},
		"necroheal": {
			"type": "checkbox",
			"text": "Necro Healing",
			"title": "Only use if you have the consume spell. Only activates if >80% mana, $roomplayers is empty, and more than minor scuffs"
		},
		"necroritual": {
			"type": "select",
			"text": "Necro Ritual",
			"title": "Will perform specified ritual unless $roomplayers is not empty.",
			"options": [{
					"text": "None",
					"value": ""
				},
				{
					"text": "Dissect",
					"value": "NECRORITUAL dissect"
				},
				{
					"text": "Preserve",
					"value": "NECRORITUAL preserve"
				},
				{
					"text": "Harvest",
					"value": "NECRORITUAL harvest"
				},
				{
					"text": "Arise",
					"value": "NECRORITUAL arise"
				}
			]
		},
		"noevasion": {
			"type": "checkbox",
			"text": "No Evasion",
			"title": "Skip evasion when switching stances"
		},
		"noparry": {
			"type": "checkbox",
			"text": "No Parry",
			"title": "Skip parry when switching stances"
		},
		"noshield": {
			"type": "checkbox",
			"text": "No Shield",
			"title": "Skip shield when switching stances"
		},
		"paralysis": {
			"type": "checkbox",
			"text": "Paralysis (Empath only)",
			"title": "Shock-free TM training; requires $paralysis variable"
		},
		"pilgrim": {
			"type": "checkbox",
			"text": "Pilgrim's Badge",
			"title": "Pray on pilgrim badge every 30 minutes"
		},
		"point": {
			"type": "checkbox",
			"text": "Point",
			"title": "Toggles hidden critter pointing (default is off)"
		},
		"pouch": {
			"type": "checkbox",
			"text": "Pouch",
			"title": "Remove a full worn gem pouch and place it into $GH_CONTAINER_POUCH_CONTAINER, and replace it with an empty one"
		},
		"powerp": {
			"type": "checkbox",
			"text": "Power Perceive",
			"title": "Trains power perception every 6 minutes"
		},
		"retreat": {
			"type": "checkbox",
			"text": "Retreat (Ranged/Magic)",
			"title": "Maintain a distance in combat when using ranged/thrown weapons and magic"
		},
		"roam": {
			"type": "checkbox",
			"text": "Roaming",
			"title": "Roam when you run out of things to kill. Attempts to check for other people and critters."
		},
			
		"slow": {
			"type": "checkbox",
			"text": "Slow Attack",
			"title": "Slows attacks to wait for stamina to refill when below 90%"
		},
			
		"smite": {
			"type": "checkbox",
			"text": "Smite",
			"title": "Trains a Paladin's conviction by smiting every 60 seconds"
		},
		"default_stance": {
			"type": "select",
			"text": "Default Stance",
			"title": "Sets your combat stance to one of your defined stances",
			"options": [{
					"text": "Block",
					"value": "BLOCK"
				},
				{
					"text": "Parry",
					"value": "PARRY"
				},
				{
					"text": "Dodge",
					"value": "DODGE"
				},
				{
					"text": "Custom",
					"value": "CUSTOM"
				}
			]
		},
		"stance": {
			"type": "checkbox",
			"text": "Stance Cycling",
			"title": "Will cycle through stances once the primary stance skill is locked (cycle: evasion -> shield -> parry)"
		},
		"tactics": {
			"type": "checkbox",
			"text": "Tactics",
			"title": "Add tactics training to hunting routine"
		},
		"target": {
			"type": "text",
			"text": "Target Bodypart",
			"title": "Target body part to focus attacks on"
		},
		"thief": {
			"type": "checkbox",
			"text": "Thief Ambushes",
			"title": "Add Thief-only ambushes to routine"
		},
		"timer": {
			"type": "checkbox",
			"text": "Timing Function",
			"title": "Uses a timing function"
		},
		"train": {
			"type": "checkbox",
			"text": "(TRAIN) Exp Check",
			"title": "Exp check after combat cycle"
		},
		
		"skin_fieldset": {
			"type": "fieldset",
			"text": "Skinning Options",
			"fields": {
		
				"skin": {
					"type": "checkbox",
					"text": "Skin Creatures",
					"title": "Skins creatures at the end. Redundant if enabling any below options."
				},
				"bundle": {
					"type": "checkbox",
					"text": "Bundle Skins",
					"title": "Skins and bundles. If no ropes to bundle, drops skins, drops bundles."
				},
				"skinretreat": {
					"type": "checkbox",
					"text": "Skin Retreat",
					"title": "Retreats prior to skinning"
				},
				"scrape": {
					"type": "checkbox",
					"text": "Scrape Skins",
					"title": "Scrapes prior to bundling"
				},
				"arrange": {
					"type": "select",
					"text": "Arrange Count",
					"title": "Can arrange a number of times to arrange",
					"options": [{
							"text": "None",
							"value": ""
						},
						{
							"text": "1",
							"value": "ARRANGE 1"
						},
						{
							"text": "2",
							"value": "ARRANGE 2"
						},
						{
							"text": "3",
							"value": "ARRANGE 3"
						},
						{
							"text": "4",
							"value": "ARRANGE 4"
						},
						{
							"text": "5",
							"value": "ARRANGE 5"
						},
						{
							"text": "All (outfitting/Ranger)",
							"value": "ARRANGE ALL"
						}
					]
				},
				"wear": {
					"type": "checkbox",
					"text": "Wear Bundle",
					"title": "Wears bundles instead of dropping them"
				},
				"tie": {
					"type": "checkbox",
					"text": "Tie Bundle",
					"title": "Ties bundles off before dropping/wearing to reduce item count"
				},
				"arrange_type": {
					"type": "select",
					"text": "Arrange For...",
					"title": "Arranges for skin (default), bones, or parts specifically",
					"options": [{
							"text": "Skin (default)",
							"value": ""
						},
						{
							"text": "Bone",
							"value": "BONE"
						},
						{
							"text": "Part",
							"value": "PART"
						}
					]
				}
			}
		},
		"loot_fieldset": {
			"type": "fieldset",
			"text": "Loot Pickup Options",
			"fields": {
				"collectible": {
					"type": "checkbox",
					"text": "Collectibles",
					"title": "Loot collectible items"
				},
				"lootboxes": {
					"type": "checkbox",
					"text": "Boxes",
					"title": "Loot boxes until stow container is full"
				},
				"lootcoins": {
					"type": "checkbox",
					"text": "Coins"
				},
				"lootgems": {
					"type": "checkbox",
					"text": "Gems",
					"title": "Loot gems until stow container is full"
				},
				"junk": {
					"type": "checkbox",
					"text": "Junk",
					"title": "Loots junk items (runes/scrolls/lockpicks/etc)"
				},
				"lootall": {
					"type": "checkbox",
					"text": "Loot All",
					"title": "Loots all above (ignores above options)"
				}
			}
		},

		//Combat Methods

		"combat_methods": {
			"type": "h1",
			"text": "Combat Methods"
		},
		"ambush": {
			"type": "checkbox",
			"text": "Ambush with Weapon",
			"title": "Hide/stalk an enemy then attack from hiding. Paladins may use this to hide/advance and unhide prior to attacking."
		},
		"back": {
			"type": "checkbox",
			"text": "Backstab (Thief only)",
			"title": "Backstab, else attack normally if weapon doesn't support backstabbing."
		},
		"snap": {
			"type": "checkbox",
			"text": "Snap Cast/Fire",
			"title": "Enable snap casting or firing",
			"child": "snap_time"
		},
		"snap_time": {
			"type": "text",
			"text": "Snap Delay (Optional)",
			"title": "Enter delay to wait before casting/firing."
		},

		//Combat Systems
		
		"combat_system": {
			"type": "h1",
			"text": "Combat Systems"
		},
		"brawl": {
			"type": "checkbox",
			"text": "Brawl",
			"title": "Brawls instead of using weapons"
		},
		"dance": {
			"type": "checkbox",
			"text": "Dance",
			"title": "Dance (BRAWL) with a set number of creatures until more than the number is in the room",
			"requiresChild": true,
			"child": "dance_count"
		},
		"dance_count": {
			"type": "text",
			"text": "Dance Count",
			"title": "Specific number to dance with"
		},	
		"offhand": {
			"type": "checkbox",
			"text": "Offhand",
			"title": "Fight with offhand weapon. Usable with melee and thrown weapons and uses the normal weapon sequences, just offhand."
		},
		"poach": {
			"type": "checkbox",
			"text": "Poach",
			"title": "Poach with ranged weapon"
		},
		"snipe": {
			"type": "checkbox",
			"text": "Snipe (Ranger/Thief only)",
			"title": "Snipe with ranged weapon"
		},
		"swap_setting": {
			"type": "select",
			"text": "Swap Weapon Style",
			"title": "How your swappable weapon works. Must be set for weapon swapping to work.",
			"options": [{
					"text": "None",
					"value": ""
				},
				{
					"text": "Swap (regular)",
					"value": "SWAP"
				},
				{
					"text": "Throwable",
					"value": "TSWAP"
				},
				{
					"text": "Fan-style",
					"value": "FSWAP"
				}
			],
			"requiresChild": true,
			"child": "swap_weapon"
		},
		"swap_weapon": {
			"type": "select",
			"text": "Swap Weapon Type",
			"title": "Swap to the specific weapon type",
			"options": [{
					"text": "None",
					"value": ""
				},
				{
					"text": "Small Edge",
					"value": "SE"
				},
				{
					"text": "Large Edge",
					"value": "LE"
				},
				{
					"text": "2H Edge",
					"value": "2HE"
				},
				{
					"text": "Small Blunt",
					"value": "SB"
				},
				{
					"text": "Large Blunt",
					"value": "LB"
				},
				{
					"text": "2H Blunt",
					"value": "2HB"
				},
				{
					"text": "Polearm",
					"value": "POLE"
				},
				{
					"text": "Staves",
					"value": "S"
				}
			]
		},
		"throw_type": {
			"type": "select",
			"text": "Throw Style",
			"title": "How to throw the weapon",
			"options": [{
					"text": "None",
					"value": ""
				},
				{
					"text": "Lob",
					"value": "LOB"
				},
				{
					"text": "Throw",
					"value": "THROW"
				},
				{
					"text": "Hurl",
					"value": "HURL"
				}
			]
		},
		"magic_fieldset": {
			"type": "fieldset",
			"text": "Magic Options",
			"fields": {	
				"magic": {
					"type": "checkbox",
					"text": "Cast once per combat routine",
					"title": "Primarily rely on weapons for combat when this is enabled"
				},
				"magic_type": {
					"type": "select",
					"text": "Magic Type",
					"title": "Primarily rely on spells for combat. Bard and Khri magics are enabled here.",
					"options": [{
							"text": "None",
							"value": ""
						},
						{
							"text": "PM",
							"value": "PM"
						},
						{
							"text": "TM",
							"value": "TM"
						},
						{
							"text": "Debilitation",
							"value": "DEBIL"
						},
						{
							"text": "Augmentation",
							"value": "AUG"
						},
						{
							"text": "Utility",
							"value": "UTIL"
						},
						{
							"text": "Enchante (Bard only)",
							"value": "ENCHANTE"
						},
						{
							"text": "Khri (Thief only",
							"value": "KHRI"
						}
					],
					"requiresChild": true,
					"child": "spellname"
				},
				"spellname": {
					"type": "text",
					"text": "Spell Name",
					"title": "Spell to cast (e.g., SOP, LB, etc)",
					"requiresChild": true,
					"child": "spellmana"
				},
				"spellmana": {
					"type": "text",
					"text": "Mana Prep",
					"title": "Amount of mana to prepare the spell with",
					"child": "spellharness"
				},
				"spellharness": {
					"type": "text",
					"text": "Harness Prep (Optional)",
					"title": "tooltip"
				}
				
			}
		},

		"ritual_fieldset": {
			"type": "fieldset",
			"text": "Ritual Options",
			"fields": {
				"ritual": {
					"type": "checkbox",
					"text": "Maintain Ritual Spell",
					"title": "Maintains a ritual spell during combat. Use setup script for additional options.",
					"requiresChild": true,
					"child": "ritualspell"
				},
				"ritualspell": {
					"type": "text",
					"text": "Ritual Spell",
					"title": "Name of the ritual spell to cast",
					"requiresChild": true,
					"child": "ritualmana"
				},
				"ritualmana": {
					"type": "text",
					"text": "Ritual Mana",
					"title": "Amount of mana to cast the spell at"
				}
			}
		},


		//Equipment
		
		"equipment": {
			"type": "h1",
			"text": "Equipment"
		},
		"weapon": {
			"type": "text",
			"text": "Weapon",
			"title": "Primary weapon to use in this routine"
		},
		"shield": {
			"type": "text",
			"text": "Shield",
			"title": "Ignores shield if using 2H weapon. Do not enter a shield if using it arm-worn."
		}
	}
}