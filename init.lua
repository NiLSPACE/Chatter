
-- This file contains the Initialize and OnDisable function





-- Global table where the config is is stored.
g_Config = {}





function Initialize(a_Plugin)
	a_Plugin:SetName("Chatter")
	a_Plugin:SetVersion(2.1)
	
	-- Load the config.
	LoadConfig(a_Plugin:GetLocalFolder() .. "/Config.cfg")
	
	-- Register the OnChat hook.
	cPluginManager:AddHook(cPluginManager.HOOK_CHAT, OnChat)
	
	-- Send a message to the console that Chatter is initialized.
	LOG("Initialized Chatter v." .. a_Plugin:GetVersion())
	return true
end





function OnDisable()
	LOG("Chatter is disabled")
end




