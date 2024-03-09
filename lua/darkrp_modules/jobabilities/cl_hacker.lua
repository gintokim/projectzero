hook.Add("HUDPaint", "animelife.jobabilities.hacker.renderhud", function()
    if !IsValid(LocalPlayer()) then return end
    if LocalPlayer():Team() ~= TEAM_HACKER then return end

    local pickpocket_ent = LocalPlayer():GetNWEntity("animelife.jobabilities.hacker.pickpocketing")
    if IsValid(pickpocket_ent) then
        if pickpocket_ent:GetPos():DistToSqr(LocalPlayer():GetPos()) > 150^2 then return end
        
        local pickpocket_time = LocalPlayer():GetNWFloat("animelife.jobabilities.hacker.pickpocket_time", 0)
        pickpocket_time = pickpocket_time - UnPredictedCurTime()

        local w = 128 * (pickpocket_time / 10)

        surface.SetDrawColor(32, 32, 32, 100)
        surface.DrawRect((ScrW() - 128) / 2, ScrH() / 2 - 32, 128, 8)

        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect((ScrW() - w) / 2, ScrH() / 2 - 32, w, 8)
    end
end)