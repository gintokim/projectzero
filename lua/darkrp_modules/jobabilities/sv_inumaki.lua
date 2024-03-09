hook.Add("PlayerSpawn", "animelife.jobabilities.inumaki", function(ply)
    if ply:Team() ~= TEAM_INUMAKI then return end

    ply:SetNWInt("animelife.jobabilities.inumaki.power", 0)
end)

local spells = {
    ["blastaway"] = {
        Commands = {"butt to be", "buttobe", "butobe", "blastaway", "blast away"},
        Cost = 50,
        Action = function(self, target)
            self:EmitSound("animelife/inumaki/buttobe.mp3")

            if IsValid(target) and target:IsPlayer() then
                target:TakeDamage(20, self, game.GetWorld())

                target:SetVelocity(self:GetShootPos() + self:GetForward() * 25000 + target:GetUp() * 64)
            end
        end
    },
    ["runaway"] = {
        Commands = {"nigero", "nigeru", "runaway", "ni ge ro", "nige ro", "ni gero"},
        Cost = 10,
        Action = function(self, target)
            self:EmitSound("animelife/inumaki/nigero.mp3")

            if IsValid(target) and target:IsPlayer() then
                local last_runspeed = target:GetRunSpeed()
                local last_speed = target:GetWalkSpeed()
                
                if last_runspeed == target:GetRunSpeed() then
                    target:SetRunSpeed(last_runspeed * 1.5)
                    target:SetWalkSpeed(last_speed * 1.5)

                    timer.Simple(15, function()
                        if !IsValid(target) then return end

                        target:SetRunSpeed(last_runspeed)
                        target:SetWalkSpeed(last_speed)
                    end)
                end
            end
        end
    },
    ["dontmove"] = {
        Commands = {"tamare", "ta ma re", "dontmove", "tama re", "ta mare", "tomare", "to mare", "toma re", "ugoku na", "ugokuna", "u go ku na"},
        Cost = 10,
        Action = function(self, target)
            self:EmitSound("animelife/inumaki/tomare.mp3")

            if IsValid(target) and target:IsPlayer() then
                if !target.InumakiFrozen then
                    target:Freeze(true)
                    target.InumakiFrozen = true

                    timer.Simple(3, function()
                        if !IsValid(target) then return end

                        target:Freeze(false)
                        target.InumakiFrozen = false
                    end)
                end
            end
        end
    },
    ["death"] = {
        Commands = {"death", "shine", "shi ne"},
        Cost = 100,
        Action = function(self, target)
            self:EmitSound("animelife/inumaki/spell.mp3")

            if IsValid(target) and target:IsPlayer() then
                target:TakeDamage(500, self, game.GetWorld())
                self:SetHealth(1)
            end
        end
    },
}

local function can_afford(ply, cost)
    return ply:GetNWInt("animelife.jobabilities.inumaki.power", 0) >= cost
end

hook.Add("PlayerSay", "animelife.jobabilities.inumaki", function(ply, msg)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() ~= TEAM_INUMAKI then return end
    
    local tr = ply:GetEyeTrace()
    local target = tr.Entity
    local t = ""
    if table.HasValue(spells["blastaway"].Commands, msg) then
        t = "blastaway"
    elseif table.HasValue(spells["runaway"].Commands, msg) then
        t = "runaway"
    elseif table.HasValue(spells["dontmove"].Commands, msg) then
        t = "dontmove"
    elseif table.HasValue(spells["death"].Commands, msg) then
        t = "death"
    end

    if spells[t] then
        if !IsValid(target) or !target:IsPlayer() then
            target = ply
        end
        
        if IsValid(target) and target:IsPlayer() then
            if can_afford(ply, spells[t].Cost) then
                spells[t].Action(ply, target)

                local last_power = ply:GetNWInt("animelife.jobabilities.inumaki.power", 0)
                ply:SetNWInt("animelife.jobabilities.inumaki.power", last_power - spells[t].Cost)

                achievements:UpdateProgress(ply, 13, 1)

                SendSkillHUDMessage(ply, "Заклинание использовано")
            else
                ply:ChatPrint("Недостаточно маны.")
            end
        else
            ply:ChatPrint("Нет человека под прицелом.")
        end

        return ""
    end
end)

timer.Create("animelife.jobabilities.inumaki.regeneration", 1, 0, function()
    for _, ply in pairs(player.GetHumans()) do
        if !IsValid(ply) or !ply:Alive() then continue end
        if ply:Team() ~= TEAM_INUMAKI then continue end
        local last_power = ply:GetNWInt("animelife.jobabilities.inumaki.power", 0)
        if last_power >= 100 then continue end

        ply:SetNWInt("animelife.jobabilities.inumaki.power", last_power + 2)
    end
end)