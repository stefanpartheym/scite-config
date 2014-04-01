--------------------------------------------------------------------------------
-- SciTE startup Lua-script
-- 
-- This is supposed to work on GNU/Linux (GTK+) as well as on Windows systems
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Register custom scite-lua include path
package.path = package.path .. ";" .. props['custom.scite.extdir'] .. "/?.lua"

-- Includes
require "utils"


--------------------------------------------------------------------------------
-- Load lua extensions
--------------------------------------------------------------------------------
function LoadLuaExtensions()
	----------------------------------------------------------------------------
	-- Dubgger extension
	if IsPropertyEnabled("custom.ext.extensions.debugger") then
		require "ext_debugger"
		Ext_Debugger_LoadExtension()
	end
end

--------------------------------------------------------------------------------
-- Main function
--------------------------------------------------------------------------------
function OnSciteStartup()
	Log("# Startup lua-script loaded ...")
	LoadLuaExtensions()
end

OnSciteStartup()
