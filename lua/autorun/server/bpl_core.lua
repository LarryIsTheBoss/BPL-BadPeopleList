-- Addon Creator: QuirkyLarry - STEAM_0:0:80555260 - 76561198121376248 - http://steamcommunity.com/profiles/76561198121376248
-- BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList

-- Localized function(s).
local l_hAd = hook.Add
local l_IVd = IsValid
local l_tHV = table.HasValue
local l_mrm = math.random
local l_mTe = math.Truncate
local l_pnt = print
local l_tCe = timer.Create
local l_tsg = tostring
local l_sEe = string.Explode
local l_ie = include
local l_tRe = timer.Remove
local l_fEs = file.Exists
local l_fRd = file.Read
local l_uJSONTTe = util.JSONToTable
local l_uSIDF64 = util.SteamIDFrom64
local l_pGBSID64 = player.GetBySteamID64
local l_fCDr = file.CreateDir
local l_tit = table.insert
local l_uTTJSON = util.TableToJSON
local l_fWe = file.Write
local l_cAd = (SERVER and concommand.Add or NULL)

l_ie("bpl_config_main.lua")
l_ie("bpl_config_punishments.lua")
l_ie("bpl_config_familyshare.lua")

local BPL_BannedSteamID = {}
if l_fEs("bpl/bpl_bannedusers.json", "DATA") then
  local SavedIDs = l_fRd("bpl/bpl_bannedusers.json", "DATA")
  BPL_BannedSteamID = l_uJSONTTe(SavedIDs)
end
-- This function enforces the punishment upon the client.
local BPLEnforcement = function(ply,l_SteamID64)
  if BPL.Punish.Type == "kick" then
    ply:Kick(BPL.Punish.KickMessage)
  elseif BPL.Punish.Type == "ban" then
    if BPL.AdminSystem == "SOURCE" then ply:Ban(BPL.Punish.BanLength, false);ply:Kick(BPL.Punish.KickMessage) end
    if BPL.AdminSystem == "ULX" then ULib.ban(	ply,BPL.Punish.BanLength,BPL.Punish.BanMessage) end
    if BPL.AdminSystem == "SAM" then local SteamID32 = l_uSIDF64(l_SteamID64); sam.player.ban_id(SteamID32, BPL.Punish.BanLength, BPL.Punish.BanMessage) end
  elseif BPL.Punish.Type == "crash" then
    ply:SendLua(BPL.Punish.CustomLUARun)
    if BPL.Punish.CustomLUAKick then ply:Kick(BPL.Punish.KickMessage) end
  end
end
-- Function that checks each method/blacklist for a detection.
local BPLPunish = function(ply,TimeUntilDisconnect,l_IPAddressSimple,l_SteamID64,l_PlayerName,l_GModLicenseOwner)
  if BPL.EnablePunishment or BPL.EnableIPPunishment or BPL.SimpleAntiFamilyShare then
    if l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64) then
      l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName, TimeUntilDisconnect, 1, function()
        BPLEnforcement(ply,l_SteamID64)
      end)
      l_pnt(" =======| [BPL] - Detection |======= ");l_pnt("[BPL] - Player's Name: " .. l_PlayerName);l_pnt("[BPL] - SteamID64:" .. l_SteamID64);l_pnt("[BPL] - IP:" .. l_IPAddressSimple[1]);l_pnt("[BPL] - Detection Method: [SteamID64]");l_pnt("[BPL] - IP Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple[1])))
    elseif l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple) then
      l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName, TimeUntilDisconnect, 1, function()
        BPLEnforcement(ply,l_SteamID64)
      end)
      l_pnt(" =======| [BPL] - Detection |======= ");l_pnt("[BPL] - Player's Name: " .. l_PlayerName);l_pnt("[BPL] - SteamID64:" .. l_SteamID64);l_pnt("[BPL] - IP:" .. l_IPAddressSimple[1]);l_pnt("[BPL] - Detection Method: [IPAddress]");l_pnt("[BPL] - SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64)))
    elseif l_SteamID64 ~= l_GModLicenseOwner then
      l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName, TimeUntilDisconnect, 1, function()
        BPLEnforcement(ply,l_SteamID64)
        l_pnt("[BPL] | " .. l_PlayerName .. "/" .. l_SteamID64 .. " was caught by BPL. - Current IP: " .. l_IPAddressSimple[1] .. " - Detection Method: [IPAddress] | " .. "SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64)))
      end)
      l_pnt(" =======| [BPL] - Detection |======= ");l_pnt("[BPL] - Player's Name: " .. l_PlayerName);l_pnt("[BPL] - SteamID64:" .. l_SteamID64);l_pnt("[BPL] - IP:" .. l_IPAddressSimple[1]);l_pnt("[BPL] - Detection Method: [FamilyShare]");l_pnt("[BPL] - IP Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple[1])));l_pnt("[BPL] - SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64)))
    else
      l_pnt("[BPL - Pass] | " .. l_PlayerName .. "/" .. l_SteamID64 .. " has passed the [BPL] check. - IP: " .. l_IPAddressSimple[1])
    end
  end
end
-- [BPL] | Main Hook. Runs on only FIRST spawn.
l_hAd("PlayerInitialSpawn", BPL.CommunityName .. "_" .. BPL.TimerName .. "_PlayerInitialSpawn", function(ply)
  if not l_IVd(ply) then return end
  local TimeUntilDisconnect = l_mrm(BPL.Punish.MinTimeBeforePunish,BPL.Punish.MaxTimeBeforePunish)
  local l_SteamID64 = ply:SteamID64()
  local l_IPAddress = ply:IPAddress()
  local l_PlayerName = ply:Nick()
  local l_GModLicenseOwner = ply:OwnerSteamID64()
  -- Splits the IP Address and the port number they are connected on.
  l_IPAddressSimple = l_sEe(":", l_IPAddress)
  l_mTe(TimeUntilDisconnect, 0)
  BPLPunish(ply,TimeUntilDisconnect,l_IPAddressSimple,l_SteamID64,l_PlayerName,l_GModLicenseOwner)
end)
-- Removes the timer incase the player disconnects before code is executed on client.
l_hAd("PlayerDisconnected",BPL.CommunityName .. "_" .. BPL.TimerName .. "_TimerRemove", function(ply)
  local pl_sid64 = ply:SteamID64()
  local l_PlayerName = ply:Nick()
  if BPL.EnablePunishment or BPL.EnableIPPunishment or BPL.SimpleAntiFamilyShare then l_tRe(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName) end
end)
-- Writes the SteamID64 to bpl_bannedusers.json and checks if the BPL folder exists.
local UpdateBannedUsersBPL = function(ply,cmd,args)
  if table.IsEmpty(args) then return end
  if l_pGBSID64(args[1]) ~= false then
    local playerbySteam64 = l_pGBSID64(args[1])
    playerbySteam64:Kick("Steam auth ticket has been cancelled")
  end
  if not l_fEs("bpl","data") then
    l_fCDr("bpl")
  end
  l_tit(BPL_BannedSteamID, args[1])
  local BannedIDsToString = l_uTTJSON(BPL_BannedSteamID)
  l_fWe("bpl/bpl_bannedusers.json", BannedIDsToString)
end
if CLIENT then return end
-- Command to write the SteamID64 to a file.
l_cAd("bpl_blacklist", function( ply, cmd, args, str )
  UpdateBannedUsersBPL(ply,cmd,args)
end)

l_pnt("[BPL] | " .. "Core has loaded. | " .. "v" .. BPL.VersionNumber)