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

-- EGG SHOP TAB (Placeholder - geen egg-buy events bekend nog)
local Tab = Window:CreateTab("Egg Shop", 4483362458)
Tab:CreateSection("Autobuy")
Tab:CreateToggle({
    Name = "Koop Wheat Seed",
    CurrentValue = false,
    Callback = function(state)
        print("Wheat: " .. tostring(state))
    end,
})
Tab:CreateToggle({
    Name = "Koop Carrot Seed",
    CurrentValue = false,
    Callback = function(state)
        print("Carrot: " .. tostring(state))
    end,
})
Tab:CreateToggle({
    Name = "Koop Tomato Seed",
    CurrentValue = false,
    Callback = function(state)
        print("Tomato: " .. tostring(state))
    end,
})
