module("chatbox", package.seeall)

function chatbox:Initialize(bool)
    _G.GLOBALS_CHATBOX = vgui.Create("animelife.chatbox")
    _G.GLOBALS_CHATBOX:SetPos(58, ScrH() - 375)
    _G.GLOBALS_CHATBOX:SetSize(585, 325)

    if bool then
        _G.GLOBALS_CHATBOX:Hide()
    end
end

function chatbox:CheckChatboxValidness()
    if !ValidPanel(_G.GLOBALS_CHATBOX) then 
        self:Initialize(false) 
    end
end

function GM:StartChat(t)
    chatbox:CheckChatboxValidness()

    if t then
        _G.GLOBALS_CHATBOX:Show("Local")
    else
        _G.GLOBALS_CHATBOX:Show("Server")
    end

    return true
end

function GM:FinishChat()
    chatbox:CheckChatboxValidness()

    _G.GLOBALS_CHATBOX:Hide()
end

function GM:ChatText(id, name, msg, chat_type, t)
    chatbox:CheckChatboxValidness()

    local ply = player.GetByID(id)
    local taipu = t or "Server"
    local color = Color(255, 255, 255)
    local team_color = Color(255, 255, 255)
    local display_name = ply.Nick and ply:Nick() or name
    local prefix = nil

    if chat_type == "chat" then
        if IsValid(ply) then
            team_color = ply:Team() == 1 and Color(194, 194, 194) or team.GetColor(ply:Team())
            prefix = ply:GetPrefix()
        end

        _G.GLOBALS_CHATBOX:AddChat(taipu, display_name, id, msg, team_color, prefix)
        chat.PlaySound() -- TODO: Replace default chat sound with something more pleasant
    elseif chat_type == "joinleave" then
        -- Do nothing. Yet.
    else
        _G.GLOBALS_CHATBOX:AddText(msg, color)
    end
end

if !chatAddText then chatAddText = chat.AddText end
function chat.AddText(...)
    chatbox:CheckChatboxValidness()

    local text = {}

    for _, obj in pairs({...}) do
        if type(obj) == "table" then
            if _G.GLOBALS_CHATBOX.TextPanel and _G.GLOBALS_CHATBOX.TextPanel.InsertColorChange then
                _G.GLOBALS_CHATBOX.TextPanel:InsertColorChange(obj.r, obj.g, obj.b, obj.a or 255)
            end

            table.insert(text, Color(obj.r, obj.g, obj.b, obj.a or 255))
        elseif type(obj) == "string" then
            if _G.GLOBALS_CHATBOX.TextPanel and _G.GLOBALS_CHATBOX.TextPanel.InsertMessage then
                _G.GLOBALS_CHATBOX.TextPanel:InsertMessage(tostring(obj))
            end

            table.insert(text, tostring(obj))
        end
    end

    if _G.GLOBALS_CHATBOX.TextPanel and _G.GLOBALS_CHATBOX.TextPanel.InsertMessage then
        _G.GLOBALS_CHATBOX.TextPanel:InsertMessage("\n")
    end

    chatAddText(...)

    return text
end

function GM:OnPlayerChat(ply, msg, team_only, dead)
    if IsValid(ply) and ply:IsPlayer() then
        local name
        if ply.Nick then
            name = ply:Nick()
        else
            name = "(Unknown Player)"
        end

        self:ChatText(ply:EntIndex(), name, msg, "chat")
    else
        self:ChatText(0, "(Unknown Player)", msg, "chat")
    end

    return true
end

hook.Add("PlayerBindPress", "animelife.chatbox.override", function(ply, bind, pressed)
    if !pressed then return end

    if bind == "messagemode" or bind == "messagemode2" then
        GAMEMODE:StartChat(bind == "messagemode2")
        return true
    end
end)

hook.Add("HUDShouldDraw", "animelife.chatbox.default", function(e)
    if e == "CHudChat" then
        return false
    end
end)