local PANEL = {}

surface.CreateFont("animelife.chatbox.entry", {font = "Roboto", size = 18, extended = true})
surface.CreateFont("animelife.chatbox.title", {font = "Exo 2 SemiBold", size = 22, weight = 600, extended = true})
surface.CreateFont("animelife.chatbox.hint", {font = "Exo 2 SemiBold", size = 16, weight = 600, extended = true})

local icon_send = Material("animelife/chat/icon_send.png")

local flux = util.Base64Decode("bG9jYWwgZmx1eCA9IHsgX3ZlcnNpb24gPSAiMC4xLjUiIH0KZmx1eC5fX2luZGV4ID0gZmx1eAoKZmx1eC50d2VlbnMgPSB7fQpmbHV4LmVhc2luZyA9IHsgbGluZWFyID0gZnVuY3Rpb24ocCkgcmV0dXJuIHAgZW5kIH0KCmxvY2FsIGVhc2luZyA9IHsKICBxdWFkICAgID0gInAgKiBwIiwKICBjdWJpYyAgID0gInAgKiBwICogcCIsCiAgcXVhcnQgICA9ICJwICogcCAqIHAgKiBwIiwKICBxdWludCAgID0gInAgKiBwICogcCAqIHAgKiBwIiwKICBleHBvICAgID0gIjIgXiAoMTAgKiAocCAtIDEpKSIsCiAgc2luZSAgICA9ICItbWF0aC5jb3MocCAqIChtYXRoLnBpICogLjUpKSArIDEiLAogIGNpcmMgICAgPSAiLShtYXRoLnNxcnQoMSAtIChwICogcCkpIC0gMSkiLAogIGJhY2sgICAgPSAicCAqIHAgKiAoMi43ICogcCAtIDEuNykiLAogIGVsYXN0aWMgPSAiLSgyXigxMCAqIChwIC0gMSkpICogbWF0aC5zaW4oKHAgLSAxLjA3NSkgKiAobWF0aC5waSAqIDIpIC8gLjMpKSIKfQoKbG9jYWwgbWFrZWZ1bmMgPSBmdW5jdGlvbihzdHIsIGV4cHIpCiAgcmV0dXJuIENvbXBpbGVTdHJpbmcoInJldHVybiBmdW5jdGlvbihwKSAiIC4uIHN0cjpnc3ViKCIlJGUiLCBleHByKSAuLiAiIGVuZCIsICJUZXN0RnVuY3Rpb24iKSgpCmVuZAoKZm9yIGssIHYgaW4gcGFpcnMoZWFzaW5nKSBkbwogIGZsdXguZWFzaW5nW2sgLi4gImluIl0gPSBtYWtlZnVuYygicmV0dXJuICRlIiwgdikKICBmbHV4LmVhc2luZ1trIC4uICJvdXQiXSA9IG1ha2VmdW5jKFtbCiAgICBwID0gMSAtIHAKICAgIHJldHVybiAxIC0gKCRlKQogIF1dLCB2KQogIGZsdXguZWFzaW5nW2sgLi4gImlub3V0Il0gPSBtYWtlZnVuYyhbWwogICAgcCA9IHAgKiAyCiAgICBpZiBwIDwgMSB0aGVuCiAgICAgIHJldHVybiAuNSAqICgkZSkKICAgIGVsc2UKICAgICAgcCA9IDIgLSBwCiAgICAgIHJldHVybiAuNSAqICgxIC0gKCRlKSkgKyAuNQogICAgZW5kCiAgXV0sIHYpCmVuZAoKCgpsb2NhbCB0d2VlbiA9IHt9CnR3ZWVuLl9faW5kZXggPSB0d2VlbgoKbG9jYWwgZnVuY3Rpb24gbWFrZWZzZXR0ZXIoZmllbGQpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBsb2NhbCBtdCA9IGdldG1ldGF0YWJsZSh4KQogICAgaWYgdHlwZSh4KSB+PSAiZnVuY3Rpb24iIGFuZCBub3QgKG10IGFuZCBtdC5fX2NhbGwpIHRoZW4KICAgICAgZXJyb3IoImV4cGVjdGVkIGZ1bmN0aW9uIG9yIGNhbGxhYmxlIiwgMikKICAgIGVuZAogICAgbG9jYWwgb2xkID0gc2VsZltmaWVsZF0KICAgIHNlbGZbZmllbGRdID0gb2xkIGFuZCBmdW5jdGlvbigpIG9sZCgpIHgoKSBlbmQgb3IgeAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgpsb2NhbCBmdW5jdGlvbiBtYWtlc2V0dGVyKGZpZWxkLCBjaGVja2ZuLCBlcnJtc2cpCiAgcmV0dXJuIGZ1bmN0aW9uKHNlbGYsIHgpCiAgICBpZiBjaGVja2ZuIGFuZCBub3QgY2hlY2tmbih4KSB0aGVuCiAgICAgIGVycm9yKGVycm1zZzpnc3ViKCIlJHgiLCB0b3N0cmluZyh4KSksIDIpCiAgICBlbmQKICAgIHNlbGZbZmllbGRdID0geAogICAgcmV0dXJuIHNlbGYKICBlbmQKZW5kCgp0d2Vlbi5lYXNlICA9IG1ha2VzZXR0ZXIoIl9lYXNlIiwKICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uKHgpIHJldHVybiBmbHV4LmVhc2luZ1t4XSBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGVhc2luZyB0eXBlICckeCciKQp0d2Vlbi5kZWxheSA9IG1ha2VzZXR0ZXIoIl9kZWxheSIsCiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbih4KSByZXR1cm4gdHlwZSh4KSA9PSAibnVtYmVyIiBlbmQsCiAgICAgICAgICAgICAgICAgICAgICAgICAiYmFkIGRlbGF5IHRpbWU7IGV4cGVjdGVkIG51bWJlciIpCnR3ZWVuLm9uc3RhcnQgICAgID0gbWFrZWZzZXR0ZXIoIl9vbnN0YXJ0IikKdHdlZW4ub251cGRhdGUgICAgPSBtYWtlZnNldHRlcigiX29udXBkYXRlIikKdHdlZW4ub25jb21wbGV0ZSAgPSBtYWtlZnNldHRlcigiX29uY29tcGxldGUiKQoKCmZ1bmN0aW9uIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpCiAgbG9jYWwgc2VsZiA9IHNldG1ldGF0YWJsZSh7fSwgdHdlZW4pCiAgc2VsZi5vYmogPSBvYmoKICBzZWxmLnJhdGUgPSB0aW1lID4gMCBhbmQgMSAvIHRpbWUgb3IgMAogIHNlbGYucHJvZ3Jlc3MgPSB0aW1lID4gMCBhbmQgMCBvciAxCiAgc2VsZi5fZGVsYXkgPSAwCiAgc2VsZi5fZWFzZSA9ICJxdWFkb3V0IgogIHNlbGYudmFycyA9IHt9CiAgZm9yIGssIHYgaW4gcGFpcnModmFycykgZG8KICAgIGlmIHR5cGUodikgfj0gIm51bWJlciIgdGhlbgogICAgICBlcnJvcigiYmFkIHZhbHVlIGZvciBrZXkgJyIgLi4gayAuLiAiJzsgZXhwZWN0ZWQgbnVtYmVyIikKICAgIGVuZAogICAgc2VsZi52YXJzW2tdID0gdgogIGVuZAogIHJldHVybiBzZWxmCmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOmluaXQoKQogIGZvciBrLCB2IGluIHBhaXJzKHNlbGYudmFycykgZG8KICAgIGxvY2FsIHggPSBzZWxmLm9ialtrXQogICAgaWYgdHlwZSh4KSB+PSAibnVtYmVyIiB0aGVuCiAgICAgIGVycm9yKCJiYWQgdmFsdWUgb24gb2JqZWN0IGtleSAnIiAuLiBrIC4uICInOyBleHBlY3RlZCBudW1iZXIiKQogICAgZW5kCiAgICBzZWxmLnZhcnNba10gPSB7IHN0YXJ0ID0geCwgZGlmZiA9IHYgLSB4IH0KICBlbmQKICBzZWxmLmluaXRlZCA9IHRydWUKZW5kCgoKZnVuY3Rpb24gdHdlZW46YWZ0ZXIoLi4uKQogIGxvY2FsIHQKICBpZiBzZWxlY3QoIiMiLCAuLi4pID09IDIgdGhlbgogICAgdCA9IHR3ZWVuLm5ldyhzZWxmLm9iaiwgLi4uKQogIGVsc2UKICAgIHQgPSB0d2Vlbi5uZXcoLi4uKQogIGVuZAogIHQucGFyZW50ID0gc2VsZi5wYXJlbnQKICBzZWxmOm9uY29tcGxldGUoZnVuY3Rpb24oKSBmbHV4LmFkZChzZWxmLnBhcmVudCwgdCkgZW5kKQogIHJldHVybiB0CmVuZAoKCmZ1bmN0aW9uIHR3ZWVuOnN0b3AoKQogIGZsdXgucmVtb3ZlKHNlbGYucGFyZW50LCBzZWxmKQplbmQKCgoKZnVuY3Rpb24gZmx1eC5ncm91cCgpCiAgcmV0dXJuIHNldG1ldGF0YWJsZSh7fSwgZmx1eCkKZW5kCgoKZnVuY3Rpb24gZmx1eDp0byhvYmosIHRpbWUsIHZhcnMpCiAgcmV0dXJuIGZsdXguYWRkKHNlbGYsIHR3ZWVuLm5ldyhvYmosIHRpbWUsIHZhcnMpKQplbmQKCgpmdW5jdGlvbiBmbHV4OnVwZGF0ZShkZWx0YXRpbWUpCiAgZm9yIGkgPSAjc2VsZiwgMSwgLTEgZG8KICAgIGxvY2FsIHQgPSBzZWxmW2ldCiAgICBpZiB0Ll9kZWxheSA+IDAgdGhlbgogICAgICB0Ll9kZWxheSA9IHQuX2RlbGF5IC0gZGVsdGF0aW1lCiAgICBlbHNlCiAgICAgIGlmIG5vdCB0LmluaXRlZCB0aGVuCiAgICAgICAgZmx1eC5jbGVhcihzZWxmLCB0Lm9iaiwgdC52YXJzKQogICAgICAgIHQ6aW5pdCgpCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnN0YXJ0IHRoZW4KICAgICAgICB0Ll9vbnN0YXJ0KCkKICAgICAgICB0Ll9vbnN0YXJ0ID0gbmlsCiAgICAgIGVuZAogICAgICB0LnByb2dyZXNzID0gdC5wcm9ncmVzcyArIHQucmF0ZSAqIGRlbHRhdGltZQogICAgICBsb2NhbCBwID0gdC5wcm9ncmVzcwogICAgICBsb2NhbCB4ID0gcCA+PSAxIGFuZCAxIG9yIGZsdXguZWFzaW5nW3QuX2Vhc2VdKHApCiAgICAgIGZvciBrLCB2IGluIHBhaXJzKHQudmFycykgZG8KICAgICAgICB0Lm9ialtrXSA9IHYuc3RhcnQgKyB4ICogdi5kaWZmCiAgICAgIGVuZAogICAgICBpZiB0Ll9vbnVwZGF0ZSB0aGVuIHQuX29udXBkYXRlKCkgZW5kCiAgICAgIGlmIHAgPj0gMSB0aGVuCiAgICAgICAgZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgICAgICBpZiB0Ll9vbmNvbXBsZXRlIHRoZW4gdC5fb25jb21wbGV0ZSgpIGVuZAogICAgICBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmNsZWFyKG9iaiwgdmFycykKICBmb3IgdCBpbiBwYWlycyhzZWxmW29ial0pIGRvCiAgICBpZiB0LmluaXRlZCB0aGVuCiAgICAgIGZvciBrIGluIHBhaXJzKHZhcnMpIGRvIHQudmFyc1trXSA9IG5pbCBlbmQKICAgIGVuZAogIGVuZAplbmQKCgpmdW5jdGlvbiBmbHV4OmFkZCh0d2VlbikKICAtLSBBZGQgdG8gb2JqZWN0IHRhYmxlLCBjcmVhdGUgdGFibGUgaWYgaXQgZG9lcyBub3QgZXhpc3QKICBsb2NhbCBvYmogPSB0d2Vlbi5vYmoKICBzZWxmW29ial0gPSBzZWxmW29ial0gb3Ige30KICBzZWxmW29ial1bdHdlZW5dID0gdHJ1ZQogIC0tIEFkZCB0byBhcnJheQogIHRhYmxlLmluc2VydChzZWxmLCB0d2VlbikKICB0d2Vlbi5wYXJlbnQgPSBzZWxmCiAgcmV0dXJuIHR3ZWVuCmVuZAoKCmZ1bmN0aW9uIGZsdXg6cmVtb3ZlKHgpCiAgaWYgdHlwZSh4KSA9PSAibnVtYmVyIiB0aGVuCiAgICAtLSBSZW1vdmUgZnJvbSBvYmplY3QgdGFibGUsIGRlc3Ryb3kgdGFibGUgaWYgaXQgaXMgZW1wdHkKICAgIGxvY2FsIG9iaiA9IHNlbGZbeF0ub2JqCiAgICBzZWxmW29ial1bc2VsZlt4XV0gPSBuaWwKICAgIGlmIG5vdCBuZXh0KHNlbGZbb2JqXSkgdGhlbiBzZWxmW29ial0gPSBuaWwgZW5kCiAgICAtLSBSZW1vdmUgZnJvbSBhcnJheQogICAgc2VsZlt4XSA9IHNlbGZbI3NlbGZdCiAgICByZXR1cm4gdGFibGUucmVtb3ZlKHNlbGYpCiAgZW5kCiAgZm9yIGksIHYgaW4gaXBhaXJzKHNlbGYpIGRvCiAgICBpZiB2ID09IHggdGhlbgogICAgICByZXR1cm4gZmx1eC5yZW1vdmUoc2VsZiwgaSkKICAgIGVuZAogIGVuZAplbmQKCgoKbG9jYWwgYm91bmQgPSB7CiAgdG8gICAgICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgudG8oZmx1eC50d2VlbnMsIC4uLikgZW5kLAogIHVwZGF0ZSAgPSBmdW5jdGlvbiguLi4pIHJldHVybiBmbHV4LnVwZGF0ZShmbHV4LnR3ZWVucywgLi4uKSBlbmQsCiAgcmVtb3ZlICA9IGZ1bmN0aW9uKC4uLikgcmV0dXJuIGZsdXgucmVtb3ZlKGZsdXgudHdlZW5zLCAuLi4pIGVuZCwKfQpzZXRtZXRhdGFibGUoYm91bmQsIGZsdXgpCgpyZXR1cm4gYm91bmQ=")
flux = CompileString(flux, "flux")()

