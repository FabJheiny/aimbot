-- Jheiny Radio
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local gui = Player.PlayerGui:FindFirstChild("SoundGui")
if gui then gui:Destroy() return end

local SoundGui = Instance.new("ScreenGui")
local Frame    = Instance.new("Frame")
local Frame2   = Instance.new("Frame")
local drag     = Instance.new("UIDragDetector")
local c00lflag = Instance.new("Sound")

local TopBar  = Instance.new("Frame")
local TopSep  = Instance.new("Frame")
local Title   = Instance.new("TextLabel")
local MinBtn  = Instance.new("TextButton")
local ExitBtn = Instance.new("TextButton")
local Open    = Instance.new("TextButton")

c00lflag.Name   = "c00lsound23sas"
c00lflag.Parent = Frame

SoundGui.Name           = "SoundGui"
SoundGui.Parent         = Player:WaitForChild("PlayerGui")
SoundGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SoundGui.ResetOnSpawn   = false

local W, H = 360, 130

Frame.Parent           = SoundGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel  = 0
Frame.Position         = UDim2.new(0, 400, 0, 300)
Frame.Size             = UDim2.new(0, W, 0, H)
Frame.ClipsDescendants = true
Frame.Active           = true

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Color           = Color3.fromRGB(255, 255, 255)
FrameStroke.Thickness       = 1
FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

drag.Parent = Frame

-- Top Bar
TopBar.Parent           = Frame
TopBar.Size             = UDim2.new(1, 0, 0, 20)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.BorderSizePixel  = 0
TopBar.ZIndex           = 3

TopSep.Parent           = TopBar
TopSep.Size             = UDim2.new(1, 0, 0, 1)
TopSep.Position         = UDim2.new(0, 0, 1, -1)
TopSep.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TopSep.BorderSizePixel  = 0

Title.Parent                 = TopBar
Title.Size                   = UDim2.new(1, -50, 1, 0)
Title.Position               = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3             = Color3.fromRGB(255, 255, 255)
Title.TextSize               = 10
Title.TextXAlignment         = Enum.TextXAlignment.Left
Title.Text                   = "Jheiny Radio 🦇🖤"
Title.Font                   = Enum.Font.SourceSansBold
Title.ZIndex                 = 4

local StatusLbl = Instance.new("TextLabel", TopBar)
StatusLbl.Size                 = UDim2.new(0, 80, 1, 0)
StatusLbl.Position             = UDim2.new(0, 85, 0, 0)
StatusLbl.BackgroundTransparency = 1
StatusLbl.TextColor3           = Color3.fromRGB(80, 80, 80)
StatusLbl.TextSize             = 9
StatusLbl.TextXAlignment       = Enum.TextXAlignment.Left
StatusLbl.Text                 = ""
StatusLbl.Font                 = Enum.Font.SourceSansBold
StatusLbl.ZIndex               = 4

MinBtn.Parent           = TopBar
MinBtn.Size             = UDim2.new(0, 18, 0, 14)
MinBtn.Position         = UDim2.new(1, -42, 0.5, -7)
MinBtn.Text             = "-"
MinBtn.TextSize         = 12
MinBtn.Font             = Enum.Font.SourceSansBold
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinBtn.TextColor3       = Color3.fromRGB(255, 255, 255)
MinBtn.BorderSizePixel  = 0
MinBtn.AutoButtonColor  = false
MinBtn.ZIndex           = 4

ExitBtn.Parent           = TopBar
ExitBtn.Size             = UDim2.new(0, 18, 0, 14)
ExitBtn.Position         = UDim2.new(1, -20, 0.5, -7)
ExitBtn.Text             = "x"
ExitBtn.TextSize         = 10
ExitBtn.Font             = Enum.Font.SourceSansBold
ExitBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExitBtn.TextColor3       = Color3.fromRGB(255, 80, 80)
ExitBtn.BorderSizePixel  = 0
ExitBtn.AutoButtonColor  = false
ExitBtn.ZIndex           = 4

-- Input helper
local function makeInput(label, defaultText, xPos, w, yPos)
    local lbl = Instance.new("TextLabel", Frame)
    lbl.Size                 = UDim2.new(0, w, 0, 11)
    lbl.Position             = UDim2.new(0, xPos, 0, yPos)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3           = Color3.fromRGB(110, 110, 110)
    lbl.TextSize             = 9
    lbl.TextXAlignment       = Enum.TextXAlignment.Left
    lbl.Text                 = label
    lbl.Font                 = Enum.Font.SourceSansBold
    lbl.ZIndex               = 2

    local box = Instance.new("TextBox", Frame)
    box.Size                 = UDim2.new(0, w, 0, 24)
    box.Position             = UDim2.new(0, xPos, 0, yPos + 12)
    box.BackgroundColor3     = Color3.fromRGB(15, 15, 15)
    box.BorderSizePixel      = 0
    box.Text                 = defaultText
    box.PlaceholderText      = label
    box.TextColor3           = Color3.fromRGB(255, 255, 255)
    box.PlaceholderColor3    = Color3.fromRGB(70, 70, 70)
    box.TextSize             = 11
    box.Font                 = Enum.Font.SourceSansBold
    box.TextXAlignment       = Enum.TextXAlignment.Right
    box.ClearTextOnFocus     = false
    box.ZIndex               = 2

    local c = Instance.new("UICorner", box) c.CornerRadius = UDim.new(0, 5)
    local p = Instance.new("UIPadding", box)
    p.PaddingRight = UDim.new(0, 8) p.PaddingLeft = UDim.new(0, 8)
    return box
