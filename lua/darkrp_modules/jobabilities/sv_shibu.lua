local SHIBU_DAMAGE_AGR_RADIUS = 256

local function get_shibu_in_radius(pos)
    for _, ply in pairs(ents.FindInSphere(pos, SHIBU_DAMAGE_AGR_RADIUS)) do
        if !ply:IsPlayer() or !ply:Alive() then continue end
        if ply:Team() ~= TEAM_YAKUZA then continue end
        if ply:GetNWInt("animelife.classchooser.class", -1) == 4 then
            return ply
        end
    end

    return nil
end

hook.Add("EntityTakeDamage", "animelife.jobabilities.shibu", function(target, dmg)
    if !IsValid(target) or !target:IsPlayer() then return end
    if dmg:GetDamageType() == DMG_FALL then return end
    if target == dmg:GetAttacker() then return end

    local shibu = get_shibu_in_radius(target:GetPos())
    if target == shibu then return end
    if IsValid(shibu) and shibu:IsPlayer() then
        dmg:ScaleDamage(0.5)
        shibu:TakeDamage(dmg:GetDamage(), dmg:GetAttacker(), dmg:GetInflictor())
    end
end)