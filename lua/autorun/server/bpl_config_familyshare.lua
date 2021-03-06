-- Addon Creator: QuirkyLarry - STEAM_0:0:80555260 - 76561198121376248 - http://steamcommunity.com/profiles/76561198121376248
-- BPL Github: https://github.com/LarryIsTheBoss/BPL-BadPeopleList
BPL = BPL or {}
BPL.FamilyShare = BPL.FamilyShare or {}
-- [BPL] | Setting this to true will ban the player instead of kicking them.
-- Having PunishFamilyShare to true and FamilyShareBan to false will kick family shared accounts.
BPL.FamilyShare.Ban = false
-- [BPL] | Setting this to true will crash the player.
BPL.FamilyShare.Crash = false
-- [BPL] | Setting this to true will ban the Garry's Mod license owner instead of kicking them.
BPL.FamilyShare.BanOwner = false
-- [BPL] | How long to ban the family shared account.
-- If you would like the main account to be banned too please contact me to implement it.
BPL.FamilyShare.BanLength = 0
-- [BPL] | Whitelist of SteamID 64s for BPl Family Share to ignore.
-- Incase you would like to whitelist people.
BPL.FamilyShare.Ignore = {
-- EX: "STEAMID64","76561198121376248",
}