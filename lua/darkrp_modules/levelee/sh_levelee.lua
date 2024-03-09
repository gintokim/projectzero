local meta = FindMetaTable("Player")

module("levelee", package.seeall)

function meta:GetTreeXP()
    return self:GetNWInt("animelife.levelee.xp", 0)
end

function meta:GetTreeLevel()
    return self:GetNWInt("animelife.levelee.level", 0)
end