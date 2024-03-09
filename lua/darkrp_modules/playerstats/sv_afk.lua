module("afksystem", package.seeall)

function ResetAFK(ply)
    ply:SetNWBool("animelife.afksystem.afk", false)
    ply:SetNWFloat("animelife.afksystem.kick", CurTime() + 600)
    ply:SetNWFloat("animelife.afksystem.count", CurTime())
end

hook.Add("PlayerSay", "animelife.AFKCheckForChat", function(ply)
    if !IsValid(ply) then return end

    ResetAFK(ply)
end)

hook.Add("KeyPress", "animelife.AFKCheckForKeyPress", function(ply)
    if !IsValid(ply) or !ply:Alive() then return end

	ResetAFK(ply)
end)

hook.Add("PlayerPostThink", "animelife.AFKTimer", function(ply)
    local afk_kick = ply:GetNWFloat("animelife.afksystem.kick")
    if !afk_kick then return end
    
    local diff = afk_kick - CurTime()
    if diff < 540 then
        if !ply:GetNWBool("animelife.afksystem.afk", false) then
            ply:SetNWBool("animelife.afksystem.afk", true)
            ply:SetNWFloat("animelife.afksystem.count", CurTime())
        end
    end
end)