local EXTRA_DAMAGE = 5
hook.Add("onHitCompleted", "animelife.jobabilities.hitman", function(hitman)
    if IsValid(hitman) then
        DarkRP.notify(hitman, 0, 5, "Заказ выполнен: +" .. EXTRA_DAMAGE .. " к урону")

        local last_damage = hitman:GetNWInt("animelife.jobabilities.hitman.extra_damage", 0)
        hitman:SetNWInt("animelife.jobabilities.hitman.extra_damage", last_damage + EXTRA_DAMAGE)

        achievements:UpdateProgress(hitman, 8, 1)
    end
end)

hook.Add("PlayerSpawn", "animelife.jobabilities.hitman", function(ply)
    if ply:Team() ~= TEAM_KILLER then return end

    ply:SetNWInt("animelife.jobabilities.hitman.extra_damage", 0)
end)

hook.Add("EntityTakeDamage", "animelife.jobabilities.hitman", function(target, dmg)
    if !IsValid(target) then return end

    local attacker = dmg:GetAttacker()
    if !IsValid(attacker) or !attacker:IsPlayer() then return end
    if attacker:Team() ~= TEAM_KILLER then return end

    local extra = attacker:GetNWInt("animelife.jobabilities.hitman.extra_damage", 0)
    if extra > 0 then
        dmg:AddDamage(extra)
    end
end)