local Players = game:GetService("Players")
print("idiot")
local Cmd_Module = require(script.Commands)
local Access_Module = require(script.Access)

Players.PlayerAdded:Connect(function(player)
	local cmd_tab = {}
	
	for i, v in pairs(Access_Module.Players) do
		if player.UserId == v[1] then
			player:SetAttribute("Authority", v[2])
		end
	end
	
	for i, v in pairs(Access_Module.Groups) do
		if player:IsInGroup(v[1]) then
			if player:GetRankInGroup(v[1]) == v[2] then
				player:SetAttribute("Authority", v[3])
			end
		end
	end
	
	
	
	player.Chatted:Connect(function(str)
		if string.sub(str, 1,1) == ":" then
			for i, cmdstr in string.split(str, " ") do
				local cmdstr1 = cmdstr
				if i == 1 then
					cmdstr1 = string.split(cmdstr, ":")
					table.insert(cmd_tab, cmdstr1[2])
				else
					table.insert(cmd_tab, cmdstr1)
				end
			end
			
			if Cmd_Module[cmd_tab[1]] then
				if player:GetAttribute("Authority") then
					if Cmd_Module[cmd_tab[1]].Authority <= player:GetAttribute("Authority") then
						Cmd_Module[cmd_tab[1]].Function(cmd_tab[2], cmd_tab[3], cmd_tab[4], cmd_tab[5], cmd_tab[6])
					end
				else
					print("Player ["..player.Name.." ("..player.UserId..")] doesn't have an Authority Level.")
				end
			else
				
			end
		end
	end)
end)
