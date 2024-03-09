hook.Add("lockpickTime", "animelife.jobabilities.hacker", function(ply)
    if IsValid(ply) and ply:IsPlayer() then
        if ply:Team() == TEAM_HACKER then
            return 4
        end
    end
end)

-- local PICKPOCKET_DURATION = 10
-- local PICKPOCKET_MINAMT = 5
-- local PICKPOCKET_MAXAMT = 50
-- hook.Add("PlayerUse", "animelife.jobabilities.hacker.pickpocket", function(ply, ent)
--     if ply:Team() ~= TEAM_HACKER then return end

--     if IsValid(ent) and ent:IsPlayer() then
--         if (ply.NextHackerPickpocket or 0) < SysTime() then
--             local ident = "animelife.jobabilities.hacker.pickpocket:" .. ply:SteamID() .. "-" .. ent:SteamID()
--             if !timer.Exists(ident) then
--                 ply:SetNWEntity("animelife.jobabilities.hacker.pickpocketing", ent)
--                 ply:SetNWFloat("animelife.jobabilities.hacker.pickpocket_time", UnPredictedCurTime() + PICKPOCKET_DURATION)

--                 timer.Create(ident, PICKPOCKET_DURATION, 1, function()
--                     if IsValid(ent) and ent:IsPlayer() and IsValid(ply) then
--                         local dist = ply:GetPos():DistToSqr(ent:GetPos())
--                         if dist < 150^2 then
--                             local win = math.random(PICKPOCKET_MINAMT, PICKPOCKET_MAXAMT)
--                             ent:addMoney(-win)
--                             ply:addMoney(win)
--                         end
--                     end

--                     if IsValid(ply) then
--                         ply:SetNWEntity("animelife.jobabilities.hacker.pickpocketing", game.GetWorld())
--                     end

--                     timer.Remove(ident)
--                 end)
--             end

--             ply.NextHackerPickpocket = SysTime() + PICKPOCKET_DURATION + 1
--         end
--     end
-- end)