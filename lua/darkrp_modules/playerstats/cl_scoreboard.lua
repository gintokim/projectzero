local flux = util.Base64Decode("bG9jYWwgZmx1eCA9IHsgX3ZlcnNpb24gPSAiMC4xLjUiIH0KZmx1eC5fX2luZGV4ID0gZmx1eAoKZmx1eC50d2VlbnMgPSB7fQpmbHV4LmVhc2luZyA9IHsgbGluZWFyID0gZnVuY3Rpb24ocCkgcmV0dXJuIHAgZW5kIH0KCmxvY2FsIGVhc2luZyA9IHsKICBxdWFkICAgID0gInAgKiBwIiwKICBjdWJpYyAgID0gInAgKiBwICogcCIsCiAgcXVhcnQgICA9ICJwICogcCAqIHAgKiBwIiwKICBxdWludCAgID0gInAgKiBwICogcCAqIHAgKiBwIiwKICBleHBvICAgID0gIjIgXiAoMTAgKiAocCAtIDEpKSIsCiAgc2luZSAgICA9ICItbWF0aC5jb3MocCAqIChtYXRoLnBpICogLjUpKSArIDEiLAogIGNpcmMgICAgPSAiLShtYXRoLnNxcnQoMSAtIChwICogcCkpIC0gMSkiLAogIGJhY2sgICAgPSAicCAqIHAgKiAoMi43ICogcCAtIDEuNykiLAogIGVsYXN0aWMgPSAiLSgyXigxMCAqIChwIC0gMSkpICogbWF0aC5zaW4oKHAgLSAxLjA3NSkgKiAobWF0aC5waSAqIDIpIC8gLjMpKSIKfQoKbG9jYWwgbWFrZWZ1bmMgPSBmdW5jdGlvbihzdHIsIGV4cHIpCiAgcmV0dXJuIENvbXBpbGVTdHJpbmcoInJldHVybiBmdW5jdGlvbihwKSAiIC4uIHN0cjpnc3ViKCIlJGUiLCBleHByKSAuLiAiIGVuZCIsICJUZXN0RnVuY3Rpb24iKSgpCmVuZAoKZm9yIGssIHYgaW4gcGFpcnMoZWFzaW5nKSBkbwogIGZsdXguZWFzaW5nW2sgLi4gImluIl0gPSBtYWtlZnVuYygicmV0dXJuICRlIiwgdikKICBmbHV4LmVhc2luZ1trIC4uICJvdXQiXSA9IG1ha2VmdW5jKFtbCiAgICBwID0gMSAtIHAKICAgIHJldHVybiAxIC0gKCRlKQogIF1dLCB2KQogIGZsdXguZWFzaW5nW2sgLi4gImlub3V0Il0gPSBtYWtlZnVuYyhbWwogICAgcCA9IHAgKiAyCiAgICBpZiBwIDwgMSB0aGVuCiAgICAgIHJldHVybiAuNSAqICgkZSkKICAgIGVsc2UKICAgICAgcCA9IDIgLSBwCiAgICAgIHJldHVybiAuNSAqICgxIC0gKCRlKSkgKyAuNQogICAgZW5kCiAgXV0sIHYpCmVuZAoKCgpsb2NhbCB0d2VlbiA9IHt9CnR3ZWVuLl9faW5kZXggPSB0d2VlbgoKbG9jYWwgZnVuY3Rpb24gbWFrZWZzZXR0ZXIoZmllbGQpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBsb2NhbCBtdCA9IGdldG1ldGF0YWJsZSh4KQogICAgaWYgdHlwZSh4KSB+PSAiZnVuY3Rpb24iIGFuZCBub3QgKG10IGFuZCBtdC5fX2NhbGwpIHRoZW4KICAgICAgZXJyb3IoImV4cGVjdGVkIGZ1bmN0aW9uIG9yIGNhbGxhYmxlIiwgMikKICAgIGVuZAogICAgbG9jYWwgb2xkID0gc2VsZltmaWVsZF0KICAgIHNlbGZbZmllbGRdID0gb2xkIGFuZCBmdW5jdGlvbigpIG9sZCgpIHgoKSBlbmQgb3IgeAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgpsb2NhbCBmdW5jdGlvbiBtYWtlc2V0dGVyKGZpZWxkLCBjaGVja2ZuLCBlcnJtc2cpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBpZiBjaGVja2ZuIGFuZCBub3QgY2hlY2tmbih4KSB0aGVuCiAgICAgIGVycm9yKGVycm1zZzpnc3ViKCIlJHgiLCB0b3N0cmluZyh4KSksIDIpCiAgICBlbmQKICAgIHNlbGZbZmllbGRdID0geAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgp0d2Vlbi5lYXNlICA9IG1ha2VzZXR0ZXIoIl9lYXNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uKHgpIHJldHVybiBmbHV4LmVhc2luZ1t4XSBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGVhc2luZyB0eXBlICckeCciKQp0d2Vlbi5kZWxheSA9IG1ha2VzZXR0ZXIoIl9kZWxheSIsCiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbih4KSByZXR1cm4gdHlwZSh4KSA9PSAibnVtYmVyIiBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGRlbGF5IHRpbWU7IGV4cGVjdGVkIG51bWJlciIpCnR3ZWVuLm9uc3RhcnQgICAgID0gbWFrZWZzZXR0ZXIoIl9vbnN0YXJ0IikKdHdlZW4ub251cGRhdGUgICAgPSBtYWtlZnNldHRlcigiX29udXBkYXRlIikKdHdlZW4ub25jb21wbGV0ZSAgPSBtYWtlZnNldHRlcigiX29uY29tcGxldGUiKQoKCmZ1bmN0aW9uIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpCiAgbG9jYWwgc2VsZiA9IHNldG1ldGF0YWJsZSh7fSwgdHdlZW4pCiAgc2VsZi5vYmogPSBvYmoKICBzZWxmLnJhdGUgPSB0aW1lID4gMCBhbmQgMSAvIHRpbWUgb3IgMAogIHNlbGYucHJvZ3Jlc3MgPSB0aW1lID4gMCBhbmQgMCBvciAxCiAgc2VsZi5fZGVsYXkgPSAwCiAgc2VsZi5fZWFzZSA9ICJxdWFkb3V0IgogIHNlbGYudmFycyA9IHt9CiAgZm9yIGssIHYgaW4gcGFpcnModmFycykgZG8KICAgIGlmIHR5cGUodikgfj0gIm51bWJlciIgdGhlbgogICAgICBlcnJvcigiYmFkIHZhbHVlIGZvciBrZXkgJyIgLi4gayAuLiAiJzsgZXhwZWN0ZWQgbnVtYmVyIikKICAgIGVuZAogICAgc2VsZi52YXJzW2tdID0gdgogIGVuZAogIHJldHVybiBzZWxmCmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOmluaXQoKQogIGZvciBrLCB2IGluIHBhaXJzKHNlbGYudmFycykgZG8KICAgIGxvY2FsIHggPSBzZWxmLm9ialtrXQogICAgaWYgdHlwZSh4KSB+PSAibnVtYmVyIiB0aGVuCiAgICAgIGVycm9yKCJiYWQgdmFsdWUgb24gb2JqZWN0IGtleSAnIiAuLiBrIC4uICInOyBleHBlY3RlZCBudW1iZXIiKQogICAgZW5kCiAgICBzZWxmLnZhcnNba10gPSB7IHN0YXJ0ID0geCwgZGlmZiA9IHYgLSB4IH0KICBlbmQKICBzZWxmLmluaXRlZCA9IHRydWUKZW5kCgoKZnVuY3Rpb24gdHdlZW46YWZ0ZXIoLi4uKQogIGxvY2FsIHQKICBpZiBzZWxlY3QoIiMiLCAuLi4pID09IDIgdGhlbgogICAgdCA9IHR3ZWVuLm5ldyhzZWxmLm9iaiwgLi4uKQogIGVsc2UKICAgIHQgPSB0d2Vlbi5uZXcoLi4uKQogIGVuZAogIHQucGFyZW50ID0gc2VsZi5wYXJlbnQKICBzZWxmOm9uY29tcGxldGUoZnVuY3Rpb24oKSBmbHV4LmFkZChzZWxmLnBhcmVudCwgdCkgZW5kKQogIHJldHVybiB0CmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOnN0b3AoKQogIGZsdXgucmVtb3ZlKHNlbGYucGFyZW50LCBzZWxmKQplbmQKCgoKZnVuY3Rpb24gZmx1eC5ncm91cCgpCiAgcmV0dXJuIHNldG1ldGF0YWJsZSh7fSwgZmx1eCkKZW5kCgoKZnVuY3Rpb24gZmx1eDp0byhvYmosIHRpbWUsIHZhcnMpCiAgcmV0dXJuIGZsdXguYWRkKHNlbGYsIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpKQplbmQKCgpmdW5jdGlvbiBmbHV4OnVwZGF0ZShkZWx0YXRpbWUpCiAgZm9yIGkgPSAjc2VsZiwgMSwgLTEgZG8KICAgIGxvY2FsIHQgPSBzZWxmW2ldCiAgICBpZiB0Ll9kZWxheSA+IDAgdGhlbgogICAgICB0Ll9kZWxheSA9IHQuX2RlbGF5IC0gZGVsdGF0aW1lCiAgICBlbHNlCiAgICAgIGlmIG5vdCB0LmluaXRlZCB0aGVuCiAgICAgICAgZmx1eC5jbGVhcihzZWxmLCB0Lm9iaiwgdC52YXJzKQogICAgICAgIHQ6aW5pdCgpCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnN0YXJ0IHRoZW4KICAgICAgICB0Ll9vbnN0YXJ0KCkKICAgICAgICB0Ll9vbnN0YXJ0ID0gbmlsCiAgICAgIGVuZAogICAgICB0LnByb2dyZXNzID0gdC5wcm9ncmVzcyArIHQucmF0ZSAqIGRlbHRhdGltZQogICAgICBsb2NhbCBwID0gdC5wcm9ncmVzcwogICAgICBsb2NhbCB4ID0gcCA+PSAxIGFuZCAxIG9yIGZsdXguZWFzaW5nW3QuX2Vhc2VdKHApCiAgICAgIGZvciBrLCB2IGluIHBhaXJzKHQudmFycykgZG8KICAgICAgICB0Lm9ialtrXSA9IHYuc3RhcnQgKyB4ICogdi5kaWZmCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnVwZGF0ZSB0aGVuIHQuX29udXBkYXRlKCkgZW5kCiAgICAgIGlmIHAgPj0gMSB0aGVuCiAgICAgICAgZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgICAgICBpZiB0Ll9vbmNvbXBsZXRlIHRoZW4gdC5fb25jb21wbGV0ZSgpIGVuZAogICAgICBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmNsZWFyKG9iaiwgdmFycykKICBmb3IgdCBpbiBwYWlycyhzZWxmW29ial0pIGRvCiAgICBpZiB0LmluaXRlZCB0aGVuCiAgICAgIGZvciBrIGluIHBhaXJzKHZhcnMpIGRvIHQudmFyc1trXSA9IG5pbCBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmFkZCh0d2VlbikKICAtLSBBZGQgdG8gb2JqZWN0IHRhYmxlLCBjcmVhdGUgdGFibGUgaWYgaXQgZG9lcyBub3QgZXhpc3QKICBsb2NhbCBvYmogPSB0d2Vlbi5vYmoKICBzZWxmW29ial0gPSBzZWxmW29ial0gb3Ige30KICBzZWxmW29ial1bdHdlZW5dID0gdHJ1ZQogIC0tIEFkZCB0byBhcnJheQogIHRhYmxlLmluc2VydChzZWxmLCB0d2VlbikKICB0d2Vlbi5wYXJlbnQgPSBzZWxmCiAgcmV0dXJuIHR3ZWVuCmVuZAoKCmZ1bmN0aW9uIGZsdXg6cmVtb3ZlKHgpCiAgaWYgdHlwZSh4KSA9PSAibnVtYmVyIiB0aGVuCiAgICAtLSBSZW1vdmUgZnJvbSBvYmplY3QgdGFibGUsIGRlc3Ryb3kgdGFibGUgaWYgaXQgaXMgZW1wdHkKICAgIGxvY2FsIG9iaiA9IHNlbGZbeF0ub2JqCiAgICBzZWxmW29ial1bc2VsZlt4XV0gPSBuaWwKICAgIGlmIG5vdCBuZXh0KHNlbGZbb2JqXSkgdGhlbiBzZWxmW29ial0gPSBuaWwgZW5kCiAgICAtLSBSZW1vdmUgZnJvbSBhcnJheQogICAgc2VsZlt4XSA9IHNlbGZbI3NlbGZdCiAgICByZXR1cm4gdGFibGUucmVtb3ZlKHNlbGYpCiAgZW5kCiAgZm9yIGksIHYgaW4gaXBhaXJzKHNlbGYpIGRvCiAgICBpZiB2ID09IHggdGhlbgogICAgICByZXR1cm4gZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgIGVuZAogIGVuZAplbmQKCgoKbG9jYWwgYm91bmQgPSB7CiAgdG8gICAgICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgudG8oZmx1eC50d2VlbnMsIC4uLikgZW5kLAogIHVwZGF0ZSAgPSBmdW5jdGlvbiguLi4pIHJldHVybiBmbHV4LnVwZGF0ZShmbHV4LnR3ZWVucywgLi4uKSBlbmQsCiAgcmVtb3ZlICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgucmVtb3ZlKGZsdXgudHdlZW5zLCAuLi4pIGVuZCwKfQpzZXRtZXRhdGFibGUoYm91bmQsIGZsdXgpCgpyZXR1cm4gYm91bmQ=")
flux = CompileString(flux, "flux")()


