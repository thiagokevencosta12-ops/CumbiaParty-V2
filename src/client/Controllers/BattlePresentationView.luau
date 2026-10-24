--!nonstrict
-- Visual-only intro. ArenaController owns the synchronized clock and camera.
-- Objects are allocated once; Render only changes layout, visibility and opacity.
local View = {}
local DARK = Color3.fromRGB(11, 17, 27)
local WHITE = Color3.fromRGB(239, 245, 251)
local CYAN = Color3.fromRGB(70, 224, 236)
local AMBER = Color3.fromRGB(255, 187, 100)
local MUTED = Color3.fromRGB(166, 183, 198)
local ROUND_NAMES = {[1] = "QUARTAS DE FINAL", [2] = "SEMIFINAL", [3] = "GRANDE FINAL"}

function View.new(gui, onCancel)
 local root = Instance.new("Frame")
 root.Name = "BattleIntro"
 root.Size = UDim2.fromScale(1, 1)
 root.BackgroundColor3 = DARK
 root.BackgroundTransparency = .8
 root.BorderSizePixel = 0
 root.ZIndex = 60
 root.Active = false
 root.Visible = false
 root.Parent = gui

 local function frame(parent, name, color, transparency, z)
  local object = Instance.new("Frame")
  object.Name = name
  object.BackgroundColor3 = color or DARK
  object.BackgroundTransparency = transparency or 0
  object.BorderSizePixel = 0
  object.ZIndex = z or 61
  object.Active = false
  object.Parent = parent
  return object
 end
 local function label(parent, name, text, color, maxSize, z)
  local object = Instance.new("TextLabel")
  object.Name = name
  object.BackgroundTransparency = 1
  object.Text = text
  object.TextColor3 = color or WHITE
  object.TextScaled = true
  object.TextWrapped = true
  object.Font = Enum.Font.GothamBold
  object.ZIndex = z or 63
  object.Parent = parent
  local limit = Instance.new("UITextSizeConstraint")
  limit.MinTextSize = 8
  limit.MaxTextSize = maxSize or 24
  limit.Parent = object
  return object
 end
 local top = frame(root, "TopLetterbox", DARK, .16)
 top.Size = UDim2.new(1, 0, 0, 64)
 local bottom = frame(root, "BottomLetterbox", DARK, .2)
 bottom.AnchorPoint = Vector2.new(0, 1)
 bottom.Position = UDim2.fromScale(0, 1)
 bottom.Size = UDim2.new(1, 0, 0, 58)
 local brand = label(top, "EventIdentity", "CUMBIA BATTLE", WHITE, 23)
 brand.Font = Enum.Font.GothamBlack
 brand.TextXAlignment = Enum.TextXAlignment.Left
 local round = label(top, "Round", "TORNEIO X1", CYAN, 14)
 round.TextXAlignment = Enum.TextXAlignment.Right
 local footer = label(bottom, "PresentationStatus", "UNDERGROUND  /  X1", MUTED, 12)
 footer.TextXAlignment = Enum.TextXAlignment.Left

 local cancel = Instance.new("TextButton")
 cancel.Name = "LeavePresentation"
 cancel.AnchorPoint = Vector2.new(1, .5)
 cancel.Position = UDim2.new(1, -18, .5, 0)
 cancel.Size = UDim2.fromOffset(188, 34)
 cancel.BackgroundColor3 = Color3.fromRGB(30, 41, 55)
 cancel.BackgroundTransparency = .1
 cancel.BorderSizePixel = 0
 cancel.Text = "DESISTIR DA BATALHA"
 cancel.TextColor3 = WHITE
 cancel.Font = Enum.Font.GothamMedium
 cancel.TextSize = 12
 cancel.ZIndex = 67
 cancel.Parent = bottom
 local cancelCorner = Instance.new("UICorner")
 cancelCorner.CornerRadius = UDim.new(0, 6)
 cancelCorner.Parent = cancel
 local cancelConnection = cancel.Activated:Connect(function()
  if root.Visible and typeof(onCancel) == "function" then onCancel() end
 end)

 local logo = frame(root, "Logo", DARK, 1, 62)
 logo.AnchorPoint = Vector2.new(.5, .5)
 logo.Position = UDim2.fromScale(.5, .47)
 local logoScale = Instance.new("UIScale")
 logoScale.Parent = logo
 local kicker = label(logo, "Kicker", "UNDERGROUND  •  X1", CYAN, 17)
 kicker.Position = UDim2.fromScale(.1, 0)
 kicker.Size = UDim2.fromScale(.8, .14)
 local title = label(logo, "Title", "CUMBIA\nBATTLE", WHITE, 86)
 title.Font = Enum.Font.GothamBlack
 title.Position = UDim2.fromScale(0, .17)
 title.Size = UDim2.fromScale(1, .66)
 local logoRule = frame(logo, "IdentityRule", AMBER, 0, 63)
 logoRule.AnchorPoint = Vector2.new(.5, 0)
 logoRule.Position = UDim2.fromScale(.5, .9)
 logoRule.Size = UDim2.new(.3, 0, 0, 4)

 local individual = frame(root, "Competitor", DARK, .14, 62)
 local individualAccent = frame(individual, "Accent", CYAN, 0, 63)
 individualAccent.Size = UDim2.new(0, 4, 1, 0)
 local individualTag = label(individual, "Category", "NO TECLADO", CYAN, 12)
 individualTag.Position = UDim2.new(0, 20, 0, 10)
 individualTag.Size = UDim2.new(1, -40, 0, 18)
 individualTag.TextXAlignment = Enum.TextXAlignment.Left
 local individualName = label(individual, "CompetitorName", "", WHITE, 40)
 individualName.Font = Enum.Font.GothamBlack
 individualName.Position = UDim2.new(0, 20, 0, 33)
 individualName.Size = UDim2.new(1, -40, 1, -43)
 individualName.TextXAlignment = Enum.TextXAlignment.Left

 local versus = frame(root, "Versus", DARK, 1, 62)
 versus.Size = UDim2.fromScale(1, 1)
 local vsText = label(versus, "VS", "VS", WHITE, 80)
 vsText.Font = Enum.Font.GothamBlack
 vsText.AnchorPoint = Vector2.new(.5, .5)
 vsText.Position = UDim2.fromScale(.5, .46)
 vsText.Size = UDim2.fromScale(.2, .2)
 local names = {}
 local nameLines = {}
 for i = 1, 2 do
  local color = if i == 1 then CYAN else AMBER
  local panel = frame(versus, "Side" .. i, DARK, .14, 62)
  panel.AnchorPoint = Vector2.new(if i == 1 then 0 else 1, 1)
  local accent = frame(panel, "Accent", color, 0, 63)
  accent.AnchorPoint = Vector2.new(0, 1)
  accent.Position = UDim2.fromScale(0, 1)
  accent.Size = UDim2.new(1, 0, 0, 3)
  local name = label(panel, "Name", "", WHITE, 31)
  name.Font = Enum.Font.GothamBlack
  name.Position = UDim2.new(0, 12, 0, 8)
  name.Size = UDim2.new(1, -24, 1, -16)
  names[i] = panel
  nameLines[i] = name
 end

 local countdown = frame(root, "Countdown", DARK, 1, 64)
 countdown.AnchorPoint = Vector2.new(.5, .5)
 countdown.Position = UDim2.fromScale(.5, .45)
 local countScale = Instance.new("UIScale")
 countScale.Parent = countdown
 local count = label(countdown, "Number", "3", WHITE, 140, 65)
 count.Font = Enum.Font.GothamBlack
 count.Size = UDim2.fromScale(1, 1)
 count.TextStrokeColor3 = DARK
 count.TextStrokeTransparency = .15
 local countRule = frame(countdown, "Accent", CYAN, 0, 65)
 countRule.AnchorPoint = Vector2.new(.5, 1)
 countRule.Position = UDim2.fromScale(.5, 1)
 countRule.Size = UDim2.new(.3, 0, 0, 4)

 local currentStage = nil
 local currentSignature = nil
 local previousSize = Vector2.zero
 local destroyed = false
 local V = {}
 local function layout()
  local size = root.AbsoluteSize
  if size == previousSize then return end
  previousSize = size
  local w, h = size.X, size.Y
  local compact = w < 650
  local margin = if compact then 12 else 28
  local topHeight = if h < 480 then 48 else 64
  local bottomHeight = if h < 480 then 46 else 58
  top.Size = UDim2.new(1, 0, 0, topHeight)
  bottom.Size = UDim2.new(1, 0, 0, bottomHeight)
  brand.Position = UDim2.fromOffset(margin, 0)
  brand.Size = UDim2.new(.5, -margin, 1, 0)
  round.Position = UDim2.fromScale(.5, 0)
  round.Size = UDim2.new(.5, -margin, 1, 0)
  footer.Position = UDim2.fromOffset(margin, 0)
  footer.Size = UDim2.new(1, -(if compact then 190 else 240), 1, 0)
  cancel.Position = UDim2.new(1, -margin, .5, 0)
  cancel.Size = UDim2.fromOffset(if compact then 166 else 188, 34)
  cancel.TextSize = if compact then 10 else 12
  logo.Size = UDim2.fromOffset(math.min(w - margin * 2, 540), math.min(h * .58, 300))
  individual.Size = UDim2.fromOffset(math.min(w - margin * 2, if compact then 350 else 500), if h < 480 then 88 else 112)
  for i = 1, 2 do
   names[i].Position = UDim2.new(if i == 1 then 0 else 1, if i == 1 then margin else -margin, 1, -bottomHeight - 20)
   names[i].Size = UDim2.new(.43, -margin, 0, if compact then 80 else 100)
  end
  countdown.Size = UDim2.fromOffset(math.min(w * .65, 330), math.min(h * .44, 230))
 end
 local function setData(data)
  local players = data.players or {}
  local a = players[1] and tostring(players[1].name or "Competidor") or "Competidor"
  local b = players[2] and tostring(players[2].name or "Competidor") or "Competidor"
  local roundText = ROUND_NAMES[tonumber(data.round)] or "TORNEIO X1"
  local signature = a .. "\n" .. b .. "\n" .. roundText
  if signature == currentSignature then return end
  currentSignature = signature
  nameLines[1].Text = a
  nameLines[2].Text = b
  round.Text = roundText
 end

 function V.Render(stage, progress, data)
  if destroyed then return end
  data = data or {}
  progress = math.clamp(tonumber(progress) or 0, 0, 1)
  root.Visible = true
  layout()
  setData(data)
  if stage ~= currentStage then
   currentStage = stage
   logo.Visible = stage == "Logo"
   individual.Visible = stage == "CompetitorA" or stage == "CompetitorB"
   versus.Visible = stage == "Versus" or stage == "3" or stage == "2" or stage == "1"
   countdown.Visible = stage == "3" or stage == "2" or stage == "1" or stage == "Ready"
   vsText.Visible = stage == "Versus"
   root.BackgroundTransparency = if stage == "Logo" then .18 else .8
   footer.Text = if stage == "Ready" then "O DUELO VAI COMEÇAR" else "UNDERGROUND  /  X1"
   count.Text = if stage == "Ready" then "CUMBIA!" else tostring(stage)
  end
  local entry = 1 - (1 - math.clamp(progress / .22, 0, 1)) ^ 3
  if stage == "Logo" then
   logoScale.Scale = .96 + .04 * entry
   title.TextTransparency = 1 - entry
   kicker.TextTransparency = 1 - entry
   logoRule.BackgroundTransparency = 1 - entry
  elseif stage == "CompetitorA" or stage == "CompetitorB" then
   local isA = stage == "CompetitorA"
   individualName.Text = nameLines[if isA then 1 else 2].Text
   individualAccent.BackgroundColor3 = if isA then CYAN else AMBER
   individualTag.TextColor3 = individualAccent.BackgroundColor3
   individual.AnchorPoint = Vector2.new(if isA then 0 else 1, 1)
   local margin = if previousSize.X < 650 then 12 else 28
   local slide = (1 - entry) * 28
   individual.Position = UDim2.new(if isA then 0 else 1, if isA then margin - slide else -margin + slide, 1, -bottom.Size.Y.Offset - 20)
   individual.BackgroundTransparency = .14 + .86 * (1 - entry)
   individualName.TextTransparency = 1 - entry
   individualTag.TextTransparency = 1 - entry
   individualAccent.BackgroundTransparency = 1 - entry
  elseif countdown.Visible then
   countScale.Scale = 1.08 - .08 * math.clamp(progress / .35, 0, 1)
   count.TextTransparency = 0
   countRule.Size = UDim2.new(.3 + .2 * progress, 0, 0, 4)
   countRule.BackgroundColor3 = if stage == "Ready" then AMBER else CYAN
  end
 end
 function V.Hide()
  if destroyed then return end
  root.Visible = false
  currentStage = nil
 end
 function V.Destroy()
  if destroyed then return end
  destroyed = true
  cancelConnection:Disconnect()
  root:Destroy()
 end
 return V
end

return View
