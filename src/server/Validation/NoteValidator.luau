--!strict
local Config = require(game:GetService("ReplicatedStorage").CumbiaParty.Shared.GameConfig)
local Validator = {}
local function finite(value: any): boolean
 return typeof(value)=="number" and value==value and math.abs(value)<math.huge
end
local function id(value: any): boolean
 return typeof(value)=="string" and #value>0 and #value<=Config.MaxIdLength
end
function Validator.ValidateRequest(payload: any): (boolean, string)
 if typeof(payload)~="table" then return false,"InvalidPayload" end
 if payload.protocolVersion~=Config.ProtocolVersion then return false,"InvalidProtocol" end
 if not id(payload.sessionId) or not id(payload.noteId) then return false,"InvalidId" end
 if not finite(payload.lane) or payload.lane%1~=0 or payload.lane<1 or payload.lane>4 then return false,"InvalidLane" end
 if payload.action~=nil and payload.action~="Begin" and payload.action~="End" and payload.action~="HoldPulse" then return false,"InvalidAction" end
 if not finite(payload.inputTime) then return false,"InvalidTime" end
 return true,"Valid"
end
function Validator.JudgeTiming(expected: number, actual: number): string
 if not finite(expected) or not finite(actual) then return "Miss" end
 local delta=math.abs(expected-actual)
 -- Tiny epsilon only for floating point representation at exact boundaries.
 if delta<=Config.PerfectWindowSeconds+1e-6 then return "Perfect" end
 if delta<=Config.GreatWindowSeconds+1e-6 then return "Great" end
 if delta<=Config.GoodWindowSeconds+1e-6 then return "Good" end
 return "Miss"
end
function Validator.ValidateTime(inputTime: number, received: number, measuredPing: number): boolean
 if not finite(inputTime) or not finite(received) or not finite(measuredPing) then return false end
 local allowance=math.clamp(measuredPing+Config.NetworkJitterSeconds,Config.NetworkJitterSeconds,Config.MaxBackdateSeconds)
 return inputTime<=received+Config.FutureToleranceSeconds and received-inputTime<=allowance
end
return table.freeze(Validator)