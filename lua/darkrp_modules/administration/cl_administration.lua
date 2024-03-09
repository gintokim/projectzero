local ban_text = "У вас бан\n(￣︿￣)\nПричина: %s\nДата разбана: %s\nОсталось подождать: %s"
local jail_text = "У вас срок\n(￣︿￣)\nОсталось подождать: %s"

FONT_WEIGHT_BOLD = 700
FONT_WEIGHT_REGULAR = 400
FONT_WEIGHT_LIGHT = 300
FONT_WEIGHT_MEDIUM = 500
FONT_WEIGHT_SEMIBOLD = 600

surface.CreateFont("animelife.administration.hud.title", {font = "Exo 2", size = 58, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.administration.hud.title.shadow", {font = "Exo 2", size = 58, weight = FONT_WEIGHT_BOLD, blursize = 4, extended = true})
surface.CreateFont("animelife.administration.hud.subtitle", {font = "Exo 2", size = 29, weight = FONT_WEIGHT_BOLD, extended = true})
surface.CreateFont("animelife.administration.hud.subtitle.shadow", {font = "Exo 2", size = 29, weight = FONT_WEIGHT_BOLD, blursize = 4, extended = true})
surface.CreateFont("animelife.administration.hud.report", {font = "Exo 2", size = 14, weight = FONT_WEIGHT_REGULAR, extended = true})

local hud_report = Material("animelife/administration/hud_report.png")

local flux = util.Base64Decode("bG9jYWwgZmx1eCA9IHsgX3ZlcnNpb24gPSAiMC4xLjUiIH0KZmx1eC5fX2luZGV4ID0gZmx1eAoKZmx1eC50d2VlbnMgPSB7fQpmbHV4LmVhc2luZyA9IHsgbGluZWFyID0gZnVuY3Rpb24ocCkgcmV0dXJuIHAgZW5kIH0KCmxvY2FsIGVhc2luZyA9IHsKICBxdWFkICAgID0gInAgKiBwIiwKICBjdWJpYyAgID0gInAgKiBwICogcCIsCiAgcXVhcnQgICA9ICJwICogcCAqIHAgKiBwIiwKICBxdWludCAgID0gInAgKiBwICogcCAqIHAgKiBwIiwKICBleHBvICAgID0gIjIgXiAoMTAgKiAocCAtIDEpKSIsCiAgc2luZSAgICA9ICItbWF0aC5jb3MocCAqIChtYXRoLnBpICogLjUpKSArIDEiLAogIGNpcmMgICAgPSAiLShtYXRoLnNxcnQoMSAtIChwICogcCkpIC0gMSkiLAogIGJhY2sgICAgPSAicCAqIHAgKiAoMi43ICogcCAtIDEuNykiLAogIGVsYXN0aWMgPSAiLSgyXigxMCAqIChwIC0gMSkpICogbWF0aC5zaW4oKHAgLSAxLjA3NSkgKiAobWF0aC5waSAqIDIpIC8gLjMpKSIKfQoKbG9jYWwgbWFrZWZ1bmMgPSBmdW5jdGlvbihzdHIsIGV4cHIpCiAgcmV0dXJuIENvbXBpbGVTdHJpbmcoInJldHVybiBmdW5jdGlvbihwKSAiIC4uIHN0cjpnc3ViKCIlJGUiLCBleHByKSAuLiAiIGVuZCIsICJUZXN0RnVuY3Rpb24iKSgpCmVuZAoKZm9yIGssIHYgaW4gcGFpcnMoZWFzaW5nKSBkbwogIGZsdXguZWFzaW5nW2sgLi4gImluIl0gPSBtYWtlZnVuYygicmV0dXJuICRlIiwgdikKICBmbHV4LmVhc2luZ1trIC4uICJvdXQiXSA9IG1ha2VmdW5jKFtbCiAgICBwID0gMSAtIHAKICAgIHJldHVybiAxIC0gKCRlKQogIF1dLCB2KQogIGZsdXguZWFzaW5nW2sgLi4gImlub3V0Il0gPSBtYWtlZnVuYyhbWwogICAgcCA9IHAgKiAyCiAgICBpZiBwIDwgMSB0aGVuCiAgICAgIHJldHVybiAuNSAqICgkZSkKICAgIGVsc2UKICAgICAgcCA9IDIgLSBwCiAgICAgIHJldHVybiAuNSAqICgxIC0gKCRlKSkgKyAuNQogICAgZW5kCiAgXV0sIHYpCmVuZAoKCgpsb2NhbCB0d2VlbiA9IHt9CnR3ZWVuLl9faW5kZXggPSB0d2VlbgoKbG9jYWwgZnVuY3Rpb24gbWFrZWZzZXR0ZXIoZmllbGQpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBsb2NhbCBtdCA9IGdldG1ldGF0YWJsZSh4KQogICAgaWYgdHlwZSh4KSB+PSAiZnVuY3Rpb24iIGFuZCBub3QgKG10IGFuZCBtdC5fX2NhbGwpIHRoZW4KICAgICAgZXJyb3IoImV4cGVjdGVkIGZ1bmN0aW9uIG9yIGNhbGxhYmxlIiwgMikKICAgIGVuZAogICAgbG9jYWwgb2xkID0gc2VsZltmaWVsZF0KICAgIHNlbGZbZmllbGRdID0gb2xkIGFuZCBmdW5jdGlvbigpIG9sZCgpIHgoKSBlbmQgb3IgeAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgpsb2NhbCBmdW5jdGlvbiBtYWtlc2V0dGVyKGZpZWxkLCBjaGVja2ZuLCBlcnJtc2cpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBpZiBjaGVja2ZuIGFuZCBub3QgY2hlY2tmbih4KSB0aGVuCiAgICAgIGVycm9yKGVycm1zZzpnc3ViKCIlJHgiLCB0b3N0cmluZyh4KSksIDIpCiAgICBlbmQKICAgIHNlbGZbZmllbGRdID0geAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgp0d2Vlbi5lYXNlICA9IG1ha2VzZXR0ZXIoIl9lYXNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uKHgpIHJldHVybiBmbHV4LmVhc2luZ1t4XSBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGVhc2luZyB0eXBlICckeCciKQp0d2Vlbi5kZWxheSA9IG1ha2VzZXR0ZXIoIl9kZWxheSIsCiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbih4KSByZXR1cm4gdHlwZSh4KSA9PSAibnVtYmVyIiBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGRlbGF5IHRpbWU7IGV4cGVjdGVkIG51bWJlciIpCnR3ZWVuLm9uc3RhcnQgICAgID0gbWFrZWZzZXR0ZXIoIl9vbnN0YXJ0IikKdHdlZW4ub251cGRhdGUgICAgPSBtYWtlZnNldHRlcigiX29udXBkYXRlIikKdHdlZW4ub25jb21wbGV0ZSAgPSBtYWtlZnNldHRlcigiX29uY29tcGxldGUiKQoKCmZ1bmN0aW9uIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpCiAgbG9jYWwgc2VsZiA9IHNldG1ldGF0YWJsZSh7fSwgdHdlZW4pCiAgc2VsZi5vYmogPSBvYmoKICBzZWxmLnJhdGUgPSB0aW1lID4gMCBhbmQgMSAvIHRpbWUgb3IgMAogIHNlbGYucHJvZ3Jlc3MgPSB0aW1lID4gMCBhbmQgMCBvciAxCiAgc2VsZi5fZGVsYXkgPSAwCiAgc2VsZi5fZWFzZSA9ICJxdWFkb3V0IgogIHNlbGYudmFycyA9IHt9CiAgZm9yIGssIHYgaW4gcGFpcnModmFycykgZG8KICAgIGlmIHR5cGUodikgfj0gIm51bWJlciIgdGhlbgogICAgICBlcnJvcigiYmFkIHZhbHVlIGZvciBrZXkgJyIgLi4gayAuLiAiJzsgZXhwZWN0ZWQgbnVtYmVyIikKICAgIGVuZAogICAgc2VsZi52YXJzW2tdID0gdgogIGVuZAogIHJldHVybiBzZWxmCmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOmluaXQoKQogIGZvciBrLCB2IGluIHBhaXJzKHNlbGYudmFycykgZG8KICAgIGxvY2FsIHggPSBzZWxmLm9ialtrXQogICAgaWYgdHlwZSh4KSB+PSAibnVtYmVyIiB0aGVuCiAgICAgIGVycm9yKCJiYWQgdmFsdWUgb24gb2JqZWN0IGtleSAnIiAuLiBrIC4uICInOyBleHBlY3RlZCBudW1iZXIiKQogICAgZW5kCiAgICBzZWxmLnZhcnNba10gPSB7IHN0YXJ0ID0geCwgZGlmZiA9IHYgLSB4IH0KICBlbmQKICBzZWxmLmluaXRlZCA9IHRydWUKZW5kCgoKZnVuY3Rpb24gdHdlZW46YWZ0ZXIoLi4uKQogIGxvY2FsIHQKICBpZiBzZWxlY3QoIiMiLCAuLi4pID09IDIgdGhlbgogICAgdCA9IHR3ZWVuLm5ldyhzZWxmLm9iaiwgLi4uKQogIGVsc2UKICAgIHQgPSB0d2Vlbi5uZXcoLi4uKQogIGVuZAogIHQucGFyZW50ID0gc2VsZi5wYXJlbnQKICBzZWxmOm9uY29tcGxldGUoZnVuY3Rpb24oKSBmbHV4LmFkZChzZWxmLnBhcmVudCwgdCkgZW5kKQogIHJldHVybiB0CmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOnN0b3AoKQogIGZsdXgucmVtb3ZlKHNlbGYucGFyZW50LCBzZWxmKQplbmQKCgoKZnVuY3Rpb24gZmx1eC5ncm91cCgpCiAgcmV0dXJuIHNldG1ldGF0YWJsZSh7fSwgZmx1eCkKZW5kCgoKZnVuY3Rpb24gZmx1eDp0byhvYmosIHRpbWUsIHZhcnMpCiAgcmV0dXJuIGZsdXguYWRkKHNlbGYsIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpKQplbmQKCgpmdW5jdGlvbiBmbHV4OnVwZGF0ZShkZWx0YXRpbWUpCiAgZm9yIGkgPSAjc2VsZiwgMSwgLTEgZG8KICAgIGxvY2FsIHQgPSBzZWxmW2ldCiAgICBpZiB0Ll9kZWxheSA+IDAgdGhlbgogICAgICB0Ll9kZWxheSA9IHQuX2RlbGF5IC0gZGVsdGF0aW1lCiAgICBlbHNlCiAgICAgIGlmIG5vdCB0LmluaXRlZCB0aGVuCiAgICAgICAgZmx1eC5jbGVhcihzZWxmLCB0Lm9iaiwgdC52YXJzKQogICAgICAgIHQ6aW5pdCgpCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnN0YXJ0IHRoZW4KICAgICAgICB0Ll9vbnN0YXJ0KCkKICAgICAgICB0Ll9vbnN0YXJ0ID0gbmlsCiAgICAgIGVuZAogICAgICB0LnByb2dyZXNzID0gdC5wcm9ncmVzcyArIHQucmF0ZSAqIGRlbHRhdGltZQogICAgICBsb2NhbCBwID0gdC5wcm9ncmVzcwogICAgICBsb2NhbCB4ID0gcCA+PSAxIGFuZCAxIG9yIGZsdXguZWFzaW5nW3QuX2Vhc2VdKHApCiAgICAgIGZvciBrLCB2IGluIHBhaXJzKHQudmFycykgZG8KICAgICAgICB0Lm9ialtrXSA9IHYuc3RhcnQgKyB4ICogdi5kaWZmCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnVwZGF0ZSB0aGVuIHQuX29udXBkYXRlKCkgZW5kCiAgICAgIGlmIHAgPj0gMSB0aGVuCiAgICAgICAgZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgICAgICBpZiB0Ll9vbmNvbXBsZXRlIHRoZW4gdC5fb25jb21wbGV0ZSgpIGVuZAogICAgICBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmNsZWFyKG9iaiwgdmFycykKICBmb3IgdCBpbiBwYWlycyhzZWxmW29ial0pIGRvCiAgICBpZiB0LmluaXRlZCB0aGVuCiAgICAgIGZvciBrIGluIHBhaXJzKHZhcnMpIGRvIHQudmFyc1trXSA9IG5pbCBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmFkZCh0d2VlbikKICAtLSBBZGQgdG8gb2JqZWN0IHRhYmxlLCBjcmVhdGUgdGFibGUgaWYgaXQgZG9lcyBub3QgZXhpc3QKICBsb2NhbCBvYmogPSB0d2Vlbi5vYmoKICBzZWxmW29ial0gPSBzZWxmW29ial0gb3Ige30KICBzZWxmW29ial1bdHdlZW5dID0gdHJ1ZQogIC0tIEFkZCB0byBhcnJheQogIHRhYmxlLmluc2VydChzZWxmLCB0d2VlbikKICB0d2Vlbi5wYXJlbnQgPSBzZWxmCiAgcmV0dXJuIHR3ZWVuCmVuZAoKCmZ1bmN0aW9uIGZsdXg6cmVtb3ZlKHgpCiAgaWYgdHlwZSh4KSA9PSAibnVtYmVyIiB0aGVuCiAgICAtLSBSZW1vdmUgZnJvbSBvYmplY3QgdGFibGUsIGRlc3Ryb3kgdGFibGUgaWYgaXQgaXMgZW1wdHkKICAgIGxvY2FsIG9iaiA9IHNlbGZbeF0ub2JqCiAgICBzZWxmW29ial1bc2VsZlt4XV0gPSBuaWwKICAgIGlmIG5vdCBuZXh0KHNlbGZbb2JqXSkgdGhlbiBzZWxmW29ial0gPSBuaWwgZW5kCiAgICAtLSBSZW1vdmUgZnJvbSBhcnJheQogICAgc2VsZlt4XSA9IHNlbGZbI3NlbGZdCiAgICByZXR1cm4gdGFibGUucmVtb3ZlKHNlbGYpCiAgZW5kCiAgZm9yIGksIHYgaW4gaXBhaXJzKHNlbGYpIGRvCiAgICBpZiB2ID09IHggdGhlbgogICAgICByZXR1cm4gZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgIGVuZAogIGVuZAplbmQKCgoKbG9jYWwgYm91bmQgPSB7CiAgdG8gICAgICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgudG8oZmx1eC50d2VlbnMsIC4uLikgZW5kLAogIHVwZGF0ZSAgPSBmdW5jdGlvbiguLi4pIHJldHVybiBmbHV4LnVwZGF0ZShmbHV4LnR3ZWVucywgLi4uKSBlbmQsCiAgcmVtb3ZlICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgucmVtb3ZlKGZsdXgudHdlZW5zLCAuLi4pIGVuZCwKfQpzZXRtZXRhdGFibGUoYm91bmQsIGZsdXgpCgpyZXR1cm4gYm91bmQ=")
flux = CompileString(flux, "flux")()

GLOBALS_REPORTS = GLOBALS_REPORTS or {}
local report_anim = {icon_alpha = 0, text_alpha = 0, text_x = -8, report_count = 0}

hook.Add("HUDPaint", "animelife.administration.RenderHUD", function()
    if !IsValid(LocalPlayer()) then return end
    if ValidPanel(GLOBALS_SCOREBOARD) and GLOBALS_SCOREBOARD:IsVisible() then return end
    local both_y = 58

    if LocalPlayer():GetNWBool("animelife.administration.jail", false) then
        local wait = LocalPlayer():GetNWFloat("animelife.administration.jail_wait", 0) - UnPredictedCurTime()
        if wait > 0 then
            local t = string.Split(jail_text, "\n")
            draw.SimpleText(t[1], "animelife.administration.hud.title.shadow", ScrW() / 2, both_y + 2, Color(0, 0, 0, 150), 1)
            draw.SimpleText(t[1], "animelife.administration.hud.title", ScrW() / 2, both_y, Color(255, 255, 255, 150), 1)
            
            wait = string.ToMinutesSeconds(wait)
            for i = 2, 3 do
                local y = i == 2 and both_y + 58 + 2 or both_y + 58 + 2 + 29 + 2
                draw.SimpleText(string.format(t[i], wait), "animelife.administration.hud.subtitle.shadow", ScrW() / 2, y + 2, Color(0, 0, 0, 150), 1)
                draw.SimpleText(string.format(t[i], wait), "animelife.administration.hud.subtitle", ScrW() / 2, y, Color(255, 255, 255, 150), 1)
            end

            both_y = 200
        end
    end

    if LocalPlayer():GetNWBool("animelife.administration.ban", false) then
        local wait = LocalPlayer():GetNWInt("animelife.administration.ban_date", 0) - os.time()
        if wait > 0 then
            local t = string.Split(ban_text, "\n")
            draw.SimpleText(t[1], "animelife.administration.hud.title.shadow", ScrW() / 2, both_y + 2, Color(0, 0, 0, 150), 1)
            draw.SimpleText(t[1], "animelife.administration.hud.title", ScrW() / 2, both_y, Color(255, 255, 255, 150), 1)

            local reason = LocalPlayer():GetNWString("animelife.administration.ban_reason", "неизвестна")
            local date = LocalPlayer():GetNWInt("animelife.administration.ban_date", 0)
            date = os.date("%d/%m/%Y", date)
            // local wait = LocalPlayer():GetNWFloat("animelife.administration.ban_wait", 0) - UnPredictedCurTime()
            wait = string.ToMinutesSeconds(wait)
            
            local y = both_y + 58 + 2
            for i = 2, 5 do
                draw.SimpleText(string.format(t[i], i == 3 and reason or (i == 4 and date or wait)), "animelife.administration.hud.subtitle.shadow", ScrW() / 2, y + 2, Color(0, 0, 0, 150), 1)
                draw.SimpleText(string.format(t[i], i == 3 and reason or (i == 4 and date or wait)), "animelife.administration.hud.subtitle", ScrW() / 2, y, Color(255, 255, 255, 150), 1)

                y = y + 29 + 2
            end
        end
    end

    if report_anim.icon_alpha > 0 then
        surface.SetDrawColor(255, 255, 255, 180 * report_anim.icon_alpha)
        surface.SetMaterial(hud_report)
        surface.DrawTexturedRect(23, 18, 36, 36)

        draw.SimpleText("Доступна новая жалоба. Откройте админ-меню.", "animelife.administration.hud.report", 23 + 36 + 8 + report_anim.text_x, 27 + 1, Color(0, 0, 0, 150 * report_anim.text_alpha))
        draw.SimpleText("Доступна новая жалоба. Откройте админ-меню.", "animelife.administration.hud.report", 23 + 36 + 8 + report_anim.text_x, 27, Color(255, 255, 255, 255 * report_anim.text_alpha))
    end

    if #GLOBALS_REPORTS ~= report_anim.report_count then
        if #GLOBALS_REPORTS > 0 then
            if flux and flux.to then
                flux.to(report_anim, 0.5, {icon_alpha = 1, text_alpha = 1, text_x = 0})
                :after(report_anim, 0.5, {text_alpha = 0, text_x = -8})
                :delay(2)
            end
        else
            if flux and flux.to then
                flux.to(report_anim, 0.5, {icon_alpha = 0, text_alpha = 0, text_x = -8})
            end
        end

        report_anim.report_count = #GLOBALS_REPORTS
    end

    if flux and flux.update then
        flux.update(RealFrameTime())
    end
end)