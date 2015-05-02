
-- This file contains the hook handler.





function OnChat(a_Player, a_Message)	
	local PlayerName  = a_Player:GetName()
	local PlayerUUID  = a_Player:GetUUID()
	local World       = a_Player:GetWorld()
	local GroupArray  = cRankManager:GetPlayerGroups(PlayerUUID)
	local Rank        = cRankManager:GetPlayerRankName(PlayerUUID)
	
	local TempMessage = g_Config.PersonalPrefixes[PlayerName] or g_Config.RankPrefixes[Rank] or g_Config.Prefix
	
	if (g_Config.UseRankColor) then
		local Place = TempMessage:find("{RANK}")
		if (Place ~= nil) then
			local MsgPrefix, MsgSuffix, MsgNameColorCode = cRankManager:GetRankVisuals(Rank)
			if (MsgNameColorCode ~= "") then
				Rank = cChatColor.Color .. MsgNameColorCode .. Rank .. GetLatestColor(Place, TempMessage)
			end
		end
	end
	
	if (g_Config.UsePlayerColor) then
		local Place = TempMessage:find("{PLAYERNAME}")
		if (Place ~= nil) then
			PlayerName = a_Player:GetColor() .. PlayerName .. GetLatestColor(Place, TempMessage)
		end
	end
	
	local Groups = table.concat(GroupArray, ",")
		
	TempMessage = TempMessage
		:gsub("{RANK}", Rank)
		:gsub("{PLAYERNAME}", PlayerName)
		:gsub("{WORLD}", World:GetName())
		:gsub("{WORLDINITIAL}", World:GetName():sub(1, 1))
		:gsub("{GROUPS}", Groups)
		:gsub("{MESSAGE}", a_Message)
		
	TempMessage = CallPlugins(TempMessage, a_Player)
		
	if (g_Config.ChatPerWorld) then
		World:BroadcastChat(TempMessage)
	else
		cRoot:Get():BroadcastChat(TempMessage)
	end
	
	return true
end




