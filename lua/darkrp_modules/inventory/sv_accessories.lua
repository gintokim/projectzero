local meta = FindMetaTable("Player")

module("inventory.accessories", package.seeall)

function meta:ChangeSkin(new)
    self:SetNWString("animelife.accessories.skin", new)
end

function meta:SetPet(pet)
    self:SetNWString("animelife.accessories.pet", pet)
end

function meta:SetAccessories(t, idx)
    local elem = List[idx]
    if !self.Accessories then
        self.Accessories = {}
    end

    self.Accessories[t] = {
        Name = elem.Name,
        Model = elem.Model,
        Offset = {
            x = 0, y = 0, z = 0,
            pitch = 0, yaw = 0, roll = 0
        }
    }

    self:SetNWString("animelife.accessories.head.model", elem.Model)
    self:SetNWFloat("animelife.accessories.head.offx", 0)
end

function meta:UpdateOffset(t, x, y, z, pitch, yaw, roll)
    self.Accessories[t].Offset.x = x
    self.Accessories[t].Offset.y = y
    self.Accessories[t].Offset.z = z
    self.Accessories[t].Offset.pitch = pitch
    self.Accessories[t].Offset.yaw = yaw
    self.Accessories[t].Offset.roll = roll

    self:SetNWString("animelife.accessories", util.TableToJSON(self.Accessories))
end