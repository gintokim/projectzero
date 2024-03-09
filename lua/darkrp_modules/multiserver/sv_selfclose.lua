local allowed_to_join = {
    "76561198116672024", -- hsgr
}
hook.Add("CheckPassword", "animelife.multiserver.selfcloser", function(steam_id64)
    if !table.HasValue(allowed_to_join, steam_id64) then
        return false, "closed server - couldn't join"
    end
end)