local gradient = Material("animelife/hud/gradient.png")
local bar_health = Material("animelife/hud/bar_health.png")
local bar_health_f = Material("animelife/hud/bar_health_01.png")
local gmod_tool = Material("animelife/hud/gmod_tool.png")
local ammo_icon = Material("animelife/hud/ammo_icon.png")

local robot_bar_health = Material("animelife/hud/robots/health_bar_01.png")
local robot_bar_health_f = Material("animelife/hud/robots/health_bar.png")
local robot_ammo_base = Material("animelife/hud/robots/ammo_base.png")
local robot_ammo_icon = Material("animelife/hud/robots/ammo_icon.png")

local magician_bar_health = Material("animelife/hud/magicians/health_bar.png")
local magician_bar_health_f = Material("animelife/hud/magicians/health_bar_01.png")
local magician_bar_ammo = Material("animelife/hud/magicians/ammo_bar.png")

local monsters_vignette = Material("animelife/hud/monsters/vignette.png")
local monsters_heart = Material("animelife/hud/monsters/heart.png")

surface.CreateFont("animelife.Global.HUD_Name", {font = "Exo 2 SemiBold", size = 24, weight = 500, extended = true})
surface.CreateFont("animelife.Global.HUD_Money", {font = "Exo 2 SemiBold", size = 18, weight = 500, extended = true, italic = true})
surface.CreateFont("animelife.Global.HUD_Health", {font = "Exo 2 SemiBold", size = 31, weight = 500, extended = true, italic = true})
surface.CreateFont("animelife.Global.HUD_Magician_Health", {font = "Exo 2 Bold", size = 24, weight = 600, extended = true})

surface.CreateFont("animelife.Global.HUD_Tool_Title", {font = "Exo 2 SemiBold", size = 31, weight = 500, extended = true})
surface.CreateFont("animelife.Global.HUD_Tool_Desc", {font = "Exo 2 SemiBold", size = 18, weight = 500, extended = true})

surface.CreateFont("animelife.Global.HUD_Ammo_Big", {font = "Exo 2 SemiBold", size = 36, weight = 500, extended = true})
surface.CreateFont("animelife.Global.HUD_Ammo_Small", {font = "Exo 2 SemiBold", size = 24, weight = 500, extended = true})

surface.CreateFont("animelife.Global.HUD_Robot_Ammo_Big", {font = "Exo 2 SemiBold", size = 36, weight = 500, extended = true, italic = true})
surface.CreateFont("animelife.Global.HUD_Robot_Ammo_Small", {font = "Exo 2 SemiBold", size = 24, weight = 500, extended = true, italic = true})

