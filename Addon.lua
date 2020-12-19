---
-- Oribos Flight Attendant
-- Author: waldenp0nd
-- License: Public Domain
-- https://github.com/waldenp0nd/OribosFlightAttendant
---
local name, oribosFlightAttendant = ...
oribosFlightAttendant.name = "Oribos Flight Attendant"
oribosFlightAttendant.version = GetAddOnMetadata(name, "Version")

local ringOfTransferenceMapID = 1671
local shadowlandsMapID = 1550
local flightMasterX = 0.4702
local flightMasterY = 0.5116

local playerWaypoint = nil
local playerWaypointTracking = false

local function attendant()
    local waypoint = C_Map.GetUserWaypoint()
    if C_Map.GetBestMapForUnit("player") == ringOfTransferenceMapID then
        if waypoint then
            if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
                -- Do nothing, it's ours
            else
                playerWaypoint = waypoint
                playerWaypointTracking = C_SuperTrack.IsSuperTrackingUserWaypoint()
                print("|cffff866b" .. oribosFlightAttendant.name ..":|r Your " .. C_Map.GetUserWaypointHyperlink() .. " has been saved.")
            end
        end
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(shadowlandsMapID, flightMasterX, flightMasterY, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    elseif playerWaypoint then
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(playerWaypoint.uiMapID, playerWaypoint.position.x, playerWaypoint.position.y, playerWaypoint.z))
        C_SuperTrack.SetSuperTrackedUserWaypoint(playerWaypointTracking)
        playerWaypoint = nil
    elseif waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
        C_Map.ClearUserWaypoint()
    end
end

local function OnEvent(self, event, arg, ...)
    if arg == name and event == "ADDON_LOADED" then
        if not OFA_version then
            print("Thanks for installing |cffff866b" .. oribosFlightAttendant.name .. " v" .. oribosFlightAttendant.version .. "|r!")
        elseif OFA_version ~= oribosFlightAttendant.version then
            print("Thanks for updating |cffff866b" .. oribosFlightAttendant.name .. "|r to |cffff866bv" .. oribosFlightAttendant.version .. "|r!")
        end
        if not OFA_version or OFA_version ~= oribosFlightAttendant then
            OFA_seenUpdate = false
        end
        OFA_version = oribosFlightAttendant.version
        attendant()
        C_ChatInfo.RegisterAddonMessagePrefix(name)
        C_ChatInfo.SendAddonMessage(name, OFA_version, "YELL")
        C_ChatInfo.SendAddonMessage(name, OFA_version, "PARTY")
        C_ChatInfo.SendAddonMessage(name, OFA_version, "RAID")
        local guild, _, _, _ = GetGuildInfo("player")
        if guild then
            C_ChatInfo.SendAddonMessage(name, OFA_version, "GUILD")
        end
    elseif arg == name and event == "CHAT_MSG_ADDON" and not OFA_seenUpdate then
        local message, _ = ...
        local a, b, c = strsplit(".", oribosFlightAttendant.version)
        local d, e, f = strsplit(".", message)
        if (d > a) or (d == a and e > b) or (d == a and e == b and f > c) then
            print("There is an update available for |cffff866b" .. oribosFlightAttendant.name .. "|r!")
            OFA_seenUpdate = true
        end
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
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
