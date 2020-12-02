---
-- Oribos Flight Attendant
-- Author: waldenp0nd
-- License: Public Domain
-- https://github.com/waldenp0nd/OribosFlightAttendant
---
local name, oribosFlightAttendant = ...
oribosFlightAttendant.name = "Oribos Flight Attendant"
oribosFlightAttendant.version = GetAddOnMetadata(name, "Version")

local ringOfFates = 1671
local shadowlands = 1550
local x = 47.01
local y = 51.13
local inRingOfTransference = false

local function attendant()
    if C_Map.GetBestMapForUnit("player") == ringOfFates then
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(shadowlands, x / 100, y / 100, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        inRingOfTransference = true
    elseif inRingOfTransference == true then
        C_Map.ClearUserWaypoint()
        inRingOfTransference = false
    end
end

local function OnEvent(self, event, arg, ...)
    if arg == name and event == "ADDON_LOADED" then
        if not OFA_version then
            print("Thanks for installing |cff9eb8c9" .. oribosFlightAttendant.name .. " v" .. oribosFlightAttendant.version .. "|r!")
        elseif OFA_version ~= oribosFlightAttendant.version then
            print("Thanks for updating |cff9eb8c9" .. oribosFlightAttendant.name .. "|r to |cff9eb8c9v" .. oribosFlightAttendant.version .. "|r!")
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
            print("There is an update available for |cff9eb8c9" .. oribosFlightAttendant.name .. "|r!")
            OFA_seenUpdate = true
        end
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "ZONE_CHANGED_NEW_AREA" then
        attendant()
    end
end
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("ZONE_CHANGED")
f:RegisterEvent("ZONE_CHANGED_INDOORS")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:SetScript("OnEvent", OnEvent)
