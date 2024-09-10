local name, ns = ...
local L = ns.L

function oribosFlightAttendant_OnLoad(self)
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("ZONE_CHANGED")
    self:RegisterEvent("ZONE_CHANGED_INDOORS")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("CVAR_UPDATE")
end

function oribosFlightAttendant_OnEvent(self, event, arg, ...)
    if event == "PLAYER_LOGIN" then
        if not OFA_version then
            ns:PrettyPrint(string.format(L.Install, ns.color, ns.name))
        elseif OFA_version ~= ns.version then
            -- Version-specific messages go here...
        end
        OFA_version = ns.version
    elseif event == "PLAYER_ENTERING_WORLD" then
        ns:Attendant()
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
        ns:Attendant()
    elseif event == "CVAR_UPDATE" and arg == "SHOW_IN_GAME_NAVIGATION" then
        OFA_inGameNavigation = GetCVar("showInGameNavigation")
    end
end
