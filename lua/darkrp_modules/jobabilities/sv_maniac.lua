hook.Add("EntityTakeDamage", "animelife.jobabilities.maniac", function(target, dmg)
    if !IsValid(target) then return end

    local attacker = dmg:GetAttacker()
    if !IsValid(attacker) or !attacker:IsPlayer() then return end
    if attacker:Team() ~= TEAM_MANIAC then return end

    target:SetNWBool("animelife.jobabilities.maniac.footsteps", true)

    if !timer.Exists("animelife.jobabilities.maniac.footsteps") then
        timer.Create("animelife.jobabilities.maniac.footsteps", 15, 1, function()
            if IsValid(target) then
                target:SetNWBool("animelife.jobabilities.maniac.footsteps", false)
            end

            timer.Remove("animelife.jobabilities.maniac.footsteps")
        end)
    end
end)

hook.Add("PlayerSpawn", "animelife.jobabilities.maniac", function(ply)
    ply:SetNWBool("animelife.jobabilities.maniac.footsteps", false)
end)