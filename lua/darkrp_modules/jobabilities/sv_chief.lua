hook.Add("EntityTakeDamage", "animelife.jobabilities.chief", function(target, dmg)
    if !IsValid(target) or !target:IsPlayer() then return end
    if target:Team() ~= TEAM_CHIEF then return end

    if target.SecondChanceAbility and (target:Health() + 1) <= dmg:GetDamage() then
        local ident = "animelife.jobabilities.chief.second_chance:" .. target:SteamID()
        if !timer.Exists(ident) then
            timer.Create(ident, 10, 1, function()
                if IsValid(target) and target:Alive() and target.SecondChanceAbility then
                    if target.SecondChanceAbilityKilled then
                        target:SetHealth(target:GetMaxHealth())
                        target:SetArmor(100)
                    else
                        target:Kill()
                    end

                    target.SecondChanceAbility = false
                    target.SecondChanceAbilityKilled = false
                end

                timer.Remove(ident)
            end)
        end

        return true
    end
end)

hook.Add("PlayerDeath", "animelife.jobabilities.chief", function(victim, _, attacker)
    if IsValid(attacker) and attacker:IsPlayer() then
        if attacker:Team() ~= TEAM_CHIEF then return end

        if attacker.SecondChanceAbility then
            attacker.SecondChanceAbilityKilled = true
        end
    end
end)

hook.Add("PlayerSpawn", "animelife.jobabilities.chief", function(ply)
    if ply:Team() ~= TEAM_CHIEF then return end

    ply.SecondChanceAbilityKilled = false 
    ply.SecondChanceAbility = false 
end)

-- not really a chief thing, but I don't want any more files
hook.Add("playerArrested", "animelife.achievements.cp", function(ply, time, arrester)
    if IsValid(arrester) and arrester:IsPlayer() then
        achievements:UpdateProgress(arrester, 7, 1)
    end
end)