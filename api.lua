
-- This file contains all the chatter-api related functions.




-- Contains all the plugins that want to change something in chat.
g_Plugins = {}





-- Registers a plugin. 
-- a_Tag is the tag you want to replace for example {FACTION}
-- a_PluginName is the name of the plugin who is calling
-- a_CallbackName is the name of the function that Chatter will call when someone is talking.
function RegisterPlugin(a_Tag, a_PluginName, a_CallbackName)
	assert(
		(type(a_Tag) == 'string') and
		(type(a_PluginName) == 'string') and
		(type(a_CallbackName) == 'string')
	)
	
	table.insert(g_Plugins, {Tag = "{" .. a_Tag:upper() .. "}", PluginName = a_PluginName, CallbackName = a_CallbackName})
end





-- Calls a plugin if the tag he wants to replace is in the chat message.
function CallPlugins(a_TempMessage, a_Player)
	for Idx, PluginData in ipairs(g_Plugins) do
		if (a_TempMessage:find(PluginData.Tag) ~= nil) then
			local NewTag = cPluginManager:CallPlugin(PluginData.PluginName, PluginData.CallbackName, a_Player)
			if (type(NewTag) == 'string') then
				a_TempMessage = a_TempMessage:gsub(PluginData.Tag, NewTag)
			end
		end
	end
	
	return a_TempMessage
end





