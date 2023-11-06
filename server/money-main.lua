------------------
--Cooldown Stuff--
------------------

RegisterNetEvent("blackmarket:server:TriggerWashTimer", function(data)
	local newData = data.args
    Context.WashTimes[newData.ShopName] = os.time()
end)

lib.callback.register("blackmarket:server:GetWashTime", function(_, data)
	local newData = data.args
	local washtime = 0
	local savedTimestamp = Context.WashTimes[newData.ShopName]

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneWashTimeSeconds = newData.WashTime * 60
	local timeExpires = savedTimestamp + zoneWashTimeSeconds
	local remainingTime = timeExpires - os.time()

	washtime = remainingTime > 0 and remainingTime or 0

	if washtime <= 0 then
		Context.WashTimes[newData.ShopName] = -1
	end

	return washtime
end)

----------
--Events--
----------

RegisterNetEvent('blackmarket:server:UpdateStores', function(data)
	Context.StoreInfo[data.ShopName] = {
		CurrentlyWashing = false,
		AmountBeingWashed = 0,
		Owner = nil,
	}
end)

RegisterNetEvent('blackmarket:server:StartWashing', function(input, data, citizenId)
	local src = source
	local moneyAmount = input[1]

	exports.ox_inventory:RemoveItem(src, "black_money", moneyAmount)
	Context.StoreInfo[data.ShopName] = {
		CurrentlyWashing = true,
		AmountBeingWashed = moneyAmount,
		Owner = citizenId
	}
end)

-------------
--Callbacks--
-------------

lib.callback.register("blackmarket:server:GetStoreInfo", function(source, data)
	return Context.StoreInfo[data]
end)