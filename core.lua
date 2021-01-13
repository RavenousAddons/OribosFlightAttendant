local name, oribosFlightAttendant = ...
local L = oribosFlightAttendant.L

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
                oribosFlightAttendant:PrettyPrint(string.format(L.Install, oribosFlightAttendant.color, oribosFlightAttendant.name))
            elseif OFA_version ~= oribosFlightAttendant.version then
                oribosFlightAttendant:PrettyPrint(string.format(L.Update, oribosFlightAttendant.color, oribosFlightAttendant.version))
            end
            if not OFA_version or OFA_version ~= oribosFlightAttendant.version then
                OFA_seenUpdate = false
            end
            OFA_version = oribosFlightAttendant.version
            C_ChatInfo.RegisterAddonMessagePrefix(name)
            oribosFlightAttendant:SendVersion()
            oribosFlightAttendant:Attendant()
        elseif event == "CHAT_MSG_ADDON" and OFA_seenUpdate == false then
            local message, _ = ...
            local a, b, c = strsplit(".", oribosFlightAttendant.version)
            local d, e, f = strsplit(".", message)
            if (d > a) or (d == a and e > b) or (d == a and e == b and f > c) then
                oribosFlightAttendant:PrettyPrint(string.format(L.OutOfDate, oribosFlightAttendant.color, oribosFlightAttendant.name))
                OFA_seenUpdate = true
            end
        end
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
        oribosFlightAttendant:Attendant()
    elseif event == "CVAR_UPDATE" and arg == "SHOW_IN_GAME_NAVIGATION" then
        OFA_inGameNavigation = GetCVar("showInGameNavigation")
    end
end
