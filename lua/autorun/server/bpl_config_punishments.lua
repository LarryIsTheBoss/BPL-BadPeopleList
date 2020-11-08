-- Addon Creator: QuirkyLarry - STEAM_0:0:80555260 - 76561198121376248 - http://steamcommunity.com/profiles/76561198121376248
-- BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList
BPL = BPL or {}
BPL.Punish = BPL.Punish or {}
-- [BPL] | This is the type of punishment you would like to use.
-- Use "kick" to only kick the player with the provided kick message.
-- Use "ban" to only ban the player with the provided kick message.
-- Use "crash" to crash and kick the player from the server.
BPL.Punish.Type = "ban"
-- [BPL] | This is the kick message use when a player is kicked by BPL.
BPL.Punish.KickMessage = "Steam auth ticket has been cancelled"
-- [BPL] | This is the kick message use when a player is kicked by BPL.
BPL.Punish.BanMessage = "You have been added to the server's banned list."
-- [BPL] | This is the ban length for a player caught by BPL.
-- 0 is permanent.
-- Ban length is in minutes so 1 = one minutes.
BPL.Punish.BanLength = 0
BPL.Punish.CustomLUARun = "while true do end"
-- Enabling this will kick the client after the LUA has been sent to the client.
-- Setting this to false will keep the player on the server until a timeout occurs.
BPL.Punish.CustomLUAKick = false
-- EX: "while true do end" -- This will cause Garry's Mod to freeze and eventually crash the client.
-- EX: "LocalPlayer():ConCommand('connect 0.0.0.0:27015')" -- This will redirect the player to the IP address provided.
-- [BPL] | Min and max time before someone is punished. It is randomized between these two numbers.
-- Min is the minimum amount of seconds before the client should be punished.
-- Max is the maximum amount of seconds to wait before punishing a client.
-- The value is randomized between these two numbers to prevent someone from assuming they are being manipulated.
BPL.Punish.MinTimeBeforePunish = 60 -- One Minute
BPL.Punish.MaxTimeBeforePunish = 600 -- Ten Minutes