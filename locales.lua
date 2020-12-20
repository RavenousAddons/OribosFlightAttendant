local _, oribosFlightAttendant = ...

oribosFlightAttendant.name = "Oribos Flight Attendant"
oribosFlightAttendant.version = GetAddOnMetadata(name, "Version")
oribosFlightAttendant.github = "https://github.com/waldenp0nd/OribosFlightAttendant"
oribosFlightAttendant.curseforge = "https://www.curseforge.com/wow/addons/oribos-flight-attendant"
oribosFlightAttendant.wowinterface = "https://www.wowinterface.com/downloads/info25812-OribosFlightAttendant.html"
oribosFlightAttendant.discord = "https://discord.gg/dNfqnRf2fq"
oribosFlightAttendant.color = "ff866b"
oribosFlightAttendant.locales = {
    ["enUS"] = {
        ["help"] = {
            "This AddOn automatically creates a waypoint to the Flight Master when you're in the Ring of Transference.", -- oribosFlightAttendant.name
            "Check out |cff" .. oribosFlightAttendant.color .. "%s|r on GitHub, WoWInterface, or Curse for more info and support!", -- oribosFlightAttendant.name
            "You can also get help directly from the author on Discord: %s" -- oribosFlightAttendant.discord
        },
        ["load"] = {
            ["outofdate"] = "There is an update available for |cff" .. oribosFlightAttendant.color .. "%s|r! Please go to GitHub, WoWInterface, or Curse to download.", -- oribosFlightAttendant.name
            ["install"] = "Thanks for installing |cff" .. oribosFlightAttendant.color .. "%s|r!", -- oribosFlightAttendant.name
            ["update"] = "Thanks for updating to |cff" .. oribosFlightAttendant.color .. "v%s|r!" -- oribosFlightAttendant.version
        }
    }
}
