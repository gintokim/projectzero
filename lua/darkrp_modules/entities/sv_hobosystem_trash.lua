util.AddNetworkString("animelife.hobosystem.menu")
util.AddNetworkString("animelife.hobosystem.collect")

local HOBOKING_INCOME_PERCENT = 10

net.Receive("animelife.hobosystem.collect", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() ~= TEAM_HOBO and ply:Team() ~= TEAM_HOBOKING then return end
    if !ply:Alive() then return end

    local ent = net.ReadEntity()
    if !IsValid(ent) then return end
    if ent:GetClass() ~= "animelife_hobosystem_trash" then return end
    if ent:GetPos():DistToSqr(ply:GetPos()) > 256^2 then return end
    if ent:GetChilling() then return end

    ent:SetChilling(true)
    ent:SetChillingTime(UnPredictedCurTime() + (5 * 60))

    timer.Simple(5 * 60, function()
        if !IsValid(ent) then return end

        ent:SetChilling(false)
    end)

    local min_money = 0
    local max_money = 50
    local prize = math.random(min_money, max_money)

    ply:ChatPrint("В мусорке найдено: " .. prize .. "¥")

    achievements:UpdateProgress(ply, 1, 1)

    if prize < 1 then return end
    ply:addMoney(prize)

    local hobo_king = team.GetPlayers(TEAM_HOBOKING)[1]
    if IsValid(hobo_king) and (hobo_king ~= ply) then
        local income = math.ceil(prize * (HOBOKING_INCOME_PERCENT / 100))
        hobo_king:addMoney(income)
        DarkRP.notify(hobo_king, 0, 5, "Доход с мусорки: +" .. income .. "¥")
    end
end)

hook.Add("EntityTakeDamage", "animelife.hobosystem.abilities", function(target, dmg)
    if !IsValid(target) or !target:IsPlayer() then return end

    local attacker = dmg:GetAttacker()
    if !IsValid(attacker) or !attacker:IsPlayer() then return end
    if attacker:Team() ~= TEAM_HOBO and attacker:Team() ~= TEAM_HOBOKING then return end

    -- Hobo's have a chance of stealing some money
    -- whenever they attack
    local chance = math.random(1, 25)
    if chance == 13 then
        attacker:addMoney(25)

        if target:canAfford(25) then
            target:addMoney(-25)
        end

        DarkRP.notify(attacker, 0, 4, "Вы стащили " .. 25 .. "¥")
    end
end)