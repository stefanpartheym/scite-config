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

--------------------------------------------------------------------------------
-- Append key to table
--------------------------------------------------------------------------------
function TableAppendKey(t, key)
    local index = table.getn(t) + 1
    t[index] = key
    
    return index
end

--------------------------------------------------------------------------------
-- Check if t contains key
--------------------------------------------------------------------------------
function TableContainsKey(t, key)
    for i = 1, table.getn(t), 1 do
        if t[i] == key then
            return true
        end
    end
    
    return false
end

--------------------------------------------------------------------------------
-- Convert table content to string
--------------------------------------------------------------------------------
function TableToString(t)
    local result = "{"
    
    for i = 1, table.getn(t), 1 do
        if type(t[i]) == "table" then
            result = result .. TableDump(t[i])
        else
            result = result .. tostring(t[i])
        end
        
        if i < table.getn(t) then
            result = result .. ', '
        end
    end
    
    result = result .. "}"
    return result
end

--------------------------------------------------------------------------------
-- Dump table content
--------------------------------------------------------------------------------
function TableDump(t)
    print(TableToString(t))
end

--------------------------------------------------------------------------------
-- Split string into table
--------------------------------------------------------------------------------
function StringSplit(str, delimiter)
    local result = {}
    for s in string.gmatch(str, "[^"..delimiter.."]+") do
        result[table.getn(result) + 1] = s
    end
    
    return result
end
