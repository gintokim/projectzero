util.AddNetworkString("animelife.f4menu")
util.AddNetworkString("animelife.f4menu.news.like_update")
util.AddNetworkString("animelife.f4menu.news.request_like_update")

local function get_update_likes()
    local entries = file.Read("animelife_update_likes.txt", "DATA")
    entries = string.Split(entries, ";")

    return #entries - 1
end

hook.Add("ShowSpare2", "animelife.f4menu", function(ply)
    net.Start("animelife.f4menu")
        net.WriteInt(get_update_likes(), 16)
    net.Send(ply)
end)

if !file.Exists("animelife_update_likes.txt", "DATA") then
    file.Write("animelife_update_likes.txt", "")
end

function f4menu_like_update(ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local entries = file.Read("animelife_update_likes.txt", "DATA")
    local steam_id = ply:SteamID()

    -- already liked it
    if entries:find(steam_id .. ";") then
        return
    end

    file.Append("animelife_update_likes.txt", steam_id .. ";")

    net.Start("animelife.f4menu.news.request_like_update")
        net.WriteInt(get_update_likes(), 16)
    net.Send(ply)
end

function f4menu_update_reset()
    file.Delete("animelife_update_likes.txt")

    file.Write("animelife_update_likes.txt", "")
end

net.Receive("animelife.f4menu.news.like_update", function(len, ply)
    f4menu_like_update(ply)
end)

hook.Add("playerCanChangeTeam", "animelife.jobs.wip", function(ply, team)
    if team == TEAM_HUNTER then
        return false, "Профессия недоступна к использованию."
    end
end)