function PANEL:Init()
    self.TextPanel = vgui.Create("DHTML", self)
    self.TextPanel:SetHTML([[
        <head>
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Exo+2&display=swap" rel="stylesheet">
        </head>
        <style>
            * {
                margin: 0;
            }

            body {
                font-family: 'Exo 2', Arial, Roboto, Helvetica, sans-serif;
                font-size: 16px;
                color: #FFF;
                text-shadow: 0px 2px 2px rgba(0, 0, 0, 0.5);
                line-height: 20px;
            }

            body::-webkit-scrollbar {
                width: 6px;
            }
            
            body::-webkit-scrollbar-track {
                background-color: rgba(0, 0, 0, 0);
            }
            
            body::-webkit-scrollbar-thumb {
                background-color: rgba(255, 255, 255, 0.1);
                border-radius: 6px;
            }

            .emoji {
                width: 24px;
                height: 24px;
            }

            p {
                word-wrap: break-word;

                animation-name: fade_out;
                animation-duration: 2s;
                animation-delay: 5s;
                animation-fill-mode: forwards;

                margin-left: 8px;
                margin-right: 8px;
            }

            @keyframes fade_out {
                0% {
                    opacity: 100%;
                }
                100% {
                    opacity: 0%;
                }
            }
        </style>
        <body>
        </body>
        <script type="text/javascript">
            function insert_message(msg) {
                var p = document.createElement("p");
                p.innerHTML = msg;
                document.body.appendChild(p);
            }

            function set_opacity(opacity) {
                var any_p = document.getElementsByTagName("p");

                for (var i = 0; i < any_p.length; i++) {
                    any_p[i].style.animation = "none";
                    any_p[i].style.opacity = opacity;
                }

                if (opacity == 0) {
                    document.body.style.overflow = "hidden";
                } else {
                    document.body.style.overflow = "visible";
                }
            }
        </script>
    ]])

    self.TextInput = vgui.Create("DTextEntry", self)
    self.TextInput:SetFont("animelife.chatbox.entry")
    self.TextInput:SetDrawBorder(false)
    self.TextInput:SetDrawLanguageID(false)
    self.TextInput.Paint = function(panel, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 255 * 0.42))
        panel:DrawTextEntryText(Color(255, 255, 255), Color(0, 0, 0), Color(255, 255, 255))
    end
    self.TextInput.AutoCompleted = false
    self.TextInput.OnKeyCodeTyped = function(panel, key_code)
        local text = panel:GetValue()
        if key_code == KEY_ESCAPE then
            GAMEMODE:FinishChat()
            self:Hide()
        elseif key_code == KEY_BACKSPACE then
            if #text == 0 then
                GAMEMODE:FinishChat()
            elseif panel.AutoCompleted then
                local old = panel.AutoCompleted[1]
                panel:SetText(old)
                panel:SetCaretPos(utf8.len(old))
                panel.AutoCompleted = false 

                return true
            end
        elseif key_code == KEY_TAB then
            local new = GAMEMODE:OnChatTab(text)
            if new then
                panel:SetText(new)
                panel:SetCaretPos(utf8.len(new))
                
                if panel.AutoCompleted then
                    panel.AutoCompleted = {panel.AutoCompleted[1], new}
                else
                    panel.AutoCompleted = {text, new}
                end
            end

            return true
        elseif key_code == KEY_ENTER then
            if #text > 0 then
                local cmd = "say"
                if self.ChatType == "Local" then
                    cmd = "say_team"
                end

                RunConsoleCommand(cmd, text)

                panel:AddHistory(text)
            end

            GAMEMODE:FinishChat()
        end
    end

    self.TextPanel.Message = ""
    self.TextPanel.ColorTag = false
    function self.TextPanel:InsertColorChange(r, g, b, a)
        if self.ColorTag then
            self.Message = self.Message .. "</color>"
        end

        self.Message = self.Message .. "<color style='color: rgba(" .. r .. ", " .. g .. ", " .. b .. ", " .. a .. ")'>"
        self.ColorTag = true
    end

    function self.TextPanel:InsertMessage(msg)
        self.Message = self.Message .. string.JavascriptSafe(msg)

        if msg[#msg] == "\n" then
            if self.ColorTag then
                self.Message = self.Message .. "</color>"
            end

            self:QueueJavascript('insert_message("' .. self.Message .. '");')
            self.Message = ""
            self.ColorTag = false
        end
    end

    function self.TextPanel:ScrollToEnd()
        self:QueueJavascript('window.scrollTo(0, document.body.scrollHeight);')
    end

    function self.TextPanel:ChangeOpacity(opacity)
        self:QueueJavascript('set_opacity(' .. opacity .. ');')
    end
    
    self.ChatType = ""

    self.SendButton = vgui.Create("DButton", self)
    self.SendButton:SetText("")
    self.SendButton.Paint = function(panel, w, h)
        if self.TextPanel.Fading == nil then return end

        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 255 * 0.42))

        surface.SetDrawColor(255, 255, 255, 150)
        surface.SetMaterial(icon_send)
        surface.DrawTexturedRect((w - 12) / 2, (h - 12) / 2, 12, 12)
    end
    self.SendButton.DoClick = function()
        self.TextInput:OnKeyCodeTyped(KEY_ENTER)
    end

    self.Ad = {alpha = 0, add_x = 0, text = "", sender = ""}
