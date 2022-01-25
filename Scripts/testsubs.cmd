debug 8
if_1 goto start
exit

start:
put #echo list_add test:;#echo %names
gosub list_add names ryken|test|test2
gosub list_add names %1
put #echo %names
put #echo list_do test:
gosub list_do names "echo"
put #echo list_reverse test:
gosub list_reverse names
put #echo %names
put #echo list_reverse test2:
gosub list_reverse names
put #echo %names
put #echo list_getlast test:
gosub list_getlast names lastvar
echo %lastvar
put #echo %names
put #echo list_replace test:
gosub list_replace names test replace
put #echo %names
put #echo list_replaceat test:
gosub list_replaceat names 0 replaceat
put #echo %names
put #echo list_removeat test:
gosub list_removeat names 1
put #echo %names
gosub list_add names %1
put #echo list_remove test:
gosub list_remove names %1
put #echo %names
put #echo list_push test:
gosub list_push names %1
put #echo %names
put #echo list_pop test:
gosub list_pop names popvar
echo %popvar
put #echo %names
put #echo list_pop 2nd test:
gosub list_pop names popvar
echo %popvar
put #echo %names
exit

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

list_removeat:
	# expects $1 to be the list name (no %), $2 to be the numerical location in the list to remove
	eval list_size count("%$1", "|")
	var list_contents %$1
	var list_removeat_position $2
	var list_removeat_count 0
	list_removeat2:
		if (%list_removeat_count = %list_removeat_position) then
		{
			evalmath list_removeat_count %list_removeat_count + 1
			goto list_removeat2
		}
		else if (%list_removeat_count <= %list_size) then
		{
			if %list_removeat_count = 0 then var list_temp_contents %list_contents(0)
			else var list_temp_contents %list_temp_contents|%list_contents(%list_removeat_count)
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
			pause 0.5
			evalmath list_do_count %list_do_count + 1
			goto list_do2
		}
	return