end

-- Linha 1: Sound ID (largura toda)
local IdBox = makeInput("Sound ID", "", 6, W - 12, 22)

-- Linha 2: Speed | Vol
-- Linha 3 esquerda: PLAY
-- Linha 3 direita: Loop + PP (cabem no espaço acima do STOP)

-- Speed e Vol dividem a metade esquerda (mesma largura do PLAY)
local halfW  = (W - 18) / 2   -- largura do PLAY e do bloco direito
local inputW = (halfW - 6) / 2 -- cada campo ocupa metade da área esquerda

local SpeedBox = makeInput("Playback Speed", "1",   6,                 inputW, 60)
local VolBox   = makeInput("Volume",         "0.5", 6 + inputW + 6,   inputW, 60)

-- Bloco direito: Loop + PP lado a lado, alinhados acima do STOP
local rightX  = 6 + halfW + 6   -- início do bloco direito
local btnW    = (halfW - 6) / 2  -- largura de cada botãozinho

-- Loop
local loopLbl = Instance.new("TextLabel", Frame)
loopLbl.Size                 = UDim2.new(0, btnW, 0, 11)
loopLbl.Position             = UDim2.new(0, rightX, 0, 60)
loopLbl.BackgroundTransparency = 1
loopLbl.TextColor3           = Color3.fromRGB(110, 110, 110)
loopLbl.TextSize             = 9
loopLbl.TextXAlignment       = Enum.TextXAlignment.Left
loopLbl.Text                 = "Loop"
loopLbl.Font                 = Enum.Font.SourceSansBold
loopLbl.ZIndex               = 2

local loopBtn = Instance.new("TextButton", Frame)
loopBtn.Size             = UDim2.new(0, btnW, 0, 24)
loopBtn.Position         = UDim2.new(0, rightX, 0, 72)
loopBtn.Text             = "OFF"
loopBtn.Font             = Enum.Font.SourceSansBold
loopBtn.TextSize         = 10
loopBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loopBtn.TextColor3       = Color3.fromRGB(100, 100, 100)
loopBtn.BorderSizePixel  = 0
loopBtn.AutoButtonColor  = false
loopBtn.ZIndex           = 2
Instance.new("UICorner", loopBtn).CornerRadius = UDim.new(0, 5)

local isLooped = false
local function setLoop(val)
    isLooped = val
    if val then
        loopBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        loopBtn.TextColor3       = Color3.fromRGB(0, 0, 0)
        loopBtn.Text             = "ON"
    else
        loopBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        loopBtn.TextColor3       = Color3.fromRGB(100, 100, 100)
        loopBtn.Text             = "OFF"
    end
end
loopBtn.MouseButton1Click:Connect(function() setLoop(not isLooped) end)

-- Pause/Continue
local ppX = rightX + btnW + 6

local ppLbl = Instance.new("TextLabel", Frame)
ppLbl.Size                 = UDim2.new(0, btnW, 0, 11)
ppLbl.Position             = UDim2.new(0, ppX, 0, 60)
ppLbl.BackgroundTransparency = 1
ppLbl.TextColor3           = Color3.fromRGB(110, 110, 110)
ppLbl.TextSize             = 9
ppLbl.TextXAlignment       = Enum.TextXAlignment.Left
ppLbl.Text                 = "Pause"
ppLbl.Font                 = Enum.Font.SourceSansBold
ppLbl.ZIndex               = 2

local ppBtn = Instance.new("TextButton", Frame)
ppBtn.Size             = UDim2.new(0, btnW, 0, 24)
ppBtn.Position         = UDim2.new(0, ppX, 0, 72)
ppBtn.Text             = "="    -- = enquanto tocando (clica pra pausar)
ppBtn.Font             = Enum.Font.SourceSansBold
ppBtn.TextSize         = 14
ppBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ppBtn.TextColor3       = Color3.fromRGB(100, 100, 100)
ppBtn.BorderSizePixel  = 0
ppBtn.AutoButtonColor  = false
ppBtn.ZIndex           = 2
Instance.new("UICorner", ppBtn).CornerRadius = UDim.new(0, 5)

local isPaused = false

