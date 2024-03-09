local PANEL = {}

local background = Material("animelife/administration/background.png")
local icon_close = Material("animelife/administration/icon_close.png")
local hug_face = Material("animelife/administration/hug_face.png")
local leaderboard_background = Material("animelife/administration/leaderboard_background.png")
local box_stats = Material("animelife/administration/box_stats.png")
local box_warns = Material("animelife/administration/box_warns.png")
local box_chat = Material("animelife/administration/box_chat.png")
local icon_stats = Material("animelife/administration/icon_stats.png")
local icon_chat = Material("animelife/administration/icon_chat.png")
local icon_send = Material("animelife/administration/icon_send.png")
local chat_message = Material("animelife/administration/chat_message.png")
local chat_message_sent = Material("animelife/administration/chat_message_sent.png")

FONT_WEIGHT_BOLD = 700
FONT_WEIGHT_REGULAR = 400
FONT_WEIGHT_LIGHT = 300
FONT_WEIGHT_MEDIUM = 500
FONT_WEIGHT_SEMIBOLD = 600

surface.CreateFont("animelife.admin.title.semibold", {font = "Exo 2 SemiBold", size = 43, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.title.bold", {font = "Exo 2", size = 43, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.admin.title", {font = "Exo 2", size = 26, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.admin.date", {font = "Exo 2 SemiBold", size = 17, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.subtitle", {font = "Exo 2 SemiBold", size = 22, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.subtitle02", {font = "Exo 2 SemiBold", size = 24, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.subtitle03", {font = "Exo 2 SemiBold", size = 32, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.leaderboard.place", {font = "Exo 2", size = 12, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.admin.leaderboard.name", {font = "Exo 2", size = 14, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.admin.leaderboard.stats", {font = "Exo 2 SemiBold", size = 14, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.warn", {font = "Exo 2 SemiBold", size = 17, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.admin.warn02", {font = "Exo 2 SemiBold", size = 14, weight = FONT_WEIGHT_SEMIBOLD, extended = true})

GLOBALS_ADMINUI_CHAT = GLOBALS_ADMINUI_CHAT or {}

function PANEL:Init()
    self.CurrentTab = 1
    self.Warns = {}

    local x, y = 30, 96
    for i = 1, 2 do
        local tab_button = vgui.Create("DButton", self)
        tab_button:SetText("")
        tab_button:SetPos(x, y)
        tab_button:SetSize(24, 24)
        tab_button.Paint = function(panel, w, h)
            local mat = i == 1 and icon_stats or icon_chat
            surface.SetDrawColor(self.CurrentTab == i and Color(132, 173, 174) or Color(85, 91, 110))
            surface.SetMaterial(mat)
            surface.DrawTexturedRect((w - mat:Width()) / 2, (h - mat:Height()) / 2, mat:Width(), mat:Height())
        end
        tab_button.DoClick = function()
            if i == 2 then
                self.StatsTab:SetVisible(false)
                self.ChatTab:SetVisible(true)
            else
                self.StatsTab:SetVisible(true)
                self.ChatTab:SetVisible(false)
            end

            self.CurrentTab = i
        end

        y = y + 24 + 24
    end

    self.StatsTab = vgui.Create("DPanel", self)
    self.StatsTab.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(leaderboard_background)
        surface.DrawTexturedRect(w - 372, 0, 372, h)

        draw.SimpleText("Лучшие за неделю", "animelife.admin.title", w - 138 - 201 + 4, 54, Color(18, 16, 28))

        surface.SetDrawColor(247, 248, 250)
        surface.DrawRect(w - 26 - 313, 84, 313, 3)

        draw.RoundedBox(6, w - 295 - 44, 86, 44, 3, Color(195, 226, 230))

        draw.SimpleText(os.date("%d %B %Y", os.time()), "animelife.admin.date", 73, 67, Color(207, 206, 212))

        draw.SimpleText("Привет,", "animelife.admin.title.semibold", 73, 81, Color(20, 18, 30))
        draw.SimpleText(LocalPlayer():Nick() .. "!", "animelife.admin.title.bold", 192, 81, Color(20, 18, 30))

        surface.SetFont("animelife.admin.title.bold")

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(hug_face)
        surface.DrawTexturedRect(192 + surface.GetTextSize(LocalPlayer():Nick() .. "!") + 9, 90, 30, 30)

        draw.SimpleText("Статистика", "animelife.admin.subtitle", 107, 173, Color(20, 18, 30))

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(box_stats)
        surface.DrawTexturedRect(58, 193, 776, 230)

        local x, y, i = 286, 238, 1
        for _, v in pairs({
            {"На посту с", "23.03.2021"},
            {"Разобрано репортов", 0},
            {"Тип привилегии", LocalPlayer():GetNWString("animelife.administration.type", "наборный")},
            {"Ваше место в топе", 1}
        }) do
            draw.SimpleText(v[1], "animelife.admin.subtitle02", x, y, Color(80, 89, 102), 1)
            draw.SimpleText(v[2], "animelife.admin.subtitle03", x, y + 26, Color(144, 181, 182), 1)

            if i % 2 == 0 then
                y = y + 26 + 53
                x = 286
                i = 1
            else
                x = x + 286
                i = i + 1
            end
        end

        draw.SimpleText("Ваши предупреждения", "animelife.admin.subtitle", 107, 434, Color(20, 18, 30))

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(box_warns)
        surface.DrawTexturedRect(58, 456, 776, 393)

        if #self.Warns < 1 then
            draw.SimpleText("Всё хорошо. Предупреждений нет. <(￣︶￣)>", "animelife.admin.subtitle", 58 + (776 / 2), 456 + (393 / 2), Color(175, 175, 175), 1, 1)
        else
            if self.WarnsScroll.Items < 1 then
                draw.SimpleText("Предупреждения загружаются... ε=ε=ε=ε=┌(;￣▽￣)┘", "animelife.admin.subtitle", 58 + (776 / 2), 456 + (393 / 2), Color(175, 175, 175), 1, 1)
            end
        end
    end

    self.WarnsScroll = vgui.Create("DScrollPanel", self.StatsTab)
    self.WarnsScroll.Items = 0
    local v_bar = self.WarnsScroll:GetVBar()
    v_bar:SetWide(4)
    v_bar.Paint = function() end
    v_bar.btnUp.Paint = function() end
    v_bar.btnDown.Paint = function() end
    v_bar.btnGrip.Paint = function(panel, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 25))
    end

    timer.Simple(0.5, function()
        if !ValidPanel(self) then return end
        
        for _, warn in pairs(self.Warns) do
            local warn_item = vgui.Create("DPanel", self.WarnsScroll)
            warn_item:SetSize(680, 51)
            warn_item:Dock(TOP)
            warn_item:DockMargin(0, 8, 0, 0)
            warn_item.Paint = function(panel, w, h)
                draw.RoundedBox(6, 0, 0, w, h, Color(149, 148, 154))

                draw.RoundedBoxEx(6, w - 212, 0, 212, h, Color(134, 133, 139), false, true, false, true)

                draw.SimpleText("Выдано за: " .. warn.Reason, "animelife.admin.warn", 40, h / 2, Color(255, 255, 255), nil, 1)
                draw.SimpleText("Истекает: " .. os.date("%d.%m.%Y", warn.Date), "animelife.admin.warn02", w - (212 / 2), h / 2, Color(255, 255, 255), 1, 1)
            end

            self.WarnsScroll.Items = self.WarnsScroll.Items + 1
        end
    end)

    // self.NameLabel = vgui.Create("DLabel", self.StatsTab)
    // self.NameLabel:SetText("Привет,")
    // self.NameLabel:SetFont("animelife.admin.title.semibold")
    // self.NameLabel:SetColor(Color(20, 18, 30))
    // self.NameLabel:SizeToContents()

    // self.NameLabelBold = vgui.Create("DLabel", self.StatsTab)
    // self.NameLabelBold:SetText(LocalPlayer():Nick() .. "!")
    // self.NameLabelBold:SetFont("animelife.admin.title.bold")
    // self.NameLabelBold:SetColor(Color(20, 18, 30))
    // self.NameLabelBold:SizeToContents()

    self.Leaderboard = vgui.Create("DScrollPanel", self.StatsTab)

    for i = 1, 15 do
        local leaderboard_item = vgui.Create("DPanel", self.Leaderboard)
        leaderboard_item:SetSize(251, 81)
        leaderboard_item:Dock(TOP)
        leaderboard_item:DockMargin(0, 11, 0, 0)
        leaderboard_item.Paint = function(panel, w, h)
            draw.SimpleText("#" .. i, "animelife.admin.leaderboard.place", 9 + 36, 4, Color(185, 185, 188))
            draw.SimpleText("Nameless Player", "animelife.admin.leaderboard.name", 9 + 36, 4 + 12, Color(18, 16, 28))
            draw.DrawText("Разобранных репортов: 56\nСредняя оценка: 5", "animelife.admin.leaderboard.stats", 9 + 36, 4 + 12 + 14, Color(18, 16, 28))

            surface.SetDrawColor(158, 158, 158)
            surface.DrawRect(0, 0, 36, 36)

            surface.SetDrawColor(245, 245, 251)
            surface.DrawRect(18, 6 + 36, 2, 39)
        end

        local leaderboard_avatar = vgui.Create("AvatarImage", leaderboard_item)
        leaderboard_avatar:SetPos(0, 0)
        leaderboard_avatar:SetSize(36, 36)
        leaderboard_avatar:SetSteamID("7656119"..tostring(7960265728+math.random(1, 200000000)), 64)
    end

    self.ChatTab = vgui.Create("DPanel", self)
    self.ChatTab:SetVisible(false)
    self.ChatTab.Paint = function(panel, w, h)
        draw.SimpleText(os.date("%d %B %Y", os.time()), "animelife.admin.date", 73, 67, Color(207, 206, 212))

        draw.SimpleText("Чат", "animelife.admin.title.bold", 73, 81, Color(20, 18, 30))
        draw.SimpleText("5 администраторов в сети", "animelife.admin.date", 132, 100, Color(197, 197, 197))

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(box_chat)
        surface.DrawTexturedRect(58, 135, 1159, 742)

        draw.RoundedBox(6, 58 + 64, h - 112, 966, 55, Color(242, 242, 242, 255))
        if self.ChatEntry:GetValue() == "" then
            draw.SimpleText("Отправьте сообщение...", "animelife.admin.date", 58 + 64 + 41, h - 112 + 19, Color(75, 75, 75))
        end
    end

    self.ChatScroll = vgui.Create("DScrollPanel", self.ChatTab)
    local v_bar = self.ChatScroll:GetVBar()
    v_bar:SetWide(2)
    v_bar.Paint = function() end
    v_bar.btnUp.Paint = function() end
    v_bar.btnDown.Paint = function() end
    v_bar.btnGrip.Paint = function(panel, w, h) 
        draw.RoundedBox(4, 0, 0, w, h, Color(243, 247, 247))
    end

    local function insert_chat_message(text, time, sender)
        local msg_panel = vgui.Create("DPanel", self.ChatScroll)
        msg_panel:Dock(TOP)
        msg_panel:DockMargin(0, 24, 0, 0)
        msg_panel:SetSize(self.ChatScroll:GetWide(), 60)
        msg_panel.Paint = function(panel, w, h)
            // surface.SetDrawColor(255, 255, 255)
            // surface.SetMaterial(chat_message)
            // surface.DrawTexturedRect(0, 0, 226, 44)

            local message = markup.Parse("<font=animelife.admin.warn02><colour=49,51,63>" .. text .. "</colour></font>")
            
            if sender ~= LocalPlayer() then
                draw.RoundedBoxEx(12, 0, 0, message:GetWidth() + 20 + 20, message:GetHeight() + 14 + 14, Color(242, 242, 242), false, true, true, true)

                message:Draw(20, 14)

                draw.SimpleText("Nameless Player в " .. os.date("%H:%M", time), "animelife.admin.warn02", 12, (message:GetHeight() + 14 + 14) + 4, Color(128, 128, 128))
            else
                local width = message:GetWidth() + 20 + 20
                draw.RoundedBoxEx(12, w - width, 0, width, message:GetHeight() + 14 + 14, Color(239, 238, 253), true, false, true, true)

                message:Draw(w - 20, 14, TEXT_ALIGN_RIGHT)

                draw.SimpleText(os.date("%H:%M", time), "animelife.admin.warn02", w - 12, (message:GetHeight() + 14 + 14) + 4, Color(128, 128, 128), TEXT_ALIGN_RIGHT)
            end
        end

        return msg_panel
    end

    for _, msg in pairs(GLOBALS_ADMINUI_CHAT) do
        local pnl = insert_chat_message(msg.Text, msg.Time, msg.Sender)
    end

    self.ChatEntry = vgui.Create("DTextEntry", self.ChatTab)
    self.ChatEntry:SetDrawLanguageID(false)
    self.ChatEntry:SetFont("animelife.admin.date")
    self.ChatEntry.Paint = function(panel, w, h) 
        panel:DrawTextEntryText(Color(75, 75, 75), Color(0, 0, 0), Color(0, 0, 0))
    end

    self.SendButton = vgui.Create("DButton", self.ChatTab)
    self.SendButton:SetText("")
    self.SendButton.Paint = function(panel, w, h)
        draw.RoundedBox(6, 0, 0, w, h, Color(243, 247, 247))

        surface.SetDrawColor(144, 146, 151)
        surface.SetMaterial(icon_send)
        surface.DrawTexturedRect((w - 24) / 2, (h - 24) / 2, 24, 24)
    end
    self.SendButton.DoClick = function()
        local idx = table.insert(GLOBALS_ADMINUI_CHAT, {Sender = table.Random({LocalPlayer(), game.GetWorld()}), Time = os.time(), Text = self.ChatEntry:GetValue()})
        local cur = GLOBALS_ADMINUI_CHAT[idx]
        local pnl = insert_chat_message(cur.Text, cur.Time, cur.Sender)

        self.ChatEntry:SetValue("")
        // self.ChatScroll:ScrollToChild(self.ChatScroll:GetChildren()[5])
    end

    self.CloseButton = vgui.Create("DButton", self)
    self.CloseButton:SetText("")
    self.CloseButton.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(icon_close)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    self.CloseButton.DoClick = function()
        if ValidPanel(self) then
            self:Remove()
            self = nil
        end
    end
end

function PANEL:PerformLayout(w, h)
    self.CloseButton:SetPos(w - 24 - 34, 30)
    self.CloseButton:SetSize(24, 24)

    self.StatsTab:SetPos(88, 0)
    self.StatsTab:SetSize(1254, h)

    self.WarnsScroll:SetPos(102, 486)
    self.WarnsScroll:SetSize(776 - 88, 325)

    self.ChatTab:SetPos(88, 0)
    self.ChatTab:SetSize(1254, h)

    self.ChatEntry:SetPos(58 + 64 + 39, h - 112 + 16)
    self.ChatEntry:SetSize(966 - 39, 22)

    self.ChatScroll:SetPos(58 + 64, 152)
    self.ChatScroll:SetSize(1127 - (58 + 92), 636)

    self.SendButton:SetPos(w - 55 - 186, h - 112)
    self.SendButton:SetSize(55, 55)

    self.Leaderboard:SetPos(w - 372, 124)
    self.Leaderboard:SetSize(372, h - 124)

    // self.NameLabel:SetPos(73, 81)
    // self.NameLabelBold:SetPos(self.NameLabel:GetWide() + 73 + 8, 81)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(background)
    surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("animelife.administration", PANEL, "EditablePanel")

function OpenAdminMenu(warns)
    local a = vgui.Create("animelife.administration")
    if istable(warns) then
        a.Warns = warns
    end
    a:SetSize(1342, 903)
    a:Center()
    a:MakePopup()
    a:InvalidateLayout()
end

net.Receive("animelife.administration.menu", function()
    local len = net.ReadInt(32)
    local warns = net.ReadData(len)
    warns = util.Decompress(warns)
    warns = util.JSONToTable(warns)

    OpenAdminMenu(warns)
end)