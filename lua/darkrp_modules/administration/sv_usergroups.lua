sql.Query("CREATE TABLE IF NOT EXISTS animelife_usergroups(SteamID TINYTEXT, Group TINYTEXT, Type TINYTEXT, Date SMALLINT)")

module("administration", package.seeall)

function AddUserToUsergroup(steam_id, group, t)
    if !steam_id then return end
    if !group then return end
    if !t then t = "chosen" end

    if group == "player" then
        sql.Query("DELETE FROM animelife_usergroups WHERE SteamID = " .. SQLStr(steam_id))
    else
        local query = sql.Query("SELECT * FROM animelife_usergroups WHERE SteamID = " .. SQLStr(steam_id))
        if istable(query) and #query > 0 then
            sql.Query("UPDATE animelife_usergroups SET Group = " .. SQLStr(group) .. ", Type = " .. SQLStr(t) .. ", Date = " .. os.time() .. " WHERE SteamID = " .. SQLStr(steam_id))
        else
            sql.Query("INSERT INTO animelife_usergroups(SteamID, Group, Type, Date) VALUES("
            .. SQLStr(steam_id) .. ", "
            .. SQLStr(group) .. ", "
            .. SQLStr(t) .. ", "
            .. os.time() .. ")")
        end
    end

    local ply = player.GetBySteamID(steam_id)
    if IsValid(ply) then
        ply:SetUserGroup(group)
    end
end