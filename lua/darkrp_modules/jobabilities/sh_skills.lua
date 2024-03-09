module("skills", package.seeall)

local icon_fix = Material("animelife/skillsystem/skills/fix.png")
local icon_bigger = Material("animelife/skillsystem/skills/bigger.png")
local icon_smaller = Material("animelife/skillsystem/skills/smaller.png")
local icon_chance = Material("animelife/skillsystem/skills/second_chance.png")
local icon_invisible = Material("animelife/skillsystem/skills/invisible.png")
local icon_mask = Material("animelife/skillsystem/skills/mask.png")

List = {
    [14] = {
        [1] = {
            Name = "Ремонтный набор",
            Description = "Восстанавливает 70% здоровья",
            Cooldown = 60 * 3,
            Icon = icon_fix,
            OnPressed = function(ply)
                local new_health = ply:Health() + (ply:GetMaxHealth() * 0.7)
                new_health = math.Clamp(new_health, 0, ply:GetMaxHealth())
                ply:SetHealth(new_health)
            end,
        },
        [2] = {
            Name = "Стать больше",
            Description = "Делает вас больше",
            Cooldown = 1,
            Icon = icon_bigger,
            OnPressed = function(ply)
                local max_size = 2
                if ply:GetModelScale() < max_size then
                    local size = ply:GetModelScale() + 0.1
                    ply:SetModelScale(size)
                    ply:SetViewOffset(Vector(0, 0, 64 * size))
                    ply:SetViewOffsetDucked(Vector(0, 0, 28 * size))
                else
                    ply:ChatPrint("Достигнут максимальный размер модели.")
                    achievements:MarkCompleted(ply, 12)
                end
            end,
        },
        [3] = {
            Name = "Стать меньше",
            Description = "Делает вас меньше",
            Cooldown = 1,
            Icon = icon_smaller,
            OnPressed = function(ply)
                local min_size = 0.5
                if ply:GetModelScale() > min_size then
                    local size = ply:GetModelScale() - 0.1
                    ply:SetModelScale(size)
                    ply:SetViewOffset(Vector(0, 0, 64 * size))
                    ply:SetViewOffsetDucked(Vector(0, 0, 28 * size))
                else
                    ply:ChatPrint("Достигнут минимальный размер модели.")
                end
            end
        },
    },
    [9] = {
        [1] = {
            Name = "Второй шанс",
            Description = "Попробуйте снова",
            Cooldown = 60 * 10,
            Icon = icon_chance,
            OnPressed = function(ply)
                ply.SecondChanceAbility = true
            end,
        },
    },
    [15] = {
        [1] = {
            Name = "Переключить инвиз",
            Description = "Стрельба - выход из невидимости",
            Cooldown = 1,
            Icon = icon_invisible,
            OnPressed = function(ply)
                ply.MimicInvisible = !ply.MimicInvisible
                ply:SetNWBool("animelife.jobabilities.mimic_nodraw", ply.MimicInvisible)

                ply:SetNoDraw(ply.MimicInvisible)

                if ply:GetNWEntity("animelife.jobabilities.mimic_masked", game.GetWorld()) ~= game.GetWorld() then
                    local mdl = ply:getJobTable().model
                    ply:SetModel(isstring(mdl) and mdl or table.Random(mdl))
                    ply:SetNWEntity("animelife.jobabilities.mimic_masked", game.GetWorld())
                end
            end,
        },
        [2] = {
            Name = "Мимикрия",
            Description = "Маскировка под человека",
            Cooldown = 5,
            Icon = icon_mask,
            OnPressed = function(ply)
                local tr = ply:GetEyeTraceNoCursor()
                if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
                    if tr.Entity:GetPos():DistToSqr(ply:GetPos()) > 512^2 then
                        return
                    end

                    ply:SetNWEntity("animelife.jobabilities.mimic_masked", tr.Entity)

                    ply:SetModel(tr.Entity:GetModel())
                end
            end,
        },
    },
}