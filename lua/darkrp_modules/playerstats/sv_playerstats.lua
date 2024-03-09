sql.Query("CREATE TABLE IF NOT EXISTS animelife_players(SteamID TINYTEXT, Likes TEXT, Dislikes TEXT, Background TINYINT, Backgrounds SMALLTEXT, Status TINYTEXT, Jails MEDIUMINT, Bans LONGTEXT)")

local meta = FindMetaTable("Player")

util.AddNetworkString("animelife.playerstats.status_change")
// util.AddNetworkString("animelife.playerstats.background_set")
util.AddNetworkString("animelife.playerstats.background_buy")
util.AddNetworkString("animelife.playerstats.like")
util.AddNetworkString("animelife.playerstats.dislike")

module("playerstats", package.seeall)

function RegisterPlayer(ply)
    local res = sql.Query("SELECT * FROM animelife_players WHERE SteamID = " .. SQLStr(ply:SteamID()))
    if istable(res) and #res > 0 then return end

    sql.Query("INSERT INTO animelife_players(SteamID, Likes, Dislikes, Background, Backgrounds, Status, Jails, Bans) VALUES("
    .. SQLStr(ply:SteamID()) .. ", " 
    .. SQLStr("") .. ", " 
    .. SQLStr("") .. ", " 
    .. 1 .. ", " 
    .. SQLStr("") .. ", "
    .. SQLStr("Нет статуса.") .. ", " 
    .. 0 .. ", " 
    .. SQLStr("[]") .. ")")

    print(sql.LastError())
end

function GetDatabaseValues(steam_id)
    local res = sql.Query("SELECT * FROM animelife_players WHERE SteamID = " .. SQLStr(steam_id))
	if istable(res) and #res > 0 then
		return res
	end

    return nil
end

function Like(ply, target)
    local dislikes = target:GetDislikes()
    if table.HasValue(string.Split(dislikes, ","), ply:SteamID()) then
        dislikes = string.Replace(dislikes, ply:SteamID() .. ",", "")
        target:SetDislikes(dislikes)
    end

    local likes = target:GetLikes()
    if table.HasValue(string.Split(likes, ","), ply:SteamID()) then
        likes = string.Replace(likes, ply:SteamID() .. ",", "")
    else
        likes = likes .. ply:SteamID() .. ","
    end

    target:SetLikes(likes)
end

function Dislike(ply, target)
    local likes = target:GetLikes()
    if table.HasValue(string.Split(likes, ","), ply:SteamID()) then
        likes = string.Replace(likes, ply:SteamID() .. ",", "")
        target:SetLikes(likes)
    end

    local dislikes = target:GetDislikes()
    if table.HasValue(string.Split(dislikes, ","), ply:SteamID()) then
        dislikes = string.Replace(dislikes, ply:SteamID() .. ",", "")
    else
        dislikes = dislikes .. ply:SteamID() .. ","
    end

    target:SetDislikes(dislikes)
end

function meta:SetLikes(str, nosave)
    self:SetNWString("animelife.playerstats.likes", str)

    if nosave then return end
    sql.Query("UPDATE animelife_players SET Likes = " .. SQLStr(str) .. " WHERE SteamID = " .. SQLStr(self:SteamID()))
end

function meta:SetDislikes(str, nosave)
    self:SetNWString("animelife.playerstats.dislikes", str)

    if nosave then return end
    sql.Query("UPDATE animelife_players SET Dislikes = " .. SQLStr(str) .. " WHERE SteamID = " .. SQLStr(self:SteamID()))
end

function meta:SetStatus(str)
    self:SetNWString("animelife.playerstats.status", str)
end

function meta:SetBackground(num)
    self:SetNWString("animelife.playerstats.background", num)
end

function meta:AddBackground(num, save)
    local last = self:GetBackgrounds()
    local new = last .. "," .. num
    self:SetNWString("animelife.playerstats.background.list", new)

    if save then
        sql.Query("UPDATE animelife_players SET Backgrounds = " .. SQLStr(new) .. " WHERE SteamID = " .. SQLStr(self:SteamID()))
    end
end

hook.Add("PlayerInitialSpawn", "animelife.DatabaseRestore", function(ply)
    timer.Simple(1, function()
        if !IsValid(ply) or !ply:IsPlayer() then return end

        local data = GetDatabaseValues(ply:SteamID())
        if istable(data) then
            local likes, dislikes = data[1].Likes, data[1].Dislikes
            local status, background = data[1].Status, data[1].Background

            ply:SetLikes(likes, true)
            ply:SetDislikes(dislikes, true)
            ply:SetStatus(status)
            ply:SetBackground(tonumber(background))

            local backgrounds = data[1].Backgrounds
            for _, num in pairs(string.Split(backgrounds, ",") or {}) do
                num = tonumber(num)
                if !isnumber(num) then continue end
                ply:AddBackground(num, false)
            end
        else
            RegisterPlayer(ply)
        end
    end)
end)

net.Receive("animelife.playerstats.status_change", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    
    local str = net.ReadString()
    if !isstring(str) then return end
    if utf8.len(str) > 64 then
        str = utf8.sub(str, 1, 64) .. "..."
    end

    ply:SetStatus(str)

    sql.Query("UPDATE animelife_players SET Status = " .. SQLStr(str) .. " WHERE SteamID = " .. SQLStr(ply:SteamID()))
end)

// net.Receive("animelife.playerstats.background_set", function(len, ply)
//     if !IsValid(ply) or !ply:IsPlayer() then return end

//     local bgi = net.ReadInt(16)

//     ply:SetBackground(bgi)
// end)

net.Receive("animelife.playerstats.background_buy", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local bgi = net.ReadInt(16)
    if ply:HasBackground(bgi) then 
        ply:SetBackground(bgi)
        sql.Query("UPDATE animelife_players SET Background = " .. bgi .. " WHERE SteamID = " .. SQLStr(ply:SteamID()))
        return 
    end

    ply:AddBackground(bgi, true)
end)

net.Receive("animelife.playerstats.like", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local target = net.ReadEntity()
    if target == ply then return end

    Like(ply, target)
end)

net.Receive("animelife.playerstats.dislike", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local target = net.ReadEntity()
    if target == ply then return end

    Dislike(ply, target)
end)