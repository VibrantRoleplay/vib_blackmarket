QBCore = exports["qb-core"]:GetCoreObject()

math.randomseed(os.time())

-------------
--Variables--
-------------

----------
--Events--
----------

-----------
--Threads--
-----------

CreateThread(function()
    for k, v in pairs(Config.MarketPeds) do
        exports.ox_inventory:RegisterShop(v.Name, {
            name = v.Name,
            inventory = v.ItemsForSale,
        })
    end
end)