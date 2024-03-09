sql.Query("CREATE TABLE IF NOT EXISTS animelife_reports_admin(SteamID TINYTEXT, Claimed SMALLINT, Reports MEDIUMTEXT, Scores MEDIUMTEXT)")
sql.Query("CREATE TABLE IF NOT EXISTS animelife_admin_leaderboard(NextClear TINYINT)")
sql.Query("CREATE TABLE IF NOT EXISTS animelife_admin_leaderboard_participants(SteamID TINYTEXT, Position TINYINT, Claimed SMALLINT, AvgScore TINYINT)")

module("administration", package.seeall)

Reports = Reports or {}

function NewReport(ply, target, reason)
    local idx = table.insert(Reports, {Player = ply, Target = target, Reason = reason, Time = os.time()})

    // local admins = GetAdmins()

    timer.Simple(600, function()
        table.remove(Reports, idx)
    end)
end

function GetAverageAdminScore(steam_id)
    local query = sql.Query("SELECT * FROM animelife_reports_admin WHERE SteamID = " .. SQLStr(steam_id))
    if istable(query) and #query > 0 then
        local scores = query[1].Scores
        scores = string.Split(scores, "+")
        local sum = 0
        for i = 1, #scores do
            sum = sum + tonumber(scores[i])
        end

        return sum / #scores
    end

    return 0
end

Leaderboards = Leaderboards or {}

function UpdateLeaderboard()
    local q = sql.Query("SELECT * FROM animelife_admin_leaderboard_participants")
    if istable(q) and #q > 0 then
        local leadboard_tbl = q
        table.sort(leadboard_tbl, function(a, b)
            return a.AvgScore > b.AvgScore and a.Claimed > b.Claimed
        end)

        Leaderboards = leadboard_tbl
    end
end

function ClearLeaderboard()
    Leaderboards = {}

    -- update & reschedule
    sql.Query("UPDATE animelife_admin_leaderboard SET NextClear = " .. os.time() + 604800)
    sql.Query("DROP TABLE IF EXISTS animelife_admin_leaderboard")
    sql.Query("CREATE TABLE IF NOT EXISTS animelife_admin_leaderboard_participants(SteamID TINYTEXT, Position TINYINT, Claimed SMALLINT, AvgScore TINYINT)")
end

timer.Create("animelife.administration.leaderboard_clear", 1200, 0, function()
    local q = sql.Query("SELECT * FROM animelife_admin_leaderboard")
    if istable(q) and #q > 0 then
        if tonumber(q[1].NextClear) < os.time() then
            ClearLeaderboard()
        end
    end
end)

timer.Create("animelife.administration.leaderboard_update", 300, 0, function()
    UpdateLeaderboard()
end)