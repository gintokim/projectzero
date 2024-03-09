local PANEL = {}

AccessorFunc(PANEL, "checked", "Checked", FORCE_BOOL)

function PANEL:Init()
    self:SetChecked(false)

    self:SetText("")

    self.ClickFunction = nil
end

function PANEL:DoClick()
    self:SetChecked(!self:GetChecked())

    if isfunction(self.ClickFunction) then
        self.ClickFunction(self, self:GetChecked())
    end
end

function PANEL:SetClickAction(func)
    self.ClickFunction = func
end

function PANEL:Paint(w, h)
    draw.RoundedBox(8, 0, 0, h, h, self:GetChecked() and Color(224, 172, 255) or Color(22, 23, 26))
end

vgui.Register("animelife.settings.checkbox", PANEL, "DButton")