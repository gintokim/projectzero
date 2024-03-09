local function findPlayer(obj)
    if isstring(obj) then
        -- SteamID case
        local sid, sid64 = player.GetBySteamID(obj), player.GetBySteamID64(obj)
        if IsValid(sid) then
            return sid
        elseif IsValid(sid64) then
            return sid64
        end

        -- Name case
        for _, ply in pairs(player.GetAll()) do
            if ply:GetName() == obj then
                return ply
            end
        end
    end

    return nil
end

concommand.Add("al_noclip", function(ply, cmd, args)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if !ply:IsAdmin() then return end

    local target = findPlayer(args[1])
    if !IsValid(target) then
        target = ply
    end
    
    administration.Noclip(ply, target)
end)