local function applyPauseState(paused)
    isPaused = paused
    if paused then
        -- pausado: mostra > pra continuar, cinza escuro
        ppBtn.Text             = ">"
        ppBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ppBtn.TextColor3       = Color3.fromRGB(180, 180, 180)
        ppLbl.Text             = "Continue"
        StatusLbl.Text         = "= paused"
    else
        -- tocando: mostra = pra pausar, cinza neutro
        ppBtn.Text             = "="
        ppBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ppBtn.TextColor3       = Color3.fromRGB(100, 100, 100)
        ppLbl.Text             = "Pause"
        StatusLbl.Text         = "> playing"
    end
end

ppBtn.MouseButton1Click:Connect(function()
    local s = workspace:FindFirstChild("c00lsound23sas")
    if not s then return end
    if isPaused then
        s:Resume()
        applyPauseState(false)
    else
        if s.IsPlaying then
            s:Pause()
            applyPauseState(true)
        end
    end
end)

-- Linha 3: PLAY | STOP
local btnY = 100

local PlayBtn = Instance.new("TextButton", Frame)
PlayBtn.Size             = UDim2.new(0, halfW, 0, 24)
PlayBtn.Position         = UDim2.new(0, 6, 0, btnY)
PlayBtn.BorderSizePixel  = 0
PlayBtn.Text             = "PLAY"
PlayBtn.Font             = Enum.Font.SourceSansBold
PlayBtn.TextSize         = 10
PlayBtn.AutoButtonColor  = false
PlayBtn.ZIndex           = 2
PlayBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayBtn.TextColor3       = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", PlayBtn).CornerRadius = UDim.new(0, 6)

local StopBtn = Instance.new("TextButton", Frame)
StopBtn.Size             = UDim2.new(0, halfW, 0, 24)
StopBtn.Position         = UDim2.new(0, 6 + halfW + 6, 0, btnY)
StopBtn.BorderSizePixel  = 0
StopBtn.Text             = "STOP"
StopBtn.Font             = Enum.Font.SourceSansBold
StopBtn.TextSize         = 10
StopBtn.AutoButtonColor  = false
StopBtn.ZIndex           = 2
StopBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StopBtn.TextColor3       = Color3.fromRGB(255, 80, 80)
Instance.new("UICorner", StopBtn).CornerRadius = UDim.new(0, 6)

local StopStroke = Instance.new("UIStroke", StopBtn)
StopStroke.Color           = Color3.fromRGB(255, 80, 80)
StopStroke.Thickness       = 1
StopStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Minimized pill
Frame2.Parent           = SoundGui
Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame2.BorderSizePixel  = 0
Frame2.Position         = UDim2.new(1, -56, 1, -36)
Frame2.Size             = UDim2.new(0, 50, 0, 18)
Frame2.Visible          = false

local F2S = Instance.new("UIStroke", Frame2)
F2S.Color           = Color3.fromRGB(255, 255, 255)
F2S.Thickness       = 1
F2S.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

Open.Parent                 = Frame2
Open.Size                   = UDim2.new(1, 0, 1, 0)
Open.BackgroundTransparency = 1
Open.Text                   = "> radio"
Open.Font                   = Enum.Font.SourceSansBold
Open.TextSize               = 9
Open.TextColor3             = Color3.fromRGB(255, 255, 255)
Open.BorderSizePixel        = 0
Open.AutoButtonColor        = false

-- Logic
local minimized = false

local function resetPPBtn()
    isPaused = false
    ppBtn.Text             = "="
    ppBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ppBtn.TextColor3       = Color3.fromRGB(100, 100, 100)
    ppLbl.Text             = "Pause"
end

PlayBtn.MouseButton1Click:Connect(function()
    local id    = IdBox.Text
    local speed = tonumber(SpeedBox.Text) or 1
    local vol   = tonumber(VolBox.Text) or 0.5
    if id == "" then return end

    local existing = workspace:FindFirstChild("c00lsound23sas")
    local s = existing or c00lflag:Clone()
    if not existing then s.Parent = workspace end

    s.SoundId       = "rbxassetid://" .. id
    s.PlaybackSpeed = speed
    s.Volume        = vol
    s.Looped        = isLooped
    s:Play()

    resetPPBtn()
    StatusLbl.Text = "> playing"
end)

StopBtn.MouseButton1Click:Connect(function()
    local s = workspace:FindFirstChild("c00lsound23sas")
    if s then s:Stop() end
    resetPPBtn()
    StatusLbl.Text = ""
end)

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Frame.Size  = minimized and UDim2.new(0, W, 0, 20) or UDim2.new(0, W, 0, H)
    MinBtn.Text = minimized and "+" or "-"
end)

ExitBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false Frame2.Visible = true
end)

Open.MouseButton1Click:Connect(function()
    Frame.Visible = true Frame2.Visible = false
end)
