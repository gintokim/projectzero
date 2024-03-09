local PANEL = {}

AccessorFunc(PANEL, "item", "Item", FORCE_STRING)
AccessorFunc(PANEL, "style", "Style", FORCE_NUMBER)

surface.CreateFont("animelife.inventory.slot.tooltip", {font = "Roboto", size = 18, weight = 400, extended = true})

local PANEL_STYLES = {
    -- default
    [1] = {
        Outline = Color(0, 0, 0),
        Background = Color(46, 44, 57)
    },
    -- trading
    [2] = {
        Outline = Color(245, 165, 111),
        Background = Color(192, 192, 192, 0.42 * 255)
    }
}

function PANEL:Init()
    self:SetItem("none")
    self:SetStyle(1) -- set default style

    self:SetCursor("hand")

    self.PreviewModel = vgui.Create("SpawnIcon", self)
    self.PreviewModel:SetModel("models/error.mdl")
    self.PreviewModel:SetVisible(false)
    self.PreviewModel:SetMouseInputEnabled(false)
    self.PreviewModel:SetTooltip(false)
    self.PreviewModel.PaintOver = function() end -- remove blue outline on hover

    -- set up drag&drop feature
    self:Receiver("inv_slot_icon", function(receiver, tbl, dropped, idx, mx, my)
        if tbl[1]:GetItem() == "none" then
            return
        end

        print(receiver, tbl[1], dropped, idx, mx, my)
        if dropped then
            receiver:SetItem(tbl[1]:GetItem())
            tbl[1]:SetItem("none")
        end
    end, {})
    self:Droppable("inv_slot_icon")
end

function PANEL:SetModel(model)
    self.PreviewModel:SetModel(model)
    self.PreviewModel:SetVisible(true)
end

function PANEL:PerformLayout(w, h)
    self.PreviewModel:SetPos(12, 12)
    self.PreviewModel:SetSize(w - 24, h - 24)
end

function PANEL:InitTooltip()
    local tooltip = vgui.Create("DPanel", self:GetParent())
    tooltip:SetSize(146, 48)
    tooltip.Paint = function(panel, w, h)
        if self:GetItem() ~= "none" then
            -- draw.RoundedBox(4, 0, h, w, 16, Color(0, 0, 0, 150))
            draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 125))

            local item_name = inventory.ITEMS[self:GetItem()].Name
            draw.SimpleText(item_name, "animelife.inventory.slot.tooltip", w / 2, h / 2, Color(165, 166, 189), 1, 1)
        end
    end

    return tooltip
end

function PANEL:OnCursorEntered()
    if !ValidPanel(self.Tooltip) then
        self.Tooltip = self:InitTooltip()
    end
end

function PANEL:OnCursorExited()
    if ValidPanel(self.Tooltip) then
        self.Tooltip:Remove()
        self.Tooltip = nil
    end
end

function PANEL:Think()
    if ValidPanel(self.Tooltip) then
        -- local mx, my = self:CursorPos()
        local mx, my = self:GetPos()
        self.Tooltip:SetPos(mx - 36, my - 72)
    end

    if self:GetItem() ~= "none" then
        if !self.PreviewModel:IsVisible() then
            self.PreviewModel:SetVisible(true)
        end

        if !self:IsHovered() and self.Tooltip:IsVisible() then
            self.Tooltip:SetVisible(false)
        end
    end
end

function PANEL:Paint(w, h)
    local cur_style = self:GetStyle()

    surface.SetDrawColor(PANEL_STYLES[cur_style].Background)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(PANEL_STYLES[cur_style].Outline)
    surface.DrawOutlinedRect(0, 0, w, h, 1)
end

vgui.Register("animelife.inventory.slot", PANEL, "DPanel")