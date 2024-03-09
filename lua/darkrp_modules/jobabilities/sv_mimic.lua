hook.Add("EntityFireBullets", "animelife.jobabilities.mimic", function(ent)
    if !IsValid(ent) or !ent:IsPlayer() then return end
    if ent.MimicInvisible then
        ent.MimicInvisible = false
        ent:SetNWBool("animelife.jobabilities.mimic_nodraw", false)

        ent:SetNoDraw(false)
    end
end)

hook.Add("PlayerSpawn", "animelife.jobabilities.mimic", function(ply)
    if ply:GetNWBool("animelife.jobabilities.mimic_nodraw", false) then
        ply:SetNWBool("animelife.jobabilities.mimic_nodraw", false)
    end

    ply:SetNWEntity("animelife.jobabilities.mimic_masked", game.GetWorld())
end)

local function GetMimic(ply)
    for _, v in pairs(player.GetAll()) do
        if v:GetNWEntity("animelife.jobabilities.mimic_masked", nil) == ply then
            return v
        end
    end

    return nil
end

hook.Add("EntityTakeDamage", "animelife.jobabilities.mimic", function(target, dmg)
    if !IsValid(target) or !target:IsPlayer() then return end

    local masked_ent = target:GetNWEntity("animelife.jobabilities.mimic_masked", nil)
    if IsValid(masked_ent) and masked_ent:IsPlayer() then
        masked_ent:TakeDamageInfo(dmg)
    end
end)