local ENT = {}

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.PrintName = "Мусорка"
ENT.Author = "AnimeLife"
ENT.Model = Model("models/props_junk/TrashDumpster01a.mdl")
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "Chilling")
    self:NetworkVar("Float", 0, "ChillingTime")
end

function ENT:Initialize()
    if CLIENT then return end

    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)

    self:SetChilling(false)
    self:SetChillingTime(0)

    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end
end

function ENT:Use(ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if ply:Team() ~= TEAM_HOBO and ply:Team() ~= TEAM_HOBOKING then
        ply:ChatPrint("Мусорка доступна только бездомным.")
        return
    end
    if self:GetChilling() then return end

    net.Start("animelife.hobosystem.menu")
        net.WriteEntity(self)
    net.Send(ply)
end

if CLIENT then
    surface.CreateFont("animelife.entities.dumpster", {font = "Roboto", size = 72, extended = true})
    surface.CreateFont("animelife.entities.dumpster2", {font = "Roboto", size = 32, extended = true})

    function ENT:Draw()
        self:DrawModel()
    end

    function ENT:DrawTranslucent()
        local dist = LocalPlayer():GetPos():DistToSqr(self:GetPos())
        if dist > 512^2 then return end

        local pos = self:LocalToWorld(Vector(20, 0, 0))
        local ang = self:LocalToWorldAngles(Angle(0, 90, 90))
        local scale = 0.08
        cam.Start3D2D(pos, ang, scale)
            local text = "Мусорка"
            draw.SimpleText(text, "animelife.entities.dumpster", 0, 2, Color(0, 0, 0, 75), 1, 1)
            draw.SimpleText(text, "animelife.entities.dumpster", 0, 0, Color(255, 255, 255), 1, 1)

            if self:GetChilling() then
                local chill_time = self:GetChillingTime() - UnPredictedCurTime()
                if chill_time > 0 then
                    chill_time = string.ToMinutesSeconds(chill_time)
                    draw.DrawText("Пусто\n" .. chill_time, "animelife.entities.dumpster2", 0, 54, Color(0, 0, 0, 25), 1, 1)
                    draw.DrawText("Пусто\n" .. chill_time, "animelife.entities.dumpster2", 0, 52, Color(255, 255, 255, 150), 1, 1)
                end
            end
        cam.End3D2D()
    end
end

scripted_ents.Register(ENT, "animelife_hobosystem_trash")