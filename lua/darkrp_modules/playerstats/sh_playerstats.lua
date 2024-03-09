local meta = FindMetaTable("Player")

function meta:GetDislikes()
    return self:GetNWString("animelife.playerstats.dislikes", "")
end

function meta:GetLikes()
    return self:GetNWString("animelife.playerstats.likes", "")
end

function meta:GetStatus()
    return self:GetNWString("animelife.playerstats.status", "Нет статуса.")
end

function meta:GetBackground()
    return self:GetNWInt("animelife.playerstats.background", 1)
end

function meta:GetBackgrounds()
    return self:GetNWString("animelife.playerstats.background.list", "")
end

function meta:HasBackground(num)
    return table.HasValue(string.Split(self:GetBackgrounds(), ","), tostring(num))
end

GLOBALS_BACKGROUNDS = {
    ["scoreboard"] = {},
    ["store"] = {}
}

for _, f in pairs(file.Find("materials/animelife/scoreboard/backgrounds/*.png", "MOD") or {}) do
    local mat = Material("animelife/scoreboard/backgrounds/" .. f)
    // table.insert(GLOBALS_BACKGROUNDS["scoreboard"], mat)
    GLOBALS_BACKGROUNDS["scoreboard"][tonumber(string.StripExtension(f))] = mat
end

for _, f in pairs(file.Find("materials/animelife/bgstore/list/*.png", "MOD") or {}) do
    local mat = Material("animelife/bgstore/list/" .. f)
    GLOBALS_BACKGROUNDS["store"][tonumber(string.StripExtension(f))] = mat
end