local PANEL = {}

local animelife_logo = Material("animelife/scoreboard/animelife_logo.png")
local header = Material("animelife/scoreboard/header.png")
local base_avatar = Material("animelife/scoreboard/base_avatar.png")
local pen = Material("animelife/scoreboard/icon_pen.png")
local thumb_like = Material("animelife/scoreboard/thumb_like.png")
local thumb_dislike = Material("animelife/scoreboard/thumb_dislike.png")
local achi_test = Material("animelife/scoreboard/achievements/0.png")
local ping = Material("animelife/scoreboard/icon_ping.png")

FONT_WEIGHT_BOLD = 700
FONT_WEIGHT_REGULAR = 400
FONT_WEIGHT_LIGHT = 300
FONT_WEIGHT_MEDIUM = 500
FONT_WEIGHT_SEMIBOLD = 600

surface.CreateFont("animelife.scoreboard.playernamebig", {font = "Exo 2", size = 43, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.scoreboard.playernamebig.shadow", {font = "Exo 2", size = 43, weight = FONT_WEIGHT_BOLD, blursize = 2, extended = true})
surface.CreateFont("animelife.scoreboard.status", {font = "Exo 2 SemiBold", size = 22, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.scoreboard.status.shadow", {font = "Exo 2 SemiBold", size = 22, weight = FONT_WEIGHT_SEMIBOLD, blursize = 2, extended = true})
surface.CreateFont("animelife.scoreboard.likes", {font = "Exo 2", size = 17, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.scoreboard.likes.shadow", {font = "Exo 2", size = 17, weight = FONT_WEIGHT_BOLD, blursize = 2, extended = true})
surface.CreateFont("animelife.scoreboard.stats", {font = "Exo 2", size = 22, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.scoreboard.stats.numbers", {font = "Exo 2 Medium", size = 22, weight = FONT_WEIGHT_MEDIUM, extended = true})
surface.CreateFont("animelife.scoreboard.admin", {font = "Exo 2 Medium", size = 17, weight = FONT_WEIGHT_MEDIUM, extended = true})
surface.CreateFont("animelife.scoreboard.category", {font = "Exo 2 SemiBold", size = 22, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.scoreboard.achievement", {font = "Exo 2 SemiBold", size = 17, weight = FONT_WEIGHT_SEMIBOLD, extended = true})
surface.CreateFont("animelife.scoreboard.score", {font = "Exo 2 Medium", size = 19, weight = FONT_WEIGHT_MEDIUM, extended = true})

function PANEL:Init()
    self.CurrentPlayer = LocalPlayer()

    -- Scoreboard Side
    self.ScoreboardScroll = vgui.Create("DScrollPanel", self)
    self.ScoreboardScroll:SetPos(0, 4)
    self.ScoreboardScroll:SetSize(1040, 1011)
    self.ScoreboardScroll.Players = {}
    self.ScoreboardScroll.NextUpdate = 0
    self.ScoreboardScroll.Think = function(panel)
        if RealTime() > panel.NextUpdate then
            for ply in pairs(panel.Players or {}) do
                if !IsValid(ply) then
                    panel:RemovePlayer(ply)
                end
            end

            local sorted = player.GetAll()
            table.sort(sorted, function(a, b)
                return team.GetName(a:Team()) > team.GetName(b:Team())
            end)
            for c, ply in pairs(sorted) do
                if panel.Players[ply] == nil then
                    panel:AddPlayer(ply, c)
                end
            end

            panel:InvalidateLayout()

            panel.NextUpdate = RealTime() + 3
        end
    end
    self.ScoreboardScroll.AddPlayer = function(panel, ply, id)
        local player_panel = vgui.Create("DPanel", panel)
        // player_panel:SetPos(18, score_y)
        player_panel:Dock(TOP)
        player_panel:DockMargin(18, 6, 18, 0)
        player_panel:SetSize(panel:GetWide() - 36, 52)
        player_panel:SetCursor("hand")
        player_panel.OnMousePressed = function()
            if !IsValid(ply) then return end
            
            self.CurrentPlayer = ply

            if ValidPanel(self.ProfileAvatar) then
                self.ProfileAvatar:SetPlayer(self.CurrentPlayer, 184)
            end

            if ValidPanel(self.StatusEdit) then
                self.StatusEdit:SetVisible(self.CurrentPlayer == LocalPlayer())
            end

            if ValidPanel(self.AdminPanel) then
                self.AdminPanel:SetVisible(self.CurrentPlayer == LocalPlayer() or LocalPlayer():IsAdmin())
                self.ProfileLayout:Layout()
            end
        end
        player_panel.Paint = function(panel, w, h)
            draw.RoundedBox(6, 0, 0, w, h, Color(16, 16, 16, 65))
            if ply == LocalPlayer() then
                draw.RoundedBox(6, 0, 0, w, h, Color(0, 0, 0, 16 * math.sin(CurTime() * 4)))
            end

            local nick = "Disconnected Player"
            local nick_color = Color(255, 255, 255)
            if IsValid(ply) then
                nick = ply:Nick()

                if ply:IsAdmin() then
                    nick_color = Color(255, 157, 157)
                end
            end

            draw.SimpleText(nick, "animelife.scoreboard.score", 32, h / 2, nick_color, nil, 1)

            if IsValid(ply) then
                local job = team.GetName(ply:Team())
                local class = classchooser.List[ply:Team()]
                if istable(class) then
                    local actual_class = ply:GetNWInt("animelife.classchooser.class", -1)
                    if actual_class ~= -1 then
                        if istable(class[actual_class]) then
                            job = job .. " (" .. class[actual_class].Name .. ")"
                        end
                    end
                end

                draw.SimpleText(job, "animelife.scoreboard.score", w / 2, h / 2, team.GetColor(ply:Team()), 1, 1)
            end

            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(ping)
            surface.DrawTexturedRect(w - 32 - 12, ( h - 12 ) / 2, 12, 12)

            local ping = 0
            if IsValid(ply) then
                ping = ply:Ping()
            end
            
            draw.SimpleText(ping .. "ms", "animelife.scoreboard.score", w - 32 - 12 - 4, h / 2, Color(255, 255, 255), 2, 1)
        end

        panel.Players[ply] = player_panel
        panel:AddItem(player_panel)
    end
    self.ScoreboardScroll.RemovePlayer = function(panel, ply)
        if ValidPanel(panel.Players[ply]) then
            panel.Players[ply]:Remove()
            panel.Players[ply] = nil
        end
    end
    local vertical_bar = self.ScoreboardScroll:GetVBar()
    vertical_bar:SetWide(4)
    vertical_bar.Paint = function() end
    vertical_bar.btnUp.Paint = function() end
    vertical_bar.btnDown.Paint = function() end
    vertical_bar.btnGrip.Paint = function(panel, w, h)
        draw.RoundedBox(2, 0, 0, w, h, Color(221, 205, 231))
    end

    // local score_y = 15
    // local sorted = player.GetAll()
    // table.sort(sorted, function(a, b)
    //     return team.GetName(a:Team()) > team.GetName(b:Team())
    // end)
    // for _, ply in pairs(sorted) do
    //     local player_panel = vgui.Create("DPanel", self.ScoreboardScroll)
    //     player_panel:SetPos(18, score_y)
    //     player_panel:SetSize(self.ScoreboardScroll:GetWide() - 36, 52)
    //     player_panel:SetCursor("hand")
    //     player_panel.OnMousePressed = function()
    //         self.CurrentPlayer = ply

    //         if ValidPanel(self.ProfileAvatar) then
    //             self.ProfileAvatar:SetPlayer(self.CurrentPlayer, 184)
    //         end

    //         if ValidPanel(self.StatusEdit) then
    //             self.StatusEdit:SetVisible(self.CurrentPlayer == LocalPlayer())
    //         end

    //         if ValidPanel(self.AdminPanel) then
    //             self.AdminPanel:SetVisible(self.CurrentPlayer == LocalPlayer() or LocalPlayer():IsAdmin())
    //             self.ProfileLayout:Layout()
    //         end
    //     end
    //     player_panel.Paint = function(panel, w, h)
    //         draw.RoundedBox(6, 0, 0, w, h, Color(16, 16, 16, 65))
    //         if ply == LocalPlayer() then
    //             draw.RoundedBox(6, 0, 0, w, h, Color(0, 0, 0, 16 * math.sin(CurTime() * 4)))
    //         end

    //         draw.SimpleText(ply:Nick(), "animelife.scoreboard.score", 32, h / 2, Color(255, 255, 255), nil, 1)
    //         draw.SimpleText(team.GetName(ply:Team()), "animelife.scoreboard.score", w / 2, h / 2, Color(255, 255, 255), 1, 1)

    //         surface.SetDrawColor(255, 255, 255)
    //         surface.SetMaterial(ping)
    //         surface.DrawTexturedRect(w - 32 - 12, ( h - 12 ) / 2, 12, 12)

    //         draw.SimpleText(ply:Ping() .. "ms", "animelife.scoreboard.score", w - 32 - 12 - 4, h / 2, Color(255, 255, 255), 2, 1)
    //     end

    //     score_y = score_y + 52 + 6
    // end

    -- Profile Side
    self.ProfileBase = vgui.Create("DScrollPanel", self)
    self.ProfileBase:SetPos(ScrW() - 880, 4)
    self.ProfileBase:SetSize(880, 1076)
    self.ProfileBase.Paint = function(panel, w, h)
        surface.SetDrawColor(19, 24, 33)
        surface.DrawRect(0, 0, w, h)
    end
    self.ProfileBase.PaintOver = function(panel, w, h)
        if panel.Updating then
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleText("Обновление профиля...", "animelife.scoreboard.status", w / 2, h / 2, Color(255, 255, 255), 1, 1)
        end

        if istable(panel.Tooltip) then
            local ax, ay = panel.Tooltip[1], panel.Tooltip[2] + ((self.CurrentPlayer == LocalPlayer() or LocalPlayer():IsAdmin()) and 460 or 240)
            local description = markup.Parse("<font=animelife.scoreboard.achievement><colour=225,225,255>" .. panel.Tooltip[4].. "</colour></font>", 236)
            local desc_h = description:GetHeight()
            desc_h = desc_h + 25 + 4 + 10 + 8
            surface.SetDrawColor(50, 50, 51, 255)
            surface.DrawRect(ax - 60, ay - desc_h, 236, desc_h)

            surface.SetDrawColor(255, 255, 255, 6)
            surface.DrawRect(ax - 60, ay - desc_h, 236, 25)

            draw.SimpleText(panel.Tooltip[3], "animelife.scoreboard.achievement", ax - 60 + 16, ay - desc_h + 4, Color(255, 255, 255))

            description:Draw(ax - 60 + 16, ay - desc_h + 25 + 10)
            -- draw.SimpleText(panel.Tooltip[4], "animelife.scoreboard.achievement", ax - 60 + 16, ay - 65 + 25 + 10, Color(225, 225, 225))
        end
    end

    self.ProfileLayout = vgui.Create("DIconLayout", self.ProfileBase)
    self.ProfileLayout:Dock(FILL)
    self.ProfileLayout:SetSpaceX(512)
    self.ProfileLayout:SetSpaceY(0)

    self.ProfileBackground = vgui.Create("DPanel", self.ProfileLayout)
    self.ProfileBackground:SetPos(0, 0)
    self.ProfileBackground:SetSize(self.ProfileBase:GetWide(), 243)
    self.ProfileBackground.Paint = function(panel, w, h)
        local bgi = self.CurrentPlayer:GetBackground()
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(GLOBALS_BACKGROUNDS["scoreboard"][bgi])
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetMaterial(base_avatar)
        surface.DrawTexturedRect(61, 34, base_avatar:Width(), base_avatar:Height())

        if ValidPanel(self.ProfileAvatar) then
            render.ClearStencil()
            render.SetStencilEnable(true)
            render.SetStencilWriteMask(1)
            render.SetStencilTestMask(1)
            render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
            render.SetStencilPassOperation(STENCILOPERATION_ZERO)
            render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
            render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
            render.SetStencilReferenceValue(1)
                draw.NoTexture()
                drawRoundedRectangle(65, 34, 174, 174, 16, Color(255, 255, 255), Color(255, 255, 255), 0, 0.25, nil)
            render.SetStencilFailOperation(STENCILOPERATION_ZERO)
            render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
            render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
            render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
            render.SetStencilReferenceValue(1)
                self.ProfileAvatar:PaintManual()
            render.SetStencilEnable( false )
            render.ClearStencil()
        end

        local nick = self.CurrentPlayer:Nick()
        local steam_id = self.CurrentPlayer:SteamID()
        draw.SimpleText(nick, "animelife.scoreboard.playernamebig.shadow", 268, 55, Color(0, 0, 0, 255 * 0.35))
        draw.SimpleText(nick, "animelife.scoreboard.playernamebig", 268, 54, Color(255, 255, 255))

        local status = self.CurrentPlayer:GetStatus()
        draw.SimpleText(status, "animelife.scoreboard.status.shadow", 268, 54 + 43 + 9 + 1, Color(0, 0, 0, 255 * 0.35))
        draw.SimpleText(status, "animelife.scoreboard.status", 268, 54 + 43 + 9, Color(255, 255, 255))

        if ValidPanel(self.StatusEdit) then
            surface.SetFont("animelife.scoreboard.status")
            self.StatusEdit:SetPos(268 + surface.GetTextSize(status) + 7, 109)
        end

        draw.SimpleText(steam_id, "animelife.scoreboard.status.shadow", 268, 54 + 43 + 9 + 22 + 12 + 1, Color(0, 0, 0, 255 * 0.35))
        draw.SimpleText(steam_id, "animelife.scoreboard.status", 268, 54 + 43 + 9 + 22 + 12, Color(228, 228, 228))

        local likes, dislikes = #string.Split(self.CurrentPlayer:GetLikes(), ",") - 1, #string.Split(self.CurrentPlayer:GetDislikes(), ",") - 1
        draw.SimpleText(likes, "animelife.scoreboard.likes.shadow", 286, 173, Color(0, 0, 0, 255 * 0.35))
        draw.SimpleText(likes, "animelife.scoreboard.likes", 286, 172, Color(228, 228, 228))

        surface.SetFont("animelife.scoreboard.likes")
        local dx = 286 + surface.GetTextSize(likes) + 10
        if ValidPanel(self.DislikeButton) then
            self.DislikeButton:SetPos(dx, 173)
        end

        draw.SimpleText(dislikes, "animelife.scoreboard.likes.shadow", dx + 22, 173, Color(0, 0, 0, 255 * 0.35))
        draw.SimpleText(dislikes, "animelife.scoreboard.likes", dx + 22, 172, Color(228, 228, 228))

        flux.update(RealFrameTime())
    end

    self.ProfileAvatar = vgui.Create("AvatarImage", self.ProfileBackground)
    self.ProfileAvatar:SetPos(65, 34)
    self.ProfileAvatar:SetSize(174, 174)
    self.ProfileAvatar:SetPlayer(self.CurrentPlayer, 184)
    self.ProfileAvatar:SetPaintedManually(true)
    self.ProfileAvatar:SetCursor("hand")
    self.ProfileAvatar.OnMousePressed = function()
        if IsValid(self.CurrentPlayer) then
            self.CurrentPlayer:ShowProfile()
        end
    end

    self.StatusEdit = vgui.Create("DButton", self.ProfileBackground)
    self.StatusEdit:SetPos(562, 109)
    self.StatusEdit:SetSize(14, 14)
    self.StatusEdit:SetText("")
    self.StatusEdit.Color = {r = 255, g = 255, b = 255}
    self.StatusEdit.Paint = function(panel, w, h)
        surface.SetDrawColor(panel.Color.r, panel.Color.g, panel.Color.b)
        surface.SetMaterial(pen)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    self.StatusEdit.OnCursorEntered = function(panel)
        flux.to(panel.Color, 0.5, {r = 221, g = 205, b = 231})
    end
    self.StatusEdit.OnCursorExited = function(panel)
        flux.to(panel.Color, 0.5, {r = 255, g = 255, b = 255})
    end
    self.StatusEdit.DoClick = function()
        local preview = LocalPlayer().GetStatus and LocalPlayer():GetStatus() or "Нет статуса."
        Derma_StringRequest("Смена статуса", "Введите ваш новый статус", preview, function(str)
            net.Start("animelife.playerstats.status_change")
                net.WriteString(str)
            net.SendToServer()
        end)
    end

    self.LikeButton = vgui.Create("DButton", self.ProfileBackground)
    self.LikeButton:SetPos(266, 173)
    self.LikeButton:SetSize(16, 18)
    self.LikeButton:SetText("")
    self.LikeButton.Color = {r = 255, g = 255, b = 255}
    self.LikeButton.Paint = function(panel, w, h)
        surface.SetDrawColor(panel.Color.r, panel.Color.g, panel.Color.b)
        surface.SetMaterial(thumb_like)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    self.LikeButton.OnCursorEntered = function(panel)
        flux.to(panel.Color, 0.5, {r = 183, g = 241, b = 165})
    end
    self.LikeButton.OnCursorExited = function(panel)
        flux.to(panel.Color, 0.5, {r = 255, g = 255, b = 255})
    end
    self.LikeButton.DoClick = function()
        net.Start("animelife.playerstats.like")
            net.WriteEntity(self.CurrentPlayer)
        net.SendToServer()
    end

    self.DislikeButton = vgui.Create("DButton", self.ProfileBackground)
    self.DislikeButton:SetPos(306, 173)
    self.DislikeButton:SetSize(17, 19)
    self.DislikeButton:SetText("")
    self.DislikeButton.Color = {r = 255, g = 255, b = 255}
    self.DislikeButton.Paint = function(panel, w, h)
        surface.SetDrawColor(panel.Color.r, panel.Color.g, panel.Color.b)
        surface.SetMaterial(thumb_dislike)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    self.DislikeButton.OnCursorEntered = function(panel)
        flux.to(panel.Color, 0.5, {r = 247, g = 127, b = 151})
    end
    self.DislikeButton.OnCursorExited = function(panel)
        flux.to(panel.Color, 0.5, {r = 255, g = 255, b = 255})
    end
    self.DislikeButton.DoClick = function()
        net.Start("animelife.playerstats.dislike")
            net.WriteEntity(self.CurrentPlayer)
        net.SendToServer()
    end

    self.AdminPanel = vgui.Create("DPanel", self.ProfileLayout)
    self.AdminPanel:SetPos(0, 243)
    self.AdminPanel:SetSize(self.ProfileBase:GetWide(), 216)
    self.AdminPanel.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255, 2)
        surface.DrawRect(0, 0, panel:GetSize())

        draw.SimpleText("Администрирование", "animelife.scoreboard.stats", w / 2, 14, Color(224, 224, 224), 1)
        draw.SimpleText("Статистика", "animelife.scoreboard.stats", w / 2, 101, Color(224, 224, 224), 1)

        draw.SimpleText("Количество банов: " .. self.CurrentPlayer:GetNWInt("animelife.administration.ban_count", 0), "animelife.scoreboard.stats.numbers", 29, 137, Color(224, 224, 224))
        draw.SimpleText("Количество джайлов: 0", "animelife.scoreboard.stats.numbers", 29, 137 + 22 + 6, Color(224, 224, 224))
    end

    self.AdminScroll = vgui.Create("DHorizontalScroller", self.AdminPanel)
    self.AdminScroll:SetPos(0, 14 + 22 + 14)
    self.AdminScroll:SetSize(self.AdminPanel:GetWide(), 37)
    self.AdminScroll:SetOverlap(-18)
    self.AdminScroll.btnLeft.Paint = function() end
    self.AdminScroll.btnRight.Paint = function() end

    local offset_panel = vgui.Create("DPanel", self.AdminScroll)
    offset_panel:SetSize(35, 37)
    offset_panel.Paint = function() end
    self.AdminScroll:AddPanel(offset_panel)

    for _, act in pairs(administration.Actions or {}) do
        local act_button = vgui.Create("DButton", self.AdminScroll)
        act_button:SetSize(149, 37)
        act_button:SetText("")
        act_button.Paint = function(panel, w, h)
            draw.RoundedBox(12, 0, 0, w, h, Color(255, 255, 255, 6))

            draw.SimpleText(act.Name or "действие unknown", "animelife.scoreboard.admin", w / 2, h / 2, Color(255, 255, 255), 1, 1)
        end

        self.AdminScroll:AddPanel(act_button)
    end

    self.AchievementsPanel = vgui.Create("DPanel", self.ProfileLayout)
    self.AchievementsPanel:SetSize(self.ProfileBase:GetWide(), 617)
    self.AchievementsPanel.Paint = function() end

    local achievements_text = vgui.Create("DLabel", self.AchievementsPanel)
    achievements_text:SetPos(61, 21)
    achievements_text:SetText("| Достижения")
    achievements_text:SetFont("animelife.scoreboard.category")
    achievements_text:SetColor(Color(255, 255, 255))
    achievements_text:SizeToContents()

    local kaomoji = "｡ﾟ･ (>﹏<) ･ﾟ｡"
    -- kaomoji = "(〃＾▽＾〃)"

    local no_achi_text = vgui.Create("DLabel", self.AchievementsPanel)
    no_achi_text:SetPos(175, 21)
    no_achi_text:SetText("0 полученных достижений " .. kaomoji)
    no_achi_text:SetFont("animelife.scoreboard.category")
    no_achi_text:SetColor(Color(255, 255, 255, 5))
    no_achi_text:SetSize(512, 25)
    no_achi_text.Think = function(panel)
        local achi_count = #achievements:GetAllCompleted(self.CurrentPlayer) - 1
        if achi_count > 0 then
            kaomoji = "(〃＾▽＾〃)"
        else
            kaomoji = "｡ﾟ･ (>﹏<) ･ﾟ｡"
        end
        
        -- panel:SetText(achi_count .. " полученных достижений " .. kaomoji)
        panel:SetText(kaomoji .. " полученных достижений: " .. achi_count)
    end

    local x, y = 96, 66
    for i = 1, #achievements.List do
        local achi = achievements.List[i]
        local achi_button = vgui.Create("DButton", self.AchievementsPanel)
        achi_button:SetPos(x, y)
        achi_button:SetSize(102, 102)
        achi_button:SetText("")
        achi_button.Paint = function(panel, w, h)
            surface.SetDrawColor(255, 255, 255, achievements:GetStatus(self.CurrentPlayer, i) and 255 or 12)
            surface.SetMaterial(achi.Icon)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        achi_button.OnCursorEntered = function(panel)
            self.ProfileBase.Tooltip = {panel.x, panel.y, achi.Name, achi.Description}
        end
        achi_button.OnCursorExited = function()
            self.ProfileBase.Tooltip = nil
        end

        if i % 7 == 0 then
            x = 96
            y = y + 102 - 6
        else
            x = x + 102 - 6
        end
    end
end

local matBlurScreen = Material( "pp/blurscreen" )
local function blur(panel, amount) 
	local x, y = panel:LocalToScreen( 0, 0 )
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( matBlurScreen )
	for i = 1, 2 do
		matBlurScreen:SetFloat('$blur', (i / 6) * (amount ~= nil and amount or 6))
		matBlurScreen:Recompute()
		render.UpdateScreenEffectTexture()
		
		surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
	end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(header)
    surface.DrawTexturedRect(0, 0, ScrW(), 4)

    local x, y = self:LocalToScreen(0), self:LocalToScreen(4)
    render.SetScissorRect(x, y, x + self:LocalToScreen(1040), y + self:LocalToScreen(1076), true)
        blur(self, 6)
    render.SetScissorRect(0, 0, 0, 0, false)

    surface.SetDrawColor(0, 0, 0, 225)
    surface.DrawRect(0, 4, 1040, 1076)

    local w, h = animelife_logo:Width(), animelife_logo:Height()

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(animelife_logo)
    surface.DrawTexturedRect(17, ScrH() - h - 12, w, h)
end

vgui.Register("animelife.scoreboard", PANEL, "EditablePanel")

hook.Add("HUDShouldDraw", "htrhrt", function(e)
    -- TODO: Don't draw any HUD if scoreboard is open
    if e == "CHudHealth" then return false end
end)

function GM:ScoreboardShow()
    if ( !ValidPanel( GLOBALS_SCOREBOARD ) ) then
        GLOBALS_SCOREBOARD = vgui.Create("animelife.scoreboard")
        GLOBALS_SCOREBOARD:SetSize(ScrW(), ScrH())
        GLOBALS_SCOREBOARD:SetAlpha(0)
        GLOBALS_SCOREBOARD:AlphaTo(255, 0.1)
        GLOBALS_SCOREBOARD:SetVisible(true)
    else
        GLOBALS_SCOREBOARD:SetVisible( true )
        GLOBALS_SCOREBOARD:SetAlpha(0)
        GLOBALS_SCOREBOARD:AlphaTo(255, 0.1)
    end

    RestoreCursorPosition()
    gui.EnableScreenClicker( true )
end

function GM:ScoreboardHide()
    if ( !ValidPanel( GLOBALS_SCOREBOARD ) ) then
        GLOBALS_SCOREBOARD = vgui.Create("animelife.scoreboard")
        GLOBALS_SCOREBOARD:SetSize(ScrW(), ScrH())
        GLOBALS_SCOREBOARD:SetVisible(false)
    else
        GLOBALS_SCOREBOARD:SetVisible( false )
    end

    RememberCursorPosition()
    gui.EnableScreenClicker( false )
end