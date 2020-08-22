--[[
Welcome to BPL - Bad People List

How is this useful?: This addon can be used to deter players that are toxic, unwanted, or potential problematic.

What should this not be used for?: To deter cheaters with paid hacks. Any good hacks will have anti-lua run on client which prevents this addon from working 100% properly. 
They will still be kicked, but not crashed. This is not an alt-account system. It can be used in that way, but is not meant to work in that way.

About: This is used to deter people from playing on your server, either by crashing them, or making them think their steam ticket has been cancelled.
This should easily deter most people thrown on the list.

Addon Creator: QuirkyLarry
SteamID: STEAM_0:0:80555260
SteamID64: 76561198121376248
SteamID Profile Link: http://steamcommunity.com/profiles/76561198121376248
]]

BPL = {}
-- [BPL] | Must be in quotes and separated by commas
BPL.BPL_SteamID64M = { -- List of Minges
-- EX: "STEAMID64","76561198121376248",
}

-- [BPL] | Must be in quotes and separated by commas.
BPL.BPL_SteamID64CB = { -- List of people who have charged back.
-- EX: "STEAMID64","76561198121376248",
}

-- [BPL] | Must be in quotes and separated by commas.
-- [BPL] | Do not include port.
BPL.BPL_IPs = {
-- EX: "0.0.0.0",
}

-- [BPL] | This will kick people instead of crashing them with this message. "Steam auth ticket has been cancelled"
BPL.SoftPunishID = false
BPL.SoftPunishIP = false

-- [BPL] | Min and max time befoire someone is punished. It is randomized between these two numbers.
BPL.MinTimeBeforePunish = 60
BPL.MaxTimeBeforePunish = 600

BPL.VersionNumber = 1.2