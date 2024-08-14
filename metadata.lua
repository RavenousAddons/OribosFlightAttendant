local name, ns = ...

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

ns.name = "Oribos Flight Attendant"
ns.title = GetAddOnMetadata(name, "Title")
ns.notes = GetAddOnMetadata(name, "Notes")
ns.version = GetAddOnMetadata(name, "Version")
ns.color = "ff866b"
