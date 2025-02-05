-- Adonis Anticheat Bypass

warn("Finding and destroying the RemoteEvent...")
for i,v in game:GetService("ReplicatedStorage"):GetChildren() do
	if v:IsA("RemoteEvent") then
		local aaa = string.split(v.Name,"")
		if aaa[9]=="-" and aaa[14]=="-" and aaa[19]=="-" and aaa[24]=="-" then
			v:Destroy()
			print("Found and destroyed!")
		end
	end
end

warn("Locking the Player.Kick function...")
hookfunction(game.Players.LocalPlayer.Kick, function()repeat task.wait(2^31)until false end)
print("Function locked!")
