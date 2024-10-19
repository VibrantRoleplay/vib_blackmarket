lib.callback.register('blackmarket:server:GetAccessCode', function(source)
    local correctCode = Config.Hacking.RandomNumberCode
    
    return correctCode
end)