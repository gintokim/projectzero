local PANEL = {}

local background = Material("animelife/prefixes/background.png")
local icon_info = Material("animelife/prefixes/icon_info.png")
local icon_color = Material("animelife/prefixes/icon_color.png")
local icon_price = Material("animelife/prefixes/icon_price.png")
local icon_buy = Material("animelife/prefixes/icon_buy.png")

surface.CreateFont("animelife.prefix.store.title", {font = "Exo 2 Bold", size = 19, weight = 700, extended = true})
surface.CreateFont("animelife.prefix.store.info", {font = "Exo 2 Medium", size = 19, weight = 500, extended = true})
surface.CreateFont("animelife.prefix.store.button", {font = "Exo 2 SemiBold", size = 19, weight = 600, extended = true})
surface.CreateFont("animelife.prefix.store.item.name", {font = "Exo 2 Bold", size = 20, weight = 700, extended = true})
surface.CreateFont("animelife.prefix.store.item.desc", {font = "Exo 2 SemiBold", size = 16, weight = 600, extended = true})

function PANEL:Init()
    self:SetAlpha(0)
    self:AlphaTo(255, 0.25)

    self.CurrentTab = 1

    self.CloseButton = vgui.Create("DButton", self)
    self.CloseButton:SetText("")
    self.CloseButton.Paint = function() end
    self.CloseButton.DoClick = function()
        if ValidPanel(self) then
            self:Remove()
            self = nil
        end
    end

    local x, y = 725, 80
    for i = 1, 2 do
        local cat_btn = vgui.Create("DButton", self)
        cat_btn:SetPos(x, y)
        cat_btn:SetSize(213, 52)
        cat_btn:SetText("")
        cat_btn.Paint = function(panel, w, h)
            draw.RoundedBox(128, 0, 0, w, h, self.CurrentTab == i and Color(164, 117, 255) or Color(203, 179, 250))

            draw.SimpleText(i == 1 and "Префиксы" or "Статусы", "animelife.prefix.store.button", w / 2, h / 2, Color(255, 255, 255), 1, 1)
        end
        cat_btn.DoClick = function()
            self.CurrentTab = i

            if i == 2 then
                self.ScrollListPrefix:SetVisible(false)
                self.ScrollListStatus:SetVisible(true)
            else
                self.ScrollListPrefix:SetVisible(true)
                self.ScrollListStatus:SetVisible(false)
            end
        end

        x = x + 213 + 45
    end

    self.ScrollListPrefix = vgui.Create("DScrollPanel", self)
    local v_bar = self.ScrollListPrefix:GetVBar()
    v_bar:SetWide(4)

    self.ScrollListStatus = vgui.Create("DScrollPanel", self)
    self.ScrollListStatus:SetVisible(false)
    v_bar = self.ScrollListStatus:GetVBar()
    v_bar:SetWide(4)

    for i = 1, 2 do
        x, y = 53, 22
        for _, p in pairs(prefix.List[i == 1 and "chat" or "status"]) do
            local item_panel = vgui.Create("DPanel", i == 1 and self.ScrollListPrefix or self.ScrollListStatus)
            item_panel:SetPos(x, y)
            item_panel:SetSize(508, 88)
            item_panel.Paint = function(panel, w, h)
                draw.RoundedBox(16, 6, 4, w - 6, h - 4, Color(255, 255, 255))

                surface.SetDrawColor(isfunction(p.Color) and p.Color() or p.Color)
                surface.SetMaterial(icon_color)
                surface.DrawTexturedRect(0, 0, 20, 20)

                surface.SetFont("animelife.prefix.store.item.name")

                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(icon_price)
                surface.DrawTexturedRect(surface.GetTextSize(p.Name) + 35 + 8 + 6, 23 + 4, 16, 16)

                draw.SimpleText(p.Name, "animelife.prefix.store.item.name", 35 + 6, 22 + 4, Color(97, 96, 126))
                draw.SimpleText(string.Comma(p.Price) .. "¥", "animelife.prefix.store.item.name", surface.GetTextSize(p.Name) + 35 + 8 + 16 + 4 + 6, 22 + 4, Color(244, 149, 201))
                draw.SimpleText(p.Description, "animelife.prefix.store.item.desc", 35 + 6, 45 + 4, Color(202, 202, 210))
            end

            local buy_btn = vgui.Create("DButton", item_panel)
            buy_btn:SetText("")
            buy_btn:SetPos(item_panel:GetWide() - 36 - 40, 25)
            buy_btn:SetSize(40, 40)
            buy_btn.Paint = function(panel, w, h)
                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(icon_buy)
                surface.DrawTexturedRect(0, 0, w, h)
            end

            y = y + 88 + 12
        end
    end
end

function PANEL:PerformLayout(w, h)
    self.ScrollListPrefix:SetPos((w - 619) / 2, 240)
    self.ScrollListPrefix:SetSize(619, h)

    self.ScrollListStatus:SetPos((w - 619) / 2, 240)
    self.ScrollListStatus:SetSize(619, h)

    self.CloseButton:SetPos((w - 619) / 2 + 619 - 21 - 24, 18)
    self.CloseButton:SetSize(24, 24)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 150)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(background)
    surface.DrawTexturedRect((w - 619) / 2, 0, 619, 1080)

    draw.SimpleText("Префиксы и статусы", "animelife.prefix.store.title", w / 2, 33, Color(79, 78, 112), 1)

    surface.SetMaterial(icon_info)
    surface.DrawTexturedRect((w - 619) / 2 + 125, 160, 41, 41)

    draw.SimpleText(self.CurrentTab == 1 and "Префиксы отображаются перед ником в чате" or
    "Статус будет подвешен над вашей головой", "animelife.prefix.store.info", (w - 619) / 2 + 182, 171, Color(216, 216, 222))
end

vgui.Register("animelife.prefix.store", PANEL, "EditablePanel")

function OpenPrefixStore()
    local f = vgui.Create("animelife.prefix.store")
    f:SetSize(ScrW(), ScrH())
    f:MakePopup()
end