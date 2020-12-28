local name, oribosFlightAttendant = ...
local L = oribosFlightAttendant.L

OFA_playerWaypoint = OFA_playerWaypoint ~= nil and OFA_playerWaypoint or nil
OFA_playerWaypointTracking = OFA_playerWaypointTracking ~= nil and OFA_playerWaypointTracking or false

function oribosFlightAttendant:PrettyPrint(message, full)
    if full == false then
        message = message .. ":"
    end
    local prefix = "|cff" .. oribosFlightAttendant.color .. oribosFlightAttendant.name .. (full and " " or ":|r ")
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. message)
end

function oribosFlightAttendant:SendVersion()
    local inInstance, _ = IsInInstance()
    if inInstance then
        C_ChatInfo.SendAddonMessage(name, OFA_version, "INSTANCE_CHAT")
    elseif IsInGroup() then
        if GetNumGroupMembers() > 5 then
            C_ChatInfo.SendAddonMessage(name, OFA_version, "RAID")
        end
        C_ChatInfo.SendAddonMessage(name, OFA_version, "PARTY")
    end
    local guildName, _, _, _ = GetGuildInfo("player")
    if guildName then
        C_ChatInfo.SendAddonMessage(name, OFA_version, "GUILD")
    end
end

function oribosFlightAttendant:Attendant()
    local ringOfTransferenceMapID = 1671
    local shadowlandsMapID = 1550
    local flightMasterX = 0.4702
    local flightMasterY = 0.5116
    local waypoint = C_Map.GetUserWaypoint()
    if C_Map.GetBestMapForUnit("player") == ringOfTransferenceMapID then
        if waypoint then
            if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
                -- Do nothing, it's ours
            else
                OFA_playerWaypoint = waypoint
                OFA_playerWaypointTracking = C_SuperTrack.IsSuperTrackingUserWaypoint()
                oribosFlightAttendant:PrettyPrint(string.format(L.Saved, C_Map.GetUserWaypointHyperlink()))
            end
        end
        SetCVar("showInGameNavigation", 1)
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(shadowlandsMapID, flightMasterX, flightMasterY, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    else
        if OFA_inGameNavigation ~= nil then
            SetCVar("showInGameNavigation", OFA_inGameNavigation)
        end
        if OFA_playerWaypoint then
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(OFA_playerWaypoint.uiMapID, OFA_playerWaypoint.position.x, OFA_playerWaypoint.position.y, OFA_playerWaypoint.z))
            C_SuperTrack.SetSuperTrackedUserWaypoint(OFA_playerWaypointTracking)
            OFA_playerWaypoint = nil
        elseif waypoint then
            if waypoint.uiMapID == shadowlandsMapID and string.format("%.4f", waypoint.position.x) == string.format("%.4f", flightMasterX) and string.format("%.4f", waypoint.position.y) == string.format("%.4f", flightMasterY) then
                C_Map.ClearUserWaypoint()
            end
        end
    end
end
