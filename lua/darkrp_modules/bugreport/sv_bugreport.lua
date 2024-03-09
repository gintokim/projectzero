sql.Query("CREATE TABLE IF NOT EXISTS animelife_bugreport(SteamID TINYTEXT, Message MEDIUMTEXT, Links MEDIUMTEXT)")

module("bugreport", package.seeall)

function bugreport:Report(ply, text, links)
    if self:IsBanned(ply:SteamID()) then
        return
    end

   if (ply.NextBugReport or 0) > SysTime() then
       return
   end 

   -- TODO: Limit string length to (some)num

   sql.Query("INSERT INTO animelife_bugreport(SteamID, Message, Links) VALUES(" .. ply:SteamID() .. ", " .. text .. ", " .. links .. ")")

   -- Add cooldown
   ply.NextBugReport = SysTime() + 2
end

function bugreport:Delete(steam_id, text, links)
    
end

function bugreport:Ban(steam_id)
    
end

function bugreport:IsBanned(steam_id)
    return false
end