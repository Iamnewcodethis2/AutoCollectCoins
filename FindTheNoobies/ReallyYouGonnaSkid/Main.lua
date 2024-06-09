local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Find The Noobies Morph | Version Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest",
	  IntroText = "Loading Script..."
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddSection({
    Name = "Main"
})

CreditsTab:AddSection({
    Name = "Credits"
})

OrionLib:MakeNotification({
    Name = "Welcome!",
    Content = "Thank you for executing this script",
    Image = "rbxassetid://4483345998",
    Time = 4
})

MainTab:AddButton({
    Name = "Auto Collect Coins Fast",
    Callback = function()
        local lastCoinPosition = nil
        local coinTeleportDelay = 0.1
        local autoCollectEnabled = true

        local function getNearestCoin()
            local coinParent = game.Workspace:FindFirstChild("Coins")

            if coinParent then
                local availableCoins = {}

                for _, coin in ipairs(coinParent:GetChildren()) do
                    if coin.Name == "Noobie Coin" and coin.Position ~= lastCoinPosition then
                        table.insert(availableCoins, coin)
                    end
                end

                if #availableCoins > 0 then
                    local nearestCoin = availableCoins[math.random(#availableCoins)]
                    return nearestCoin
                else
                    return nil
                end
            else
                return nil
            end
        end

        local function teleportToCoin()
            while true do
                if autoCollectEnabled then
                    local nearestCoin = getNearestCoin()

                    if nearestCoin then
                        lastCoinPosition = nearestCoin.Position
                        game.Players.LocalPlayer.Character:MoveTo(nearestCoin.Position)
                        wait(coinTeleportDelay)
                    else
                        print("No available Noobie Coin found!")
                        wait(1)
                    end
                else
                    wait()
                end
            end
        end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            autoCollectEnabled = false
        end)

        teleportToCoin()
    end
})

MainTab:AddButton({
    Name = "Auto Collect Coins Normal",
    Callback = function()
        local lastCoinPosition = nil
        local coinTeleportDelay = 1.5
        local autoCollectEnabled = true

        local function getNearestCoin()
            local coinParent = game.Workspace:FindFirstChild("Coins")

            if coinParent then
                local availableCoins = {}

                for _, coin in ipairs(coinParent:GetChildren()) do
                    if coin.Name == "Noobie Coin" and coin.Position ~= lastCoinPosition then
                        table.insert(availableCoins, coin)
                    end
                end

                if #availableCoins > 0 then
                    local nearestCoin = availableCoins[math.random(#availableCoins)]
                    return nearestCoin
                else
                    return nil
                end
            else
                return nil
            end
        end

        local function teleportToCoin()
            while true do
                if autoCollectEnabled then
                    local nearestCoin = getNearestCoin()

                    if nearestCoin then
                        lastCoinPosition = nearestCoin.Position
                        game.Players.LocalPlayer.Character:MoveTo(nearestCoin.Position)
                        wait(coinTeleportDelay)
                    else
                        print("No available Noobie Coin found!")
                        wait(1)
                    end
                else
                    wait()
                end
            end
        end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            autoCollectEnabled = false
        end)

        teleportToCoin()
    end
})

MainTab:AddButton({
    Name = "Auto Collect Coin Slow",
    Callback = function()
        local lastCoinPosition = nil
        local coinTeleportDelay = 2.5
        local autoCollectEnabled = true

        local function getNearestCoin()
            local coinParent = game.Workspace:FindFirstChild("Coins")

            if coinParent then
                local availableCoins = {}

                for _, coin in ipairs(coinParent:GetChildren()) do
                    if coin.Name == "Noobie Coin" and coin.Position ~= lastCoinPosition then
                        table.insert(availableCoins, coin)
                    end
                end

                if #availableCoins > 0 then
                    local nearestCoin = availableCoins[math.random(#availableCoins)]
                    return nearestCoin
                else
                    return nil
                end
            else
                return nil
            end
        end

        local function teleportToCoin()
            while true do
                if autoCollectEnabled then
                    local nearestCoin = getNearestCoin()

                    if nearestCoin then
                        lastCoinPosition = nearestCoin.Position
                        game.Players.LocalPlayer.Character:MoveTo(nearestCoin.Position)
                        wait(coinTeleportDelay)
                    else
                        print("No available Noobie Coin found!")
                        wait(1)
                    end
                else
                    wait()
                end
            end
        end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            autoCollectEnabled = false
        end)

        teleportToCoin()
    end
})

MainTab:AddButton({
    Name = "Auto Collect Coin Super Slow",
    Callback = function()
        local lastCoinPosition = nil
        local coinTeleportDelay = 4
        local autoCollectEnabled = true

        local function getNearestCoin()
            local coinParent = game.Workspace:FindFirstChild("Coins")

            if coinParent then
                local availableCoins = {}

                for _, coin in ipairs(coinParent:GetChildren()) do
                    if coin.Name == "Noobie Coin" and coin.Position ~= lastCoinPosition then
                        table.insert(availableCoins, coin)
                    end
                end

                if #availableCoins > 0 then
                    local nearestCoin = availableCoins[math.random(#availableCoins)]
                    return nearestCoin
                else
                    return nil
                end
            else
                return nil
            end
        end

        local function teleportToCoin()
            while true do
                if autoCollectEnabled then
                    local nearestCoin = getNearestCoin()

                    if nearestCoin then
                        lastCoinPosition = nearestCoin.Position
                        game.Players.LocalPlayer.Character:MoveTo(nearestCoin.Position)
                        wait(coinTeleportDelay)
                    else
                        print("No available Noobie Coin found!")
                        wait(1)
                    end
                else
                    wait()
                end
            end
        end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            autoCollectEnabled = false
        end)

        teleportToCoin()
    end
})

CreditsTab:AddParagraph("Credits", "@Maxwellaltaccount2 : Script Creator")
CreditsTab:AddParagraph("Credits", "@gtkkx : Script Auto Collect")
CreditsTab:AddParagraph("Credits", "@Chat Gpt#2180 [Bot] : Script Improved Auto Collect")
