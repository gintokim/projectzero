-- Custom Taunt code is really messy
-- Makes it hard to maintain
hook.Add("CustomTauntCanPlay", "animelife.jobabilities.musiclover", function(ply, dance)
    if IsValid(ply) and ply:IsPlayer() then
        if ply:Team() == TEAM_MUSILY then return true end
    end

    -- fortnite dances
    return string.StartWith(dance, "f_")
end)

if CLIENT then
    local background = Material("animelife/musiclover/hud_background.png")
    local icon_vinyl = Material("animelife/musiclover/icon_vinyl.png")

    surface.CreateFont("animelife.jobabilities.musiclover.now_playing", {font = "Exo 2 SemiBold", weight = 600, size = 13, extended = true})
    surface.CreateFont("animelife.jobabilities.musiclover.track_name", {font = "Exo 2 Medium", weight = 500, size = 16, extended = true})

    local station_name = "Unknown Artist - Unknown Track"
    local fft_data = {}

    function BoomboxPlay(ply, snd, name)
        if IsValid(ply.AudioStation) then
            ply.AudioStation:Stop()
        end
        
        ply.AudioStation = nil

        station_name = name

        sound.PlayURL(snd, "3d", function(audio)
            if !IsValid(ply) then return end
            if IsValid(audio) then
                audio:SetVolume(1)
                audio:SetPos(ply:GetPos())
                ply.AudioStation = audio
            end
        end)
    end

    net.Receive("animelife.jobabilities.musiclover.play_track", function()
        local musily = net.ReadEntity()
        local snd = net.ReadString()
        local name = net.ReadString()

        BoomboxPlay(musily, snd, name)
    end)

    net.Receive("animelife.jobabilities.musiclover.stop_track", function()
        if IsValid(LocalPlayer().AudioStation) then
            LocalPlayer().AudioStation:Stop()
        end

        LocalPlayer().AudioStation = nil
    end)

    hook.Add("PlayerPostThink", "animelife.jobabilities.musiclover", function(ply)
        if !IsValid(ply) then return end

        if IsValid(ply.AudioStation) then
            if ply:Team() ~= TEAM_MUSILY then
                ply.AudioStation:Stop()
                ply.AudioStation = nil

                return
            end

            local station = ply.AudioStation
            if station:GetTime() >= station:GetLength() then
                ply.AudioStation = nil
            end

            station:SetPos(ply:GetPos())

            local volume = ply:GetNWFloat("animelife.jobabilities.musiclover.volume", 1)
            station:SetVolume(volume)
        end
    end)

    hook.Add("HUDPaint", "animelife.jobabilities.musiclover", function()
        if !IsValid(LocalPlayer()) then return end
        if LocalPlayer():Team() ~= TEAM_MUSILY then return end
        if !IsValid(LocalPlayer().AudioStation) then return end

        local audio_station = LocalPlayer().AudioStation

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(background)
        surface.DrawTexturedRect(ScrW() - 311, ScrH() / 2 - 85, 311, 85)

        local slap_force = 2
        local scale = 1 + ((fft_data and fft_data[1] or 0) * slap_force)
        local fftd = audio_station:FFT(fft_data, FFT_256)

        surface.SetDrawColor(242, 215, 255)
        surface.SetMaterial(icon_vinyl)
        ui.Smooth(true, false)
            surface.DrawTexturedRectRotated(ScrW() - 311 + 8, ScrH() / 2 - 85 + 8, 52 * scale, 52 * scale, 0)
        ui.Smooth(false, false)

        draw.SimpleText("Сейчас играет:", "animelife.jobabilities.musiclover.now_playing", ScrW() - 311 + 30, ScrH() / 2 - 85 + 28, Color(84, 94, 108))
        draw.SimpleText(station_name, "animelife.jobabilities.musiclover.track_name", ScrW() - 311 + 30, ScrH() / 2 - 85 + 44, Color(84, 94, 108))

        local pos = audio_station:GetTime()
        local len = audio_station:GetLength()

        surface.SetDrawColor(242, 215, 255)
        surface.DrawRect(ScrW() - 311 + 20, ScrH() / 2 - 85 + 70, 271 * (pos / len), 2)

        local volume = math.Round(LocalPlayer():GetNWFloat("animelife.jobabilities.musiclover.volume", 1) * 100)
        draw.SimpleText("Громкость: " .. volume .. "%", "animelife.Global.HUD_Money", ScrW() - 14, ScrH() / 2 + 12, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT)
        draw.SimpleText("Громкость: " .. volume .. "%", "animelife.Global.HUD_Money", ScrW() - 16, ScrH() / 2 + 12, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
    end)
end