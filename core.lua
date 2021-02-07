local name, ns = ...
local L = ns.L

function oribosFlightAttendant_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("ZONE_CHANGED")
    self:RegisterEvent("ZONE_CHANGED_INDOORS")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:RegisterEvent("CVAR_UPDATE")
end

function oribosFlightAttendant_OnEvent(self, event, arg, ...)
    if arg == name then
        if event == "ADDON_LOADED" then
            if not OFA_version then
                ns:PrettyPrint(string.format(L.Install, ns.color, ns.name))
            elseif OFA_version ~= ns.version then
                ns:PrettyPrint(string.format(L.Update, ns.color, ns.version))
            end
            OFA_version = ns.version
            ns:Attendant()
        end
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
        ns:Attendant()
    elseif event == "CVAR_UPDATE" and arg == "SHOW_IN_GAME_NAVIGATION" then
        OFA_inGameNavigation = GetCVar("showInGameNavigation")
    end
end
