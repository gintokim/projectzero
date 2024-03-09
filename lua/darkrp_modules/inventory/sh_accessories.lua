local meta = FindMetaTable("Player")

module("inventory.accessories", package.seeall)

List = {
    ["white_hat"] = {
        Name = "White Hat",
        Model = "models/nita/ph_resortmadness/fedora_2.mdl"
    }
}

TYPE_HEAD = 1
TYPE_FACE = 2
TYPE_BACK = 3

function meta:GetPet()
    return self:GetNWString("animelife.accessories.pet", "none")
end

function meta:GetSkin()
    return self:GetNWString("animelife.accessories.skin", "none")
end

function meta:GetAccessories()
    return {
        [TYPE_HEAD] = {
            Model = self:GetNWString("animelife.accessories.head.model", "models/error.mdl")
        }
    }
end

if CLIENT then
    -- hook.Add("PostPlayerDraw", "animelife.accessories.Render", function(ply)
    --     if !IsValid(ply) or !ply:Alive() then return end

    --     local accessories = ply:GetAccessories()
    --     -- print(accessories)
    --     if istable(accessories) and #accessories > 0 then
    --         if !ply.Accessories then ply.Accessories = {} end

    --         for t = 1, 3 do
    --             -- print(accessories[t])
    --             if istable(accessories[t]) then
    --                 if !IsValid(ply.Accessories[t]) then
    --                     ply.Accessories[t] = ClientsideModel(accessories[t].Model)
    --                     ply.Accessories[t]:SetNoDraw(true)
    --                 elseif IsValid(ply.Accessories[t]) and ply.Accessories[t]:GetModel() ~= accessories[t].Model then
    --                     ply.Accessories[t]:SetModel(accessories[t].Model)
    --                 elseif IsValid(ply.Accessories[t]) then
    --                     local item = ply.Accessories[t]
    --                     item:SetPos(ply:LocalToWorld(Vector(0, 0, 64)))
    --                     item:SetAngles(ply:LocalToWorldAngles(Angle(0, 0, 0)))
    --                     item:DrawModel()
    --                 end
    --             else
    --                 if IsValid(ply.Accessories[t]) then
    --                     ply.Accessories[t]:Remove()
    --                 end
    --             end
    --         end
    --     end
    -- end)
end