end

function PANEL:PerformLayout(w, h)
    self.TextPanel:SetPos(0, 38)
    self.TextPanel:SetSize(w, h - 38 - 31 - 24)
    self.TextPanel:InvalidateLayout()

    self.TextInput:SetPos(self.x + 23, self.y + h - 31 - 18)
    self.TextInput:SetSize(w - 64 - 31, 31)
    self.TextInput:InvalidateLayout()

    self.SendButton:SetPos(w - 31 - 23, h - 31 - 18)
    self.SendButton:SetSize(31, 31)
    self.SendButton:InvalidateLayout()
end

function PANEL:AddText(text, color, t)
    self.TextPanel:InsertColorChange(color.r, color.g, color.b, color.a or 255)
    self.TextPanel:InsertMessage(text .. "\n")

    self.TextPanel:ScrollToEnd()

    if self.TextPanel.Fading == nil then return end
    if !self.TextPanel.Fading then
        self.TextPanel:ChangeOpacity(1)
    end

    MsgC(Color(255, 255, 255), "(" .. os.date("%H:%M", os.time()) .. ") ", color, text .. "\n")
end

function PANEL:AddChat(t, name, id, text, color, pref)
    if isnumber(pref) then
        local p = prefix.List["chat"][pref]
        self.TextPanel:InsertColorChange(p.Color.r, p.Color.g, p.Color.b, p.Color.a or 255)
        self.TextPanel:InsertMessage("「" .. p.Name .. "」")
    end

    self.TextPanel:InsertColorChange(color.r, color.g, color.b, color.a or 255)
    self.TextPanel:InsertMessage(name)

    self.TextPanel:InsertColorChange(255, 255, 255, 255)
    self.TextPanel:InsertMessage(":")

    self.TextPanel:InsertColorChange(255, 255, 255, 255)
	self.TextPanel:InsertMessage(" " .. text .. "\n")

    self.TextPanel:ScrollToEnd()

    if self.TextPanel.Fading == nil then return end
    if !self.TextPanel.Fading then
        self.TextPanel:ChangeOpacity(1)
    end

    MsgC(Color(255, 255, 255), "(" .. os.date("%H:%M", os.time()) .. ") ", color, name .. ": " .. text .. "\n")
