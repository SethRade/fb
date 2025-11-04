--// PERSISTENT FULLBRIGHT SCRIPT //--

local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")

-- state variables
local FBEnabled = false
local FBConnection

-- fullbright apply/restore
local function applyFullbright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
end

local function restoreLighting()
    Lighting.Brightness = 1
    Lighting.ClockTime = 14
    Lighting.FogEnd = 1000
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

local function toggleFullbright()
    if FBEnabled then
        FBEnabled = false
        if FBConnection then
            FBConnection:Disconnect()
            FBConnection = nil
        end
        restoreLighting()
        print("[Fullbright] Disabled")
    else
        FBEnabled = true
        applyFullbright()
        FBConnection = Lighting.LightingChanged:Connect(function()
            if FBEnabled then
                applyFullbright()
            end
        end)
        print("[Fullbright] Enabled")
    end
end

-- toggle on ` key press
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Backquote then
        toggleFullbright()
    end
end)

-- persist through teleports
if queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) then
    local teleport = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    teleport([[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SethRade/fb/refs/heads/main/fullbright.lua"))()
    ]])
end

print("[Fullbright] Press ` (backtick) to toggle — persists across teleports.")