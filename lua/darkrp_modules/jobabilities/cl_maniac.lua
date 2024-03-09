hook.Add("PlayerFootstep", "animelife.jobabilities.maniac.footsteps", function(ply, pos, foot)
    if LocalPlayer():Team() ~= TEAM_MANIAC then return end
    if !ply:GetNWBool("animelife.jobabilities.maniac.footsteps", false) then return end

    if !ply.ManiacFootsteps then
        ply.ManiacFootsteps = {}
    end

    table.insert(ply.ManiacFootsteps, {
        Pos = pos,
        Angle = ply:EyeAngles(),
        Foot = foot,
        Alpha = 1,
        DisappearTime = CurTime() + 5
    })
end)

local foot = Material("animelife/maniac/foot.png")
local foot_right = Material("animelife/maniac/foot_right.png")
hook.Add("PostDrawTranslucentRenderables", "animelife.jobabilities.maniac.footsteps", function()
    if LocalPlayer():Team() ~= TEAM_MANIAC then return end

    for _, ply in pairs(player.GetAll()) do
        if !ply:GetNWBool("animelife.jobabilities.maniac.footsteps", false) then continue end
        if !ply.ManiacFootsteps then continue end

        for key, step in pairs(ply.ManiacFootsteps or {}) do
            if step.Alpha <= 0 then
                table.remove(ply.ManiacFootsteps, key)
                continue
            end

            local dist = LocalPlayer():GetPos():DistToSqr(step.Pos)

            if dist < 1024^2 then
                local job_color = team.GetColor(ply:Team())
                cam.Start3D2D(step.Pos + Vector(0, 0, 1), Angle(0, step.Angle.y - 90, 0), 0.08)
                    surface.SetDrawColor(job_color.r, job_color.g, job_color.b, 255 * step.Alpha)
                    surface.SetMaterial(step.Foot == 1 and foot_right or foot)
                    surface.DrawTexturedRect(step.Foot == 1 and 72 or 0, 0, 144, 144)
                cam.End3D2D()
            end

            if step.DisappearTime < CurTime() then
                step.Alpha = math.Approach(step.Alpha, 0, FrameTime())
            end
        end
    end
end)