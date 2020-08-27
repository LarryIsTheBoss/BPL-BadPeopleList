--[[
Welcome to BPL - Bad People List
Addon Creator: QuirkyLarry
SteamID: STEAM_0:0:80555260
SteamID64: 76561198121376248
SteamID Profile Link: http://steamcommunity.com/profiles/76561198121376248
BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList
]]
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

-- Local Ban/Kick/Sendlua Function(s).
local BPLEnforcementSource = function(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  if BPL.Punish.Type == "kick" then
    ply:Kick(BPL.Punish.KickMessage)
  elseif BPL.Punish.Type == "ban" then
    ply:Ban(BPL.Punish.BanLength, false)
    ply:Kick(BPL.Punish.KickMessage)
  elseif BPL.Punish.Type == "crash" then
    ply:SendLua(BPL.Punish.CustomLUARun);ply:Kick(BPL.Punish.KickMessage)
  end
end

local BPLEnforcementULX = function(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  if BPL.Punish.Type == "kick" then
    ply:Kick(BPL.Punish.KickMessage)
  elseif BPL.Punish.Type == "ban" then
    ULib.ban(	ply,BPL.Punish.BanLength,BPL.Punish.BanMessage)
  elseif BPL.Punish.Type == "crash" then
    ply:SendLua(BPL.Punish.CustomLUARun);ply:Kick(BPL.Punish.KickMessage)
  end
end

local BPLEnforcementSAM = function(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  local SteamID32 = l_uSIDF64(l_SteamID64)
  if BPL.Punish.Type == "kick" then
    ply:Kick(BPL.Punish.KickMessage)
  elseif BPL.Punish.Type == "ban" then
    sam.player.ban_id(SteamID32, BPL.Punish.BanLength, BPL.Punish.BanMessage)
  elseif BPL.Punish.Type == "crash" then
    ply:SendLua(BPL.Punish.CustomLUARun);ply:Kick(BPL.Punish.KickMessage)
  end
end
-- Local Punish by SteamID64 Function.
local BPLPunishID = function(ply,TimeUntilDisconnect,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  if not l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) and not l_tHV(BPL_BannedSteamID, l_SteamID64) then return end
  l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_PID", TimeUntilDisconnect, 1, function()
      if BPL.AdminSystem == "SOURCE" then
        BPLEnforcementSource(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      elseif BPL.AdminSystem == "ULX" then
        BPLEnforcementULX(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      elseif BPL.AdminSystem == "SAM" then
        BPLEnforcementSAM(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      end
      l_pnt("[BPL] | " .. l_PlayerName .. "/" .. l_SteamID64 .. " was caught by BPL. - Current IP: " .. l_IPAddressSimple[1] .. " - Detection Method: [SteamID64] | " .. "IP Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple[1])))
  end)
end
-- Local Punish by IP Function.
local BPLPunishIP = function(ply,TimeUntilDisconnect,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  if not l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple) then return end
  l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_PIP", TimeUntilDisconnect, 1, function()
      if BPL.AdminSystem == "SOURCE" then
        BPLEnforcementSource(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      elseif BPL.AdminSystem == "ULX" then
        BPLEnforcementULX(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      elseif BPL.AdminSystem == "SAM" then
        BPLEnforcementSAM(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      end
      l_pnt("[BPL] | " .. l_PlayerName .. "/" .. l_SteamID64 .. " was caught by BPL. - Current IP: " .. l_IPAddressSimple[1] .. " - Detection Method: [IPAddress] | " .. "SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64)))
  end)
end
-- Local Anti-Family Share Function.
local BPLFamilyShare = function(ply,TimeUntilDisconnect,l_SteamID64,l_GModLicenseOwner,l_PlayerName)
  if l_SteamID64 == l_GModLicenseOwner then return end
  if l_tHV(BPL.FamilyShare.Ignore, l_SteamID64) then return end
  l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_FS", TimeUntilDisconnect, 1, function()
    if BPL.AdminSystem == "SOURCE" then
        BPLEnforcementSource(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      elseif BPL.AdminSystem == "ULX" then
        BPLEnforcementULX(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      elseif BPL.AdminSystem == "SAM" then
        BPLEnforcementSAM(ply,l_SteamID64,l_PlayerName,l_IPAddressSimple)
      end
      l_pnt("[BPL] | " .. l_PlayerName .. "/" .. l_SteamID64 .. " was caught by BPL. - Current IP: " .. l_IPAddressSimple[1] .. " - Detection Method: [FamilyShare] | " .. "SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64)) .. "IP Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple[1])))
  end)
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
  if BPL.EnablePunishment then BPLPunishID(ply,TimeUntilDisconnect,l_SteamID64,l_PlayerName,l_IPAddressSimple) end
  if BPL.EnableIPPunishment then BPLPunishIP(ply,TimeUntilDisconnect,l_SteamID64,l_PlayerName,l_IPAddressSimple) end
  if BPL.AntiFamilyShare then BPLFamilyShare(ply,TimeUntilDisconnect,l_SteamID64,l_GModLicenseOwner,l_PlayerName) end
end)
-- Removes the timer incase the player disconnects before code is executed on client.
l_hAd("PlayerDisconnected",BPL.CommunityName .. "_" .. BPL.TimerName .. "_TimerRemove", function(ply)
  local pl_sid64 = ply:SteamID64()
  if BPL.EnablePunishment then l_tRe(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_PID") end
  if BPL.EnableIPPunishment then l_tRe(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_PIP") end
  if BPL.AntiFamilyShare then l_tRe(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_FS") end
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