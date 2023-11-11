--------------------
--Wash Timer Stuff--
--------------------

RegisterNetEvent("blackmarket:server:TriggerWashTimer", function(data)
    Context.WashTimes[data.args.ShopName] = os.time()
end)

lib.callback.register("blackmarket:server:GetWashTime", function(_, data)
	local washtime = 0
	local savedTimestamp = Context.WashTimes[data.args.ShopName]

	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local zoneWashTimeSeconds = data.args.WashTime * 60
	local timeExpires = savedTimestamp + zoneWashTimeSeconds
	local remainingTime = timeExpires - os.time()

	washtime = remainingTime > 0 and remainingTime or 0

	if washtime <= 0 then
		Context.WashTimes[data.args.ShopName] = -1
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
		storeCut = nil,
		Robber = nil,
		HasStoreBeenRobbed = false,
		Investigated = false,
	}
end)

RegisterNetEvent('blackmarket:server:StartWashing', function(input, data, citizenId, moneyLaunderingLoss)
	local moneyAmount = input[1]

	exports.ox_inventory:RemoveItem(source, Config.MoneyItem, moneyAmount)
	Context.StoreInfo[data.ShopName] = {
		CurrentlyWashing = true,
		AmountBeingWashed = moneyAmount,
		Owner = citizenId,
		StoreCut = moneyLaunderingLoss,
	}
end)

RegisterNetEvent('blackmarket:server:RetrieveMoney', function(data)
	local amount = QBCore.Shared.Round(data.returnMoney)

	exports.ox_inventory:AddItem(source, "money", amount)
	Context.StoreInfo[data.storeData.args.ShopName] = {
		CurrentlyWashing = false,
		AmountBeingWashed = 0,
		Owner = nil,
		storeCut = nil,
	}
end)

RegisterNetEvent('blackmarket:server:RobStore', function(data, citizenId)
	local src = source
	local moneyAmount = Context.StoreInfo[data.storeData.args.ShopName].AmountBeingWashed

	if exports.ox_inventory:CanCarryItem(source, Config.MoneyItem, moneyAmount) then
		exports.ox_inventory:AddItem(source, Config.MoneyItem, moneyAmount)
	end

	Context.StoreInfo[data.storeData.args.ShopName].AmountBeingWashed = 0
	Context.StoreInfo[data.storeData.args.ShopName].Robber = citizenId
	Context.StoreInfo[data.storeData.args.ShopName].HasStoreBeenRobbed = true
end)

-------------
--Callbacks--
-------------

lib.callback.register("blackmarket:server:GetStoreInfo", function(source, data)
	return Context.StoreInfo[data]
end)

lib.callback.register('blackmarket:server:InvestigateRobbery', function(source, data)
    local robber = QBCore.Functions.GetPlayerByCitizenId(data.robber)
	local robberInfo = robber.PlayerData.charinfo
	
	Context.StoreInfo[data.storeData.args.ShopName].Investigated = true
    return robberInfo
end)