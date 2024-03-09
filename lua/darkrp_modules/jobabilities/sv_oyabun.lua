local function is_oyabun_around()
    for _, ply in pairs(player.GetAll()) do
        if ply:Team() == TEAM_YAKUZA then
            -- is oyabun?
            if ply:GetNWInt("animelife.classchooser.class", -1) == 1 then
                return true
            end
        end
    end

    return false
end

hook.Add("EntityTakeDamage", "animelife.jobabilities.oyabun", function(target, dmg)
    if !IsValid(target) or !target:IsPlayer() then return end
    if !target:isCP() then return end
    if !is_oyabun_around() then return end

    local attacker = dmg:GetAttacker()
    if !IsValid(attacker) or !attacker:IsPlayer() then return end
    if attacker:Team() ~= TEAM_YAKUZA then return end

    dmg:ScaleDamage(1.25)
end)

hook.Add("canWanted", "animelife.jobabilities.oyabun", function(target, actor)
    if target:Team() == TEAM_YAKUZA then
        -- is oyabun?
        if target:GetNWInt("animelife.classchooser.class", -1) == 1 then
            return false, "Главу Якудзы нельзя объявить в розыск."
        end
    end
end)