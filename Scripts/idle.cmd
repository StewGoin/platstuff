
CHECKCONNECTION:

	put look
	if $connected = 0 then goto RECONNECT

	pause 60

	goto CHECKCONNECTION

RECONNECT:

	put #connect
	pause 20


#[22:24] Connection lost. (ConnectionAborted)
#[22:24] Attempting to reconnect.
#Unable to contact Genie Key server!
#Please make sure that your internet connection is working properly and that you do not have a firewall blocking access.
#For more information visit http://genieclient.com or http://twitter.com/genieclient
