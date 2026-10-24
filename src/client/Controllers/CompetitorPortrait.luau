--!nonstrict
-- Provisional block-avatar portraits shared by bracket, HUD and results.
-- Replace this renderer later without changing participant identity or combat.
local P={}
local palette={
 Color3.fromRGB(106,224,195),Color3.fromRGB(128,179,255),Color3.fromRGB(250,164,112),Color3.fromRGB(204,146,255),
 Color3.fromRGB(244,132,177),Color3.fromRGB(240,208,101),Color3.fromRGB(134,212,128),Color3.fromRGB(141,213,232),
}
function P.Draw(parent,appearance)
 local old=parent:FindFirstChild("Portrait")
 if old then old:Destroy() end
 local a=appearance or {color=1,style=1}
 local frame=Instance.new("Frame");frame.Name="Portrait";frame.Size=UDim2.fromScale(1,1)
 frame.BorderSizePixel=0;frame.BackgroundColor3=Color3.fromRGB(29,35,53);frame.Parent=parent
 local function block(name,x,y,w,h,color)
  local v=Instance.new("Frame");v.Name=name;v.Position=UDim2.fromScale(x,y);v.Size=UDim2.fromScale(w,h)
  v.BorderSizePixel=0;v.BackgroundColor3=color;v.Parent=frame;return v
 end
 local color=palette[a.color] or palette[1]
 block("Shirt",.16,.67,.68,.33,color)
 local skin=Color3.fromRGB(242,197,144)
 block("Head",.27,.17,.46,.5,skin)
 block("Hair",.25,.10,.50,if a.style==2 then .22 else .12,Color3.fromRGB(56,44,59))
 block("EyeLeft",.38,.36,.05,.05,Color3.fromRGB(31,28,36))
 block("EyeRight",.57,.36,.05,.05,Color3.fromRGB(31,28,36))
 block("Smile",.43,.52,.14,.035,Color3.fromRGB(74,44,44))
 if a.style==1 then block("Headband",.25,.23,.5,.07,color)
 elseif a.style==3 then block("HeadphonesLeft",.19,.32,.09,.22,color);block("HeadphonesRight",.72,.32,.09,.22,color) end
 return frame
end
return P
