-- file caricato all'avvio
-- impostiamo i vari require

--app = require('application')
mclient = require('mclient')
config = require('config')
setup = require('setup')

-- importiamo anche i moduli che gestisono i vari input e output
--leds = require('leds')
temperature = require('temperature')

mclient.start()
temperature.start()
