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
-- Load lexers
--------------------------------------------------------------------------------
function LoadCustomLexers()
    if IsPropertyEnabled("custom.ext.loadlexers") then
        local lexers = props["custom.ext.lexers"]
        for lexer_path in string.gmatch(lexers, "[^;]+") do
            local lexer_name = ""
            for i in string.gmatch(lexer_path, "[^/]+") do
                lexer_name = i
            end
            
            Log("# Loading custom lexer: " .. lexer_name)
            local status, err = pcall(function() dofile(lexer_path) end)
            if not status then
                Log(">ERROR: Unable to load custom lexer: " .. lexer_name)
                Log(">>>>Reason: [" .. err .. "]")
            end
        end
    end
end

--------------------------------------------------------------------------------
-- Main function
--------------------------------------------------------------------------------
function OnSciteStartup()
    Log("# Startup lua-script loaded ...")
    LoadCustomLexers()
    LoadLuaExtensions()
end

OnSciteStartup()
