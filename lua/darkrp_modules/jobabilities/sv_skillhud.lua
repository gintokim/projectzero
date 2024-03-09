util.AddNetworkString("animelife.skillhud.notify")

function SendSkillHUDMessage(ply, text)
    net.Start("animelife.skillhud.notify")
        net.WriteString(text)
    net.Send(ply)
end