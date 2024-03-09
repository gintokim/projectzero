local gradient_additions = Material("animelife/hud/gradient_additions.png")

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
    local StartArrested = CurTime()
    local ArrestedUntil = msg:ReadFloat()

    Arrested = function(x, y)
        if CurTime() - StartArrested <= ArrestedUntil and LocalPlayer():getDarkRPVar("Arrested") then
            local timeleft = math.ceil((ArrestedUntil - (CurTime() - StartArrested)) * 1 / game.GetTimeScale())
            draw.SimpleText("В тюрьме: " .. timeleft, "animelife.Global.HUD_Money", x + 2, y, Color(0, 0, 0, 75), nil, TEXT_ALIGN_BOTTOM)
            draw.SimpleText("В тюрьме: " .. timeleft, "animelife.Global.HUD_Money", x, y, Color(255, 201, 201), nil, TEXT_ALIGN_BOTTOM)
        elseif !LocalPlayer():getDarkRPVar("Arrested") then
            Arrested = function() end
        end
    end
end)

hook.Add("HUDPaint", "animelife.jobabilities.government.renderhud", function()
    if !IsValid(LocalPlayer()) then return end
    if !LocalPlayer():Alive() then return end

    local lockdown = GetGlobalBool("DarkRP_LockDown")
    local wanted = LocalPlayer():getDarkRPVar("wanted")
    local arrested = LocalPlayer():getDarkRPVar("Arrested")
    if lockdown or wanted or arrested then
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(gradient_additions)
        surface.DrawTexturedRect(0, ScrH() - 85, 278, 85)

        local y = ScrH() - 16
        if lockdown then
            draw.SimpleText("Комендантский час", "animelife.Global.HUD_Money", 38, y, Color(0, 0, 0, 75), nil, TEXT_ALIGN_BOTTOM)
            draw.SimpleText("Комендантский час", "animelife.Global.HUD_Money", 36, y, Color(255, 201, 201), nil, TEXT_ALIGN_BOTTOM)

            y = y - 22
        end

        if wanted then
            local reason = tostring(LocalPlayer():getDarkRPVar("wantedReason"))
            draw.SimpleText("Объявлен в розыск: " .. reason, "animelife.Global.HUD_Money", 38, y, Color(0, 0, 0, 75), nil, TEXT_ALIGN_BOTTOM)
            draw.SimpleText("Объявлен в розыск: " .. reason, "animelife.Global.HUD_Money", 36, y, Color(255, 201, 201), nil, TEXT_ALIGN_BOTTOM)

            y = y - 22
        end

        if arrested then
            Arrested(36, y)
        end
    end
end)