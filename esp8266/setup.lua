-- File che gestisce la connessione iniziale

local module = {}

local function wifi_wait_ip()
	if wifi.sta.getip() == nil then
		print('IP non ancora disponibile, attendi..')

	else
		tmr.stop(1)
		print('\n===================================')
		print('ESP8266 mode è: ' .. wifi.getmode())
		print('Il MAC address è: ' .. wifi.getmode())
		print('L\'indirizzo IP è: ' .. wifi.getmode())
		print('====================================')
		mclient.start()
	end
end

local function wifi_start(list_aps)
	if list_aps then
		for key, value in pairs(list_aps) do
			if config.SSID and config.SSID[key] then
				wifi.setmode(wifi.STATION)
				wifi.sta.config(key, config.SSID[key])
				wifi.sta.connect()

				print('Mi sto connettendo a ' .. key .. '..')

				tmr.alarm(1, 2500, 1, wifi_wait_ip)
			end
		end
	else
		print('C\'è stato un errore nella lista degli ip')
	end
end

function module.start()
	print('Configuro il wifi..')
	wifi.setmode(wifi.STATION)
	wifi.sta.getap(wifi_start)
end

return module
