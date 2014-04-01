--------------------------------------------------------------------------------
-- SciTE Lua Debugger extension loader
-- 
-- NOTE: This requires the "scite-debug" from http://scitedebug.luaforge.net/
--       Download the package and extract its content to a directory called
--       "./debugger" .
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Includes
require "utils"


--------------------------------------------------------------------------------
-- Load Debugger extension
--------------------------------------------------------------------------------
function Ext_Debugger_LoadExtension()
	local extension_dir  = props["custom.ext.extensions.debugger.dir"]
	local extension_path = props["custom.scite.extdir"] .. "/" .. extension_dir
	
	Log("# Loading Debugger extension ... ")
	
	-- set necessary property for this extension
	props["spawner.extension.path"] = extension_path
	require "debugger.extman" -- load extension
end
