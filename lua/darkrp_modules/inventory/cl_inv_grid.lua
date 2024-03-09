local PANEL = {}

AccessorFunc(PANEL, "slot_size", "SlotSize", FORCE_NUMBER)
AccessorFunc(PANEL, "slot_count", "SlotAmount", FORCE_NUMBER)

function PANEL:Init()
    self:SetSlotSize(64)
    self:SetSlotAmount(30)

    self.Slots = {}

    self.SlotList = vgui.Create("DIconLayout", self)
    self.SlotList:SetSpaceX(9)
    self.SlotList:SetSpaceY(14)

    for i = 1, self:GetSlotAmount() do
        local slot_panel = vgui.Create("animelife.inventory.slot", self.SlotList)
        slot_panel:SetSize(64, 64)

        table.insert(self.Slots, slot_panel)
    end

    local v_bar = self:GetVBar()
    v_bar:SetWide(4)

    -- TODO: Add vertical bar paint
end

function PANEL:PerformLayout(w, h)
    self.SlotList:SetSize(w, h - 4)
end

vgui.Register("animelife.inventory.grid", PANEL, "DScrollPanel")