end

function PANEL:Show(t)
    self.TextPanel.Fading = false
    self.TextPanel:SetVisible(true)
    self.TextPanel:ChangeOpacity(1)
    self.TextPanel:ScrollToEnd()

    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)

    self:SetZPos(-30)

    self.TextInput:RequestFocus()
	self.TextInput:SetVisible(true)
	self.TextInput:MakePopup()

    self.SendButton:SetVisible(true)

    if self.ChatType ~= t then
        self.ChatType = t
        self:InvalidateLayout()
    end
end

function PANEL:Hide()
    self.TextPanel.Fading = true
    self.TextPanel:ChangeOpacity(0)
    self.TextPanel:ScrollToEnd()

    self:SetMouseInputEnabled(false)
    self:SetKeyboardInputEnabled(false)

    self.TextInput:SetText("")
	self.TextInput:SetVisible(false)
    
    self.SendButton:SetVisible(false)
end

function PANEL:Paint(w, h)
    if self.TextPanel.Fading == nil then return end
    if !self.TextPanel.Fading then
        draw.RoundedBox(16, 0, 0, w, h, Color(18, 18, 18, 255 * 0.75))

        -- Title
        draw.RoundedBoxEx(16, 0, 0, w, 32, Color(18, 18, 18, 255 * 0.67), true, true, false, false)
        -- draw.SimpleText("animelife", "animelife.chatbox.title", 32, 16, Color(255, 255, 255), nil, TEXT_ALIGN_CENTER)
        draw.SimpleText("anime", "animelife.chatbox.title", 32, 16, Color(221, 205, 231), nil, TEXT_ALIGN_CENTER)
        draw.SimpleText("life", "animelife.chatbox.title", 74, 16, Color(255, 255, 255), nil, TEXT_ALIGN_CENTER)

        -- Advert Hint
        local input_val = self.TextInput:GetValue()
        local extra_y = 0
        if string.StartWith(input_val, "/") or string.StartWith(input_val, "!") then
            input_val = utf8.sub(input_val, 2, utf8.len(input_val))
            if input_val:find("advert") or input_val:find("ad") then
                DisableClipping(true)
                    draw.RoundedBox(16, 0, -39, w, 32, Color(255, 172, 48, 255 * 0.67))

                    draw.SimpleText("Стоимость рекламы: 100¥", "animelife.chatbox.hint", 24 + 1, -39 + 6 + 1, Color(0, 0, 0, 75))
                    draw.SimpleText("Стоимость рекламы: 100¥", "animelife.chatbox.hint", 24, -39 + 6, Color(255, 255, 255))
                    draw.SimpleText("Продолжительность: 30 секунд", "animelife.chatbox.hint", w - 24 + 1, -39 + 6 + 1, Color(0, 0, 0, 75), TEXT_ALIGN_RIGHT)
                    draw.SimpleText("Продолжительность: 30 секунд", "animelife.chatbox.hint", w - 24, -39 + 6, Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                DisableClipping(false)

                extra_y = -39
            end
        end

        -- Advert Box
        if self.Ad.alpha > 0 then
            DisableClipping(true)
                draw.RoundedBox(16, -32 + self.Ad.add_x, -55 + extra_y, w, 48, Color(255, 172, 48, (255 * 0.67) * self.Ad.alpha))

                draw.SimpleText("«" .. self.Ad.text .. "»", "animelife.chatbox.hint", -32 + 24 + self.Ad.add_x + 1, -55 + extra_y + 6 + 1, Color(0, 0, 0, 75 * self.Ad.alpha))
                draw.SimpleText("«" .. self.Ad.text .. "»", "animelife.chatbox.hint", -32 + 24 + self.Ad.add_x, -55 + extra_y + 6, Color(255, 255, 255, 255 * self.Ad.alpha))

                draw.SimpleText("- " .. self.Ad.sender .. " [Реклама]", "animelife.chatbox.hint", -32 + 32 + self.Ad.add_x + 1, -55 + extra_y + 18 + 6 + 1, Color(0, 0, 0, 75 * self.Ad.alpha))
                draw.SimpleText("- " .. self.Ad.sender .. " [Реклама]", "animelife.chatbox.hint", -32 + 32 + self.Ad.add_x, -55 + extra_y + 18 + 6, Color(255, 255, 255, 255 * self.Ad.alpha))
            DisableClipping(false)
        end
    end

    flux.update(RealFrameTime())
end

vgui.Register("animelife.chatbox", PANEL, "EditablePanel")

net.Receive("animelife.advertisement", function()
    if !ValidPanel(GLOBALS_CHATBOX) then
        return
    end

    flux.to(GLOBALS_CHATBOX.Ad, 0.25, {alpha = 1, add_x = 32})
    :after(GLOBALS_CHATBOX.Ad, 0.25, {alpha = 0, add_x = 0})
    :delay(29)

    local text = net.ReadString()
    local sender = net.ReadString()

    GLOBALS_CHATBOX.Ad.text = text
    GLOBALS_CHATBOX.Ad.sender = sender

    chat.AddText(Color(255, 172, 48), "[Реклама] " .. sender .. ": " .. text)
end)