surface.CreateFont("animelife.jobabilities.mimic", {font = "Exo 2 SemiBold", weight = 600, size = 18, extended = true})

hook.Add("HUDPaint", "animelife.jobabilities.mimic", function()
    if !IsValid(LocalPlayer()) then return end
    if LocalPlayer():Team() ~= TEAM_MIMIC then return end

    if LocalPlayer():GetNWBool("animelife.jobabilities.mimic_nodraw", false) then
        draw.DrawText("Активная способность:\nНевидимость", "animelife.jobabilities.mimic", ScrW() - 32 + 2, ScrH() / 2 - 32, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.DrawText("Активная способность:\nНевидимость", "animelife.jobabilities.mimic", ScrW() - 32, ScrH() / 2 - 32, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
    end

    local masked_ent = LocalPlayer():GetNWEntity("animelife.jobabilities.mimic_masked", nil)
    if IsValid(masked_ent) and masked_ent:IsPlayer() then
        draw.DrawText("Маскировка:\n" .. masked_ent:Nick(), "animelife.jobabilities.mimic", ScrW() - 32 + 2, ScrH() / 2 - 32, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.DrawText("Маскировка:\n" .. masked_ent:Nick(), "animelife.jobabilities.mimic", ScrW() - 32, ScrH() / 2 - 32, team.GetColor(masked_ent:Team()), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
    end
end)