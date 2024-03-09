surface.CreateFont("animelife.chathud", {font = "Roboto", size = 64, extended = true})

hook.Add("OnPlayerChat", "animelife.chat.append_hud_messages", function(ply, msg, t, alive)
    if IsValid(ply) and msg ~= "" and !t then
        AppendChat(ply, "«" .. msg .. "»")
    end
end)

function AppendChat(ply, msg)
    local text = {
        Message = msg,
        Player = ply,
        Alpha = 255,
        DisappearTime = CurTime() + 5
    }

    if !ply.ChatObject then
        ply.ChatObject = {}
    end

    table.insert(ply.ChatObject, 1, text)

    if #ply.ChatObject > 4 then
        table.remove(ply.ChatObject, #ply.ChatObject)
    end
end

hook.Add("PostDrawTranslucentRenderables", "animelife.chat.renderhud", function()
    for _, ply in pairs(player.GetHumans()) do
        if ply == LocalPlayer() then continue end
        local dist = ply:GetPos():DistToSqr(LocalPlayer():GetPos())
        if dist > 356^2 then continue end
        if !ply.ChatObject then continue end
        if #ply.ChatObject == 0 then continue end

        local bone_head = ply:LookupBone("ValveBiped.Bip01_Head1") or 1
        bone_head = ply:GetBonePosition(bone_head)
        local pos = bone_head + Vector(0, 0, 20)

        local ang = Angle(0, EyeAngles().y - 90, 90)

        cam.Start3D2D(pos, ang, 0.03)
            for key, chat in pairs(ply.ChatObject) do
                if chat.Alpha <= 0 then
                    table.remove(ply.ChatObject, key)
                    continue
                end

                if chat.DisappearTime < CurTime() then
                    chat.Alpha = math.Approach(chat.Alpha, 0, FrameTime() * 225)
                end

                surface.SetFont("animelife.chathud")
                local w = surface.GetTextSize(chat.Message)

                draw.WordBox(8, -w / 2, (key - 1) * -86, chat.Message, "animelife.chathud", Color(0, 0, 0, chat.Alpha / 1.5), Color(255, 255, 255, chat.Alpha))
            end
        cam.End3D2D()
    end
end)