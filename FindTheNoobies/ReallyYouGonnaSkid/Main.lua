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

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddSection({
    Name = "Auto Collect Options"
})

SettingsTab:AddSection({
    Name = "Settings"
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

local defaultSettings = {
    autoCollectEnabled = false,
    coinTeleportDelay = 1.5,
    debugMode = false,
    coinType = "Noobie Coin"
}

local settings = setmetatable({}, {__index = defaultSettings})

local executor = nil

if KRNL_LOADED then
    executor = "Krnl"
elseif getexecutorname then
    executor = getexecutorname()
elseif fluxus then
    executor = "Fluxus"
elseif arceus then
    executor = "Arceus X Neo"
elseif codex then
    executor = "Codex"
elseif delta then
    executor = "Delta"
elseif alysse then
    executor = "Alysse"
elseif hydrogen then
    executor = "Hydrogen"
elseif solara then
    executor = "Solara"
elseif sigma then
    executor = "Sigma2"
elseif crystal then
    executor = "Crystal"
elseif incognito then
    executor = "Incognito"
else
    executor = "Unknown"
end

local function loadSettings()
    if executor ~= "Unknown" then
        local success, result = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("OrionTest/Settings.json"))
        end)
        if success and type(result) == "table" then
            for k, v in pairs(result) do
                settings[k] = v
            end
        end
    end
end

local function saveSettings()
    if executor ~= "Unknown" then
        local success, result = pcall(function()
            return writefile("OrionTest/Settings.json", game:GetService("HttpService"):JSONEncode(settings))
        end)
        if not success then
            print("Failed to save settings: " .. tostring(result))
        end
    end
end

local function logDebug(message)
    if settings.debugMode then
        print("[DEBUG]: " .. message)
    end
end

local function getNearestCoin()
    local coinParent = game.Workspace:FindFirstChild("Coins")
    if coinParent then
        local availableCoins = {}
        for _, coin in ipairs(coinParent:GetChildren()) do
            if coin.Name == settings.coinType then
                table.insert(availableCoins, coin)
            end
        end
        if #availableCoins > 0 then
            return availableCoins[math.random(#availableCoins)]
        end
    end
    return nil
end

local function teleportToCoins()
    local lastCoinPosition = nil
    while settings.autoCollectEnabled do
        local nearestCoin = getNearestCoin()
        if nearestCoin and nearestCoin.Position ~= lastCoinPosition then
            lastCoinPosition = nearestCoin.Position
            game.Players.LocalPlayer.Character:MoveTo(nearestCoin.Position)
            logDebug("Teleported to coin at position: " .. tostring(nearestCoin.Position))
            wait(settings.coinTeleportDelay)
        else
            logDebug("No available " .. settings.coinType .. " found or same position as last coin.")
            wait(1)
        end
    end
end

MainTab:AddButton({
    Name = "Start Auto Collect",
    Callback = function()
        settings.autoCollectEnabled = true
        saveSettings()
        logDebug("Auto collect started.")
        teleportToCoins()
    end
})

MainTab:AddButton({
    Name = "Stop Auto Collect",
    Callback = function()
        settings.autoCollectEnabled = false
        saveSettings()
        logDebug("Auto collect stopped.")
    end
})

SettingsTab:AddDropdown({
    Name = "Select Auto Collect Speed",
    Default = tostring(settings.coinTeleportDelay),
    Options = {"0.1", "1.5", "2.5", "4"},
    Callback = function(value)
        settings.coinTeleportDelay = tonumber(value)
        saveSettings()
        logDebug("Auto collect speed set to: " .. value)
    end
})

SettingsTab:AddToggle({
    Name = "Enable Debug Mode",
    Default = settings.debugMode,
    Callback = function(value)
        settings.debugMode = value
        saveSettings()
        logDebug("Debug mode enabled: " .. tostring(value))
    end
})

SettingsTab:AddTextbox({
    Name = "Enter Walk Speed",
    Default = "",
    TextDisappear = true,
    Callback = function(speed)
        local success, modifiedWalkspeed = pcall(function()
            return tonumber(speed)
        end)

        if success and modifiedWalkspeed then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = modifiedWalkspeed
        end
    end
})

SettingsTab:AddTextbox({
    Name = "Enter Jump Power",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        local success, modifiedJumpPower = pcall(function()
            return tonumber(value)
        end)

        if success and modifiedJumpPower then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = modifiedJumpPower
            end
        end
    end
})

local noclipConnection
local noclipEnabled = false

local function noclip()
    if noclipConnection then return end
    noclipEnabled = true
    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if noclipEnabled then
            local character = game.Players.LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

local function clip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    noclipEnabled = false
end

SettingsTab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(value)
        if value then
            noclip()
        else
            clip()
        end
    end    
})

SettingsTab:AddButton({
    Name = "Full Bright",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = 1
        Lighting.FogEnd = 999999
        Lighting.GlobalShadows = false
    end    
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    settings.autoCollectEnabled = true
    logDebug("Character respawned, auto collect enabled.")
    wait(1) -- Delay to ensure the character is fully loaded before teleporting again
    teleportToCoins()
end)

CreditsTab:AddParagraph("Credits", "@Maxwellaltaccount2 : Script Creator")
CreditsTab:AddParagraph("Credits", "@gtkkx : Script Auto Collect")
CreditsTab:AddParagraph("Credits", "@Chat Gpt#2180 [Bot] : Script Improved Auto Collect")

loadSettings()
