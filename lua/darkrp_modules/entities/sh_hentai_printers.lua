-- GLOBALS_HENTAIPRINTERS_GIRLS = {
--     ["Common"] = {
--         Price = 3000,
--         Color = Color(),
--     },
--     ["Uncommon"] = {
--         Price = 6000,
--         Color = Color(),
--     },
--     ["Rare"] = {
--         Price = 10000,
--         Color = Color(),
--     },
--     ["Immortal"] = {
--         Price = 15000,
--         Color = Color(),
--     },
--     ["Immortal+"] = {
--         Price = 17000,
--         Color = Color(),
--         VIP = true
--     }
-- }

-- local ENT = {}

-- ENT.Base = "base_anim"
-- ENT.Type = "anim"

-- ENT.PrintName = "Hentai Printers!"
-- ENT.Author = "AnimeLife"

-- ENT.Model = Model("models/props_junk/TrashDumpster01a.mdl")
-- ENT.Spawnable = true
-- ENT.AdminOnly = true

-- ENT.RenderGroup = RENDERGROUP_BOTH

-- function ENT:SetupDataTables()
--     self:NetworkVar("Int", 0, "Girl")
--     self:NetworkVar("Int", 1, "Temperature")
--     self:NetworkVar("Int", 2, "Printed")
--     self:NetworkVar("Entity", 0, "PrinterOwner")
-- end

-- function ENT:Initialize()
--     if CLIENT then return end

--     self:SetModel(self.Model)
--     self:PhysicsInit(SOLID_VPHYSICS)

--     self:SetUseType(SIMPLE_USE)

--     local phys = self:GetPhysicsObject()
--     if IsValid(phys) then
--         phys:Wake()
--     end

--     self:SetTemperature(10)
-- end

-- function ENT:Explode()
--     local pos = self:GetPos()
--     local ef = EffectData()
--     ef:SetStart(pos)
--     ef:SetOrigin(pos)
--     ef:SetScale(1)
--     util.Effect("Explosion", ef)

--     if IsValid(self:GetPrinterOwner()) then 
--         DarkRP.notify(self:GetPrinterOwner(), 1, 4, DarkRP.getPhrase("money_printer_exploded")) 
--     end

--     SafeRemoveEntity(self)
-- end

-- function ENT:Think()
--     if self:WaterLevel() > 0 then
--         self:Explode()
--     end
-- end

-- if CLIENT then
--     function ENT:Initialize()
--         self:SetMaterial("debug/debugwhite")

--         local girl = self:GetGirl() or "Common"
--         self:SetColor(GLOBALS_HENTAIPRINTERS_GIRLS[girl].Color)
--     end

--     function ENT:Draw()
--         self:DrawModel()
--     end

--     function ENT:DrawTranslucent()
--     end
-- end

-- scripted_ents.Register(ENT, "animelife_hentaiprinter")