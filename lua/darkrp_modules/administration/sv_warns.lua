sql.Query("CREATE TABLE IF NOT EXISTS animelife_warns(SteamID TINYTEXT, CuratorID TINYTEXT, Reason TINYTEXT, Date SMALLINT)")

module("administration", package.seeall)

function AddWarn(curator, admin, reason, date)
    if !isnumber(date) then return end
    reason = reason or "???"

    sql.Query("INSERT INTO animelife_warns(SteamID, CuratorID, Reason, Date) VALUES("
    .. SQLStr(admin:SteamID()) .. ", "
    .. SQLStr(curator:SteamID()) .. ", "
    .. SQLStr(reason) .. ", "
    .. date .. ")")
end

function GetWarns(admin)
    local query = sql.Query("SELECT * FROM animelife_warns WHERE SteamID = " .. SQLStr(admin:SteamID()))
    if istable(query) and #query > 0 then
        return query
    end

    return {}
end

timer.Create("animelife.administration.WarnThink", 600, 0, function()
    local t = sql.Query("SELECT * FROM animelife_warns")
    if istable(t) and #t > 0 then
        for _, v in pairs(t) do
            if tonumber(v.Date) < os.time() then
                sql.Query("DELETE FROM animelife_warns WHERE SteamID = " .. SQLStr(v.SteamID) .. " AND Reason = " .. SQLStr(v.Reason) .. " AND Date = " .. v.Date .. " AND CuratorID = " .. SQLStr(v.CuratorID))
            end
        end
    end
end)