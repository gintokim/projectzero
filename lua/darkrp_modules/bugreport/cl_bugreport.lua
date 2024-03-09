local PANEL = {}

local background = Material("animelife/bugreport/background.png")
local icon_close = Material("animelife/bugreport/icon_close.png")
local detail_girl = Material("animelife/bugreport/detail_girl.png")
local detail_bug = Material("animelife/bugreport/detail_bug.png")
local button_send = Material("animelife/bugreport/button_send.png")
local button_link = Material("animelife/bugreport/button_link.png")

surface.CreateFont("animelife.bugreport.title", {font = "Exo 2 Bold", size = 64, weight = 700, extended = true})
surface.CreateFont("animelife.bugreport.expla", {font = "Exo 2", size = 26, extended = true})
surface.CreateFont("animelife.bugreport.expla_small", {font = "Exo 2", size = 22, extended = true})

function PANEL:Init()
    self.CloseButton = vgui.Create("DButton", self)
    self.CloseButton:SetText("")
    self.CloseButton.Paint = function(pnl, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(icon_close)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    self.CloseButton.DoClick = function()
        if ValidPanel(self) then
            self:Remove()
        end
    end
end

function PANEL:PerformLayout(w, h)
    local x, y = (w - 1068) / 2, (h - 715) / 2

    self.CloseButton:SetSize(24, 24)
    self.CloseButton:SetPos(x + 1068 - 40 - 24, y + 33)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(255, 255, 255)

    local x, y = (w - 1068) / 2, (h - 715) / 2
    -- surface.SetMaterial(background)
    -- surface.DrawTexturedRect(x, y, 1068, 715)
    draw.RoundedBox(16, x, y, 1068, 715, Color(255, 255, 255))

    surface.SetMaterial(detail_girl)
    surface.DrawTexturedRect(x + 512, y + 97, 715, 629)

    surface.SetMaterial(detail_bug)
    surface.DrawTexturedRect(x + 57, y + 40, 210, 210)

    draw.DrawText("Помогите нам\nисправить ошибки", "animelife.bugreport.title", x + 104, y + 132, Color(75, 75, 75))
    draw.DrawText("вы можете выслать предложения по\nулучшению качества сервера или указать\nна ошибки", "animelife.bugreport.expla", x + 104, y + 270, Color(75, 75, 75))

    -- Hardcoded bans
    if table.HasValue(bugreport.BannedPlayers, LocalPlayer():SteamID()) then
        draw.DrawText("Функция отправки предложений и багов вам\nнедоступна", "animelife.bugreport.expla", x + 104, y + 365, Color(255, 75, 75))
        draw.DrawText("Скорее всего, вы совершали спам-рассылку или\nиспользовали это окно не по назначению", "animelife.bugreport.expla_small", x + 104, y + 440, Color(75, 75, 75))
    end
end

vgui.Register("animelife.bugreport", PANEL, "EditablePanel")

module("bugreport", package.seeall)

function bugreport:ClientMenu()
    local br = vgui.Create("animelife.bugreport")
    br:SetSize(ScrW(), ScrH())
    br:MakePopup()
    br:SetAlpha(0)
    br:AlphaTo(255, 0.25)
end
-- bugreport:ClientMenu()