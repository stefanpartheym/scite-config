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
-- Main function
--------------------------------------------------------------------------------
function OnSciteStartup()
	Log("# Startup lua-script loaded ...")
end

OnSciteStartup()
