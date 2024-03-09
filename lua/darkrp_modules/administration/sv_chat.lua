module("administration", package.seeall)

hook.Add("PlayerSay", "animelife.administration.ManageChat", function(ply, msg)
    if ply:IsAdmin() then
        if msg == "!menu" || msg == "/menu" || msg == "!admin" || msg == "/admin" then
            OpenMenu(ply)
            return ""
        end
    end

    -- don't display banned player messages
    if ply:GetNWBool("animelife.administration.ban", false) or ply:GetNWBool("animelife.administration.jail", false) then
        return ""
    end

    -- muted players
    if ply.aniadmin_chatmute then
        return ""
    end
end)

hook.Add("PlayerCanSeePlayersChat", "animelife.administration.ChatMute", function(msg, team_chat, l, t)
    -- The speaker parameter does not have to be a valid Player object which happens when console messages are displayed for example
    if !IsValid(t) then return true end -- always display

    -- can't see muted player chat
    if t.aniadmin_chatmute then
        return false
    end

    -- can't see banned player chat
    if t:GetNWBool("animelife.administration.ban", false) or t:GetNWBool("animelife.administration.jail", false) then
        return false
    end
end)

hook.Add("PlayerCanHearPlayersVoice", "animelife.administration.ChatMute", function(l, t)
    -- can't hear muted player talk
    if t.aniadmin_voicemute then
        return false
    end

    -- can't hear banned player talk
    if t:GetNWBool("animelife.administration.ban", false) or t:GetNWBool("animelife.administration.jail", false) then
        return false
    end
end)

net.Receive("animelife.administration.chatmsg", function()
    // local admins = GetAdmins()
    // net.Start("animelife.administration.chatmsg")
    // net.Send(admins)
end)