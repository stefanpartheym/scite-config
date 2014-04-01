--------------------------------------------------------------------------------
-- SciTE Lua utilities
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Check if a SciTE-property is enabled
--------------------------------------------------------------------------------
function IsPropertyEnabled(property)
	local value = props[property]
	if (value == "on") or (value == "true") or (value == "1") then
		return true
	else
		return false
	end
end

--------------------------------------------------------------------------------
-- Check if debug-mode is enabled
--------------------------------------------------------------------------------
function IsDebugMode()
	return IsPropertyEnabled("custom.ext.debugmode")
end

--------------------------------------------------------------------------------
-- Write log message (depends on debug-mode)
--------------------------------------------------------------------------------
function Log(message)
	if IsDebugMode() then
		print (message)
	end
end
