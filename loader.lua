-- Pet Changer by AnyDev | Accurate Dinosaur, Primal & Zen Egg Support
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- 🐣 Egg-to-Pet mapping with full wiki lists
local eggToPets = {
	["Common Egg"]     = {"Dog","Golden Lab","Bunny"},
	["Uncommon Egg"]   = {"Black Bunny","Cat","Chicken","Deer"},
	["Rare Egg"]       = {"Monkey","Orange Tabby","Pig","Rooster","Spotted Deer"},
	["Legendary Egg"]  = {"Cow","Silver Monkey","Sea Otter","Turtle","Polar Bear"},
	["Mythical Egg"]   = {"Grey Mouse","Brown Mouse","Squirrel","Red Giant Ant","Red Fox"},
	["Bug Egg"]        = {"Snail","Giant Ant","Caterpillar","Praying Mantis","Dragonfly"},
	["Bee Egg"]        = {"Bee","Honey Bee","Bear Bee","Petal Bee","Queen Bee"},
	["Paradise Egg"]   = {"Ostrich","Peacock","Capybara","Scarlet Macaw","Mimic Octopus"},
	["Oasis Egg"]      = {"Meerkat","Sand Snake","Axolotl","Hyacinth Macaw"},
	["Dinosaur Egg"]   = {"Pterodactyl","Raptor","Triceratops","Stegosaurus","Brontosaurus","T-Rex"},
	["Primal Egg"]     = {"Parasaurolophus","Iguanodon","Pachycephalosaurus","Dilophosaurus","Ankylosaurus","Spinosaurus"},
	["Zen Egg"]        = {"Shiba Inu","Nihonzaru","Tanuki","Tanchozuru","Kappa","Kitsune"}
}

-- 🪞 Create ESP
local function createESP(part, petName)
	if not part then return end
	local old = part:FindFirstChild("EggESP")
	if old then old:Destroy() end
	local gui = Instance.new("BillboardGui", part)
	gui.Name = "EggESP"
	gui.Size = UDim2.new(0,120,0,40)
	gui.StudsOffset = Vector3.new(0,2.5,0)
	gui.AlwaysOnTop = true
	local label = Instance.new("TextLabel", gui)
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = petName
	label.TextColor3 = Color3.new(1,1,1)
	label.TextStrokeTransparency = 0.4
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
end

-- 🎯 Weighted random selection to honor actual hatch chances
local function choosePetForEgg(eggName)
	local pets = eggToPets[eggName]
	if not pets then return nil end
	local tableMap = {
		["Dinosaur Egg"] = {
			{"Pterodactyl", 3},
			{"Raptor", 35},
			{"Triceratops", 32.5},
			{"Stegosaurus", 28},
			{"Brontosaurus", 1},
			{"T-Rex", 0.5}
		},
		["Primal Egg"] = {
			{"Parasaurolophus", 35},
			{"Iguanodon", 32.5},
			{"Pachycephalosaurus", 28},
			{"Dilophosaurus", 3},
			{"Ankylosaurus", 1},
			{"Spinosaurus", 0.5}
		},
		["Zen Egg"] = {
			{"Shiba Inu", 40},
			{"Nihonzaru", 32},
			{"Tanuki", 20.82},
			{"Tanchozuru", 4.6},
			{"Kappa", 3.5},
			{"Kitsune", 0.08}
		}
	}
	local list = tableMap[eggName]
	if list then
		local roll = math.random() * 100
		local sum = 0
		for _, entry in ipairs(list) do
			sum += entry[2]
			if roll <= sum then return entry[1] end
		end
	end
	-- Equal chance fallback for eggs without weighted data
	return pets[math.random(1, #pets)]
end

-- 🔁 Randomize ESP across workspace eggs
local function randomizeESP()
	for _, egg in ipairs(workspace:GetDescendants()) do
		if egg:IsA("Model") then
			local part = egg:FindFirstChildWhichIsA("BasePart")
			if part and eggToPets[egg.Name] then
				local pet = choosePetForEgg(egg.Name)
				if pet then createESP(part, pet) end
			end
		end
	end
end

-- 🧩 UI Setup
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "PetChangerUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,280,0,90)
frame.Position = UDim2.new(0,20,0.4,0)
frame.BackgroundColor3 = Color3.fromRGB(24,24,24)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0.4,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.Text = "Pet Changer by AnyDev"

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9,0,0.4,0)
button.Position = UDim2.new(0.05,0,0.5,0)
button.Font = Enum.Font.GothamBold
button.TextSize = 16
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(0,170,90)
button.BorderSizePixel = 0
button.TextStrokeTransparency = 0.8
button.Text = "Randomize ESP"

-- ⏱️ 3-second cooldown before re-randomize
local cooling = false
button.MouseButton1Click:Connect(function()
	if cooling then return end
	cooling = true
	button.Text = "Please wait..."
	task.wait(3)
	randomizeESP()
	button.Text = "Randomize ESP"
	cooling = false
end)
