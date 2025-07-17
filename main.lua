local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Mijn Script GUI",
    LoadingTitle = "Mijn Script Laadt...",
    LoadingSubtitle = "Door Milan",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- of vul een mapnaam in
       FileName = "MijnScriptConfig"
    },
    Discord = {
       Enabled = false,
       Invite = "", -- Vul je Discord invite in als je wilt
       RememberJoins = true
    },
    KeySystem = false, -- Zet op true als je een key wilt gebruiken
    KeySettings = {
       Title = "Key Systeem",
       Subtitle = "Key Systeem",
       Note = "Vraag de key aan de eigenaar",
       FileName = "Key", -- Sla de key lokaal op
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = "JOUWKEYHIER"
    }
})

local MainTab = Window:CreateTab("Hoofd", 4483362458) -- Tab met een icoon
local Tab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image
MainTab:CreateButton({
    Name = "Klik mij!",
    Callback = function()
        print("Knop is geklikt!")
        -- Hier kun je je eigen code zetten
    end,
})

MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Farm aan/uit:", Value)
        -- Hier kun je je auto-farm code starten/stoppen
    end,
})