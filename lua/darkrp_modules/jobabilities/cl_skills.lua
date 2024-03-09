local background = Material("animelife/skillsystem/background.png")
local gradient = Material("animelife/skillsystem/gradient.png")
local button_skill = Material("animelife/skillsystem/button_skill.png")

local tets_mat = Material("animelife/skillsystem/skills/fix.png")

surface.CreateFont("animelife.skillsystem.title", {font = "Exo 2 SemiBold", weight = 600, size = 54, extended = true})
surface.CreateFont("animelife.skillsystem.name", {font = "Exo 2 SemiBold", weight = 600, size = 28, extended = true})
surface.CreateFont("animelife.skillsystem.description", {font = "Exo 2 Medium", weight = 500, size = 18, extended = true})

local flux = util.Base64Decode("bG9jYWwgZmx1eCA9IHsgX3ZlcnNpb24gPSAiMC4xLjUiIH0KZmx1eC5fX2luZGV4ID0gZmx1eAoKZmx1eC50d2VlbnMgPSB7fQpmbHV4LmVhc2luZyA9IHsgbGluZWFyID0gZnVuY3Rpb24ocCkgcmV0dXJuIHAgZW5kIH0KCmxvY2FsIGVhc2luZyA9IHsKICBxdWFkICAgID0gInAgKiBwIiwKICBjdWJpYyAgID0gInAgKiBwICogcCIsCiAgcXVhcnQgICA9ICJwICogcCAqIHAgKiBwIiwKICBxdWludCAgID0gInAgKiBwICogcCAqIHAgKiBwIiwKICBleHBvICAgID0gIjIgXiAoMTAgKiAocCAtIDEpKSIsCiAgc2luZSAgICA9ICItbWF0aC5jb3MocCAqIChtYXRoLnBpICogLjUpKSArIDEiLAogIGNpcmMgICAgPSAiLShtYXRoLnNxcnQoMSAtIChwICogcCkpIC0gMSkiLAogIGJhY2sgICAgPSAicCAqIHAgKiAoMi43ICogcCAtIDEuNykiLAogIGVsYXN0aWMgPSAiLSgyXigxMCAqIChwIC0gMSkpICogbWF0aC5zaW4oKHAgLSAxLjA3NSkgKiAobWF0aC5waSAqIDIpIC8gLjMpKSIKfQoKbG9jYWwgbWFrZWZ1bmMgPSBmdW5jdGlvbihzdHIsIGV4cHIpCiAgcmV0dXJuIENvbXBpbGVTdHJpbmcoInJldHVybiBmdW5jdGlvbihwKSAiIC4uIHN0cjpnc3ViKCIlJGUiLCBleHByKSAuLiAiIGVuZCIsICJUZXN0RnVuY3Rpb24iKSgpCmVuZAoKZm9yIGssIHYgaW4gcGFpcnMoZWFzaW5nKSBkbwogIGZsdXguZWFzaW5nW2sgLi4gImluIl0gPSBtYWtlZnVuYygicmV0dXJuICRlIiwgdikKICBmbHV4LmVhc2luZ1trIC4uICJvdXQiXSA9IG1ha2VmdW5jKFtbCiAgICBwID0gMSAtIHAKICAgIHJldHVybiAxIC0gKCRlKQogIF1dLCB2KQogIGZsdXguZWFzaW5nW2sgLi4gImlub3V0Il0gPSBtYWtlZnVuYyhbWwogICAgcCA9IHAgKiAyCiAgICBpZiBwIDwgMSB0aGVuCiAgICAgIHJldHVybiAuNSAqICgkZSkKICAgIGVsc2UKICAgICAgcCA9IDIgLSBwCiAgICAgIHJldHVybiAuNSAqICgxIC0gKCRlKSkgKyAuNQogICAgZW5kCiAgXV0sIHYpCmVuZAoKCgpsb2NhbCB0d2VlbiA9IHt9CnR3ZWVuLl9faW5kZXggPSB0d2VlbgoKbG9jYWwgZnVuY3Rpb24gbWFrZWZzZXR0ZXIoZmllbGQpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBsb2NhbCBtdCA9IGdldG1ldGF0YWJsZSh4KQogICAgaWYgdHlwZSh4KSB+PSAiZnVuY3Rpb24iIGFuZCBub3QgKG10IGFuZCBtdC5fX2NhbGwpIHRoZW4KICAgICAgZXJyb3IoImV4cGVjdGVkIGZ1bmN0aW9uIG9yIGNhbGxhYmxlIiwgMikKICAgIGVuZAogICAgbG9jYWwgb2xkID0gc2VsZltmaWVsZF0KICAgIHNlbGZbZmllbGRdID0gb2xkIGFuZCBmdW5jdGlvbigpIG9sZCgpIHgoKSBlbmQgb3IgeAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgpsb2NhbCBmdW5jdGlvbiBtYWtlc2V0dGVyKGZpZWxkLCBjaGVja2ZuLCBlcnJtc2cpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBpZiBjaGVja2ZuIGFuZCBub3QgY2hlY2tmbih4KSB0aGVuCiAgICAgIGVycm9yKGVycm1zZzpnc3ViKCIlJHgiLCB0b3N0cmluZyh4KSksIDIpCiAgICBlbmQKICAgIHNlbGZbZmllbGRdID0geAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgp0d2Vlbi5lYXNlICA9IG1ha2VzZXR0ZXIoIl9lYXNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uKHgpIHJldHVybiBmbHV4LmVhc2luZ1t4XSBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGVhc2luZyB0eXBlICckeCciKQp0d2Vlbi5kZWxheSA9IG1ha2VzZXR0ZXIoIl9kZWxheSIsCiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbih4KSByZXR1cm4gdHlwZSh4KSA9PSAibnVtYmVyIiBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGRlbGF5IHRpbWU7IGV4cGVjdGVkIG51bWJlciIpCnR3ZWVuLm9uc3RhcnQgICAgID0gbWFrZWZzZXR0ZXIoIl9vbnN0YXJ0IikKdHdlZW4ub251cGRhdGUgICAgPSBtYWtlZnNldHRlcigiX29udXBkYXRlIikKdHdlZW4ub25jb21wbGV0ZSAgPSBtYWtlZnNldHRlcigiX29uY29tcGxldGUiKQoKCmZ1bmN0aW9uIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpCiAgbG9jYWwgc2VsZiA9IHNldG1ldGF0YWJsZSh7fSwgdHdlZW4pCiAgc2VsZi5vYmogPSBvYmoKICBzZWxmLnJhdGUgPSB0aW1lID4gMCBhbmQgMSAvIHRpbWUgb3IgMAogIHNlbGYucHJvZ3Jlc3MgPSB0aW1lID4gMCBhbmQgMCBvciAxCiAgc2VsZi5fZGVsYXkgPSAwCiAgc2VsZi5fZWFzZSA9ICJxdWFkb3V0IgogIHNlbGYudmFycyA9IHt9CiAgZm9yIGssIHYgaW4gcGFpcnModmFycykgZG8KICAgIGlmIHR5cGUodikgfj0gIm51bWJlciIgdGhlbgogICAgICBlcnJvcigiYmFkIHZhbHVlIGZvciBrZXkgJyIgLi4gayAuLiAiJzsgZXhwZWN0ZWQgbnVtYmVyIikKICAgIGVuZAogICAgc2VsZi52YXJzW2tdID0gdgogIGVuZAogIHJldHVybiBzZWxmCmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOmluaXQoKQogIGZvciBrLCB2IGluIHBhaXJzKHNlbGYudmFycykgZG8KICAgIGxvY2FsIHggPSBzZWxmLm9ialtrXQogICAgaWYgdHlwZSh4KSB+PSAibnVtYmVyIiB0aGVuCiAgICAgIGVycm9yKCJiYWQgdmFsdWUgb24gb2JqZWN0IGtleSAnIiAuLiBrIC4uICInOyBleHBlY3RlZCBudW1iZXIiKQogICAgZW5kCiAgICBzZWxmLnZhcnNba10gPSB7IHN0YXJ0ID0geCwgZGlmZiA9IHYgLSB4IH0KICBlbmQKICBzZWxmLmluaXRlZCA9IHRydWUKZW5kCgoKZnVuY3Rpb24gdHdlZW46YWZ0ZXIoLi4uKQogIGxvY2FsIHQKICBpZiBzZWxlY3QoIiMiLCAuLi4pID09IDIgdGhlbgogICAgdCA9IHR3ZWVuLm5ldyhzZWxmLm9iaiwgLi4uKQogIGVsc2UKICAgIHQgPSB0d2Vlbi5uZXcoLi4uKQogIGVuZAogIHQucGFyZW50ID0gc2VsZi5wYXJlbnQKICBzZWxmOm9uY29tcGxldGUoZnVuY3Rpb24oKSBmbHV4LmFkZChzZWxmLnBhcmVudCwgdCkgZW5kKQogIHJldHVybiB0CmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOnN0b3AoKQogIGZsdXgucmVtb3ZlKHNlbGYucGFyZW50LCBzZWxmKQplbmQKCgoKZnVuY3Rpb24gZmx1eC5ncm91cCgpCiAgcmV0dXJuIHNldG1ldGF0YWJsZSh7fSwgZmx1eCkKZW5kCgoKZnVuY3Rpb24gZmx1eDp0byhvYmosIHRpbWUsIHZhcnMpCiAgcmV0dXJuIGZsdXguYWRkKHNlbGYsIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpKQplbmQKCgpmdW5jdGlvbiBmbHV4OnVwZGF0ZShkZWx0YXRpbWUpCiAgZm9yIGkgPSAjc2VsZiwgMSwgLTEgZG8KICAgIGxvY2FsIHQgPSBzZWxmW2ldCiAgICBpZiB0Ll9kZWxheSA+IDAgdGhlbgogICAgICB0Ll9kZWxheSA9IHQuX2RlbGF5IC0gZGVsdGF0aW1lCiAgICBlbHNlCiAgICAgIGlmIG5vdCB0LmluaXRlZCB0aGVuCiAgICAgICAgZmx1eC5jbGVhcihzZWxmLCB0Lm9iaiwgdC52YXJzKQogICAgICAgIHQ6aW5pdCgpCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnN0YXJ0IHRoZW4KICAgICAgICB0Ll9vbnN0YXJ0KCkKICAgICAgICB0Ll9vbnN0YXJ0ID0gbmlsCiAgICAgIGVuZAogICAgICB0LnByb2dyZXNzID0gdC5wcm9ncmVzcyArIHQucmF0ZSAqIGRlbHRhdGltZQogICAgICBsb2NhbCBwID0gdC5wcm9ncmVzcwogICAgICBsb2NhbCB4ID0gcCA+PSAxIGFuZCAxIG9yIGZsdXguZWFzaW5nW3QuX2Vhc2VdKHApCiAgICAgIGZvciBrLCB2IGluIHBhaXJzKHQudmFycykgZG8KICAgICAgICB0Lm9ialtrXSA9IHYuc3RhcnQgKyB4ICogdi5kaWZmCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnVwZGF0ZSB0aGVuIHQuX29udXBkYXRlKCkgZW5kCiAgICAgIGlmIHAgPj0gMSB0aGVuCiAgICAgICAgZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgICAgICBpZiB0Ll9vbmNvbXBsZXRlIHRoZW4gdC5fb25jb21wbGV0ZSgpIGVuZAogICAgICBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmNsZWFyKG9iaiwgdmFycykKICBmb3IgdCBpbiBwYWlycyhzZWxmW29ial0pIGRvCiAgICBpZiB0LmluaXRlZCB0aGVuCiAgICAgIGZvciBrIGluIHBhaXJzKHZhcnMpIGRvIHQudmFyc1trXSA9IG5pbCBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmFkZCh0d2VlbikKICAtLSBBZGQgdG8gb2JqZWN0IHRhYmxlLCBjcmVhdGUgdGFibGUgaWYgaXQgZG9lcyBub3QgZXhpc3QKICBsb2NhbCBvYmogPSB0d2Vlbi5vYmoKICBzZWxmW29ial0gPSBzZWxmW29ial0gb3Ige30KICBzZWxmW29ial1bdHdlZW5dID0gdHJ1ZQogIC0tIEFkZCB0byBhcnJheQogIHRhYmxlLmluc2VydChzZWxmLCB0d2VlbikKICB0d2Vlbi5wYXJlbnQgPSBzZWxmCiAgcmV0dXJuIHR3ZWVuCmVuZAoKCmZ1bmN0aW9uIGZsdXg6cmVtb3ZlKHgpCiAgaWYgdHlwZSh4KSA9PSAibnVtYmVyIiB0aGVuCiAgICAtLSBSZW1vdmUgZnJvbSBvYmplY3QgdGFibGUsIGRlc3Ryb3kgdGFibGUgaWYgaXQgaXMgZW1wdHkKICAgIGxvY2FsIG9iaiA9IHNlbGZbeF0ub2JqCiAgICBzZWxmW29ial1bc2VsZlt4XV0gPSBuaWwKICAgIGlmIG5vdCBuZXh0KHNlbGZbb2JqXSkgdGhlbiBzZWxmW29ial0gPSBuaWwgZW5kCiAgICAtLSBSZW1vdmUgZnJvbSBhcnJheQogICAgc2VsZlt4XSA9IHNlbGZbI3NlbGZdCiAgICByZXR1cm4gdGFibGUucmVtb3ZlKHNlbGYpCiAgZW5kCiAgZm9yIGksIHYgaW4gaXBhaXJzKHNlbGYpIGRvCiAgICBpZiB2ID09IHggdGhlbgogICAgICByZXR1cm4gZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgIGVuZAogIGVuZAplbmQKCgoKbG9jYWwgYm91bmQgPSB7CiAgdG8gICAgICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgudG8oZmx1eC50d2VlbnMsIC4uLikgZW5kLAogIHVwZGF0ZSAgPSBmdW5jdGlvbiguLi4pIHJldHVybiBmbHV4LnVwZGF0ZShmbHV4LnR3ZWVucywgLi4uKSBlbmQsCiAgcmVtb3ZlICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgucmVtb3ZlKGZsdXgudHdlZW5zLCAuLi4pIGVuZCwKfQpzZXRtZXRhdGFibGUoYm91bmQsIGZsdXgpCgpyZXR1cm4gYm91bmQ=")
flux = CompileString(flux, "flux")()

