local afk_messages = {
    "Отошел %s", "Спит уже %s",
    "Еще не вернулся %s", "Спит %s",
    "Нет на месте уже %s", "Меня нет уже %s",
    "Сплю... %s", "Витает в облаках %s",
    "Сгорели вафли, скоро буду. %s",
    "Я отошел %s", "Скоро буду %s",
    "Когда-нибудь вернусь %s",
    "Be right back! %s", "AFK %s"
}
local afk_message_delay = 15

hook.Add("PostDrawTranslucentRenderables", "animelife.afksystem.world_render", function()
    for _, ply in pairs(player.GetAll()) do
        if !IsValid(ply) or !ply:Alive() then continue end
        if ply:GetViewEntity() == LocalPlayer() then continue end
        if !ply:IsAFK() then continue end

        local dist = ply:GetPos():DistToSqr(LocalPlayer():GetViewEntity():GetPos())
        if dist > 256^2 then continue end

        local alpha = 1 - (1 * (dist / 256^2))

        if (ply.AFKNextMessage or 0) < CurTime() then
            ply.AFKMessage = table.Random(afk_messages)

            ply.AFKNextMessage = CurTime() + afk_message_delay
        end

        local afk_count = LocalPlayer():GetNWFloat("animelife.afksystem.count", 0.0)
        local kick_in = string.ToMinutesSeconds(math.ceil(-(afk_count - CurTime())))

        local display_message = ply.AFKMessage or afk_messages[1]
        display_message = string.format(display_message, kick_in)
        cam.Start3D2D(ply:GetPos() + Vector(10, 8, 48 + math.sin(CurTime() * 2) * 1.5), Angle(0, EyeAngles().y - 90, 90), 0.05)
            draw.SimpleText(display_message, "animelife.OverHUD.Job", 2, 2, Color(0, 0, 0, 150 * alpha), 1)
            draw.SimpleText(display_message, "animelife.OverHUD.Job", 0, 0, Color(255, 255, 255, 255 * alpha), 1)
        cam.End3D2D()
    end
end)