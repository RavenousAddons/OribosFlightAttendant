local name, oribosFlightAttendant = ...

local L = {}
oribosFlightAttendant.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

-- Default (English)
L.Saved = "Your %s has been saved." -- C_Map.GetUserWaypointHyperlink()
L.Version = "%s is the current version." -- oribosFlightAttendant.version
L.OutOfDate = "There is an update available for |cff%s%s|r!" -- oribosFlightAttendant.color, oribosFlightAttendant.name
L.Install = "Thanks for installing |cff%s%s|r!" -- oribosFlightAttendant.color, oribosFlightAttendant.name
L.Update = "Thanks for updating to |cff%sv%s|r!" -- oribosFlightAttendant.color, oribosFlightAttendant.version
L.Support1 = "This AddOn automatically creates a waypoint to the Flight Master when you're in the Ring of Transference."
L.Support2 = "Check out the AddOn on |rGitHub|cffffffff, |rWoWInterface|cffffffff, or |rCurse|cffffffff for more info and support!"
L.Support3 = "You can also get help directly from the author on Discord: |r%s|cffffffff" -- oribosFlightAttendant.discord

-- Check locale and assign appropriate
local CURRENT_LOCALE = GetLocale()

-- English
if CURRENT_LOCALE == "enUS" then return end

-- German
if CURRENT_LOCALE == "deDE" then return end

-- Spanish
if CURRENT_LOCALE == "esES" then return end

-- Latin-American Spanish
if CURRENT_LOCALE == "esMX" then return end

-- French
if CURRENT_LOCALE == "frFR" then return end

-- Italian
if CURRENT_LOCALE == "itIT" then return end

-- Brazilian Portuguese
if CURRENT_LOCALE == "ptBR" then return end

-- Russian
if CURRENT_LOCALE == "ruRU" then return end

-- Korean
if CURRENT_LOCALE == "koKR" then return end

-- Simplified Chinese
if CURRENT_LOCALE == "zhCN" then return end

-- Traditional Chinese
if CURRENT_LOCALE == "zhTW" then return end

-- Swedish
if CURRENT_LOCALE == "svSE" then return end
