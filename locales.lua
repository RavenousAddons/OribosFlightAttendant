local name, ns = ...

local L = {}
ns.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

-- Default (English)
L.Saved = "Your %s has been saved." -- C_Map.GetUserWaypointHyperlink()
L.Version = "%s is the current version." -- ns.version
L.OutOfDate = "There is an update available for |cff%s%s|r!" -- ns.color, ns.name
L.Install = "Thanks for installing |cff%s%s|r!" -- ns.color, ns.name
L.Update = "Thanks for updating to |cff%sv%s|r!" -- ns.color, ns.version
L.Support1 = "This Addon automatically creates a waypoint to the Flight Master when you're in the Oribos Ring of Transference."
L.Support2 = "Check out the Addon on |rGitHub|cffffffff, |rWoWInterface|cffffffff, or |rCurse|cffffffff for more info and support!"

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
