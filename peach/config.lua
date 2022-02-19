Config = {}

Config.Locale = 'de'

Config.Delays = {
	PeachProcessing = 500 * 10,
}

Config.JuiceDealerItems = {
	peach_juice = 784,
}



Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	--Peach
	PeachField = {coords = vector3(1841.21, 4912.01, 42.5), name = _U('blip_PeachFarm'), color = 17, sprite = 237, radius = 0.0, scale = 0.5},
	PeachProcessing = {coords = vector3(-369.14, 6061.31, 31.00), name = _U('blip_peachprocessing'), color = 17, sprite = 365, radius = 0.0},
	--JuiceDealer
	JuiceDealer = {coords = vector3(-2506.11, 3615.14, 13.16), name = _U('blip_juicedealer'), color = 17, sprite = 272, radius = 0.0},
	
}
