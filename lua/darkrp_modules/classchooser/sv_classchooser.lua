util.AddNetworkString("animelife.classchooser.choose")

local function get_players(class)
    local count = 0
    for _, ply in pairs(player.GetAll()) do
        if ply:Team() == t then
            if ply:GetNWInt("animelife.classchooser.class", -1) == class then
                count = count + 1
            end
        end
    end

    return count
end

net.Receive("animelife.classchooser.choose", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    if !classchooser.List[ply:Team()] then return end
    if ply:GetNWInt("animelife.classchooser.class", -1) ~= -1 then return end

    local list = classchooser.List[ply:Team()]
    local class = net.ReadInt(16)
    if !list[class] then return end
    if get_players(class) >= list[class].Limit then return end

    ply:SetNWInt("animelife.classchooser.class", class)

    -- ply:SetMaxHealth(list[class].Stats.hp)
    -- ply:SetHealth(ply:GetMaxHealth())
    -- ply:SetArmor(list[class].Stats.armor)
end)

hook.Add("PlayerChangedTeam", "animelife.classchooser.changeteam", function(ply)
    if ply:GetNWInt("animelife.classchooser.class", -1) ~= -1 then
        ply:SetNWInt("animelife.classchooser.class", -1)
    end
end)