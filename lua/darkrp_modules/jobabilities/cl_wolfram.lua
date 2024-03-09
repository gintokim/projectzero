hook.Add("PreDrawHalos", "animelife.jobabilities.wolfram", function()
    if LocalPlayer():Team() ~= TEAM_WOLFRAM then return end

    local enemies = {}

    for _, ply in pairs(player.GetAll()) do
        if ply == LocalPlayer() then continue end
        if ply:GetNWFloat("animelife.jobabilities.wolfram.robot_vision", 0) > UnPredictedCurTime() then
            table.insert(enemies, ply)
        end
    end

    halo.Add(enemies, Color(255, 75, 75), 0, 0, 1, true, true)
end)