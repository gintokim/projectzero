local meta = FindMetaTable("Player")

module("levelee", package.seeall)

ascend_formula = function(n)
    return (100 * n) * (n / 2)
end

function meta:SetTreeLevel(lv)
    self:SetNWInt("animelife.levelee.level", lv)
end

function meta:AddTreeXP(xp)
    local last_xp = self:GetNWInt("animelife.levelee.xp", 0)
    self:SetNWInt("animelife.levelee.xp", last_xp + xp)
end

function meta:TransferXPToLevel()
    local xp = self:GetNWInt("animelife.levelee.xp", 0)

    -- nowhere to upgrade
    if xp <= 0 then return end

    -- reset xp var
    self:SetNWInt("animelife.levelee.xp", 0)

    local lv = self:GetNWInt("animelife.levelee.level", 0)
    local should_ascend = xp >= ascend_formula(lv)
    if should_ascend then
        self:SetTreeLevel(lv + 1)
        return
    end

    local last_save = self:GetNWInt("animelife.levelee.xp_bank", 0)
    self:SetNWInt("animelife.levelee.xp_bank", last_save + xp)
end