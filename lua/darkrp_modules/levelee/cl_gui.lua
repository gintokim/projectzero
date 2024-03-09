local PANEL = {}
local PANEL_BG_COLOR = Color(47, 38, 83)
local PANEL_MATERIAL_BACKGROUND = Material("animelife/levelee/background.png")
local PANEL_MATERIAL_LOGO = Material("animelife/levelee/logo.png")
local PANEL_MATERIAL_LVBASE = Material("animelife/levelee/level_base.png")
local PANEL_MATERIAL_STATSTEXT = Material("animelife/levelee/stats_text.png")
local PANEL_MATERIAL_LANTERN = Material("animelife/levelee/lantern.png")

function PANEL:Init()
    self.Scroll = vgui.Create("DScrollPanel", self)
    self.Scroll:Dock(FILL)

    self.MainSection = vgui.Create("DPanel", self.Scroll)
    self.MainSection.Paint = self.PaintMainSection
end

function PANEL:PerformLayout(w, h)
    self.MainSection:SetSize(w, 1781)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(PANEL_BG_COLOR)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:PaintMainSection(w, h)
    ui.DrawMaterial(PANEL_MATERIAL_BACKGROUND, (w - 1280) / 2, 0, 1280, 720, Color(255, 255, 255))
    ui.DrawMaterial(PANEL_MATERIAL_LOGO, (w - 719) / 2, 279, 719, 202, Color(255, 255, 255))
    ui.DrawMaterial(PANEL_MATERIAL_LVBASE, 0, 576, 613, 340, Color(255, 255, 255))
    ui.DrawMaterial(PANEL_MATERIAL_STATSTEXT, 502 - 96, 576 - 16, 192, 32, Color(255, 255, 255))

    local rot = math.sin(CurTime() * 2) * 5
    ui.Smooth(true, false)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(PANEL_MATERIAL_LANTERN)
        surface.DrawTexturedRectRotated(633 - 27, 888 - 27, 54, 54, rot)
    ui.Smooth(false, false)
end

vgui.Register("animelife.levelee.gui", PANEL, "EditablePanel")

-- local g = vgui.Create("animelife.levelee.gui")
-- g:SetSize(ScrW(), ScrH())
-- g:MakePopup()

-- concommand.Add("cgd", function()
--     g:Remove()
-- end)