local flux = util.Base64Decode("bG9jYWwgZmx1eCA9IHsgX3ZlcnNpb24gPSAiMC4xLjUiIH0KZmx1eC5fX2luZGV4ID0gZmx1eAoKZmx1eC50d2VlbnMgPSB7fQpmbHV4LmVhc2luZyA9IHsgbGluZWFyID0gZnVuY3Rpb24ocCkgcmV0dXJuIHAgZW5kIH0KCmxvY2FsIGVhc2luZyA9IHsKICBxdWFkICAgID0gInAgKiBwIiwKICBjdWJpYyAgID0gInAgKiBwICogcCIsCiAgcXVhcnQgICA9ICJwICogcCAqIHAgKiBwIiwKICBxdWludCAgID0gInAgKiBwICogcCAqIHAgKiBwIiwKICBleHBvICAgID0gIjIgXiAoMTAgKiAocCAtIDEpKSIsCiAgc2luZSAgICA9ICItbWF0aC5jb3MocCAqIChtYXRoLnBpICogLjUpKSArIDEiLAogIGNpcmMgICAgPSAiLShtYXRoLnNxcnQoMSAtIChwICogcCkpIC0gMSkiLAogIGJhY2sgICAgPSAicCAqIHAgKiAoMi43ICogcCAtIDEuNykiLAogIGVsYXN0aWMgPSAiLSgyXigxMCAqIChwIC0gMSkpICogbWF0aC5zaW4oKHAgLSAxLjA3NSkgKiAobWF0aC5waSAqIDIpIC8gLjMpKSIKfQoKbG9jYWwgbWFrZWZ1bmMgPSBmdW5jdGlvbihzdHIsIGV4cHIpCiAgcmV0dXJuIENvbXBpbGVTdHJpbmcoInJldHVybiBmdW5jdGlvbihwKSAiIC4uIHN0cjpnc3ViKCIlJGUiLCBleHByKSAuLiAiIGVuZCIsICJUZXN0RnVuY3Rpb24iKSgpCmVuZAoKZm9yIGssIHYgaW4gcGFpcnMoZWFzaW5nKSBkbwogIGZsdXguZWFzaW5nW2sgLi4gImluIl0gPSBtYWtlZnVuYygicmV0dXJuICRlIiwgdikKICBmbHV4LmVhc2luZ1trIC4uICJvdXQiXSA9IG1ha2VmdW5jKFtbCiAgICBwID0gMSAtIHAKICAgIHJldHVybiAxIC0gKCRlKQogIF1dLCB2KQogIGZsdXguZWFzaW5nW2sgLi4gImlub3V0Il0gPSBtYWtlZnVuYyhbWwogICAgcCA9IHAgKiAyCiAgICBpZiBwIDwgMSB0aGVuCiAgICAgIHJldHVybiAuNSAqICgkZSkKICAgIGVsc2UKICAgICAgcCA9IDIgLSBwCiAgICAgIHJldHVybiAuNSAqICgxIC0gKCRlKSkgKyAuNQogICAgZW5kCiAgXV0sIHYpCmVuZAoKCgpsb2NhbCB0d2VlbiA9IHt9CnR3ZWVuLl9faW5kZXggPSB0d2VlbgoKbG9jYWwgZnVuY3Rpb24gbWFrZWZzZXR0ZXIoZmllbGQpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBsb2NhbCBtdCA9IGdldG1ldGF0YWJsZSh4KQogICAgaWYgdHlwZSh4KSB+PSAiZnVuY3Rpb24iIGFuZCBub3QgKG10IGFuZCBtdC5fX2NhbGwpIHRoZW4KICAgICAgZXJyb3IoImV4cGVjdGVkIGZ1bmN0aW9uIG9yIGNhbGxhYmxlIiwgMikKICAgIGVuZAogICAgbG9jYWwgb2xkID0gc2VsZltmaWVsZF0KICAgIHNlbGZbZmllbGRdID0gb2xkIGFuZCBmdW5jdGlvbigpIG9sZCgpIHgoKSBlbmQgb3IgeAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgpsb2NhbCBmdW5jdGlvbiBtYWtlc2V0dGVyKGZpZWxkLCBjaGVja2ZuLCBlcnJtc2cpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBpZiBjaGVja2ZuIGFuZCBub3QgY2hlY2tmbih4KSB0aGVuCiAgICAgIGVycm9yKGVycm1zZzpnc3ViKCIlJHgiLCB0b3N0cmluZyh4KSksIDIpCiAgICBlbmQKICAgIHNlbGZbZmllbGRdID0geAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgp0d2Vlbi5lYXNlICA9IG1ha2VzZXR0ZXIoIl9lYXNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uKHgpIHJldHVybiBmbHV4LmVhc2luZ1t4XSBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGVhc2luZyB0eXBlICckeCciKQp0d2Vlbi5kZWxheSA9IG1ha2VzZXR0ZXIoIl9kZWxheSIsCiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbih4KSByZXR1cm4gdHlwZSh4KSA9PSAibnVtYmVyIiBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGRlbGF5IHRpbWU7IGV4cGVjdGVkIG51bWJlciIpCnR3ZWVuLm9uc3RhcnQgICAgID0gbWFrZWZzZXR0ZXIoIl9vbnN0YXJ0IikKdHdlZW4ub251cGRhdGUgICAgPSBtYWtlZnNldHRlcigiX29udXBkYXRlIikKdHdlZW4ub25jb21wbGV0ZSAgPSBtYWtlZnNldHRlcigiX29uY29tcGxldGUiKQoKCmZ1bmN0aW9uIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpCiAgbG9jYWwgc2VsZiA9IHNldG1ldGF0YWJsZSh7fSwgdHdlZW4pCiAgc2VsZi5vYmogPSBvYmoKICBzZWxmLnJhdGUgPSB0aW1lID4gMCBhbmQgMSAvIHRpbWUgb3IgMAogIHNlbGYucHJvZ3Jlc3MgPSB0aW1lID4gMCBhbmQgMCBvciAxCiAgc2VsZi5fZGVsYXkgPSAwCiAgc2VsZi5fZWFzZSA9ICJxdWFkb3V0IgogIHNlbGYudmFycyA9IHt9CiAgZm9yIGssIHYgaW4gcGFpcnModmFycykgZG8KICAgIGlmIHR5cGUodikgfj0gIm51bWJlciIgdGhlbgogICAgICBlcnJvcigiYmFkIHZhbHVlIGZvciBrZXkgJyIgLi4gayAuLiAiJzsgZXhwZWN0ZWQgbnVtYmVyIikKICAgIGVuZAogICAgc2VsZi52YXJzW2tdID0gdgogIGVuZAogIHJldHVybiBzZWxmCmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOmluaXQoKQogIGZvciBrLCB2IGluIHBhaXJzKHNlbGYudmFycykgZG8KICAgIGxvY2FsIHggPSBzZWxmLm9ialtrXQogICAgaWYgdHlwZSh4KSB+PSAibnVtYmVyIiB0aGVuCiAgICAgIGVycm9yKCJiYWQgdmFsdWUgb24gb2JqZWN0IGtleSAnIiAuLiBrIC4uICInOyBleHBlY3RlZCBudW1iZXIiKQogICAgZW5kCiAgICBzZWxmLnZhcnNba10gPSB7IHN0YXJ0ID0geCwgZGlmZiA9IHYgLSB4IH0KICBlbmQKICBzZWxmLmluaXRlZCA9IHRydWUKZW5kCgoKZnVuY3Rpb24gdHdlZW46YWZ0ZXIoLi4uKQogIGxvY2FsIHQKICBpZiBzZWxlY3QoIiMiLCAuLi4pID09IDIgdGhlbgogICAgdCA9IHR3ZWVuLm5ldyhzZWxmLm9iaiwgLi4uKQogIGVsc2UKICAgIHQgPSB0d2Vlbi5uZXcoLi4uKQogIGVuZAogIHQucGFyZW50ID0gc2VsZi5wYXJlbnQKICBzZWxmOm9uY29tcGxldGUoZnVuY3Rpb24oKSBmbHV4LmFkZChzZWxmLnBhcmVudCwgdCkgZW5kKQogIHJldHVybiB0CmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOnN0b3AoKQogIGZsdXgucmVtb3ZlKHNlbGYucGFyZW50LCBzZWxmKQplbmQKCgoKZnVuY3Rpb24gZmx1eC5ncm91cCgpCiAgcmV0dXJuIHNldG1ldGF0YWJsZSh7fSwgZmx1eCkKZW5kCgoKZnVuY3Rpb24gZmx1eDp0byhvYmosIHRpbWUsIHZhcnMpCiAgcmV0dXJuIGZsdXguYWRkKHNlbGYsIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpKQplbmQKCgpmdW5jdGlvbiBmbHV4OnVwZGF0ZShkZWx0YXRpbWUpCiAgZm9yIGkgPSAjc2VsZiwgMSwgLTEgZG8KICAgIGxvY2FsIHQgPSBzZWxmW2ldCiAgICBpZiB0Ll9kZWxheSA+IDAgdGhlbgogICAgICB0Ll9kZWxheSA9IHQuX2RlbGF5IC0gZGVsdGF0aW1lCiAgICBlbHNlCiAgICAgIGlmIG5vdCB0LmluaXRlZCB0aGVuCiAgICAgICAgZmx1eC5jbGVhcihzZWxmLCB0Lm9iaiwgdC52YXJzKQogICAgICAgIHQ6aW5pdCgpCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnN0YXJ0IHRoZW4KICAgICAgICB0Ll9vbnN0YXJ0KCkKICAgICAgICB0Ll9vbnN0YXJ0ID0gbmlsCiAgICAgIGVuZAogICAgICB0LnByb2dyZXNzID0gdC5wcm9ncmVzcyArIHQucmF0ZSAqIGRlbHRhdGltZQogICAgICBsb2NhbCBwID0gdC5wcm9ncmVzcwogICAgICBsb2NhbCB4ID0gcCA+PSAxIGFuZCAxIG9yIGZsdXguZWFzaW5nW3QuX2Vhc2VdKHApCiAgICAgIGZvciBrLCB2IGluIHBhaXJzKHQudmFycykgZG8KICAgICAgICB0Lm9ialtrXSA9IHYuc3RhcnQgKyB4ICogdi5kaWZmCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnVwZGF0ZSB0aGVuIHQuX29udXBkYXRlKCkgZW5kCiAgICAgIGlmIHAgPj0gMSB0aGVuCiAgICAgICAgZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgICAgICBpZiB0Ll9vbmNvbXBsZXRlIHRoZW4gdC5fb25jb21wbGV0ZSgpIGVuZAogICAgICBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmNsZWFyKG9iaiwgdmFycykKICBmb3IgdCBpbiBwYWlycyhzZWxmW29ial0pIGRvCiAgICBpZiB0LmluaXRlZCB0aGVuCiAgICAgIGZvciBrIGluIHBhaXJzKHZhcnMpIGRvIHQudmFyc1trXSA9IG5pbCBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmFkZCh0d2VlbikKICAtLSBBZGQgdG8gb2JqZWN0IHRhYmxlLCBjcmVhdGUgdGFibGUgaWYgaXQgZG9lcyBub3QgZXhpc3QKICBsb2NhbCBvYmogPSB0d2Vlbi5vYmoKICBzZWxmW29ial0gPSBzZWxmW29ial0gb3Ige30KICBzZWxmW29ial1bdHdlZW5dID0gdHJ1ZQogIC0tIEFkZCB0byBhcnJheQogIHRhYmxlLmluc2VydChzZWxmLCB0d2VlbikKICB0d2Vlbi5wYXJlbnQgPSBzZWxmCiAgcmV0dXJuIHR3ZWVuCmVuZAoKCmZ1bmN0aW9uIGZsdXg6cmVtb3ZlKHgpCiAgaWYgdHlwZSh4KSA9PSAibnVtYmVyIiB0aGVuCiAgICAtLSBSZW1vdmUgZnJvbSBvYmplY3QgdGFibGUsIGRlc3Ryb3kgdGFibGUgaWYgaXQgaXMgZW1wdHkKICAgIGxvY2FsIG9iaiA9IHNlbGZbeF0ub2JqCiAgICBzZWxmW29ial1bc2VsZlt4XV0gPSBuaWwKICAgIGlmIG5vdCBuZXh0KHNlbGZbb2JqXSkgdGhlbiBzZWxmW29ial0gPSBuaWwgZW5kCiAgICAtLSBSZW1vdmUgZnJvbSBhcnJheQogICAgc2VsZlt4XSA9IHNlbGZbI3NlbGZdCiAgICByZXR1cm4gdGFibGUucmVtb3ZlKHNlbGYpCiAgZW5kCiAgZm9yIGksIHYgaW4gaXBhaXJzKHNlbGYpIGRvCiAgICBpZiB2ID09IHggdGhlbgogICAgICByZXR1cm4gZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgIGVuZAogIGVuZAplbmQKCgoKbG9jYWwgYm91bmQgPSB7CiAgdG8gICAgICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgudG8oZmx1eC50d2VlbnMsIC4uLikgZW5kLAogIHVwZGF0ZSAgPSBmdW5jdGlvbiguLi4pIHJldHVybiBmbHV4LnVwZGF0ZShmbHV4LnR3ZWVucywgLi4uKSBlbmQsCiAgcmVtb3ZlICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgucmVtb3ZlKGZsdXgudHdlZW5zLCAuLi4pIGVuZCwKfQpzZXRtZXRhdGFibGUoYm91bmQsIGZsdXgpCgpyZXR1cm4gYm91bmQ=")
flux = CompileString(flux, "flux")()

