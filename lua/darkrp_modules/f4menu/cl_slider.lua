local PANEL = {}

local slider_drag = Material("animelife/f4menu/settings/slider_drag.png")

function PANEL:Init()
    self.Scratch:SetWide(0)
    self.Scratch:SetTall(0)

    self.TextArea:SetWide(0)
    self.TextArea:SetTall(0)

    self.Label:SetWide(0)
    self.Label:SetTall(0)

    self.Slider:SetHeight(4)
    self.Slider:SetWide(self:GetWide() * 4.3) -- wtf??
    self.Slider:SetNotchColor(Color(0, 0, 0, 0))
    self.Slider:Dock(NODOCK)
    self.Slider.Knob:SetSize(11, 11)
    self.Slider.Knob.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(slider_drag)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    local x, y = self.Slider:GetPos()
    self.Slider:SetPos(x, y + 4)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(4, 0, (h - 4) / 2, w, 4, Color(224, 172, 255, 75))
end

vgui.Register("animelife.settings.slider", PANEL, "DNumSlider")