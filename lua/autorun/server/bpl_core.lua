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

l_ie("bpl_config_main.lua")
l_ie("bpl_config_punishments.lua")
l_ie("bpl_config_familyshare.lua")

-- Local Punish by SteamID64 Function.
local BPLPunishID = function(ply,TimeUntilDisconnect,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  if not l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) then return end
  l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_PID", TimeUntilDisconnect, 1, function()
      if BPL.Punish.SoftPunishID then ply:Kick("Steam auth ticket has been cancelled") else ply:SendLua(BPL.Punish.HardPunishLUA); ply:Kick("Steam auth ticket has been cancelled") end
      l_pnt("[BPL] | " .. l_PlayerName .. " - " .. l_SteamID64 .. " attempted to play but was caught. - Their current IP: " .. l_IPAddressSimple[1] .. " - Detection Method: [SteamID64] | " .. "IP Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple[1])))
  end)
end
-- Local Punish by IP Function.
local BPLPunishIP = function(ply,TimeUntilDisconnect,l_SteamID64,l_PlayerName,l_IPAddressSimple)
  if not l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple) then return end
  l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_PIP", TimeUntilDisconnect, 1, function()
      if BPL.Punish.SoftPunishIP then ply:Kick("Steam auth ticket has been cancelled") else ply:SendLua(BPL.HardPunishLUA); ply:Kick("Steam auth ticket has been cancelled") end
      l_pnt("[BPL] | " .. l_PlayerName .. " - " .. l_SteamID64 .. " attempted to play but was caught. - Their current IP: " .. l_IPAddressSimple[1] .. " - Detection Method: [IPAddress] | " .. "SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64)))
  end)
end
-- Local Anti-Family Share Function.
local BPLFamilyShare = function(ply,l_SteamID64,l_GModLicenseOwner,TimeUntilDisconnect)
  if l_SteamID64 == l_GModLicenseOwner then return end
  if l_tHV(BPL.FamilyShare.Ignore, l_SteamID64) then return end
  l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_FS", TimeUntilDisconnect, 1, function()
    if BPL.FamilyShareBan then ply:Ban(BPL.FamilyShareBanLength,true) else ply:Kick("Family Shared accounts are not allowed.") end
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
  if BPL.AntiFamilyShare then BPLFamilyShare(ply,l_SteamID64,l_GModLicenseOwner,TimeUntilDisconnect) end
end)

-- Removes the timer incase the player disconnects before code is executed on client.
l_hAd("PlayerDisconnected",BPL.CommunityName .. "_" .. BPL.TimerName .. "_TimerRemove", function(ply)
  local pl_sid64 = ply:SteamID64()
  if BPL.EnablePunishment then l_tRe(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_PID") end
  if BPL.EnableIPPunishment then BPLPunishIP(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_PIP") end
  if BPL.AntiFamilyShare then BPLFamilyShare(BPL.CommunityName .. "_" .. pl_sid64 .. "_" .. BPL.TimerName .. "_FS") end
end)
l_pnt("[BPL] | " .. "Core has loaded. | " .. "v" .. BPL.VersionNumber)