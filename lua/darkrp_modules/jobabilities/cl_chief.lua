hook.Add("PreDrawHalos", "animelife.jobabilities.chief", function()
    if LocalPlayer():Team() ~= TEAM_CHIEF then return end

    local wanted = {}

    for _, ply in pairs(player.GetAll()) do
        if ply:getDarkRPVar("wanted") then
            table.insert(wanted, ply)
        end
    end

    halo.Add(wanted, Color(75, 75, 255), 0, 0, 1, true, true)
end)