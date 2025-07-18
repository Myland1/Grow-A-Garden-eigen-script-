local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

-- Zorg dat deze variabelen bereikbaar zijn voor Cleanup
local buying = buying or {}
local buyingGear = buyingGear or {}
local buyingEggs = buyingEggs or {}

local function Cleanup()
    -- Zet alle koop flags uit, zodat loops stoppen
    for k in pairs(buying) do
        buying[k] = false
    end
    for k in pairs(buyingGear) do
        buyingGear[k] = false
    end
    for k in pairs(buyingEggs) do
        buyingEggs[k] = false
    end

    -- Verwijder bestaande GUI als die er is
    local existingGui = CoreGui:FindFirstChild("Rayfield")
    if existingGui then
        existingGui:Destroy()
    end
end

-- Roep Cleanup aan voordat je het menu maakt
Cleanup()

-- Daarna kan jouw Rayfield code starten, zoals jij hem al hebt
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Mylands Grow a Garden",
   Icon = 0,
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by Myland",
   ShowText = "Rayfield",
   Theme = "Default",
   ToggleUIKeybind = "K",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

-- Daarna volgt jouw volledige rest van het script (tabs, toggles, etc.)

-- WALK SPEED TAB
local Tab = Window:CreateTab("General", 4483362458)
local selectedSpeed = 16
local plr = game.Players.LocalPlayer

local function applySpeed(humanoid)
    if humanoid then
        humanoid.WalkSpeed = selectedSpeed
        humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if humanoid.WalkSpeed ~= selectedSpeed then
                humanoid.WalkSpeed = selectedSpeed
            end
        end)
    end
end

local Slider = Tab:CreateSlider({
    Name = "Stel je snelheid in",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1",
    Callback = function(Value)
        selectedSpeed = Value
        if plr and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            applySpeed(humanoid)
        end
    end,
})

plr.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    applySpeed(humanoid)
end)

if plr.Character then
    local humanoid = plr.Character:FindFirstChild("Humanoid")
    applySpeed(humanoid)
end

-- SEED SHOP TAB
local Tab = Window:CreateTab("Seed Shop", 4483362458)
Tab:CreateSection("Autobuy")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuySeed = ReplicatedStorage.GameEvents.BuySeedStock
local seeds = {
    "Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Tomato", "Corn",
    "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut",
    "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper",
    "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone"
}
local buying = {}

-- Select All Toggle
local allSeedsActive = false
Tab:CreateToggle({
    Name = "🧺 Select Everything",
    CurrentValue = false,
    Callback = function(state)
        allSeedsActive = state
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

-- Per Seed Toggle
for _, seed in ipairs(seeds) do
    buying[seed] = false
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

-- GEAR SHOP TAB
local Tab = Window:CreateTab("Gear Shop", 4483362458)
Tab:CreateSection("Autobuy")

local BuyGear = ReplicatedStorage.GameEvents.BuyGearStock -- ⚠️ Controleer of dit de juiste RemoteEvent is
local gearItems = {
    "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler",
    "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Tanning Mirror",
    "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool",
    "Friendship Pot", "Levelup Lollipop"
}
local buyingGear = {}

-- Select All Toggle
local allGearActive = false
Tab:CreateToggle({
    Name = "🧰 Select Everything",
    CurrentValue = false,
    Callback = function(state)
        allGearActive = state
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

-- Per Gear Toggle
for _, gear in ipairs(gearItems) do
    buyingGear[gear] = false
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

-- EGG SHOP TAB
local Tab = Window:CreateTab("Egg Shop", 4483362458)
Tab:CreateSection("Autobuy")

local BuyEgg = ReplicatedStorage.GameEvents.BuyPetEgg -- ⚠️ Controleer of dit de juiste RemoteEvent is
local eggItems = {
    "Common Egg", "Common Summer Egg", "Rare Summer Egg",
    "Mythical Egg", "Paradise Egg", "Bug Egg"
}
local buyingEggs = {}

-- Select All Toggle
local allEggsActive = false
Tab:CreateToggle({
    Name = "🥚 Select Everything",
    CurrentValue = false,
    Callback = function(state)
        allEggsActive = state
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

-- Per Egg Toggle
for _, egg in ipairs(eggItems) do
    buyingEggs[egg] = false
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

