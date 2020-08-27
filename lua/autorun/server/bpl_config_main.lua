--[[
Welcome to BPL - Bad People List

How is this useful?: This addon can be used to deter players that are toxic, unwanted, or potentially problematic.

What should this not be used for?: To deter cheaters with paid hacks. Any good hacks will have anti-lua run on client which prevents this addon from working 100% properly. 
They will still be kicked, but not crashed. This is not an alt-account system, but is an anti-family share system. It can be slightly used in that way, but is not meant to work in that way.

About: This is used to deter people from playing on your server, either by crashing them, or making them think their steam ticket has been cancelled.
This should easily deter most people thrown on the list.

Commands: Use "bpl_blacklist STEAMID64" to add someone to the blacklist live. 
This will kick them with the "Steam auth ticket has been cancelled" message and punish them on rejoin.

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
-- [BPL] | Administration system. This is the administration system you are currently using. 
-- For SAM put "SAM"
-- For ULX put "ULX"
-- To use Garry's Mod ban system use "SOURCE"
BPL.AdminSystem = "SOURCE"
-- [BPL] | Must be in quotes and separated by commas
-- List of people for for BPL to punish.
-- I would use this for SteamID64(s) you never plan to remove.
BPL.Config.BPL_SteamID64 = {
-- EX: "STEAMID64","76561198121376248",
}
-- [BPL] | Must be in quotes and separated by commas.
-- List of player's IPs for BPL to punish.
-- Do not include port.
BPL.Config.BPL_IPs = {
-- EX: "0.0.0.0",
}
-- [BPL] | Current version of BPL.
BPL.VersionNumber = 1.6

--[[

Change Notes.

V1.6
  - Change notes were introduced.
  - Ban support for SAM, ULX, and Source was added.
  - You can now added people live to the blacklist using "bpl_blacklisted STEAMID64" in server console.
  - Now a blacklist save file for everyone added using "bpl_blacklist". These users are blacklisted after future restarts too.
  - Fixed two timers not being removed properly causing script errors.
  - You can now customize the ban message.
  - You can now customize the LUA sent to the client when the "crash" option is selected.
  - You can now customize the kick message.
  - You can now set a ban length.
  - You can now specify the punishment type.
--]]