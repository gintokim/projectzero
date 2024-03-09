local meta = FindMetaTable("Player")

module("prefix", package.seeall)

List = {
    ["chat"] = {
        [1] = {
            Name = "Крутой",
            Color = Color(245, 184, 255),
            Description = [[Описание товара]],
            Price = 1500,
            Expires = {18585954, 19548473},
        }
    },
    ["status"] = {
        [1] = {
            Name = "Патрик",
            Color = function() return HSVToColor((CurTime() * 25) % 360, 0.5, 1) end,
            Description = [[Описание товара]],
            Price = 3500,
        }
    },
}

function CanBuy(t, idx)
    local e = List[t][idx]
    local from, to = e.Expires[1], e.Expires[2]
    return os.time() >= from and os.time() <= to
end

function StatusFormat(status)
    if !status then return "" end
    return status
end

function meta:GetOverheadStatus()
    return self:GetNWInt("animelife.customizations.status", false)
end

function meta:GetPrefix()
    return self:GetNWInt("animelife.customizations.prefix", false)
end