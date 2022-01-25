# The hell does this even do?

put app my ring quick

matchre dokoras ^You .+ worth .+ dokoras
matchre kronars ^You .+ worth .+ kronars
matchre lirums ^You .+ worth .+ lirums
matchwait

dokoras:
put #var currency Dokoras
goto end

kronars:
put #var currency Kronars
goto end

lirums:
put #var currency Lirums
goto end

end:

echo
echo Currency set to $currency
echo
