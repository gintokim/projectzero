local PANEL = {}

surface.CreateFont("animelife.settings.dropdown.value", {font = "Exo 2 Medium", size = 16, weight = 500, extended = true})
surface.CreateFont("animelife.settings.dropdown.text", {font = "Exo 2 Medium", size = 14, weight = 500, extended = true})

local icon_arrow = Material("animelife/f4menu/settings/icon_arrow.png")

AccessorFunc(PANEL, "value", "Value")
-- Determines whether the button is pressed or not
AccessorFunc(PANEL, "active", "Active", FORCE_BOOL)
AccessorFunc(PANEL, "root", "RealRoot")

function PANEL:Init()
    self:SetText("")

    self:SetValue("No values given")
    self:SetActive(false)
    self:SetRealRoot(self:GetParent())

    self.Choices = {}
    self.Children = {}
end

function PANEL:AddChoice(choice)
    self.Choices[#self.Choices + 1] = choice
end

function PANEL:SetSelectFunction(func)
    self.Function = func
end

function PANEL:HideChildren()
    for i = 1, #self.Children do
        if ValidPanel(self.Children[i]) then
            self.Children[i]:Remove()
            self.Children[i] = nil
        end
    end

    self:SetActive(false)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(6, 0, 0, w, h, Color(22, 23, 26))

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(icon_arrow)
    if self:GetActive() then
        surface.DrawTexturedRectRotated(w - 4 - 22, 10 + 4, 8, 8, 180)
    else
        surface.DrawTexturedRect(w - 8 - 22, 10, 8, 8)
    end

    draw.SimpleText(self:GetValue(), "animelife.settings.dropdown.value", 28, h / 2 - 2, Color(255, 255, 255), nil, 1)
end

function PANEL:DoClick()
    -- print("Total Elements:", #self.Choices)
    -- PrintTable(self.Choices)
    if !self:GetActive() then
        -- print("Creating panel")

        local x, y = self:GetPos()
        y = y + self:GetTall()
        x, y = self:GetRealRoot():LocalToScreen(x) + (self:GetWide() / 2) + 16, self:GetRealRoot():LocalToScreen(y) - 36
        for i = 1, #self.Choices do
            local choice_item = vgui.Create("DButton", self:GetRealRoot())
            choice_item:SetPos(x, y)
            choice_item:SetSize(self:GetWide(), 28)
            choice_item:SetText("")
            choice_item.Paint = function(panel, w, h)
                surface.SetDrawColor(0, 0, 0)
                surface.DrawRect(0, 0, w, h)

                local t = self.Choices[i]
                draw.SimpleText(t, "animelife.settings.dropdown.text", 28, h / 2, self:GetValue() == t and Color(255, 255, 255) or Color(175, 175, 175), nil, 1)
            end
            choice_item.DoClick = function()
                self:SetValue(self.Choices[i])

                self:HideChildren()

                if isfunction(self.Function) then
                    self.Function(i, self.Choices[i])
                end
            end

            table.insert(self.Children, choice_item)

            y = y + 28
        end

        self:SetActive(true)
    else
        -- print("Hiding panel")

        self:HideChildren()
    end
end

vgui.Register("animelife.settings.dropdown", PANEL, "DButton")