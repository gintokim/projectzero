local icon_energy = Material("animelife/hud/icon_energy.png")

hook.Add("HUDPaint", "animelife.jobabilities.inumaki.renderhud", function()
    if !IsValid(LocalPlayer()) then return end
    if LocalPlayer():Team() ~= TEAM_INUMAKI then return end
    if !LocalPlayer():Alive() then return end

    local customizations_y = cookie.GetNumber("animelife.settings_hud_posy", 945)
    local keep_default = tobool(cookie.GetNumber("animelife.settings_hud_pos_default", 0))
    if keep_default then
        customizations_y = 945
    end

    customizations_y = customizations_y + 102

    local power = LocalPlayer():GetNWInt("animelife.jobabilities.inumaki.power", 0)
    surface.SetFont("animelife.Global.HUD_Money")
    local w = 20 + surface.GetTextSize(power) + 24 + 2
    local x = (ScrW() - w) / 2

    surface.SetDrawColor(255, 243, 205)
    surface.SetMaterial(icon_energy)
    surface.DrawTexturedRect(x, customizations_y - 17 - 24, 20, 22)

    draw.SimpleText(power, "animelife.Global.HUD_Money", x + 24 + 2, customizations_y - 24, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    draw.SimpleText(power, "animelife.Global.HUD_Money", x + 24, customizations_y - 24, Color(255, 243, 205), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end)