if identifyexecutor() == 'Delta' then
    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        pcall(function()
            v:Destroy()
        end)
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "WarningGUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    end
    gui.Parent = game:GetService("CoreGui")

    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.new(0, 0, 0)
    background.BorderSizePixel = 0
    background.Parent = gui

    local container = Instance.new("Frame")
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.Position = UDim2.new(0.5, 0, 0.45, 0)
    container.Size = UDim2.new(0.9, 0, 0.6, 0)
    container.BackgroundTransparency = 1
    container.Parent = background

    local aspect = Instance.new("UIAspectRatioConstraint")
    aspect.AspectRatio = 9 / 16
    aspect.Parent = container

    local executors = {
        {name = "KRNL", link = "https://krnl.cat/"},
        {name = "Codex", link = "https://codex.lol/"},
        {name = "Arceus X", link = "https://spdmteam.com/index"},
        {name = "Fluxus", link = "https://fluxus.team/download/"},
    }

    local buttonsContainer = Instance.new("Frame")
    buttonsContainer.Size = UDim2.new(1, 0, 0, #executors * 60)
    buttonsContainer.BackgroundTransparency = 1
    buttonsContainer.Parent = container

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0.9, 0, 0, 50)
    grid.CellPadding = UDim2.new(0.05, 0, 0, 15)
    grid.FillDirectionMaxCells = 1
    grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    grid.VerticalAlignment = Enum.VerticalAlignment.Top
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.Parent = buttonsContainer

    for _, exec in ipairs(executors) do
        local btn = Instance.new("TextButton")
        btn.Text = "Copy " .. exec.name .. " Link"
        btn.TextScaled = true
        btn.Font = Enum.Font.SourceSansBold
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = true
        btn.Size = UDim2.new(1, 0, 0, 50)
        btn.Parent = buttonsContainer

        btn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(exec.link)
            end
            btn.Text = "Copied!"
            task.delay(1.5, function()
                btn.Text = "Copy " .. exec.name .. " Link"
            end)
        end)
    end

    local function createLabel(text, color)
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, 0, 0, 50)
        label.TextColor3 = color or Color3.new(1, 1, 1)
        label.Text = text
        label.Font = Enum.Font.SourceSansBold
        label.TextScaled = true
        label.TextWrapped = true
        label.Parent = container
        return label
    end

    createLabel("⚠️ [Delta Executor Detected] ⚠️", Color3.fromRGB(255, 255, 0))
    createLabel("WARNING!: Delta Executor Is A Malware!", Color3.fromRGB(255, 0, 0))
    createLabel("It logs your information and is very detected!", Color3.new(1, 1, 1))
    createLabel("Please use any of these executors:", Color3.new(1, 1, 1))
    createLabel("(KRNL, Codex, Arceus X, Fluxus)", Color3.fromRGB(0, 255, 255))
    createLabel("Those are supported and legit exploits!", Color3.new(1, 1, 1))

    local countdownLabel = Instance.new("TextLabel")
    countdownLabel.AnchorPoint = Vector2.new(0.5, 1)
    countdownLabel.Position = UDim2.new(0.5, 0, 1, -20)
    countdownLabel.Size = UDim2.new(0.9, 0, 0, 50)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.TextScaled = true
    countdownLabel.Font = Enum.Font.SourceSansBold
    countdownLabel.Text = "Game will be closed in 30 seconds. Please install other executor"
    countdownLabel.Parent = background

    local seconds = 30
    spawn(function()
        while seconds > 0 do
            countdownLabel.Text = "Game will be closed in " .. seconds .. " second" .. (seconds == 1 and "" or "s") .. ". Please install other executor"
            wait(1)
            seconds -= 1
        end
        game:Shutdown()
    end)

    wait(999999)
    return
end

-- ✅ Pet Changer starts only if Delta is NOT detected

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local eggToPets = {
	["Common Egg"] = {"Dog","Golden Lab","Bunny"},
	["Uncommon Egg"] = {"Black Bunny","Cat","Chicken","Deer"},
	["Rare Egg"] = {"Monkey","Orange Tabby","Pig","Rooster","Spotted Deer"},
	["Legendary Egg"] = {"Cow","Silver Monkey","Sea Otter","Turtle","Polar Bear"},
	["Mythical Egg"] = {"Grey Mouse","Brown Mouse","Squirrel","Red Giant Ant","Red Fox"},
	["Bug Egg"] = {"Snail","Giant Ant","Caterpillar","Praying Mantis","Dragonfly"},
	["Bee Egg"] = {"Bee","Honey Bee","Bear Bee","Petal Bee","Queen Bee"},
	["Paradise Egg"] = {"Ostrich","Peacock","Capybara","Scarlet Macaw","Mimic Octopus"},
	["Oasis Egg"] = {"Meerkat","Sand Snake","Axolotl","Hyacinth Macaw"},
	["Dinosaur Egg"] = {"Pterodactyl","Raptor","Triceratops","Stegosaurus","Brontosaurus","T-Rex"},
	["Primal Egg"] = {"Parasaurolophus","Iguanodon","Pachycephalosaurus","Dilophosaurus","Ankylosaurus","Spinosaurus"}
}

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

local function choosePetForEgg(eggName)
	local pets = eggToPets[eggName]
	if not pets then return nil end

	local tableMap = {
		["Dinosaur Egg"] = { {"Pterodactyl",3}, {"Raptor",35}, {"Triceratops",32.5}, {"Stegosaurus",28}, {"Brontosaurus",1}, {"T-Rex",0.5} },
		["Primal Egg"] = { {"Parasaurolophus",35}, {"Iguanodon",32.5}, {"Pachycephalosaurus",28}, {"Dilophosaurus",3}, {"Ankylosaurus",1}, {"Spinosaurus",0.5} }
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

	return pets[math.random(1,#pets)]
end

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
