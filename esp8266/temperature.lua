-- File in cui gestiamo il sensore della temperatura

local module = {}

pin = 1
module.pin = pin
status, temp, humi = dht.read11(pin)

local function read_status()

	-- salviamo lo stato nel modulo che poi esporteremo

	module.status = status

    if status == dht.OK then

        print("DHT Temperature:"..temp..";\t".."Humidity:"..humi)

		-- salviamo nel modulo nuovi valori
	    module.temp = temp
	    module.humi = humi

	    if mclient.status == 'ok' then
		    mclient.send_ping('humidity', ' ' .. humi .. ' ')
		    mclient.send_ping('temperature',  ' ' .. temp .. ' ')
		end

    elseif status == dht.ERROR_CHECKSUM then
        print( "DHT Checksum error." )
    elseif status == dht.ERROR_TIMEOUT then
        print( "DHT timed out." )
    end
end

function module.read_values()
	
	print("DHT Temperature:"..temp..";".."Humidity:"..humi)

	-- salviamo nel modulo nuovi valori
    module.temp = temp
    module.humi = humi

end

local function start_sensor()
	
	tmr.alarm(0, 1000, 1, function() read_status() end)

end

function module.start()

	print('avvio il sensore di temperatura al pin ' ..  pin)
	start_sensor()

end

return module
