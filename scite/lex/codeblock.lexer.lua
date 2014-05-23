--------------------------------------------------------------------------------
-- Codeblock language lexer
--------------------------------------------------------------------------------

-- Includes
require "utils"


function OnStyle(styler)
    S_DEFAULT        = 0
    S_IDENTIFIER     = 1
    S_KEYWORD        = 2
    S_COMMENT        = 3
    
    keywords         = StringSplit(props["keywords.$(file.patterns.codeblock)"],
                                   " ")
    identifier_chars = "_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    
    ----------------------------------------------------------------------------
    styler:StartStyling(styler.startPos, styler.lengthDoc, styler.initStyle)
    
    while styler:More() do
        -- Exit state if needed
        if styler:State() == S_IDENTIFIER then
            if not identifier_chars:find(styler:Current(), 1, true) then
                identifier = styler:Token()
                if TableContainsKey(keywords, identifier) then
                    styler:ChangeState(S_KEYWORD)
                end
                styler:SetState(S_DEFAULT)
            end
        elseif styler:State() == S_COMMENT then
            if styler:Match("\n") then
                styler:ForwardSetState(S_DEFAULT)
            end
        end
        
        -- Enter state if needed
        if styler:State() == S_DEFAULT then
            if styler:Match("//") then
                styler:SetState(S_COMMENT)
            elseif identifier_chars:find(styler:Current(), 1, true) then
                styler:SetState(S_IDENTIFIER)
            end
        end
        
        -- Next character ...
        styler:Forward()
    end
    
    styler:EndStyling()
end
