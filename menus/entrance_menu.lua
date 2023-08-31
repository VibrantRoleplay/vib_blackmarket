RegisterNetEvent('blackmarket:EntranceMenu', function()
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Welcome",
        description = "Answer riddle",
        icon = 'fa-solid fa-question',
        event = "blackmarket:RiddleInput",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Welcome",
        description = "Provide entrance code",
        icon = 'fa-solid fa-hashtag',
        event = "blackmarket:CodeInput",
    }

    lib.registerContext({
        id = 'entrance_menu',
        title = "Market Entrance",
        options = headerMenu
    })

    lib.showContext('entrance_menu')
end)

RegisterNetEvent("blackmarket:RiddleInput", function()
    local options = {}
    local randomKey = math.random(1, #Config.EntranceTypes.Riddles)
    local riddle = Config.EntranceTypes.Riddles[randomKey]

    math.randomseed(GetGameTimer())

    -- Randomise the options first
    local randomised = {}
    for _, answer in ipairs(riddle.Answers) do
        local key = math.random(1, #randomised + 1)
        table.insert(randomised, key, answer)
    end

    -- Then build our options - this is because otherwise the value will be out of sync with the
    -- actual key.
    for k, answer in ipairs(randomised) do
        table.insert(options, {
            value = k,
            label = answer,
        })
    end

    local input = lib.inputDialog(riddle.Question, {
        {
            type = "select",
            label = "Select Answer",
            options = options,
            description = "Choose carefully",
            required = true,
            icon = "fa-solid fa-jar",
        },
    })

    if Config.Debug then
        print(json.encode(input, { pretty = true }))
        print(json.encode(options, { pretty = true }))
    end

    if not input or not input[1] then
        return
    end

    local selectedOption = options[input[1]]
    if selectedOption == nil then
        print("No answer selected")
    end

    local selectedAnswer = selectedOption.label

    local function formatAnswer(str)
        return str:lower():gsub("%s+", "")
    end

    if Config.Debug then
        print("FORMATTED", formatAnswer(selectedAnswer), formatAnswer(riddle.Correct_Answer))
    end

    if formatAnswer(selectedAnswer) == formatAnswer(riddle.Correct_Answer) then
        SpawnKidnapPed()
        lib.notify({
            title = 'Good job',
            description = 'You got the answer right!',
            type = 'success',
        })
    else
        lib.notify({
            title = 'Incorrect',
            description = 'You got the answer wrong!',
            type = 'error',
        })
    end
end)

RegisterNetEvent("blackmarket:CodeInput", function()
    lib.callback('blackmarket:server:GenerateNumberCode', false, function(correctCode)
        local code = correctCode

        if Config.Debug then
            print("Current code: "..code)
        end

        local checkboxInput = lib.inputDialog('Disciple says:', {
            {
                type = 'checkbox',
                label = "You understand that if you tell anyone about this, I'll make my dad smite you heathen ass?",
                description = "I understand",
                required = true,
            },
        })
        if checkboxInput and checkboxInput[1] then
            codeInput = lib.inputDialog('Code Input', {
                {
                    type = "number",
                    label = "What's todays entrance code?",
                    description = "Entrance Code:",
                    required = true,
                    icon = "fa-solid fa-bullet",
                },
            })

            if not codeInput then return end
            local codeInput = codeInput[1]
    
            if codeInput == correctCode then
                SpawnKidnapPed()
            else
                lib.alertDialog({
                    header = "Disciple says:",
                    content = "That's the wrong code ... get the fuck outta here before I call my angels",
                    centered = true,
                })
            end
        else
            lib.alertDialog({
                header = "Disciple says:",
                content = "Stop wasting my time before I call my dad ...",
                centered = true,
            })
        end
    end)
end)