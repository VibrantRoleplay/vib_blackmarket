Context = {
    StoreInfo = {},
    WashTimes = {},
	MarketInfo = {},
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

	local zoneWashTimeSeconds = data.WashTime * 60
	local timeExpires = savedTimestamp + zoneWashTimeSeconds
	local remainingTime = timeExpires - os.time()

	washtime = remainingTime > 0 and remainingTime or 0

	if washtime <= 0 then
		Context.WashTimes[data.ShopName] = -1
	end
	
	return washtime
end)