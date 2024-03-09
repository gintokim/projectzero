local PANEL = {}

local gradient = Material("animelife/inventory/gradient.png")
local animelife_logo = Material("animelife/inventory/animelife_logo.png")

surface.CreateFont("animelife.inventory.category_button", {font = "Exo 2 SemiBold", size = 24, weight = 600, extended = true})
surface.CreateFont("animelife.inventory.category", {font = "Exo 2 SemiBold", size = 32, weight = 600, extended = true})
surface.CreateFont("animelife.inventory.money", {font = "Exo 2 SemiBold", size = 24, weight = 600, extended = true})
surface.CreateFont("animelife.inventory.slot_name", {font = "Exo 2 SemiBold", size = 19, weight = 600, extended = true})

function PANEL:Init()
    local x = 803
    for i = 1, 2 do
        local cat_btn = vgui.Create("DButton", self)
        cat_btn:SetText("")
        cat_btn:SetPos(x, 1017)
        cat_btn:SetSize(160, 30)
        cat_btn.Paint = function(panel, w, h)
            draw.SimpleText(i == 1 and "Инвентарь" or "Умения", "animelife.inventory.category_button", w / 2, 0, Color(228, 227, 232), 1)
            
            draw.RoundedBox(2, 0, h - 3, w, 3, i == 1 and Color(252, 50, 115) or Color(46, 44, 57))
        end

        x = x + 160 + 29
    end

    self.PreviewPanel = vgui.Create("DPanel", self)
    self.PreviewPanel.Paint = function(panel, w, h)
        surface.SetDrawColor(51, 48, 59)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText("Внешность", "animelife.inventory.category", 42, 31, Color(218, 217, 223))
        draw.SimpleText("¥1,459,235", "animelife.inventory.money", w - 42, 36, Color(218, 217, 223), 2)

        for _, slot in pairs({{392, 115, "Голова"}, {403, 247, "Лицо"}, {375, 379, "Спина"}, {316, 520, "Скин"}, {115, 506, "Питомец"}}) do
            draw.SimpleText(slot[3], "animelife.inventory.slot_name", slot[1] + (72 / 2), slot[2] + 72 + 8, Color(218, 217, 223), 1)
        end
    end

    for _, slot in pairs({{392, 115}, {403, 247}, {375, 379}, {316, 520}, {115, 506}}) do
        local slot_panel = vgui.Create("animelife.inventory.slot", self.PreviewPanel)
        slot_panel:SetPos(slot[1], slot[2])
        slot_panel:SetSize(72, 72)
    end

    self.AccessoriesPanel = vgui.Create("DPanel", self)
    self.AccessoriesPanel.Paint = function(panel, w, h)
        surface.SetDrawColor(51, 48, 59)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText("Аксессуары", "animelife.inventory.category", 42, 31, Color(218, 217, 223))
    end

    self.AccessoriesGrid = vgui.Create("animelife.inventory.grid", self.AccessoriesPanel)

    self.MainPanel = vgui.Create("DPanel", self)
    self.MainPanel.Paint = function(panel, w, h)
        surface.SetDrawColor(51, 48, 59)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText("Основное", "animelife.inventory.category", 42, 31, Color(218, 217, 223))
    end

    self.MainGrid = vgui.Create("animelife.inventory.grid", self.MainPanel)
    self.MainGrid.Slots[8]:SetModel("models/props_junk/PopCan01a.mdl")
end

function PANEL:PerformLayout(w, h)
    self.PreviewPanel:SetPos(111, 227)
    self.PreviewPanel:SetSize(527, 715)

    self.AccessoriesPanel:SetPos(658, 227)
    self.AccessoriesPanel:SetSize(610, 715)

    self.AccessoriesGrid:SetPos(54, 94)
    self.AccessoriesGrid:SetSize(self.AccessoriesPanel:GetWide() - 54 - 54, self.AccessoriesPanel:GetTall() - 94)

    self.MainPanel:SetPos(1288, 227)
    self.MainPanel:SetSize(557, 715)

    self.MainGrid:SetPos(54, 94)
    self.MainGrid:SetSize(self.MainPanel:GetWide() - 54 - 54, self.MainPanel:GetTall() - 94)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(gradient)
    surface.DrawTexturedRect(0, 0, w, h)

    surface.SetMaterial(animelife_logo)
    surface.DrawTexturedRect((w - 345) / 2, 45, 345, 101)
end

function PANEL:Think()
    if input.IsKeyDown(KEY_I) then
        self:Remove()
        self = nil
    end
end

vgui.Register("animelife.inventory", PANEL, "DFrame")

-- local inv = vgui.Create("animelife.inventory")
-- inv:SetSize(ScrW(), ScrH())
-- inv:MakePopup()