--!nonstrict
-- This controller owns only CumbiaTiles bindings. No WalkSpeed/JumpPower writes.
local Players=game:GetService("Players")
local CAS=game:GetService("ContextActionService")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local GuiService=game:GetService("GuiService")
local Config=require(game.ReplicatedStorage.CumbiaParty.Shared.GameConfig)
local player=Players.LocalPlayer
local Input={}
local controls,wasEnabled,active,wasTouchEnabled
local connections={}
local held={}
local seen={}
local laneSources={}
local mouseLane=nil
local keys={Enum.KeyCode.D,Enum.KeyCode.F,Enum.KeyCode.J,Enum.KeyCode.K}
function Input.Init()
 local playerScripts=player:WaitForChild("PlayerScripts")
 local deadline=os.clock()+10
 repeat
  local modern=game:GetService("StarterPlayer"):FindFirstChild("PlayerModule")
  local legacy=playerScripts:FindFirstChild("PlayerModule")
  if modern and modern:FindFirstChild("ControlModule") then
   controls=require(modern.ControlModule)
  elseif legacy then
   controls=require(legacy):GetControls()
  end
  if not controls then task.wait(.1) end
 until controls or os.clock()>deadline
 assert(controls,"Roblox control module unavailable")
end
function Input.IsActive() return active==true end
function Input.IsLaneHeld(lane) return active==true and laneSources[lane]~=nil and next(laneSources[lane])~=nil end
function Input.Stop()
 local owned=active
 active=false
 for i=1,4 do CAS:UnbindAction("CumbiaTilesLane"..i) end
 CAS:UnbindAction("CumbiaTilesMovement")
 RunService:UnbindFromRenderStep("CumbiaTilesNoMovement")
 for _,c in ipairs(connections) do c:Disconnect() end
 table.clear(connections); table.clear(held); table.clear(seen);table.clear(laneSources);mouseLane=nil
 if owned and controls then
  GuiService.TouchControlsEnabled=wasTouchEnabled
  if wasEnabled then controls:Enable() else controls:Disable() end
 end
 player:SetAttribute("CumbiaTilesControlsActive",false)
end
function Input.Start(onLane,buttons,deadline,onAbort,gui)
 Input.Stop()
 assert(controls,"InputController.Init required")
 wasEnabled=controls.controlsEnabled~=false
 active=true
 wasTouchEnabled=GuiService.TouchControlsEnabled
 GuiService.TouchControlsEnabled=false
 controls:Disable() -- also disables Roblox's virtual thumbstick/jump.
 player:Move(Vector3.zero,false)
 player:SetAttribute("CumbiaTilesControlsActive",true)
 local function abort(reason)
  if not active then return end
  Input.Stop()
  onAbort(reason)
 end
 CAS:BindActionAtPriority("CumbiaTilesMovement",function()
  return Enum.ContextActionResult.Sink
 end,false,Config.InputPriority-1,
  Enum.PlayerActions.CharacterForward,Enum.PlayerActions.CharacterBackward,
  Enum.PlayerActions.CharacterLeft,Enum.PlayerActions.CharacterRight,Enum.PlayerActions.CharacterJump,
  Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Space,
  Enum.KeyCode.Up,Enum.KeyCode.Down,Enum.KeyCode.Left,Enum.KeyCode.Right,
  Enum.KeyCode.Thumbstick1,Enum.KeyCode.ButtonA)
 -- Each physical source is tracked independently, so releasing one finger does
 -- not release a second finger/key in the same lane. Other lanes remain independent.
 local function press(lane,source)
  laneSources[lane]=laneSources[lane] or {}
  local sources=laneSources[lane]
  if sources[source] then return end
  local empty=next(sources)==nil
  sources[source]=true
  if empty and active then onLane(lane,"Begin") end
 end
 local function release(lane,source)
  local sources=laneSources[lane]
  if not sources or not sources[source] then return end
  sources[source]=nil
  if next(sources)==nil and active then onLane(lane,"End") end
 end
 for lane,key in ipairs(keys) do
  held[lane]=UIS:IsKeyDown(key)
  CAS:BindActionAtPriority("CumbiaTilesLane"..lane,function(_,state)
   if state==Enum.UserInputState.End or state==Enum.UserInputState.Cancel then
    held[lane]=nil;release(lane,"Key")
   elseif state==Enum.UserInputState.Begin and active and not held[lane] then
    held[lane]=true
    if not UIS:GetFocusedTextBox() then press(lane,"Key") end
   end
   return Enum.ContextActionResult.Sink
  end,false,Config.InputPriority,key)
  table.insert(connections,buttons[lane].InputBegan:Connect(function(input)
   if not active or seen[input] then return end
   if input.UserInputType==Enum.UserInputType.Touch then
    seen[input]=lane;press(lane,input)
   elseif input.UserInputType==Enum.UserInputType.MouseButton1 then
    if mouseLane then return end
    mouseLane=lane;press(lane,"Mouse")
   end
  end))
 end
 table.insert(connections,UIS.InputEnded:Connect(function(input)
  local lane=seen[input]
  if lane then seen[input]=nil;release(lane,input) end
  if input.UserInputType==Enum.UserInputType.MouseButton1 and mouseLane then
   local old=mouseLane;mouseLane=nil;release(old,"Mouse")
  end
 end))
 table.insert(connections,UIS.WindowFocusReleased:Connect(function() abort("FocusLost") end))
 table.insert(connections,GuiService.MenuOpened:Connect(function() abort("MenuOpened") end))
 table.insert(connections,UIS.TextBoxFocused:Connect(function() abort("TextFocus") end))
 table.insert(connections,player.CharacterRemoving:Connect(function() abort("Respawn") end))
 local humanoid=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
 if humanoid then table.insert(connections,humanoid.Died:Connect(function() abort("CharacterDied") end)) end
 -- Lease bounds the lock even if the final network message never arrives.
 table.insert(connections,RunService.Heartbeat:Connect(function()
  local main=gui:FindFirstChild("Main")
  local bootstrap=script.Parent.Parent:FindFirstChild("ClientBootstrap")
  if workspace:GetServerTimeNow()>deadline or not gui.Enabled or not gui:IsDescendantOf(player.PlayerGui)
   or not main or not main.Visible or not bootstrap or not bootstrap.Enabled
   or (gui:GetAttribute("RhythmPhase")~="Playing" and gui:GetAttribute("RhythmPhase")~="Waiting") then
   abort("StateLost")
  end
 end))
 RunService:BindToRenderStep("CumbiaTilesNoMovement",Enum.RenderPriority.Input.Value+1,function()
  if active then
   player:Move(Vector3.zero,false)
   local h=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
   if h then h.Jump=false end
  end
 end)
end
return Input