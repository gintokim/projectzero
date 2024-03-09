local background = Material("animelife/groups/background_tall.png")
local health0 = Material("animelife/groups/health_00.png")
local health1 = Material("animelife/groups/health_01.png")
local armor1 = Material("animelife/groups/armor_01.png")

FONT_WEIGHT_BOLD = 700
FONT_WEIGHT_REGULAR = 400
FONT_WEIGHT_LIGHT = 300
FONT_WEIGHT_MEDIUM = 500
FONT_WEIGHT_SEMIBOLD = 600

surface.CreateFont("animelife.groups", {font = "Exo 2 SemiBold", size = 12, weight = FONT_WEIGHT_SEMIBOLD, extended = true})

hook.Add("HUDPaint", "animelife.RenderGroup", function()
    if !IsValid(LocalPlayer()) then return end
    if LocalPlayer():GetNWString("animelife.group", NULL) == NULL then return end

    local x, y = 23, 18
    for _, ply in pairs(player.GetAll()) do
        if ply == LocalPlayer() then continue end
        if ply:GetNWString("animelife.group") ~= LocalPlayer():GetNWString("animelife.group") then
            continue
        end

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(background)
        surface.DrawTexturedRect(x, y, background:Width(), background:Height())

        local nick = ply:Nick()
        if utf8.len(nick) > 16 then
            nick = utf8.sub(nick, 1, 16) .. ".."
        end
        draw.SimpleText(nick, "animelife.groups", x + 17, y + (background:Height() / 2) - 2, Color(255, 255, 255), nil, 1)

        surface.SetMaterial(health0)
        surface.DrawTexturedRect(x + 93, y + 15, health0:Width(), health0:Height())

        render.SetScissorRect(x + 93, y + 15, x + 93 + (health0:Width() * (ply:Health() / 100)), y + 32, true)
            surface.SetMaterial(health1)
            surface.DrawTexturedRect(x + 93, y + 15, health1:Width(), health1:Height())
        render.SetScissorRect(0, 0, 0, 0, false)

        surface.SetMaterial(health0)
        surface.DrawTexturedRect(x + 93, y + 29, health0:Width(), health0:Height())

        render.SetScissorRect(x + 93, y + 15, x + 93 + (health0:Width() * (ply:Armor() / 100)), y + 38, true)
            surface.SetMaterial(armor1)
            surface.DrawTexturedRect(x + 93, y + 29, health1:Width(), health1:Height())
        render.SetScissorRect(0, 0, 0, 0, false)

        if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 256^2 then
            local world_pos = (ply:GetPos() + Vector(0, 0, 64)):ToScreen()
            draw.SimpleText(nick, "animelife.groups", world_pos.x, world_pos.y, Color(255, 255, 255, 100), 1, 1)
        end

        y = y + background:Height() + 2
    end
end)

hook.Add("PreDrawHalos", "animelife.RenderGroup", function()
    if !IsValid(LocalPlayer()) then return end
	local group = {}

	for _, ply in pairs(player.GetAll()) do
        if ply == LocalPlayer() then continue end
        if ply:GetNWString("animelife.group", "invalidgroupname") ~= LocalPlayer():GetNWString("animelife.group") then
            continue
        end
        
		group[#group + 1] = ply
	end

	halo.Add(group, Color(255, 255, 255), 0, 0, 2, true, true)
end)

local PANEL = {}

local background = Material("animelife/groups/menu/background.png")
local button = Material("animelife/groups/menu/button.png")
local icon_tick = Material("animelife/groups/menu/icon_tick.png")
local icon_circle = Material("animelife/groups/menu/icon_circle.png")
local icon_close = Material("animelife/groups/menu/icon_close.png")

surface.CreateFont("animelife.groups.invite.title", {font = "Exo 2", size = 29, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.groups.invite.subtitle", {font = "Exo 2", size = 19, weight = FONT_WEIGHT_BOLD, extended = true})

function PANEL:Init()
    self.CloseButton = vgui.Create("DButton", self)
    self.CloseButton:SetPos(ScrW() - 24 - 37, 27)
    self.CloseButton:SetSize(24, 24)
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

    self.InviteButton = vgui.Create("DButton", self)
    self.InviteButton:SetPos((ScrW() - 287) / 2, 787)
    self.InviteButton:SetSize(287, 92)
    self.InviteButton:SetText("")
    self.Send = {}
    self.InviteButton.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(button)
        surface.DrawTexturedRect(0, 0, w, h)

        draw.SimpleText("Отправить приглашение", "animelife.groups.invite.subtitle", w / 2, h / 2 + 4, Color(255, 255, 255), 1, 1)
    end
    self.InviteButton.DoClick = function(panel)
        if table.Count(self.Send) < 1 then return end

        self:AlphaTo(0, 0.25, 0, function(pnl)
            if ValidPanel(self) then
                self:Remove()
                self = nil
            end
        end)

        net.Start("animelife.groups.makeinvite")
            net.WriteString(util.TableToJSON(self.Send))
        net.SendToServer()
    end

    self.ListScroller = vgui.Create("DScrollPanel", self)
    self.ListScroller:SetPos(773, 286)
    self.ListScroller:SetSize(414, 485)
    local v_bar = self.ListScroller:GetVBar()
    v_bar:SetWide(4)
    v_bar.Paint = function() end
    v_bar.btnUp.Paint = function() end
    v_bar.btnDown.Paint = function() end
    v_bar.btnGrip.Paint = function(panel, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(89, 78, 87, 150))
    end
    
    local x, y = 2, 2
    for _, ply in pairs(player.GetAll()) do
        if ply == LocalPlayer() then continue end
        local check_button = vgui.Create("DButton", self.ListScroller)
        check_button:SetPos(x, y)
        check_button:SetSize(25, 25)
        check_button:SetText("")
        check_button.Checked = false
        check_button.Paint = function(panel, w, h)
            surface.SetDrawColor(255, 255, 255)
            if panel.Checked then
                surface.SetMaterial(icon_tick)
            else
                surface.SetMaterial(icon_circle)
            end
            surface.DrawTexturedRect(0, 0, w, h)
        end
        check_button.DoClick = function(panel)
            panel.Checked = !panel.Checked
            if panel.Checked then
                table.insert(self.Send, ply)
            else
                table.RemoveByValue(self.Send, ply)
            end
        end

        local player_label = vgui.Create("DLabel", self.ListScroller)
        player_label:SetText(ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]")
        player_label:SetFont("animelife.groups.invite.subtitle")
        player_label:SetColor(Color(89, 78, 87))
        player_label:SetPos(x + 25 + 10, y + 1)
        player_label:SizeToContents()

        y = y + 25 + 18
    end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 175)
    surface.DrawRect(0, 0, w, h)

    local width, height = background:Width(), background:Height()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(background)
    surface.DrawTexturedRect((w - width) / 2, (h - height) / 2, width, height)

    draw.SimpleText("Создайте группу", "animelife.groups.invite.title", w / 2, 163, Color(255, 255, 255), 1)
    draw.SimpleText("Выберите людей, которым хотите отправить приглашение", "animelife.groups.invite.subtitle", w / 2, 203, Color(255, 255, 255), 1)
end

vgui.Register("animelife.groups.invite", PANEL, "EditablePanel")

function OpenInviteMenu()
    local invite_menu = vgui.Create("animelife.groups.invite")
    invite_menu:SetSize(ScrW(), ScrH())
    invite_menu:MakePopup()
    invite_menu:SetAlpha(0)
    invite_menu:AlphaTo(255, 0.5)
end