local next_open = 0

local function ShowSkillsMenu()
    if next_open > CurTime() then
        return
    end

    local menu = vgui.Create("EditablePanel")
    menu:SetSize(ScrW(), ScrH())
    menu:MakePopup()
    menu:SetAlpha(0)
    menu:AlphaTo(255, 0.25)
    menu.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 185)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(background)
        surface.DrawTexturedRect(0, (h - 704) / 2, w, 704)

        surface.SetMaterial(gradient)
        surface.DrawTexturedRect((w - 417) / 2, (h - 704) / 2 + 144, 417, 9)

        draw.SimpleText("Скиллы", "animelife.skillsystem.title", w / 2 + 2, (h - 704) / 2 + 88, Color(0, 0, 0, 75), 1)
        draw.SimpleText("Скиллы", "animelife.skillsystem.title", w / 2, (h - 704) / 2 + 86, Color(255, 255, 255), 1)

        flux.update(RealFrameTime())
    end
    menu.Think = function(self)
        if !input.IsKeyDown(KEY_F) then
            if ValidPanel(self) then
                self:Remove()
            end
        end
    end

    local tbl = skills.List[LocalPlayer():Team()]
    local x = (menu:GetWide() - (table.Count(tbl) * (425 - 32))) / 2
    for key, skill in pairs(tbl) do
        local btn = vgui.Create("DButton", menu)
        btn:SetSize(425, 474)
        btn:SetPos(x, (menu:GetTall() - 474) / 2 + 38)
        btn:SetText("")
        btn.Animations = {space = 12}
        btn.Paint = function(self, w, h)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(button_skill)
            surface.DrawTexturedRect(0, 0, w, h)

            surface.SetMaterial(skill.Icon)
            surface.DrawTexturedRect((w - skill.Icon:Width()) / 2 - 8, (h - skill.Icon:Height()) / 2 - 56, skill.Icon:Width(), skill.Icon:Height())

            -- draw.SimpleText(skill.Name, "animelife.skillsystem.name", w / 2 - 10, 308, Color(255, 255, 255), 1)
            local text = skill.Name
            local x = (w - (utf8.len(text) * 1 * self.Animations.space)) / 2 - 2
            for i = 1, utf8.len(text) do
                local char = utf8.sub(text, i, i)
                draw.SimpleText(char, "animelife.skillsystem.name", x, 308, Color(255, 255, 255), 1)

                x = x + self.Animations.space
            end

            local cd = skill.Cooldown
            if cd < 60 then
                cd = cd .. " с."
            else
                cd = (cd / 60) .. " мин."
            end

            draw.DrawText(skill.Description .. "\nПерерыв: " .. cd, "animelife.skillsystem.description", w / 2 - 10, 356, Color(255, 255, 255), 1)
        end
        btn.OnCursorEntered = function(self)
            flux.to(self.Animations, 0.25, {space = 16})
            surface.PlaySound("generic-hover-softer.wav")
        end
        btn.OnCursorExited = function(self)
            flux.to(self.Animations, 0.25, {space = 12})
        end
        btn.DoClick = function()
            menu:Remove()

            surface.PlaySound("generic-select-softer.wav")

            next_open = CurTime() + 0.5

            net.Start("animelife.skillsystem.run")
                net.WriteInt(key, 8)
            net.SendToServer()
        end

        x = x + 425 - 32
    end
end

net.Receive("animelife.skillsystem.menu", function()
    ShowSkillsMenu()
end)