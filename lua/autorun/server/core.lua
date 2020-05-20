--[[
Welcome to BPL - Bad People List

About: This is used to deter people from playing on your server, either by crashing them, or making them think their steam ticket has been cancelled.
This should easily deter most people thrown on the list.

Addon Creator: QuirkyLarry - STEAM_0:0:80555260
]]
local l_hAd = hook.Add
local l_IVd = IsValid
local l_tHV = table.HasValue
local l_mrm = math.random
local l_mTe = math.Truncate
local l_pnt = print
local l_tCe = timer.Create
local l_tsg = tostring
local l_sgb = string.gsub
local l_ie = include
l_ie("bpl_config.lua")

-- [BPL] | Main Hook. Runs on only FIRST spawn.
l_hAd("PlayerInitialSpawn", "BPL_SoftDetectionSystem", function(ply)
  if not l_IVd(ply) then return end
  local TimeUntilDisconnect = l_mrm(BPL.MinTimeBeforePunish,BPL.MaxTimeBeforePunish)
  local l_SteamID64 = ply:SteamID64()
  local l_IPAddress = ply:IPAddress()
  local l_IPAddressSimple = l_sgb(l_IPAddress, ":27005", "") or l_sgb(l_IPAddress, ":27006", "") or l_sgb(l_IPAddress, ":27007", "") or l_sgb(l_IPAddress, ":27008", "")
  local l_PlayerName = ply:Nick()
  l_mTe(TimeUntilDisconnect, 0)
  -- Creates a timer to punish the player - SteamID64 Check.
  if l_tHV(BPL.BPL_SteamID64M, l_SteamID64) or l_tHV(BPL.BPL_SteamID64CB, l_SteamID64) then
      l_tCe("BPL_Punish_" .. l_SteamID64 .. "_Custom_Timer", TimeUntilDisconnect, 1, function()
          if not SoftPunishID then ply:SendLua( 'while true do end' ); ply:Kick("Steam auth ticket has been cancelled") else ply:Kick("Steam auth ticket has been cancelled") end
          l_pnt("[BPL] | " .. l_PlayerName .. " - " .. l_SteamID64 .. " attempted to play but was caught. - Their current IP: " .. l_IPAddressSimple .. " - Detection Method: [SteamID64] | " .. "IP Blacklisted: " .. l_tsg(l_tHV(BPL.BPL_IPs, l_IPAddressSimple)))
      end)
  elseif l_tHV(BPL.BPL_IPs, l_IPAddressSimple) then
      -- Creates a timer to punish the player - IP Check.
      l_tCe("BPL_Punish_" .. l_SteamID64 .. "_Custom_Timer", TimeUntilDisconnect, 1, function()
          if not SoftPunishIP then ply:SendLua( 'while true do end' ); ply:Kick("Steam auth ticket has been cancelled") else ply:Kick("Steam auth ticket has been cancelled") end
          l_pnt("[BPL] | " .. l_PlayerName .. " - " .. l_SteamID64 .. " attempted to play but was caught. - Their current IP: " .. l_IPAddressSimple .. " - Detection Method: [IPAddress] | " .. "SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.BPL_SteamID64M, l_SteamID64) or l_tHV(BPL.BPL_SteamID64CB, l_SteamID64)))
      end)
  end
end)
-- Removes timer incase player disconnects before code is executed.
l_hAd("PlayerDisconnected","BPL_Punish_Custom_Remove", function(ply)
  local pl_sid64 = ply:SteamID64()
  l_tR("BPL_Punish_" .. pl_sid64 .. "_Custom_Timer")
end)
l_pnt("[BPL] | " .. "Core has loaded. | " .. "Version Number: " .. BPL.VersionNumber)