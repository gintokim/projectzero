local background = Material("animelife/classchooser/background.png")

surface.CreateFont("animelife.classchooser.subtitle", {font = "Exo 2 SemiBold", weight = 600, size = 24, extended = true})
surface.CreateFont("animelife.classchooser.title", {font = "Exo 2 SemiBold", weight = 600, size = 48, extended = true})
surface.CreateFont("animelife.classchooser.stats", {font = "Exo 2 Medium", weight = 500, size = 16, extended = true})
surface.CreateFont("animelife.classchooser.stats.title", {font = "Exo 2 SemiBold", weight = 500, size = 18, extended = true})

local flux = util.Base64Decode("bG9jYWwgZmx1eCA9IHsgX3ZlcnNpb24gPSAiMC4xLjUiIH0KZmx1eC5fX2luZGV4ID0gZmx1eAoKZmx1eC50d2VlbnMgPSB7fQpmbHV4LmVhc2luZyA9IHsgbGluZWFyID0gZnVuY3Rpb24ocCkgcmV0dXJuIHAgZW5kIH0KCmxvY2FsIGVhc2luZyA9IHsKICBxdWFkICAgID0gInAgKiBwIiwKICBjdWJpYyAgID0gInAgKiBwICogcCIsCiAgcXVhcnQgICA9ICJwICogcCAqIHAgKiBwIiwKICBxdWludCAgID0gInAgKiBwICogcCAqIHAgKiBwIiwKICBleHBvICAgID0gIjIgXiAoMTAgKiAocCAtIDEpKSIsCiAgc2luZSAgICA9ICItbWF0aC5jb3MocCAqIChtYXRoLnBpICogLjUpKSArIDEiLAogIGNpcmMgICAgPSAiLShtYXRoLnNxcnQoMSAtIChwICogcCkpIC0gMSkiLAogIGJhY2sgICAgPSAicCAqIHAgKiAoMi43ICogcCAtIDEuNykiLAogIGVsYXN0aWMgPSAiLSgyXigxMCAqIChwIC0gMSkpICogbWF0aC5zaW4oKHAgLSAxLjA3NSkgKiAobWF0aC5waSAqIDIpIC8gLjMpKSIKfQoKbG9jYWwgbWFrZWZ1bmMgPSBmdW5jdGlvbihzdHIsIGV4cHIpCiAgcmV0dXJuIENvbXBpbGVTdHJpbmcoInJldHVybiBmdW5jdGlvbihwKSAiIC4uIHN0cjpnc3ViKCIlJGUiLCBleHByKSAuLiAiIGVuZCIsICJUZXN0RnVuY3Rpb24iKSgpCmVuZAoKZm9yIGssIHYgaW4gcGFpcnMoZWFzaW5nKSBkbwogIGZsdXguZWFzaW5nW2sgLi4gImluIl0gPSBtYWtlZnVuYygicmV0dXJuICRlIiwgdikKICBmbHV4LmVhc2luZ1trIC4uICJvdXQiXSA9IG1ha2VmdW5jKFtbCiAgICBwID0gMSAtIHAKICAgIHJldHVybiAxIC0gKCRlKQogIF1dLCB2KQogIGZsdXguZWFzaW5nW2sgLi4gImlub3V0Il0gPSBtYWtlZnVuYyhbWwogICAgcCA9IHAgKiAyCiAgICBpZiBwIDwgMSB0aGVuCiAgICAgIHJldHVybiAuNSAqICgkZSkKICAgIGVsc2UKICAgICAgcCA9IDIgLSBwCiAgICAgIHJldHVybiAuNSAqICgxIC0gKCRlKSkgKyAuNQogICAgZW5kCiAgXV0sIHYpCmVuZAoKCgpsb2NhbCB0d2VlbiA9IHt9CnR3ZWVuLl9faW5kZXggPSB0d2VlbgoKbG9jYWwgZnVuY3Rpb24gbWFrZWZzZXR0ZXIoZmllbGQpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBsb2NhbCBtdCA9IGdldG1ldGF0YWJsZSh4KQogICAgaWYgdHlwZSh4KSB+PSAiZnVuY3Rpb24iIGFuZCBub3QgKG10IGFuZCBtdC5fX2NhbGwpIHRoZW4KICAgICAgZXJyb3IoImV4cGVjdGVkIGZ1bmN0aW9uIG9yIGNhbGxhYmxlIiwgMikKICAgIGVuZAogICAgbG9jYWwgb2xkID0gc2VsZltmaWVsZF0KICAgIHNlbGZbZmllbGRdID0gb2xkIGFuZCBmdW5jdGlvbigpIG9sZCgpIHgoKSBlbmQgb3IgeAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgpsb2NhbCBmdW5jdGlvbiBtYWtlc2V0dGVyKGZpZWxkLCBjaGVja2ZuLCBlcnJtc2cpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBpZiBjaGVja2ZuIGFuZCBub3QgY2hlY2tmbih4KSB0aGVuCiAgICAgIGVycm9yKGVycm1zZzpnc3ViKCIlJHgiLCB0b3N0cmluZyh4KSksIDIpCiAgICBlbmQKICAgIHNlbGZbZmllbGRdID0geAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgp0d2Vlbi5lYXNlICA9IG1ha2VzZXR0ZXIoIl9lYXNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uKHgpIHJldHVybiBmbHV4LmVhc2luZ1t4XSBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGVhc2luZyB0eXBlICckeCciKQp0d2Vlbi5kZWxheSA9IG1ha2VzZXR0ZXIoIl9kZWxheSIsCiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbih4KSByZXR1cm4gdHlwZSh4KSA9PSAibnVtYmVyIiBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGRlbGF5IHRpbWU7IGV4cGVjdGVkIG51bWJlciIpCnR3ZWVuLm9uc3RhcnQgICAgID0gbWFrZWZzZXR0ZXIoIl9vbnN0YXJ0IikKdHdlZW4ub251cGRhdGUgICAgPSBtYWtlZnNldHRlcigiX29udXBkYXRlIikKdHdlZW4ub25jb21wbGV0ZSAgPSBtYWtlZnNldHRlcigiX29uY29tcGxldGUiKQoKCmZ1bmN0aW9uIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpCiAgbG9jYWwgc2VsZiA9IHNldG1ldGF0YWJsZSh7fSwgdHdlZW4pCiAgc2VsZi5vYmogPSBvYmoKICBzZWxmLnJhdGUgPSB0aW1lID4gMCBhbmQgMSAvIHRpbWUgb3IgMAogIHNlbGYucHJvZ3Jlc3MgPSB0aW1lID4gMCBhbmQgMCBvciAxCiAgc2VsZi5fZGVsYXkgPSAwCiAgc2VsZi5fZWFzZSA9ICJxdWFkb3V0IgogIHNlbGYudmFycyA9IHt9CiAgZm9yIGssIHYgaW4gcGFpcnModmFycykgZG8KICAgIGlmIHR5cGUodikgfj0gIm51bWJlciIgdGhlbgogICAgICBlcnJvcigiYmFkIHZhbHVlIGZvciBrZXkgJyIgLi4gayAuLiAiJzsgZXhwZWN0ZWQgbnVtYmVyIikKICAgIGVuZAogICAgc2VsZi52YXJzW2tdID0gdgogIGVuZAogIHJldHVybiBzZWxmCmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOmluaXQoKQogIGZvciBrLCB2IGluIHBhaXJzKHNlbGYudmFycykgZG8KICAgIGxvY2FsIHggPSBzZWxmLm9ialtrXQogICAgaWYgdHlwZSh4KSB+PSAibnVtYmVyIiB0aGVuCiAgICAgIGVycm9yKCJiYWQgdmFsdWUgb24gb2JqZWN0IGtleSAnIiAuLiBrIC4uICInOyBleHBlY3RlZCBudW1iZXIiKQogICAgZW5kCiAgICBzZWxmLnZhcnNba10gPSB7IHN0YXJ0ID0geCwgZGlmZiA9IHYgLSB4IH0KICBlbmQKICBzZWxmLmluaXRlZCA9IHRydWUKZW5kCgoKZnVuY3Rpb24gdHdlZW46YWZ0ZXIoLi4uKQogIGxvY2FsIHQKICBpZiBzZWxlY3QoIiMiLCAuLi4pID09IDIgdGhlbgogICAgdCA9IHR3ZWVuLm5ldyhzZWxmLm9iaiwgLi4uKQogIGVsc2UKICAgIHQgPSB0d2Vlbi5uZXcoLi4uKQogIGVuZAogIHQucGFyZW50ID0gc2VsZi5wYXJlbnQKICBzZWxmOm9uY29tcGxldGUoZnVuY3Rpb24oKSBmbHV4LmFkZChzZWxmLnBhcmVudCwgdCkgZW5kKQogIHJldHVybiB0CmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOnN0b3AoKQogIGZsdXgucmVtb3ZlKHNlbGYucGFyZW50LCBzZWxmKQplbmQKCgoKZnVuY3Rpb24gZmx1eC5ncm91cCgpCiAgcmV0dXJuIHNldG1ldGF0YWJsZSh7fSwgZmx1eCkKZW5kCgoKZnVuY3Rpb24gZmx1eDp0byhvYmosIHRpbWUsIHZhcnMpCiAgcmV0dXJuIGZsdXguYWRkKHNlbGYsIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpKQplbmQKCgpmdW5jdGlvbiBmbHV4OnVwZGF0ZShkZWx0YXRpbWUpCiAgZm9yIGkgPSAjc2VsZiwgMSwgLTEgZG8KICAgIGxvY2FsIHQgPSBzZWxmW2ldCiAgICBpZiB0Ll9kZWxheSA+IDAgdGhlbgogICAgICB0Ll9kZWxheSA9IHQuX2RlbGF5IC0gZGVsdGF0aW1lCiAgICBlbHNlCiAgICAgIGlmIG5vdCB0LmluaXRlZCB0aGVuCiAgICAgICAgZmx1eC5jbGVhcihzZWxmLCB0Lm9iaiwgdC52YXJzKQogICAgICAgIHQ6aW5pdCgpCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnN0YXJ0IHRoZW4KICAgICAgICB0Ll9vbnN0YXJ0KCkKICAgICAgICB0Ll9vbnN0YXJ0ID0gbmlsCiAgICAgIGVuZAogICAgICB0LnByb2dyZXNzID0gdC5wcm9ncmVzcyArIHQucmF0ZSAqIGRlbHRhdGltZQogICAgICBsb2NhbCBwID0gdC5wcm9ncmVzcwogICAgICBsb2NhbCB4ID0gcCA+PSAxIGFuZCAxIG9yIGZsdXguZWFzaW5nW3QuX2Vhc2VdKHApCiAgICAgIGZvciBrLCB2IGluIHBhaXJzKHQudmFycykgZG8KICAgICAgICB0Lm9ialtrXSA9IHYuc3RhcnQgKyB4ICogdi5kaWZmCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnVwZGF0ZSB0aGVuIHQuX29udXBkYXRlKCkgZW5kCiAgICAgIGlmIHAgPj0gMSB0aGVuCiAgICAgICAgZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgICAgICBpZiB0Ll9vbmNvbXBsZXRlIHRoZW4gdC5fb25jb21wbGV0ZSgpIGVuZAogICAgICBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmNsZWFyKG9iaiwgdmFycykKICBmb3IgdCBpbiBwYWlycyhzZWxmW29ial0pIGRvCiAgICBpZiB0LmluaXRlZCB0aGVuCiAgICAgIGZvciBrIGluIHBhaXJzKHZhcnMpIGRvIHQudmFyc1trXSA9IG5pbCBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmFkZCh0d2VlbikKICAtLSBBZGQgdG8gb2JqZWN0IHRhYmxlLCBjcmVhdGUgdGFibGUgaWYgaXQgZG9lcyBub3QgZXhpc3QKICBsb2NhbCBvYmogPSB0d2Vlbi5vYmoKICBzZWxmW29ial0gPSBzZWxmW29ial0gb3Ige30KICBzZWxmW29ial1bdHdlZW5dID0gdHJ1ZQogIC0tIEFkZCB0byBhcnJheQogIHRhYmxlLmluc2VydChzZWxmLCB0d2VlbikKICB0d2Vlbi5wYXJlbnQgPSBzZWxmCiAgcmV0dXJuIHR3ZWVuCmVuZAoKCmZ1bmN0aW9uIGZsdXg6cmVtb3ZlKHgpCiAgaWYgdHlwZSh4KSA9PSAibnVtYmVyIiB0aGVuCiAgICAtLSBSZW1vdmUgZnJvbSBvYmplY3QgdGFibGUsIGRlc3Ryb3kgdGFibGUgaWYgaXQgaXMgZW1wdHkKICAgIGxvY2FsIG9iaiA9IHNlbGZbeF0ub2JqCiAgICBzZWxmW29ial1bc2VsZlt4XV0gPSBuaWwKICAgIGlmIG5vdCBuZXh0KHNlbGZbb2JqXSkgdGhlbiBzZWxmW29ial0gPSBuaWwgZW5kCiAgICAtLSBSZW1vdmUgZnJvbSBhcnJheQogICAgc2VsZlt4XSA9IHNlbGZbI3NlbGZdCiAgICByZXR1cm4gdGFibGUucmVtb3ZlKHNlbGYpCiAgZW5kCiAgZm9yIGksIHYgaW4gaXBhaXJzKHNlbGYpIGRvCiAgICBpZiB2ID09IHggdGhlbgogICAgICByZXR1cm4gZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgIGVuZAogIGVuZAplbmQKCgoKbG9jYWwgYm91bmQgPSB7CiAgdG8gICAgICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgudG8oZmx1eC50d2VlbnMsIC4uLikgZW5kLAogIHVwZGF0ZSAgPSBmdW5jdGlvbiguLi4pIHJldHVybiBmbHV4LnVwZGF0ZShmbHV4LnR3ZWVucywgLi4uKSBlbmQsCiAgcmVtb3ZlICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgucmVtb3ZlKGZsdXgudHdlZW5zLCAuLi4pIGVuZCwKfQpzZXRtZXRhdGFibGUoYm91bmQsIGZsdXgpCgpyZXR1cm4gYm91bmQ=")
flux = CompileString(flux, "flux")()

