
-- This file contains the LoadConfig function.




-- The default config.
local m_ConfigDefaults = [[
Prefix         = "<{PLAYERNAME}> {MESSAGE}",
UsePlayerColor = true,
UseRankColor   = false,
ChatPerWorld   = true,
AllowChatColor = true,
ColorSymbol    = "@",

PersonalPrefixes =
{
	-- You can add a player by using ["PlayerName"] = "Custom Prefix",
	-- ["STR_Warrior"] = "[{RANK}] <{PLAYERNAME}> {MESSAGE}",
},

RankPrefixes =
{
	-- You can add a specific prefix for a certain rank by using ["Rank"] = Custom Prefix
	-- ["Admin"] = "@c[Admin]@f {MESSAGE}",
},
]]





-- Writes the default config to the given path
function WriteDefaultConfigToPath(a_Path)
	local File = io.open(a_Path, "w")
	File:write(m_ConfigDefaults)
	File:close()
end





-- Loads the default config
function GetDefaultConfigLoader()
	return loadstring("return {" .. m_ConfigDefaults .. "}")
end





function LoadConfig(a_Path)
	assert(type(a_Path) == 'string')
	
	-- Check if the config file exists
	if (not cFile:IsFile(a_Path)) then
		LOGWARNING("[Chatter] Config file does not exist. Using defaults.")
		WriteDefaultConfigToPath(a_Path)
	end
	
	-- Creates a config loader
	local CfgContent = cFile:ReadWholeFile(a_Path)
	local CfgLoader, Err = loadstring("return {" .. CfgContent .. "}")
	if (not CfgLoader) then
		LOGWARNING("[Chatter] Error while loading config file. \"" .. Err .. "\". Using defaults.")
		CfgLoader = GetDefaultConfigLoader()
	end
	
	local Succes, Result = pcall(CfgLoader)
	if (not Succes) then
		LOGWARNING("[Chatter] Error while loading config file. \"" .. Result .. "\". Using defaults.")
		Result = GetDefaultConfigLoader()()
	end
	
	-- Make sure that PersonalPrefixes and RankPrefixes are a valid table
	Result.PersonalPrefixes = (type(Result.PersonalPrefixes) == 'table' and Result.PersonalPrefixes) or {}
	Result.RankPrefixes = (type(Result.RankPrefixes) == 'table' and Result.RankPrefixes) or {}
	
	-- Changes all the color codes to working color codes.
	local function FinalizePrefix(a_PrefixString)
		for Idx = 1, a_PrefixString:len() do
			if (
				(a_PrefixString:sub(Idx, Idx) == Result.ColorSymbol) and
				(IsColor(a_PrefixString:sub(Idx + 1, Idx + 1)))
			) then
				a_PrefixString = a_PrefixString:gsub(Result.ColorSymbol .. a_PrefixString:sub(Idx + 1, Idx + 1), cChatColor.Color .. a_PrefixString:sub(Idx + 1, Idx + 1))
			end
		end
		return a_PrefixString
	end
	
	-- Finalize the default prefix
	Result.Prefix = FinalizePrefix(Result.Prefix)
	
	-- Finalize the personal prefixes
	for PlayerName, Prefix in pairs(Result.PersonalPrefixes) do
		Result.PersonalPrefixes[PlayerName] = FinalizePrefix(Prefix)
	end
	
	-- Finalize the rank prefixes.
	for Rank, Prefix in pairs(Result.RankPrefixes) do
		Result.RankPrefixes[Rank] = FinalizePrefix(Prefix)
	end
	
	g_Config = Result
end




