---
-- Oribos Flight Attendant
-- Author: waldenp0nd
-- License: Public Domain
-- https://github.com/waldenp0nd/OribosFlightAttendant
---
local name, oribosFlightAttendant = ...
oribosFlightAttendant.name = "Oribos Flight Attendant"
oribosFlightAttendant.version = GetAddOnMetadata(name, "Version")

local shadowlandsMapID = 1550
local flightMasterX = 0.4702
local flightMasterY = 0.5116
local waypoint = nil

local function attendant()
    if C_Map.GetBestMapForUnit("player") == 1671 then
        waypoint = C_Map.GetUserWaypoint()
        tracking = C_SuperTrack.IsSuperTrackingUserWaypoint()
        if waypoint then
            if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
                -- Do nothing, it's ours
            else
                print("|cffff866b" .. oribosFlightAttendant.name ..":|r Your " .. C_Map.GetUserWaypointHyperlink() .. " has been saved.")
            end
        end
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(shadowlandsMapID, 0.4702, 0.5116, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    elseif waypoint then
        if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
            C_Map.ClearUserWaypoint()
        else
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(waypoint.uiMapID, waypoint.position.x, waypoint.position.y, waypoint.z))
            if not tracking then
                C_SuperTrack.SetSuperTrackedUserWaypoint(false)
            end
        end
        waypoint = nil
    else
        C_Map.ClearUserWaypoint()
        waypoint = nil
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
        C_ChatInfo.SendAddonMessage(name, OFA_version, "GUILD")
        C_ChatInfo.SendAddonMessage(name, OFA_version, "PARTY")
        C_ChatInfo.SendAddonMessage(name, OFA_version, "RAID")
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
