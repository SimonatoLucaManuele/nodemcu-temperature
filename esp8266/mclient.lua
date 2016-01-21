-- File in cui impostiamo le funzioni necessarie per creare diversi topic sul server mqtt

local module = {}
m = nil

function module.send_ping(topic, message)
	m:publish(topic, message, 0, 0)
end

function module.create_client(clientId)
	id = clientId .. node.chipid()
	m = mqtt.Client(id, 120)
	print('Ho creato un client mqtt con id: ' .. clientId)
end

local function connect()

	m = mqtt.Client(config.ID, 120)
	print('Ho creato un client mqtt con id: ' .. config.ID)
	
	m:connect(config.HOST, config.PORT, 0, 1, function(con)
		print('Connesso al host ' .. config.HOST)

		module.status = 'ok'
	end)
end

function module.start()
	connect()
end

return module
