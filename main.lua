local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- Flags voor functies
local buying = {}
local buyingGear = {}
local buyingEggs = {}
local antiAfkEnabled = false

-- Cleanup functie
local function Cleanup()
    for k in pairs(buying) do buying[k] = false end
    for k in pairs(buyingGear) do buyingGear[k] = false end
    for k in pairs(buyingEggs) do buyingEggs[k] = false end

    local existingGui = CoreGui:FindFirstChild("Rayfield")
    if existingGui then existingGui:Destroy() end
end

Cleanup()

-- Laad Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mylands Grow a Garden",
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Myland",
   ShowText = "Rayfield",
   Theme = "Default",
   ToggleUIKeybind = "K",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "Big Hub"
   },
   Discord = {Enabled = false},
   KeySystem = false
})

-- === GENERAL TAB ===
local Tab = Window:CreateTab("General", 4483362458)

-- Walkspeed
local selectedSpeed = 16
local function applySpeed(humanoid)
    if humanoid then
        humanoid.WalkSpeed = selectedSpeed
    end
end

-- Forceer snelheid elke seconde
task.spawn(function()
    while true do
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.WalkSpeed ~= selectedSpeed then
            applySpeed(humanoid)
        end
        task.wait(1)
    end
end)

Tab:CreateSlider({
    Name = "Stel je snelheid in",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        selectedSpeed = Value
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        applySpeed(humanoid)
    end,
})

LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    applySpeed(humanoid)
end)

-- Anti-AFK
Tab:CreateToggle({
    Name = "🛑 Anti AFK",
    CurrentValue = false,
    Callback = function(state)
        antiAfkEnabled = state
    end
})

-- Anti-AFK loop
task.spawn(function()
    while true do
        if antiAfkEnabled then
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
        task.wait(60)
    end
end)

-- === SEED SHOP TAB ===
local Tab = Window:CreateTab("Seed Shop", 4483362458)
Tab:CreateSection("Autobuy")

local BuySeed = ReplicatedStorage.GameEvents.BuySeedStock
local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn",
    "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut",
    "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper",
    "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone"
}

Tab:CreateToggle({
    Name = "🧺 Select Everything",
    CurrentValue = false,
    Callback = function(state)
        for _, seed in ipairs(seeds) do
            buying[seed] = state
        end
        if state then
            for _, seed in ipairs(seeds) do
                task.spawn(function()
                    while buying[seed] do
                        BuySeed:FireServer(seed, 1)
                        task.wait(0.25)
                    end
                end)
            end
        end
    end
})

for _, seed in ipairs(seeds) do
    Tab:CreateToggle({
        Name = seed,
        CurrentValue = false,
        Callback = function(state)
            buying[seed] = state
            if state then
                task.spawn(function()
                    while buying[seed] do
                        BuySeed:FireServer(seed, 1)
                        task.wait(0.25)
                    end
                end)
            end
        end,
    })
end

-- === GEAR SHOP TAB ===
local Tab = Window:CreateTab("Gear Shop", 4483362458)
Tab:CreateSection("Autobuy")

local BuyGear = ReplicatedStorage.GameEvents.BuyGearStock
local gearItems = {
    "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler",
    "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Tanning Mirror",
    "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool",
    "Friendship Pot", "Levelup Lollipop"
}

Tab:CreateToggle({
    Name = "🧰 Select Everything",
    CurrentValue = false,
    Callback = function(state)
        for _, gear in ipairs(gearItems) do
            buyingGear[gear] = state
        end
        if state then
            for _, gear in ipairs(gearItems) do
                task.spawn(function()
                    while buyingGear[gear] do
                        BuyGear:FireServer(gear, 1)
                        task.wait(0.25)
                    end
                end)
            end
        end
    end
})

for _, gear in ipairs(gearItems) do
    Tab:CreateToggle({
        Name = gear,
        CurrentValue = false,
        Callback = function(state)
            buyingGear[gear] = state
            if state then
                task.spawn(function()
                    while buyingGear[gear] do
                        BuyGear:FireServer(gear, 1)
                        task.wait(0.25)
                    end
                end)
            end
        end,
    })
end

-- === EGG SHOP TAB ===
local Tab = Window:CreateTab("Egg Shop", 4483362458)
Tab:CreateSection("Autobuy")

local BuyEgg = ReplicatedStorage.GameEvents.BuyPetEgg
local eggItems = {
    "Common Egg", "Common Summer Egg", "Rare Summer Egg",
    "Mythical Egg", "Paradise Egg", "Bug Egg"
}

Tab:CreateToggle({
    Name = "🥚 Select Everything",
    CurrentValue = false,
    Callback = function(state)
        for _, egg in ipairs(eggItems) do
            buyingEggs[egg] = state
        end
        if state then
            for _, egg in ipairs(eggItems) do
                task.spawn(function()
                    while buyingEggs[egg] do
                        BuyEgg:FireServer(egg, 1)
                        task.wait(0.25)
                    end
                end)
            end
        end
    end
})

for _, egg in ipairs(eggItems) do
    Tab:CreateToggle({
        Name = egg,
        CurrentValue = false,
        Callback = function(state)
            buyingEggs[egg] = state
            if state then
                task.spawn(function()
                    while buyingEggs[egg] do
                        BuyEgg:FireServer(egg, 1)
                        task.wait(0.25)
                    end
                end)
            end
        end,
    })
end
