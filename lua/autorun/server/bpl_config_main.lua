--[[
Welcome to BPL - Bad People List

How is this useful?: This addon can be used to deter players that are toxic, unwanted, or potentially problematic.

What should this not be used for?: To deter cheaters with paid hacks. Any good hacks will have anti-lua run on client which prevents this addon from working 100% properly. 

They will still be kicked, but not crashed. This is not an alt-account system, but is an anti-family share system. It can be slightly used in that way, but is not meant to work in that way.

About: This is used to deter people from playing on your server, either by crashing them, or making them think their steam ticket has been cancelled.
This should easily deter most people thrown on the list.

Commands: 
 - Use "bpl_blacklist STEAMID64" to add someone to the blacklist live. 
 - Use "bpl_convert "STEAMID32"" to convert a SteamID32 to SteamID. Prints in console.
 - Use "bpl_clearadv "STEAMID64"" to delete data in the DATA folder on the client.
  - Note: This will delete what you have set as your 'BPL.DataToWipe' config option.

-- Addon Creator: QuirkyLarry - STEAM_0:0:80555260 - 76561198121376248 - http://steamcommunity.com/profiles/76561198121376248
-- BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList
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
-- [BPL] | This enables Simple Anti-Family sharing. [Enable: true; Disable: false]
-- Info | Uses a simple method to determine if Garry's Mod is being shared with the account.
BPL.SimpleAntiFamilyShare = true
-- [BPL] | Administration system. This is the administration system you are currently using. 
-- For SAM put "SAM"
-- For ULX put "ULX"
-- To use Garry's Mod ban system use "SOURCE"
BPL.AdminSystem = "SOURCE"
-- [BPL] | True/False - True to enable, false to disable.
-- This wipes all adv dupe files on the client.
BPL.Wipe = false
-- [BPL] | This is the directory to wipe in the clients DATA folder.
-- Using '*' wipes all data in the clients DATA folder.
-- Using 'advdupe2' wipes all Adv Dupe 2 data.
-- Data deleted by this is not thrown in the Recycling Bin.
BPL.DataToWipe = "advdupe2"
-- [BPL] | Must be in quotes and separated by commas
-- List of people for for BPL to punish.
-- I would use this for SteamID64(s) you never plan to remove.
BPL.Config.BPL_SteamID64 = {
-- "76561198121376248",
}
-- [BPL] | Must be in quotes and separated by commas.
-- List of player's IPs for BPL to punish.
-- Do not include port.
BPL.Config.BPL_IPs = {
-- EX: "0.0.0.0",
}
-- [BPL] | Current version of BPL.
BPL.VersionNumber = "1.7.4"

--[[
Change Notes.
v1.7.4
  - Added a console command to convert SteamID32 to SteamID64 since BPL is SteamID64 based.
    - Command: bpl_convert "STEAMID32"
  - Added a console command to wipe the Adv Dupe data of the target player.
   - bpl_clearadv "STEAMID64"
  - BPL now bans the Garry's Mod license owner when a family share account is detected.
  - When a client is caught with family share detection. Family share settings is used instead of normal punishment settings.
  - Added BPL.FamilyShare.Crash config option.
  - Added BPL.FamilyShare.BanOwner config option.
  - Added BPL.Wipe config option.
  - Added BPL.DataToWipe config option.
  - Changed: More in depth localization.
  [Main Feature Added]
  - When enabled. BPL will delete all advdupe2 data on client or all data in their data directory.
v1.6.9
  - "BPL.AntiFamilyShare" was renamed to "BPL.SimpleAntiFamilyShare" in preparation for new alt-account methods.
  - Re-wrote the ban function to remove duplicate code. More efficient now.
  - Added "BPL.Punish.CustomLUAKick". Allows you to disable kicking a player after running LUA on them.
  - Changed "BPL.Config.BPL_SteamID64" config example to be less confusing.
  - Changed "disconnected hook" to be more efficient.
  - Console print messages for detections are now more legible.
  - Main hook now uses more efficient ban function.
  - Updated a few code comments.
  - Added dates to change notes.
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