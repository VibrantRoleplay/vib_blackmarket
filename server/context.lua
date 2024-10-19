Context = {
    StoreInfo = {},
    WashTimes = {},
	HackingTimes = {},
}

RegisterNetEvent("blackmarket:server:TriggerWashTimer", function(data)
    Context.WashTimes[data.args.shop.ShopName] = os.time()
end)

lib.callback.register("blackmarket:server:GetWashTime", function(_, data)
	local washtime = 0
	local savedTimestamp = Context.WashTimes[data.ShopName]

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneWashTimeInSeconds = data.WashTime * 60
	local timeExpires = savedTimestamp + zoneWashTimeInSeconds
	local remainingTime = timeExpires - os.time()

	washtime = remainingTime > 0 and remainingTime or 0

	if washtime <= 0 then
		Context.WashTimes[data.ShopName] = -1
	end
	
	return washtime
end)

RegisterNetEvent("blackmarket:server:TriggerHackTimer", function(location)
    Context.HackingTimes[location] = os.time()
end)

lib.callback.register("blackmarket:server:GetHackTimer", function(_, location)
	local hackTime = 0
	local savedTimestamp = Context.HackingTimes[location]

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneHackTimesInSeconds = Config.Hacking.HackingGlobalCooldownInMinutes * 60
	local timeExpires = savedTimestamp + zoneHackTimesInSeconds
	local remainingTime = timeExpires - os.time()

	hackTime = remainingTime > 0 and remainingTime or 0

	if hackTime <= 0 then
		Context.HackingTimes[location] = -1
	end
	
	return hackTime
end)