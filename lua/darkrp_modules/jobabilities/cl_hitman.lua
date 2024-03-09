local PANEL = {}
local minHitDistanceSqr = GM.Config.minHitDistance * GM.Config.minHitDistance

AccessorFunc(PANEL, "hitman", "Hitman")
AccessorFunc(PANEL, "target", "Target")
AccessorFunc(PANEL, "selected", "Selected")

local background = Material("animelife/hitman/background.png")
local line_mat = Material("animelife/hitman/line.png")

surface.CreateFont("animelife.hitmenu.title", {font = "Exo 2", weight = 700, size = 32, extended = true})
surface.CreateFont("animelife.hitmenu.name", {font = "Exo 2", weight = 700, size = 18, extended = true})
surface.CreateFont("animelife.hitmenu.price", {font = "Exo 2", weight = 700, size = 64, extended = true})
surface.CreateFont("animelife.hitmenu.button", {font = "Exo 2", weight = 700, size = 19, extended = true})

function PANEL:Init()
    self.PlayerList = vgui.Create("DScrollPanel", self)

    self.Buttons = {
        [1] = {
            Text = "Оформить заказ",
            Color = Color(178, 218, 255),
            Action = function()
                if IsValid(self:GetTarget()) then
                    RunConsoleCommand("darkrp", "requesthit", self:GetTarget():SteamID(), self:GetHitman():UserID())
                    self:Remove()
                end
            end
        },
        [2] = {
            Text = "Отмена",
            Color = Color(255, 178, 178),
            Action = function()
                if ValidPanel(self) then
                    self:Remove()
                end
            end
        }
    }

    local bx = 742
    for _, btn in SortedPairs(self.Buttons) do
        local button = vgui.Create("DButton", self)
        button:SetPos(bx, 797)
        button:SetSize(208, 61)
        button:SetText("")
        button.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 75))
            draw.RoundedBox(4, 0, 0, w, h - 2, btn.Color)

            draw.SimpleText(btn.Text, "animelife.hitmenu.button", w / 2, h / 2, Color(0, 0, 0, 75), 1, 1)
            draw.SimpleText(btn.Text, "animelife.hitmenu.button", w / 2, h / 2 - 2, Color(255, 255, 255), 1, 1)
        end
        button.DoClick = function()
            btn.Action()
        end

        bx = bx + 208 + 18
    end

    self:InvalidateLayout()
end

function PANEL:PerformLayout(w, h)
    self:SetSize(ScrW(), ScrH())

    self.PlayerList:SetPos(712, 399)
    self.PlayerList:SetSize(496, 325)
end

function PANEL:Think()
    if not IsValid(self:GetHitman()) or self:GetHitman():GetPos():DistToSqr(LocalPlayer():GetPos()) > minHitDistanceSqr then
        self:Remove()
        return
    end
end

function PANEL:Paint(w, h)
    local cx = (w - 506) / 2
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(background)
    surface.DrawTexturedRect(cx, 97, 506, 801)

    draw.SimpleText("Услуги киллера", "animelife.hitmenu.title", cx + 47, 226, Color(255, 148, 148))
    draw.SimpleText("Имя наемника: " .. self:GetHitman():Nick(), "animelife.hitmenu.name", cx + (506 / 2), 297, Color(50, 50, 50), 1)

    local price = self:GetHitman():getHitPrice()
    draw.SimpleText(string.Comma(price) .. "¥", "animelife.hitmenu.price", cx + (506 / 2), 312, Color(255, 132, 132), 1)
end

function PANEL:AddPlayerRows()
    local players = table.Copy(player.GetAll())
    table.sort(players, function(a, b)
        local aTeam, bTeam, aNick, bNick = team.GetName(a:Team()), team.GetName(b:Team()), string.lower(a:Nick()), string.lower(b:Nick())
        return aTeam == bTeam and aNick < bNick or aTeam < bTeam
    end)

    for _, ply in pairs(players) do
        local canRequest = hook.Call("canRequestHit", DarkRP.hooks, self:GetHitman(), LocalPlayer(), ply, self:GetHitman():getHitPrice())
        if not canRequest then continue end
    
        local line = vgui.Create("DButton", self.PlayerList)
        self.PlayerList:AddItem(line)
        line:SetSize(self.PlayerList:GetWide(), 40)
        line:Dock(TOP)
        line:DockMargin(0, 6, 0, 0)
        line:SetText("")
        line.Paint = function(panel, w, h)
            local box_color = team.GetColor(ply:Team())
            surface.SetDrawColor(box_color)
            surface.SetMaterial(line_mat)
            surface.DrawTexturedRect(0, 0, w, h)
    
            local text_color = box_color == Color(255, 255, 255) and Color(0, 0, 0) or Color(255, 255, 255)
            local text = ply:Nick() .. " [" .. team.GetName(ply:Team()) .. "]"
            if self.PlayerList.Selected == panel then
                text = "> " .. text .. " <"
            end

            draw.SimpleText(text, "animelife.hitmenu.button", w / 2, h / 2 + 2, Color(0, 0, 0, 75), 1, 1)
            draw.SimpleText(text, "animelife.hitmenu.button", w / 2, h / 2, text_color, 1, 1)
        end
        line.DoClick = function()
            self:SetTarget(ply)

            if IsValid(self:GetSelected()) then
                self:GetSelected():SetSelected(false)
            end

            line:SetSelected(true)
            self.PlayerList.Selected = line
            self:SetSelected(line)
        end
    end
end

vgui.Register("animelife.hitmenu", PANEL, "EditablePanel")

function DarkRP.openHitMenu(hitman)
    local frame = vgui.Create("animelife.hitmenu")
    frame:SetHitman(hitman)
    frame:AddPlayerRows()
    frame:SetVisible(true)
    frame:MakePopup()
    frame:ParentToHUD()
end

surface.CreateFont("animelife.hitman.hud", {font = "Exo 2 SemiBold", weight = 600, size = 16, extended = true})

local icon_pistol = Material("animelife/hitman/icon_pistol.png")
hook.Add("HUDPaint", "animelife.jobabilities.hitman", function()
    if !IsValid(LocalPlayer()) then return end
    if !LocalPlayer():Alive() then return end
    if LocalPlayer():Team() ~= TEAM_KILLER then return end

    local target = LocalPlayer():getDarkRPVar("hitTarget")
    if !IsValid(target) or !target:IsPlayer() then return end

    local name = target:Nick()

    draw.RoundedBox(8, ScrW() - 223 - 23, ScrH() / 2 - 47, 223, 47, Color(62, 62, 62, 225))

    surface.SetDrawColor(255, 255, 255, 225)
    surface.SetMaterial(icon_pistol)
    surface.DrawTexturedRect(ScrW() - 223 - 23 - 8, ScrH() / 2 - 47 - 10, 29, 26)

    draw.DrawText("Ваша цель:\n" .. name, "animelife.hitman.hud", ScrW() - 23 - (223 / 2), ScrH() / 2 - 47 + 6, Color(255, 255, 255), 1)
end)

hook.Add("PreDrawHalos", "animelife.jobabilities.hitman", function()
    if !LocalPlayer():Alive() then return end
    if LocalPlayer():Team() ~= TEAM_KILLER then return end

    local target = LocalPlayer():getDarkRPVar("hitTarget")
    if !IsValid(target) or !target:IsPlayer() then return end

    halo.Add({target}, Color(255, 75, 75), 0, 0, 2, true, false)
end)