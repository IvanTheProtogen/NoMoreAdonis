if getgenv().NoMoreAdonis then
	return warn("NoMoreAdonis already loaded...")
end
getgenv().NoMoreAdonis = true

game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)

print([[
 _   _       __  __                   _       _             _     
| \ | | ___ |  \/  | ___  _ __ ___   / \   __| | ___  _ __ (_)___ 
|  \| |/ _ \| |\/| |/ _ \| '__/ _ \ / _ \ / _` |/ _ \| '_ \| / __|
| |\  | (_) | |  | | (_) | | |  __// ___ \ (_| | (_) | | | | \__ \
|_| \_|\___/|_|  |_|\___/|_|  \___/_/   \_\__,_|\___/|_| |_|_|___/

~~~ By IvanTheSkid on GitHub ~~~]])

local RS = game:GetService("ReplicatedStorage")
local function GetAdonisRemote()
	for i,v in RS:GetChildren() do
		if v:IsA("RemoteEvent") and v:FindFirstChild("__FUNCTION") and v.__FUNCTION:IsA("RemoteFunction") then
			return v
		end
	end
end

-- this is for debugging
local function stacky(tbl, idt)
	if typeof(tbl)~="table" then return tbl end
	idt = idt or ""
	for i,v in tbl do
		print(idt,i,"--",v,"(",typeof(v),")")
		stacky(v,idt.."\t")
	end
end

local lp = game:GetService("Players").LocalPlayer
local re = GetAdonisRemote()

if not re then
	warn("Adonis Anticheat not found, lucky!")
end

local learnedData

local trigger;trigger = hookfunction(re.FireServer, function(inst,...)
	if inst~=re then return trigger(inst,...) end
	if not learnedData then
		stacky({...})
		warn("Data learned, stealing the job...")
		learnedData = {...}
	end
end)

warn("NoMoreAdonis activated, it is currently learning the behavior of the anti-cheat, please wait...")
print("Don't turn on your RemoteSpy or anti-kick just yet!!!")

local timeout = os.clock()+60
repeat task.wait(1) until learnedData or os.clock()>timeout

hookfunction(lp.Kick, function()end)
local oldwarn;oldwarn = hookfunction(warn, function(...)
	local dd = table.concat({...})
	if not string.find(dd, "Kick is not a valid member") then
		return oldwarn(...)
	end
end)

if not learnedData then
	return warn("Seems like there's no handshake, lucky!")
end

local main;function main(tbl)
	if typeof(tbl)~="table" then return tbl end
	for i,v in tbl do
		if i == "Sent" then
			tbl[i] = v+1
		end
		main(v)
	end
end

task.spawn(function()
	while true do
		main(learnedData)
		trigger(re, learnedData)
		--stacky(learnedData)
		task.wait(30)
	end
end)

oldwarn("All setup! You can now safely use the RemoteSpy!")
