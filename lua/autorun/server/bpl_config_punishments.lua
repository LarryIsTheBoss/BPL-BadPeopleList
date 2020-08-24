--[[
Welcome to BPL - Bad People List
Addon Creator: QuirkyLarry
SteamID: STEAM_0:0:80555260
SteamID64: 76561198121376248
SteamID Profile Link: http://steamcommunity.com/profiles/76561198121376248
BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList
]]
BPL = BPL or {}
BPL.Punish = BPL.Punish or {}
-- [BPL] | This will kick people instead of crashing them with this message. "Steam auth ticket has been cancelled"
BPL.Punish.SoftPunishID = false
BPL.Punish.SoftPunishIP = false
BPL.Punish.HardPunishLUA = "while true do end"
-- EX: "while true do end" -- This will cause Garry's Mod to freeze and eventually crash the client.
-- EX: "LocalPlayer():ConCommand('connect 0.0.0.0:27015')" -- This will redirect the player to the IP address provided.
-- [BPL] | Min and max time before someone is punished. It is randomized between these two numbers.
BPL.Punish.MinTimeBeforePunish = 60
BPL.Punish.MaxTimeBeforePunish = 600