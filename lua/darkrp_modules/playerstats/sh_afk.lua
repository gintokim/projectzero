local meta = FindMetaTable( "Player" )
function meta:IsAFK()
    return self:GetNWBool("animelife.afksystem.afk", false)
end