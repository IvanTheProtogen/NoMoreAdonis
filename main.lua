-- better version 

-- some versions of adonis anticheat requires handshake connections, this script doesn't support that. careful!

local RS = game:GetService("ReplicatedStorage")
local function GetAdonisRemote()
	for i,v in RS:GetChildren() do
		if v:IsA("RemoteEvent") and v:FindFirstChild("__FUNCTION") and v.__FUNCTION:IsA("RemoteFunction") then
			return v
		end
	end
end

local lp = game:GetService("Players").LocalPlayer
local re = GetAdonisRemote()
local rf = re.__FUNCTION

local function infiniteyield()while task.wait((2^31)-1)do end end
local function blank()end
local function checkerror(...)task.spawn(error, ...)end

local function main(old, inst)
	return function(instt, ...)
		if instt~=inst then
			return old(inst, ...)
		end
		infiniteyield()
	end
end

local old;old=hookfunction(lp.Kick, main(old, lp))
local oldd;oldd=hookfunction(re.FireServer, main(oldd, re))
local olddd;olddd=hookfunction(rf.InvokeServer, main(olddd, rf))
