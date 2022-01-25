# Interesting, does profiles or some other mechanism exist to account for this? Most stuff won't matter now with attack....

IF_1 goto %1
echo Which weapons skill?
exit

# ME/HE/THE macro set
hunt:
put #var weapon %2
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {sheath;wield left knife;arrange}
put #macro {NumPad3, Control, Alt} {skin;#send 2 loot}
put #macro {NumPad4, Control, Alt} {sheath knife;get bund;bund;drop bund}
put #macro {NumPad5, Control, Alt} {wield $weapon}
put #macro {NumPad6, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {NumPad7, Control, Alt} {get coin}
put #macro {NumPad8, Control, Alt} {stow gem}
put #macro {NumPad9, Control, Alt} {attack}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {attack $target}

exit

# ME/HE/THE macro set
khuj:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {wear khuj;wield left knife;arrange}
put #macro {NumPad2, Control, Alt} {}
put #macro {NumPad3, Control, Alt} {skin;#send 2 loot}
put #macro {NumPad4, Control, Alt} {sheath knife;get bund;bund;drop bund}
put #macro {NumPad5, Control, Alt} {remove khuj}
put #macro {NumPad6, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {NumPad7, Control, Alt} {get coin}
put #macro {NumPad8, Control, Alt} {stow gem}
put #macro {NumPad9, Control, Alt} {attack}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {attack $target}

exit

# Thrown macro set
thr:
thro:
throw:
thrown:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {get my dark.blade}
put #macro {NumPad2, Control, Alt} {enc;throw}
put #macro {NumPad3, Control, Alt} {enc;throw $target}
put #macro {NumPad4, Control, Alt} {enc;throw left}
put #macro {NumPad5, Control, Alt} {enc;throw left $target}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {stow gem}
put #macro {NumPad8, Control, Alt} {get coin}
put #macro {NumPad9, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {stow dark.blade}

exit

# Thrown macro set
mallet:
mall:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {get mallet}
put #macro {NumPad2, Control, Alt} {get mallet;enc;throw}
put #macro {NumPad4, Control, Alt} {sheath;wield left knife;arrange}
put #macro {NumPad5, Control, Alt} {skin;#send 2 loot}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {stow gem}
put #macro {NumPad9, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {stow mallet}

exit


# ME/HE/THE macro set
me:
he:
2he:
the:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {-bob}
put #macro {NumPad2, Control, Alt} {-feint}
put #macro {NumPad3, Control, Alt} {-draw}
put #macro {NumPad4, Control, Alt} {-sweep}
put #macro {NumPad5, Control, Alt} {-slice}
put #macro {NumPad6, Control, Alt} {-chop}
put #macro {NumPad7, Control, Alt} {get coin}
put #macro {NumPad8, Control, Alt} {stow gem}
put #macro {NumPad9, Control, Alt} {attack}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {attack $target}

exit

# ME/HE/THE macro set
brawl:
put #macro {NumPad0, Control, Alt} {-loot}
put #macro {NumPad1, Control, Alt} {-punch}
put #macro {NumPad2, Control, Alt} {-claw}
put #macro {NumPad3, Control, Alt} {-elbow}
put #macro {NumPad4, Control, Alt} {-gouge}
put #macro {NumPad5, Control, Alt} {-kick}
put #macro {NumPad6, Control, Alt} {-sweep left}
put #macro {NumPad7, Control, Alt} {-bob}
put #macro {NumPad8, Control, Alt} {-stow gem}
put #macro {NumPad9, Control, Alt} {-attack}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {attack $target}

exit

# ME/HE/THE macro set
le:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {lunge}
put #macro {NumPad2, Control, Alt} {thrust}
put #macro {NumPad3, Control, Alt} {jab}
put #macro {NumPad4, Control, Alt} {dodge}
put #macro {NumPad5, Control, Alt} {bob}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {face next}
put #macro {NumPad8, Control, Alt} {face @}
put #macro {NumPad9, Control, Alt} {attack}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {attack $target}

exit

# Thrown macro set
sli:
slin:
sling:
slings:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {get lump;load}
put #macro {NumPad2, Control, Alt} {aim;#send 5 fire}
put #macro {NumPad3, Control, Alt} {fire $target}
put #macro {NumPad4, Control, Alt} {get lump;load}
put #macro {NumPad5, Control, Alt} {enc;throw left $target}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {face next}
put #macro {NumPad8, Control, Alt} {face @}
put #macro {NumPad9, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {stow dark.blade}

exit

# bow macro set
bow:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {get bas.arrow;load;#send 1 stow bas.arrow;#send 1 aim;#send 8 fire}
put #macro {NumPad2, Control, Alt} {stow bas.arrow;aim;#queue clear;#send 8 fire}
put #macro {NumPad3, Control, Alt} {fire $target}
put #macro {NumPad4, Control, Alt} {stow bas.arrow}
put #macro {NumPad5, Control, Alt} {enc;throw left $target}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {face next}
put #macro {NumPad8, Control, Alt} {face @}
put #macro {NumPad9, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {stow dark.blade}

exit

# crossbow macro set
cross:
crossbow:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {-push my crossbow}
put #macro {NumPad2, Control, Alt} {-aim}
put #macro {NumPad3, Control, Alt} {-fire}
put #macro {NumPad4, Control, Alt} {-stow bolt}
put #macro {NumPad5, Control, Alt} {-load my crossbow}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {stow gem}
put #macro {NumPad9, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {stow mallet}

exit

# Thrown macro set
off:
offhand:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {get rock;swap}
put #macro {NumPad2, Control, Alt} {throw left;enc}
put #macro {NumPad3, Control, Alt} {enc;throw $target}
put #macro {NumPad4, Control, Alt} {stow rock}
put #macro {NumPad5, Control, Alt} {enc;throw left $target}
put #macro {NumPad6, Control, Alt} {bob}
put #macro {NumPad7, Control, Alt} {face next}
put #macro {NumPad8, Control, Alt} {face @}
put #macro {NumPad9, Control, Alt} {prep stra;target;#send 4 cast}
put #macro {Subtract, Control, Alt} {#send retreat}
put #macro {Add, Control, Alt} {stow dark.blade}

exit

# Halberd macro set
hal:
halb:
halberd:
put #macro {NumPad0, Control, Alt} {loot}
put #macro {NumPad1, Control, Alt} {dodgedraw}
put #macro {NumPad2, Control, Alt} {feint}
put #macro {NumPad3, Control, Alt} {lunge}
put #macro {NumPad4, Control, Alt} {draw}
put #macro {NumPad5, Control, Alt} {slice}
put #macro {NumPad6, Control, Alt} {thrust}
put #macro {NumPad7, Control, Alt} {sweep}
put #macro {NumPad8, Control, Alt} {chop}
put #macro {NumPad9, Control, Alt} {jab}
put #macro {Subtract, Control, Alt} {attack}
put #macro {Add, Control, Alt} {attack $target}

exit
