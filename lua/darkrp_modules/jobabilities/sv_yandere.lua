util.AddNetworkString("animelife.jobabilities.yandere.menu")
util.AddNetworkString("animelife.jobabilities.yandere.decline")
util.AddNetworkString("animelife.jobabilities.yandere.accept")

function SendYandereRequest(yandere, target)
    local cutie = yandere:GetNWEntity("animelife.jobabilities.yandere.cutie", game.GetWorld())
    if IsValid(cutie) then
        return
    end

    if (target.NextYandereAsk or 0) > SysTime() then
        DarkRP.notify(yandere, 0, 5, "Игрок уже недавно отвечал на предложение.")
        return
    end

    net.Start("animelife.jobabilities.yandere.menu")
    net.Send(target)

    DarkRP.notify(yandere, 0, 5, "Запрос на установление связи отправлен " .. target:Nick())

    target.NextYandereAsk = SysTime() + 300
end

net.Receive("animelife.jobabilities.yandere.accept", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() == TEAM_YANDERE then return end

    local yandere = team.GetPlayers(TEAM_YANDERE)[1]
    if !IsValid(yandere) then return end

    local cutie = yandere:GetNWEntity("animelife.jobabilities.yandere.cutie", game.GetWorld())
    if IsValid(cutie) then
        return
    end

    yandere:SetNWEntity("animelife.jobabilities.yandere.cutie", ply)

    DarkRP.notify(yandere, 0, 5, ply:Nick() .. " принял ваше предложение.")
    DarkRP.notify(ply, 0, 5, "Установлена связь с яндере " .. yandere:Nick())

    target.NextYandereAsk = SysTime() + 300

    achievements:MarkCompleted(yandere, 9)
end)

net.Receive("animelife.jobabilities.yandere.decline", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() == TEAM_YANDERE then return end

    local yandere = team.GetPlayers(TEAM_YANDERE)[1]
    if IsValid(yandere) then
        DarkRP.notify(yandere, 1, 5, ply:Nick() .. " отказался от предложения.")
    end

    ply.NextYandereAsk = SysTime() + 300
end)

hook.Add("PlayerUse", "animelife.jobabilities.yandere", function(ply, ent)
    if ply:Team() ~= TEAM_YANDERE then return end

    if IsValid(ent) and ent:IsPlayer() then
        if (ply.YandereNextUse or 0) < SysTime() then
            SendYandereRequest(ply, ent)

            ply.YandereNextUse = SysTime() + 2
        end
    end
end)