local hud = {next_beat = 0, scale = 1}

HUD_TYPE = {
    -- Default
    [1] = function()
        local customizations_y = cookie.GetNumber("animelife.settings_hud_posy", 945) -- 945
        local keep_default = tobool(cookie.GetNumber("animelife.settings_hud_pos_default", 0))
        if keep_default then
            customizations_y = 945
        end

        local customizations_text_color = cookie.GetString("animelife.settings.hud_color", "255 255 255 255")
        customizations_text_color = string.ToColor(customizations_text_color)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(gradient)
        surface.DrawTexturedRect((ScrW() - 732) / 2, customizations_y, 723, 204)

        surface.SetMaterial(bar_health)
        surface.DrawTexturedRect((ScrW() - 332) / 2, customizations_y + 106, 332, 18)

        render.SetScissorRect(0, 0, (ScrW() - 324) / 2 + (324 * (LocalPlayer():Health() / LocalPlayer():GetMaxHealth())), ScrH(), true)
            surface.SetMaterial(bar_health_f)
            surface.DrawTexturedRect((ScrW() - 324) / 2, customizations_y + 110, 324, 10)
        render.SetScissorRect(0, 0, 0, 0, false)

        local name = LocalPlayer():Nick()
        local job = team.GetName(LocalPlayer():Team())
        local health = LocalPlayer():Health()
        local money = LocalPlayer():getDarkRPVar("money") or 0

        draw.SimpleText(name, "animelife.Global.HUD_Name", (ScrW() - 332) / 2 - 14 + 2, customizations_y + 123, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(name, "animelife.Global.HUD_Name", (ScrW() - 332) / 2 - 14, customizations_y + 123, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText(job, "animelife.Global.HUD_Name", (ScrW() - 332) / 2 + 332 + 14 + 2, customizations_y + 123, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(job, "animelife.Global.HUD_Name", (ScrW() - 332) / 2 + 332 + 14, customizations_y + 123, customizations_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText("¥" .. string.Comma(money), "animelife.Global.HUD_Money", (ScrW() - 332) / 2 + 24 + 2, customizations_y + 104, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText("¥" .. string.Comma(money), "animelife.Global.HUD_Money", (ScrW() - 332) / 2 + 24, customizations_y + 104, customizations_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText(health, "animelife.Global.HUD_Health", (ScrW() - 332) / 2 + 332 - 24 + 2, customizations_y + 120, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(health, "animelife.Global.HUD_Health", (ScrW() - 332) / 2 + 332 - 24, customizations_y + 120, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

        -- Ammo HUD
        if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() ~= "weapon_physcannon" then
            local wep = LocalPlayer():GetActiveWeapon()
            local ammo_left = wep:Clip1()
            if ammo_left >= 0 then
                local ammo_extra = LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType())
                surface.SetMaterial(ammo_icon)
                surface.DrawTexturedRect(ScrW() - 24 - 37, ScrH() - 24 - 16, 24, 24)

                local extra_len = string.len(ammo_extra)

                draw.SimpleText(ammo_extra, "animelife.Global.HUD_Ammo_Small", ScrW() - 69, ScrH() - 14 + 2, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
                draw.SimpleText(ammo_extra, "animelife.Global.HUD_Ammo_Small", ScrW() - 69, ScrH() - 14, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

                draw.SimpleText(ammo_left .. "/", "animelife.Global.HUD_Ammo_Big", ScrW() - 69 - (extra_len * 4) - 8, ScrH() - 12 + 2, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
                draw.SimpleText(ammo_left .. "/", "animelife.Global.HUD_Ammo_Big", ScrW() - 69 - (extra_len * 4) - 8, ScrH() - 12, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
            end
        end
    end,
    -- Robots
    [2] = function()
        local customizations_y = cookie.GetNumber("animelife.settings_hud_posy", 915) -- 915
        local keep_default = tobool(cookie.GetNumber("animelife.settings_hud_pos_default", 0))
        if keep_default then
            customizations_y = 915
        end

        local customizations_text_color = cookie.GetString("animelife.settings.hud_color", "255 255 255 255")
        customizations_text_color = string.ToColor(customizations_text_color)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(gradient)
        surface.DrawTexturedRect((ScrW() - 732) / 2, customizations_y, 723, 204)

        surface.SetMaterial(robot_bar_health)
        surface.DrawTexturedRect((ScrW() - 429) / 2, customizations_y + 106, 429, 28)

        render.SetScissorRect(0, 0, (ScrW() - 421) / 2 + (421 * (LocalPlayer():Health() / LocalPlayer():GetMaxHealth())), ScrH(), true)
            surface.SetMaterial(robot_bar_health_f)
            surface.DrawTexturedRect((ScrW() - 421) / 2, customizations_y + 110, 421, 20)
        render.SetScissorRect(0, 0, 0, 0, false)

        local name = LocalPlayer():Nick()
        local job = team.GetName(LocalPlayer():Team())
        local health = LocalPlayer():Health()
        local money = LocalPlayer():getDarkRPVar("money") or 0

        draw.SimpleText(name, "animelife.Global.HUD_Name", (ScrW() - 429) / 2 - 14 + 2, customizations_y + 132, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(name, "animelife.Global.HUD_Name", (ScrW() - 429) / 2 - 14, customizations_y + 132, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText(job, "animelife.Global.HUD_Name", (ScrW() - 429) / 2 + 429 + 14 + 2, customizations_y + 132, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(job, "animelife.Global.HUD_Name", (ScrW() - 429) / 2 + 429 + 14, customizations_y + 132, customizations_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText("¥" .. string.Comma(money), "animelife.Global.HUD_Money", (ScrW() - 429) / 2 + 42 + 2, customizations_y + 106, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText("¥" .. string.Comma(money), "animelife.Global.HUD_Money", (ScrW() - 429) / 2 + 42, customizations_y + 106, customizations_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText(health, "animelife.Global.HUD_Health", (ScrW() - 429) / 2 + 429 - 42 + 2, customizations_y + 128, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(health, "animelife.Global.HUD_Health", (ScrW() - 429) / 2 + 429 - 42, customizations_y + 128, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

        -- Ammo HUD
        if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() ~= "weapon_physcannon" then
            local wep = LocalPlayer():GetActiveWeapon()
            local ammo_left = wep:Clip1()
            if ammo_left >= 0 then
                local ammo_extra = LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType())
                surface.SetMaterial(robot_ammo_base)
                surface.DrawTexturedRect(ScrW() - 243 - 67, ScrH() - 23 - 37, 243, 23)
        
                surface.SetMaterial(robot_ammo_icon)
                surface.DrawTexturedRect(ScrW() - 53 - 66, ScrH() - 32 - 52, 53, 32)

                local extra_len = string.len(ammo_extra)

                draw.SimpleText(ammo_extra, "animelife.Global.HUD_Robot_Ammo_Small", ScrW() - 149, ScrH() - 37 + 2, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
                draw.SimpleText(ammo_extra, "animelife.Global.HUD_Robot_Ammo_Small", ScrW() - 149, ScrH() - 37, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        
                draw.SimpleText(ammo_left .. "/", "animelife.Global.HUD_Robot_Ammo_Big", ScrW() - 149 - (extra_len * 4) - 8, ScrH() - 35 + 2, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
                draw.SimpleText(ammo_left .. "/", "animelife.Global.HUD_Robot_Ammo_Big", ScrW() - 149 - (extra_len * 4) - 8, ScrH() - 35, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
            end
        end

        -- Draw artefacts on low hp
        if LocalPlayer():Health() < (math.floor(LocalPlayer():GetMaxHealth() * 0.15)) then
            for i = 1, 25 do
                surface.SetDrawColor(math.random(1, 255), math.random(1, 255), math.random(1, 255), 75)
                surface.DrawRect(math.random(4, ScrW() - 4), math.random(4, ScrH() - 4), 4, 4)
            end

            for i = 1, 5 do
                surface.SetDrawColor(math.random(1, 255), math.random(1, 255), math.random(1, 255), 75)
                surface.DrawRect(math.random(16, ScrW() - 16), math.random(4, ScrH() - 4), math.random(8, 16), 4)
            end
        end

        surface.SetDrawColor(255, 255, 255, 75)
        surface.DrawOutlinedRect(16, 17, ScrW() - 16 * 2, ScrH() - 17 * 2, 1)
    end,
    [3] = function()
        local customizations_y = cookie.GetNumber("animelife.settings_hud_posy", 925) -- 925
        local keep_default = tobool(cookie.GetNumber("animelife.settings_hud_pos_default", 0))
        if keep_default then
            customizations_y = 925
        end

        local customizations_text_color = cookie.GetString("animelife.settings.hud_color", "255 255 255 255")
        customizations_text_color = string.ToColor(customizations_text_color)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(gradient)
        surface.DrawTexturedRect((ScrW() - 732) / 2, customizations_y, 723, 204)

        surface.SetMaterial(magician_bar_health)
        surface.DrawTexturedRect((ScrW() - 430) / 2, customizations_y + 110, 430, 34)

        render.SetScissorRect(0, 0, (ScrW() - 430) / 2 + (430 * (LocalPlayer():Health() / LocalPlayer():GetMaxHealth())), ScrH(), true)
            surface.SetMaterial(magician_bar_health_f)
            surface.DrawTexturedRect((ScrW() - 430) / 2, customizations_y + 110, 430, 34)
        render.SetScissorRect(0, 0, 0, 0, false)

        local name = LocalPlayer():Nick()
        local job = team.GetName(LocalPlayer():Team())
        local health = LocalPlayer():Health()
        local money = LocalPlayer():getDarkRPVar("money") or 0

        draw.SimpleText(name, "animelife.Global.HUD_Name", (ScrW() - 430) / 2 - 14 + 2, customizations_y + 136, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(name, "animelife.Global.HUD_Name", (ScrW() - 430) / 2 - 14, customizations_y + 136, customizations_text_color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText(job, "animelife.Global.HUD_Name", (ScrW() - 430) / 2 + 430 + 14 + 2, customizations_y + 136, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(job, "animelife.Global.HUD_Name", (ScrW() - 430) / 2 + 430 + 14, customizations_y + 136, customizations_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText("¥" .. string.Comma(money), "animelife.Global.HUD_Money", (ScrW() - 430) / 2 + 24 + 2, customizations_y + 104, Color(0, 0, 0, 75), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText("¥" .. string.Comma(money), "animelife.Global.HUD_Money", (ScrW() - 430) / 2 + 24, customizations_y + 104, customizations_text_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

        draw.SimpleText(health, "animelife.Global.HUD_Magician_Health", (ScrW() - 430) / 2 + 430 - 42, customizations_y + 138, Color(105, 55, 6), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

        -- Ammo HUD
        if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() ~= "weapon_physcannon" then
            local wep = LocalPlayer():GetActiveWeapon()
            local ammo_left = wep:Clip1()
            if ammo_left >= 0 then
                local ammo_extra = LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType())
                surface.SetMaterial(magician_bar_ammo)
                surface.DrawTexturedRect(ScrW() - 176, ScrH() - 126, 184, 126)

                draw.SimpleTextOutlined(ammo_left .. "/" .. ammo_extra, "animelife.Global.HUD_Robot_Ammo_Small", ScrW() - 78, ScrH() - 32, Color(217, 189, 177), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, Color(63, 43, 34))
            end
        end
    end,
    [4] = function()
        surface.SetDrawColor(255, 255, 255, 45)
        surface.SetMaterial(monsters_vignette)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

        local mul_scale = hud.scale
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(monsters_heart)

        ui.Smooth(true, false)
            surface.DrawTexturedRect(92 - ((124 * mul_scale) / 2), ScrH() - (124 * mul_scale) - 17, 124 * mul_scale, 124 * mul_scale)
        ui.Smooth(false, false)

        if hud.next_beat < RealTime() then
            local div = 1 - (LocalPlayer():Health() / LocalPlayer():GetMaxHealth())
            div = div < 0.1 and 0.1 or div

            flux.to(hud, div, {scale = 1.05})
            :after(hud, div, {scale = 1})

            hud.next_beat = RealTime() + (div * 2)
        end
    end,
}

hook.Add("HUDPaint", "animelife.Global.RenderHUD", function()
    if !LocalPlayer():Alive() or !IsValid(LocalPlayer()) then return end
    if ValidPanel(GLOBALS_SCOREBOARD) and GLOBALS_SCOREBOARD:IsVisible() then return end

    -- Main HUD
    local job_table = LocalPlayer():getJobTable()
    if job_table.category == "Роботы" then
        HUD_TYPE[2]()
    elseif job_table.category == "Монстры" then
        HUD_TYPE[4]()
    else
        HUD_TYPE[1]()
    end

    local ent = LocalPlayer():GetEyeTrace().Entity
    if IsValid(ent) and ent:isKeysOwnable() and ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 40000 then
        ent:drawOwnableInfo()
    end

    -- Toolgun HUD
    -- surface.SetMaterial(gmod_tool)
    -- surface.DrawTexturedRect(ScrW() - 490 - 51, 0, 490, 96)

    -- draw.SimpleText("Удалитель", "animelife.Global.HUD_Tool_Title", ScrW() - 460, 10, Color(255, 255, 255))
    -- draw.SimpleText("Удаляет объекты", "animelife.Global.HUD_Tool_Desc", ScrW() - 486, 60, Color(255, 255, 255))

    flux.update(RealFrameTime())
end)

local monster_coloring = {
    ["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = -0.04,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0.5,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}
hook.Add("RenderScreenspaceEffects", "animelife.Global.Postprocessing", function()
    -- DrawColorModify(monster_coloring)
end)

hook.Add("HUDShouldDraw", "animelife.Global.HUDDefaults", function(e)
    if e == "CHudAmmo" or e == "CHudSecondaryAmmo" or e == "CHudBattery" then
        return false
    end
end)

function GM:DrawDeathNotice()
end

function GM:HUDDrawTargetID()
end

local notificationSound = GM.Config.notificationSound
local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound(notificationSound)

    -- Log to client console
    MsgC(Color(255, 203, 238), "[AnimeLife] ", Color(225, 225, 225, 255), txt, "\n")
end
usermessage.Hook("_Notify", DisplayNotify)