function ShowClassChooser()
    local t = LocalPlayer():Team()
    local menu = vgui.Create("EditablePanel")
    menu:SetSize(ScrW(), ScrH())
    menu:MakePopup()
    menu.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(background)
        surface.DrawTexturedRect(0, (h - 491) / 2, w, 491)

        draw.SimpleText("Выберите класс:", "animelife.classchooser.subtitle", w / 2, 186 + 2, Color(0, 0, 0, 75), 1)
        draw.SimpleText("Выберите класс:", "animelife.classchooser.subtitle", w / 2, 186, Color(255, 255, 255), 1)
        draw.SimpleText(team.GetName(t), "animelife.classchooser.title", w / 2, 212 + 2, Color(0, 0, 0, 75), 1)
        draw.SimpleText(team.GetName(t), "animelife.classchooser.title", w / 2, 212, Color(255, 255, 255), 1)

        flux.update(RealFrameTime())
    end

    local function get_players(class)
        local count = 0
        for _, ply in pairs(player.GetAll()) do
            if ply:Team() == t then
                if ply:GetNWInt("animelife.classchooser.class", -1) == class then
                    count = count + 1
                end
            end
        end

        return count
    end

    local x = (menu:GetWide() - (table.Count(classchooser.List[t]) * (229 + 38)) ) / 2
    for key, class in pairs(classchooser.List[t]) do
        local btn = vgui.Create("DButton", menu)
        btn:SetSize(229, 491)
        btn:SetPos(x, (menu:GetTall() - 491) / 2)
        btn:SetText("")
        btn.Animations = {alpha = 1}
        btn.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 150 * self.Animations.alpha)
            surface.DrawRect(0, 0, w, h)

            draw.SimpleText(class.Name .. " (" .. get_players(key) .. "/" .. class.Limit .. ")", "animelife.classchooser.subtitle", w / 2, 46, Color(255, 255, 255), 1)
            draw.SimpleText(class.Description, "animelife.classchooser.stats", w / 2, 96, Color(255, 255, 255), 1)

            draw.SimpleText("Вооружение", "animelife.classchooser.stats.title", w / 2, 175, Color(255, 255, 255), 1)

            local wx, wy = w / 2, 210
            for i = 1, 4 do
                draw.SimpleText("• SWEP " .. i, "animelife.classchooser.stats", wx, wy, Color(255, 255, 255), 1)
                
                wy = wy + 18
            end

            draw.SimpleText("Характеристика", "animelife.classchooser.stats.title", w / 2, 321, Color(255, 255, 255), 1)

            local hp = class.Stats.hp
            local armor = class.Stats.armor
            local speed = class.Stats.speed
            draw.DrawText("Здоровье: " .. hp .. "\nБроня: " .. armor .. "\nСкорость: " .. speed, "animelife.classchooser.stats", w / 2, 321 + 24 + 22, Color(255, 255, 255), 1)
        end
        btn.OnCursorEntered = function(self)
            flux.to(self.Animations, 0.25, {alpha = 1.2})

            surface.PlaySound("click.wav")
        end
        btn.OnCursorExited = function(self)
            flux.to(self.Animations, 0.25, {alpha = 1})
        end
        btn.DoClick = function()
            surface.PlaySound("click02.wav")

            if get_players(key) >= class.Limit then
                return
            end

            menu:Remove()

            net.Start("animelife.classchooser.choose")
                net.WriteInt(key, 16)
            net.SendToServer()
        end

        x = x + 229 + 38
    end
end