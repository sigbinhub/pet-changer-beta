-- Pet Changer by AnyDev | Pet ESP Only | Accurate by ChatGPT

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- ✅ Egg -> Pets mapping (accurate from Grow A Garden Wiki)
local eggToPets = {
    ["Common Egg"]     = {"Dog", "Golden Lab", "Bunny"},
    ["Uncommon Egg"]   = {"Black Bunny", "Cat", "Chicken", "Deer"},
    ["Rare Egg"]       = {"Monkey", "Orange Tabby", "Pig", "Rooster", "Spotted Deer"},
    ["Legendary Egg"]  = {"Cow", "Silver Monkey", "Sea Otter", "Turtle", "Polar Bear"},
    ["Mythical Egg"]   = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"},
    ["Bug Egg"]        = {"Snail", "Giant Ant", "Caterpillar", "Praying Mantis", "Dragonfly"},
    ["Bee Egg"]        = {"Bee", "Honey Bee", "Bear Bee", "Petal Bee", "Queen Bee"},
    ["Paradise Egg"]   = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"},
    ["Oasis Egg"]      = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw"}
}

-- 🔧 Create ESP
local function createESP(part, petName)
    if not part then return end

    local existing = part:FindFirstChild("EggESP")
    if existing then existing:Destroy() end

    local gui = Instance.new("BillboardGui", part)
    gui.Name = "EggESP"
    gui.Size = UDim2.new(0, 120, 0, 40)
    gui.StudsOffset = Vector3.new(0, 2.5, 0)
    gui.AlwaysOnTop = true

    local label = Instance.new("TextLabel", gui)
    label.Name = "PetLabel"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = petName
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0.4
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
end

-- 🔁 Randomize ESP
local function randomizeESP()
    for _, egg in ipairs(workspace:GetDescendants()) do
        if egg:IsA("Model") then
            local petList = eggToPets[egg.Name]
            local part = egg:FindFirstChildWhichIsA("BasePart")
            if petList and part then
                local chosen = petList[math.random(1, #petList)]
                createESP(part, chosen)
            end
        end
    end
end

-- 🎨 UI Setup
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "PetChangerUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 90)
frame.Position = UDim2.new(0, 20, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.05
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.4, 0)
title.Text = "Pet Changer by AnyDev"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0.4, 0)
button.Position = UDim2.new(0.05, 0, 0.5, 0)
button.Text = "Randomize ESP"
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
button.AutoButtonColor = true
button.BorderSizePixel = 0
button.TextStrokeTransparency = 0.8
button.BackgroundTransparency = 0.1
button.ClipsDescendants = true

-- ⏱️ Cooldown Logic Before Action
button.MouseButton1Click:Connect(function()
    button.Active = false
    button.Text = "Starting in 3..."
    task.wait(1)
    button.Text = "Starting in 2..."
    task.wait(1)
    button.Text = "Starting in 1..."
    task.wait(1)

    randomizeESP()

    button.Text = "Randomize ESP"
    button.Active = true
end)
