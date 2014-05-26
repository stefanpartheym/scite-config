--------------------------------------------------------------------------------
-- Codeblock language lexer
--------------------------------------------------------------------------------

-- Includes
require "utils"


function OnStyle(styler)
    S_DEFAULT         = 0
    S_IDENTIFIER      = 1
    S_KEYWORD         = 2
    S_SPECIAL_KEYWORD = 7
    S_COMMENT         = 3
    S_STRING          = 4
    S_OPERATOR        = 5
    S_DECLARATION     = 6
    
    keywords         = StringSplit(props["keywords.$(file.patterns.codeblock)"],
                                   " ")
    special_keywords = StringSplit(props["keywords2.$(file.patterns.codeblock)"],
                                   " ")
    identifier_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" ..
                       "_1234567890"
    operator_chars   = "-+*/=<>(){}|:,"
    newline_chars    = "\r\n"
    
    ----------------------------------------------------------------------------
    styler:StartStyling(styler.startPos, styler.lengthDoc, styler.initStyle)
    
    while styler:More() do
        -- Exit state if needed
        if styler:State() == S_IDENTIFIER then
            if not identifier_chars:find(styler:Current(), 1, true) then
                identifier = styler:Token()
                if TableContainsKey(keywords, identifier) then
                    -- Use ChangeState() here istead of SetState(), since we
                    -- need to change the state of the CURRENT token (which is
                    -- a keyword)
                    styler:ChangeState(S_KEYWORD)
                elseif TableContainsKey(special_keywords, identifier) then
                    styler:ChangeState(S_SPECIAL_KEYWORD)
                end
                
                styler:SetState(S_DEFAULT)
            end
        elseif styler:State() == S_STRING then
            if styler:Current() == "'" then
                if styler:Next() == "'" then
                    styler:Forward() -- Skip ...
                else
                    styler:ForwardSetState(S_DEFAULT)
                end
            end
        elseif styler:State() == S_OPERATOR then
            styler:SetState(S_DEFAULT)
        elseif styler:State() == S_DECLARATION then
            if styler:Current() == "|" then
                styler:ForwardSetState(S_DEFAULT)
            end
        elseif styler:State() == S_COMMENT then
            -- Skip newline characters first (either LF, CR or CRLF)
            if newline_chars:find(styler:Current(), 1, true) then
                styler:Forward()
                if newline_chars:find(styler:Current(), 1, true) then
                    styler:Forward()
                end
                styler:SetState(S_DEFAULT)
            end
        end
        
        -- Enter state if needed
        if styler:State() == S_DEFAULT then
            if styler:Match("//") then
                styler:SetState(S_COMMENT)
            elseif styler:Current() == "'" then
                styler:SetState(S_STRING)
            elseif operator_chars:find(styler:Current(), 1, true) then
                styler:SetState(S_OPERATOR)
                if styler:Current() == "|" then
                    styler:SetState(S_DECLARATION)
                end
            elseif identifier_chars:find(styler:Current(), 1, true) then
                styler:SetState(S_IDENTIFIER)
            end
        end
        
        -- Next character ...
        styler:Forward()
    end
    
    styler:EndStyling()
end
