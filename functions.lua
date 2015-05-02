
-- This file contains functions used by the Chatter plugin.





-- Returns the latest color (§c) used in a string. 
function GetLatestColor(a_Spot, a_String)
	assert(type(a_String) == 'string')
	
	local Char = ""
	
	for Idx = a_Spot, 1, -1 do
		if (
			(a_String:sub(Idx, Idx + 1) == cChatColor.Color) and
			(IsColor(a_String:sub(Idx + 2, Idx + 2)))
		) then
			return cChatColor.Color .. a_String:sub(Idx + 2, Idx + 2)
		end
	end
	return cChatColor.White
end





-- Returns true if § + the given character would be a color.
function IsColor(a_Char)
	return (
		(a_Char == "0") or
		(a_Char == "1") or
		(a_Char == "2") or
		(a_Char == "3") or
		(a_Char == "4") or
		(a_Char == "5") or
		(a_Char == "6") or
		(a_Char == "7") or
		(a_Char == "8") or
		(a_Char == "9") or
		(a_Char == "a") or
		(a_Char == "b") or
		(a_Char == "c") or
		(a_Char == "d") or
		(a_Char == "e") or
		(a_Char == "f") or
		(a_Char == "k") or
		(a_Char == "l") or
		(a_Char == "m") or
		(a_Char == "n") or
		(a_Char == "o") or
		(a_Char == "r")
	)
end




