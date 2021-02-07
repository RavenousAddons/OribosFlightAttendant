local name, ns = ...
local L = ns.L

function oribosFlightAttendant_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("CHAT_MSG_ADDON")
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
            if not OFA_version or OFA_version ~= ns.version then
                OFA_seenUpdate = false
            end
            OFA_version = ns.version
            C_ChatInfo.RegisterAddonMessagePrefix(name)
            ns:SendVersion()
            ns:Attendant()
        elseif event == "CHAT_MSG_ADDON" and OFA_seenUpdate == false then
            local message, _ = ...
            local a, b, c = strsplit(".", ns.version)
            local d, e, f = strsplit(".", message)
            if (d > a) or (d == a and e > b) or (d == a and e == b and f > c) then
                ns:PrettyPrint(string.format(L.OutOfDate, ns.color, ns.name))
                OFA_seenUpdate = true
            end
        end
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
        ns:Attendant()
    elseif event == "CVAR_UPDATE" and arg == "SHOW_IN_GAME_NAVIGATION" then
        OFA_inGameNavigation = GetCVar("showInGameNavigation")
    end
end
