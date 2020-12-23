---
-- Oribos Flight Attendant
--   Simply adds a native waypoint to your map when you’re in the
--   Ring of Transference that points to the Flight Master.
-- Author: waldenp0nd
-- License: Public Domain
---
local name, oribosFlightAttendant = ...

local defaults = {
    LOCALE = "enUS"
}

local ringOfTransferenceMapID = 1671
local shadowlandsMapID = 1550
local flightMasterX = 0.4702
local flightMasterY = 0.5116

local playerWaypoint = nil
local playerWaypointTracking = false

local function prettyPrint(message)
    local prefix = "|cffff866b" .. oribosFlightAttendant.name ..":|r "
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. message)
end

local function attendant()
    local waypoint = C_Map.GetUserWaypoint()
    if C_Map.GetBestMapForUnit("player") == ringOfTransferenceMapID then
        if waypoint then
            if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
                -- Do nothing, it's ours
            else
                playerWaypoint = waypoint
                playerWaypointTracking = C_SuperTrack.IsSuperTrackingUserWaypoint()
                prettyPrint("Your " .. C_Map.GetUserWaypointHyperlink() .. " has been saved.")
            end
        end
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(shadowlandsMapID, flightMasterX, flightMasterY, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    elseif playerWaypoint then
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(playerWaypoint.uiMapID, playerWaypoint.position.x, playerWaypoint.position.y, playerWaypoint.z))
        C_SuperTrack.SetSuperTrackedUserWaypoint(playerWaypointTracking)
        playerWaypoint = nil
    elseif waypoint then
        if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
            C_Map.ClearUserWaypoint()
        end
    end
end

local function sendVersionData()
    local inInstance, _ = IsInInstance()
    if inInstance then
        C_ChatInfo.SendAddonMessage(name, RAV_version, "INSTANCE_CHAT")
    elseif IsInGroup() then
        if GetNumGroupMembers() > 5 then
            C_ChatInfo.SendAddonMessage(name, RAV_version, "RAID")
        end
        C_ChatInfo.SendAddonMessage(name, RAV_version, "PARTY")
    end
    local guildName, _, _, _ = GetGuildInfo("player")
    if guildName then
        C_ChatInfo.SendAddonMessage(name, RAV_version, "GUILD")
    end
end

local function OnEvent(self, event, arg, ...)
    if arg == name then
        if event == "ADDON_LOADED" then
            oribosFlightAttendant.locale = GetLocale()
            if not oribosFlightAttendant.locales[oribosFlightAttendant.locale] then
                oribosFlightAttendant.locale = defaults.LOCALE
            end
            if not OFA_version then
                prettyPrint(string.format(oribosFlightAttendant.locales[oribosFlightAttendant.locale].load.install, oribosFlightAttendant.name))
            elseif OFA_version ~= oribosFlightAttendant.version then
                prettyPrint(string.format(oribosFlightAttendant.locales[oribosFlightAttendant.locale].load.update, oribosFlightAttendant.version))
            end
            if not OFA_version or OFA_version ~= oribosFlightAttendant.version then
                print(string.format(oribosFlightAttendant.locales[oribosFlightAttendant.locale].help[1], oribosFlightAttendant.name))
                print(string.format(oribosFlightAttendant.locales[oribosFlightAttendant.locale].help[2], oribosFlightAttendant.name))
                print(string.format(oribosFlightAttendant.locales[oribosFlightAttendant.locale].help[3], oribosFlightAttendant.discord))
                OFA_seenUpdate = false
            end
            OFA_version = oribosFlightAttendant.version
            C_ChatInfo.RegisterAddonMessagePrefix(name)
            sendVersionData()
        elseif event == "CHAT_MSG_ADDON" and OFA_seenUpdate == false then
            local message, _ = ...
            local a, b, c = strsplit(".", oribosFlightAttendant.version)
            local d, e, f = strsplit(".", message)
            if (d > a) or (d == a and e > b) or (d == a and e == b and f > c) then
                prettyPrint(string.format(oribosFlightAttendant.locales[oribosFlightAttendant.locale].load.outofdate, oribosFlightAttendant.name))
                OFA_seenUpdate = true
            end
        end
    end
    if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
        attendant()
    end
end
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("ZONE_CHANGED")
f:RegisterEvent("ZONE_CHANGED_INDOORS")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:SetScript("OnEvent", OnEvent)
