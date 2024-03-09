module("prefix", package.seeall)

surface.CreateFont("animelife.OverHUD.Name", {font = "Exo 2", size = 75, weight = 700, extended = true})
surface.CreateFont("animelife.OverHUD.Job", {font = "Exo 2", size = 42, weight = 700, extended = true})

local volume = Material("animelife/hud/talking.png")

hook.Add("PostDrawTranslucentRenderables", "animelife.RenderPrefixStatus", function()
    for _, ply in pairs(player.GetAll()) do
        if !IsValid(ply) or !ply:Alive() then continue end
        -- if !ply.GetOverheadStatus or !ply:GetOverheadStatus() then continue end
        if ply:GetViewEntity() == LocalPlayer() then continue end
        if ply:GetNWBool("animelife.jobabilities.mimic_nodraw", false) then continue end

        local bone_head = ply:LookupBone("ValveBiped.Bip01_Head1") or 1
        bone_head = ply:GetBonePosition(bone_head)
        local pos = bone_head + Vector(0, 0, 17)
        local ang = Angle(0, EyeAngles().y - 90, 90)

        local dist = ply:GetPos():DistToSqr(LocalPlayer():GetViewEntity():GetPos())
        if dist > 256^2 then continue end
        local alpha = 1 - (1 * (dist / 256^2))
        local name = ply:Nick()
        local job = team.GetName(ply:Team())

        local class = classchooser.List[ply:Team()]
        if istable(class) then
            local actual_class = ply:GetNWInt("animelife.classchooser.class", -1)
            if actual_class ~= -1 then
                if istable(class[actual_class]) then
                    job = team.GetName(ply:Team()) .. " (" .. class[actual_class].Name .. ")"
                end
            end
        end

        local masked_ent = ply:GetNWEntity("animelife.jobabilities.mimic_masked")
        if IsValid(masked_ent) then
            name = masked_ent:Nick()
            job = team.GetName(masked_ent:Team())
        end

        cam.Start3D2D(pos, ang, 0.05)
            if ply:IsSpeaking() then
                surface.SetDrawColor(255, 255, 255, 255 * alpha)
                surface.SetMaterial(volume)
                surface.DrawTexturedRect(-64 / 2, -64, 64, 64)
            end

            draw.SimpleText(name, "animelife.OverHUD.Name", 2, 2, Color(0, 0, 0, 150 * alpha), 1)
            draw.SimpleText(name, "animelife.OverHUD.Name", 0, 0, Color(255, 255, 255, 255 * alpha), 1)
            draw.SimpleText(job, "animelife.OverHUD.Job", 2, 75 + 6 + 2, Color(0, 0, 0, 150 * alpha), 1)
            draw.SimpleText(job, "animelife.OverHUD.Job", 0, 75 + 6, Color(245, 184, 255, 255 * alpha), 1)

            local status = ply:GetOverheadStatus()
            if isnumber(status) then
                status = List["status"][status]
                local status_text = StatusFormat(status.Name)
                local status_color = isfunction(status.Color) and status.Color() or status.Color
                status_color = ColorAlpha(status_color, 255 * alpha)

                draw.SimpleText(status_text, "animelife.OverHUD.Job", 2, 75 + 42 + 12 + 2, Color(0, 0, 0, 150 * alpha), 1)
                draw.SimpleText(status_text, "animelife.OverHUD.Job", 0, 75 + 42 + 12, status_color, 1)
            end

            local is_robot = LocalPlayer():getJobTable().category == "Роботы"
            if is_robot then
                draw.SimpleText("Здоровье: " .. ply:Health(), "animelife.OverHUD.Job", -64 + 2, -56 + 2, Color(0, 0, 0, 150 * alpha), 2)
                draw.SimpleText("Здоровье: " .. ply:Health(), "animelife.OverHUD.Job", -64, -56, Color(255, 255, 255, 255 * alpha), 2)

                draw.SimpleText("Броня: " .. ply:Armor() .. "%", "animelife.OverHUD.Job", 64 + 2, -56 + 2, Color(0, 0, 0, 150 * alpha))
                draw.SimpleText("Броня: " .. ply:Armor() .. "%", "animelife.OverHUD.Job", 64, -56, Color(255, 255, 255, 255 * alpha))
            end
        cam.End3D2D()
    end
end)