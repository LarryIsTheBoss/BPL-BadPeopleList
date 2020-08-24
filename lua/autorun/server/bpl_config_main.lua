--[[
Welcome to BPL - Bad People List

How is this useful?: This addon can be used to deter players that are toxic, unwanted, or potentially problematic.

What should this not be used for?: To deter cheaters with paid hacks. Any good hacks will have anti-lua run on client which prevents this addon from working 100% properly. 
They will still be kicked, but not crashed. This is not an alt-account system, but is an anti-family share system. It can be slightly used in that way, but is not meant to work in that way.

About: This is used to deter people from playing on your server, either by crashing them, or making them think their steam ticket has been cancelled.
This should easily deter most people thrown on the list.

Addon Creator: QuirkyLarry
SteamID: STEAM_0:0:80555260
SteamID64: 76561198121376248
SteamID Profile Link: http://steamcommunity.com/profiles/76561198121376248
BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList
]]

BPL = BPL or {}
BPL.Config = BPL.Config or {}
-- [BPL] | This customizes the timers to look custom to your server.
BPL.CommunityName = "TopTierRP"
-- [BPL] | This is added after your community name in the timer name to make it look less suspicous.
BPL.TimerName = "UpdateInfo"
-- [BPL] | This enables BPL to punish a player caught by BPL by using their SteamID64. [Enable: true; Disable: false]
BPL.EnablePunishment = true
-- [BPL] | This enables BPL to punish a player caught by BPL by using their IP. [Enable: true; Disable: false]
BPL.EnableIPPunishment = true
-- [BPL] | This enables Anti-Family sharing. [Enable: true; Disable: false]
BPL.AntiFamilyShare = true
-- [BPL] | Must be in quotes and separated by commas
-- List of people for for BPL to punish.
BPL.Config.BPL_SteamID64 = { -- List of Minges
-- EX: "STEAMID64","76561198121376248",
"76561198121376248",
}
-- [BPL] | Must be in quotes and separated by commas.
-- List of player's IPs for BPL to punish.
-- Do not include port.
BPL.Config.BPL_IPs = {
-- EX: "0.0.0.0",
}
-- [BPL] | Current version of BPL.
BPL.VersionNumber = 1.5