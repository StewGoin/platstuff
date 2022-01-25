# Are there any subs in here that aren't in base/include?

# developed from scripts by pbombard, Dasffion, Copernicus, Saet and BakedMage
# an include file providing some common subroutines for list manipulation
# anywhere referenced, the name of the list and any return variables
# supplied to these should be just the variable name, without the % preceeding it.
#
# subroutines included:
#
# list_add $1 $2 - adds an item($2) to the end(right) of a list($1)
#
# list_getlast - returns the end(rightmost) item from a list($1) in a variable($2) but does NOT remove the item from the list
#
# list_push $1 $2 - adds an item($2) to the front(left) of a list($1)
#
# list_pop $1 $2 - removes the frontmost(leftmost) item of a list($1) and stores it in a variable($2)
#
# list_replace $1 $2 $3 - replaces all occurences of an item($2) with another item($3) in a list($1)
#
# list_replaceat $1 $2 $3 - replaces an item at postion($2) with an item($3) in a list($1)
#
# list_remove $1 $2 - removes all occurences of item($2) from a list($1)
# 
# list_removeat $1 $2 - removes item at position($2) from a list($1)
#
# list_reverse $1 - reverses the order of the items in a list($1)

list_add:
	# expects $1 to be the list name (no %), $2 to be the item to add to the list.
	if (("%$1" = "\%$1") || ("%$1" = "")) then var $1 $2
	else var $1 %$1|$2
	return

list_getlast:
	# expects $1 to be the list name (no %), $2 to be the returned variable name (no %)
	eval list_size count("%$1", "|")
	var $2 %$1(%list_size)
	return

list_push:
	# expects $1 to be the list name (no %), $2 to be first item to push into the array
	if (("%$1" = "\%$1") || ("%$1" = "")) then var $1 $2
	else var $1 $2|%$1
	return

list_pop:
	#expects $1 to be the list name (no %), $2 to be the returned variable name (no %)
	eval list_size count("%$1", "|")
	var list_contents %$1
	var list_pop_count 0
	var $2 %list_contents(0)
	var list_temp_contents %list_contents(1)
	evalmath list_pop_count %list_pop_count + 2
	list_pop2:
		if (%list_pop_count <= %list_size) then
		{
			var list_temp_contents %list_temp_contents|%list_contents(%list_pop_count)
			evalmath list_pop_count %list_pop_count + 1
			goto list_pop2
		}
	list_pop_return:
		if ("%list_temp_contents" = "") then unvar $1
		else var $1 %list_temp_contents
		return

list_replace:
	# expects $1 to be the list name (no %), $2 to be the item to replace in it, $3 the stuff to replace it with
	var list_contents |%$1|
	list_replace2:
		eval list_contents replace("%list_contents", "|$2|", "|$3|")
		if contains("%list_contents", "|$2|") then goto list_replace2
	list_replace_return:
		eval list_contents replacere("%list_contents", "(^\||\|$)", "")
		var $1 %list_contents
		return

list_replaceat:
	# expects $1 to be the list name (no %), $2 to be the numerical location in the list to replace, $3 to be the stuff to replace it with
	eval list_size count("%$1", "|")
	var list_contents %$1
	var list_replaceat_position $2
	var list_replaceat_contents $3
	var list_replaceat_count 0
	list_replaceat2:
		if (%list_replaceat_count = %list_replaceat_position) then
		{
			if %list_replaceat_count = 0 then var list_temp_contents %list_replaceat_contents
			else var list_temp_contents %list_temp_contents|%list_replaceat_contents
			evalmath list_replaceat_count %list_replaceat_count + 1
			goto list_replaceat2
		}
		else if (%list_replaceat_count <= %list_size) then
		{
			if %list_replaceat_count = 0 then var list_temp_contents %list_contents(0)
			else var list_temp_contents %list_temp_contents|%list_contents(%list_replaceat_count)
			evalmath list_replaceat_count %list_replaceat_count + 1
			goto list_replaceat2
		}
	list_replaceat_return:
	var $1 %list_temp_contents
	return

list_remove:
	# expects $1 to be the list name (no %), $2 to be the item to remove from it
	var list_contents |%$1|
	list_remove2:
		eval list_contents replace("%list_contents", "|$2|", "|")
		eval list_contents replace("%list_contents", "||" "|")
		if contains("%list_contents", "|$2|") then goto list_remove2
	list_remove_return:
		eval list_contents replacere("%list_contents", "(^\||\|$)", "")
		if ("%list_contents" = "") then unvar $1
		else var $1 %list_contents
		return
		
list_find:
	# expects $1 to be the list name (no %), $2 to be the item to find in it, and $3 to be the variable to store the location
	var list_find_list %$1
	eval list_size count("%list_find_list", "|")
	var list_find_item $2
	var list_find_var $3
	var list_find_count 0
	list_find2:
		if (%list_find_count <= %list_size) then
		{
			if ("%list_find_list(%list_find_count)" = "%list_find_item") then
			{
				var %list_find_var %list_find_count
				return
			}
			else
			{
				evalmath list_find_count %list_find_count + 1
				goto list_find2
			}
		else var %list_find_var null
	return
	
list_removeat:
	# expects $1 to be the list name (no %), $2 to be the numerical location in the list to remove
	eval list_size count("%$1", "|")
	var list_removeat_contents %$1
	var list_removeat_position $2
	var list_removeat_count 0
	list_removeat2:
		if (%list_removeat_count = 0) then
		{
			gosub list_pop list_removeat_contents list_throwaway
			var list_temp_contents %list_removeat_contents
			unvar list_throwaway
			goto list_removeat_return
		}
		if (%list_removeat_count = %list_removeat_position) then
		{
			evalmath list_removeat_count %list_removeat_count + 1
			goto list_removeat2
		}
		else if (%list_removeat_count <= %list_size) then
		{
			if %list_removeat_count = 0 then var list_temp_contents %list_removeat_contents(0)
			else var list_temp_contents %list_temp_contents|%list_removeat_contents(%list_removeat_count)
			evalmath list_removeat_count %list_removeat_count + 1
			goto list_removeat2
		}
	list_removeat_return:
	if ("%list_temp_contents" = "") then unvar $1
	else var $1 %list_temp_contents
	return
	
list_reverse:
	eval list_reverse_count count("%$1", "|")
	if (%list_reverse_count = 0) then return
	var list_contents %$1
	var list_temp_contents %list_contents(%list_reverse_count)
	evalmath list_reverse_count %list_reverse_count - 1
	var list
	list_reverse2:
		if (%list_reverse_count >= 0) then 
		{
			var list_temp_contents %list_temp_contents|%list_contents(%list_reverse_count)
			evalmath list_reverse_count %list_reverse_count - 1
			goto list_reverse2
		}
	list_reverse_return:
	var $1 %list_temp_contents
	return

list_do:
	var list_do_command $2
	var list_contents %$1
	eval list_size count("%$1", "|")
	var list_do_count 0
	list_do2:
		if (%list_do_count <= %list_size) then
		{
			put %list_do_command %list_contents(%list_do_count)
			pause
			evalmath list_do_count %list_do_count + 1
			goto list_do2
		}
	return
