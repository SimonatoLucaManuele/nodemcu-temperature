-- file di configurazione dell'applicazione

local module = {}

module.SSID = {}
module.SSID['Vodafone-Simonato'] = 'Mirco14021959'

module.HOST = '192.168.1.5'
module.PORT = 1883
module.ID = node.chipid()

module.ENDPOINT = 'nodemcu/'

return module
