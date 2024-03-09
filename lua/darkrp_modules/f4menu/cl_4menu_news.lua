local PANEL = {}

surface.CreateFont("animelife.f4menu.news.title", {font = "Exo 2", weight = 700, size = 48, extended = true})
surface.CreateFont("animelife.f4menu.news.subtitle", {font = "Exo 2 SemiBold", weight = 600, size = 24, extended = true})
surface.CreateFont("animelife.f4menu.news.title_shadow", {font = "Exo 2", weight = 700, blursize = 2, size = 48, extended = true})
surface.CreateFont("animelife.f4menu.news.subtitle_shadow", {font = "Exo 2 SemiBold", weight = 600, blursize = 2, size = 24, extended = true})
surface.CreateFont("animelife.f4menu.news.category", {font = "Exo 2", weight = 700, size = 18, extended = true})
surface.CreateFont("animelife.f4menu.news.features", {font = "Exo 2", weight = 700, size = 32, extended = true})
surface.CreateFont("animelife.f4menu.news.features_list", {font = "Exo 2 SemiBold", weight = 600, size = 18, extended = true})

local news = Material("animelife/f4menu/news/close.png")
local like = Material("animelife/f4menu/news/like.png")

function PANEL:Init()
    self:SetAlpha(0)
    self:AlphaTo(255, 0.25)

    self.Likes = 0

    self.BackgroundImage = vgui.Create("DHTML", self)
    self.BackgroundImage:SetSize(ScrW(), 352)
    self.BackgroundImage:SetMouseInputEnabled(false)
    self.BackgroundImage:SetHTML([[
    <style>
        body {
            background: url('https://pic.netbian.com/uploads/allimg/210502/193553-1619955353bd3d.jpg') no-repeat center;
            background-size: cover;
        }
    </style>
    <body>
    </body>
    ]])
    self.BackgroundImage.PaintOver = function(panel, w, h)
        surface.SetDrawColor(0, 148, 255, 255 * (1 * 0.49))
        surface.DrawRect(0, 0, w, h)

        local title = GLOBALS_NEWS.NewsTitle or "Новостей нет"
        local subtitle = GLOBALS_NEWS.NewsSubTitle or "Как-так то?"

        draw.SimpleText(title, "animelife.f4menu.news.title_shadow", 511, 207 + 2, Color(0, 0, 0, 125))
        draw.SimpleText(title, "animelife.f4menu.news.title", 511, 207, nil)
        draw.SimpleText(subtitle, "animelife.f4menu.news.subtitle_shadow", 511, 207 + 56 + 2, Color(0, 0, 0, 125))
        draw.SimpleText(subtitle, "animelife.f4menu.news.subtitle", 511, 207 + 56, nil)
    end

    self.BackgroundIcon = vgui.Create("DHTML", self)
    self.BackgroundIcon:SetSize(276, 346)
    self.BackgroundIcon:SetPos(184, 154)
    self.BackgroundIcon:SetMouseInputEnabled(false)
    self.BackgroundIcon:SetHTML([[
        <style>
            body {
                margin: 0;
            }

            .icon {
                background: url('https://pic.netbian.com/uploads/allimg/210502/193553-1619955353bd3d.jpg') no-repeat center;
                background-size: cover;

                width: 100vw;
                height: 100vh;

                border-radius: 16px;
            }
        </style>
        <body>
            <div class="icon"></icon>
        </body>
    ]])

    self.CloseButton = vgui.Create("DButton", self)
    self.CloseButton:SetPos(ScrW() - 50 - 24, 39)
    self.CloseButton:SetSize(24, 24)
    self.CloseButton:SetText("")
    self.CloseButton.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(news)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    self.CloseButton.DoClick = function()
        if ValidPanel(self) then
            self:Remove()
            self = nil
        end
    end

    self.LikeButton = vgui.Create("DButton", self)
    self.LikeButton:SetPos(ScrW() - 51 - 98, 237)
    self.LikeButton:SetSize(51, 72)
    self.LikeButton:SetText("")
    self.LikeButton.Paint = function(panel, w, h)
        local hovered_color = Color(244, 200, 255)
        local inactive_color = Color(255, 255, 255)
        surface.SetDrawColor(panel:IsHovered() and hovered_color or inactive_color)
        surface.SetMaterial(like)
        surface.DrawTexturedRect(0, 0, w, 51)

        draw.SimpleText(self.Likes, "animelife.f4menu.news.subtitle", w / 2, 51, Color(0, 0, 0, 150), TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Likes, "animelife.f4menu.news.subtitle", w / 2, 51 - 2, Color(255, 255, 255), TEXT_ALIGN_CENTER)
    end
    self.LikeButton.DoClick = function()
        net.Start("animelife.f4menu.news.like_update")
        net.SendToServer()
    end

    self.UpdateText = vgui.Create("DHTML", self)
    self.UpdateText:SetPos(0, 352 + 241)
    self.UpdateText:SetSize(ScrW(), 471)
    -- self.UpdateText:SetMouseInputEnabled(false)
    self.UpdateText:SetHTML([[
        <style>
            body {
                color: #FFF;
                font-family: Arial, Helvetica, sans-serif;
                font-size: 14px;
                font-weight: 400;
                display: flex;
                justify-content: center;
                text-align: left;
                line-height: 24px;
            }

            .update_text {
                margin-top: 16px;
                max-width: calc(100vw / 1.5);
            }
        </style>
        <body>
            <div class="update_text">
            </div>
        </body>
        <script type="text/javascript">
            function insert_text(text) {
                var p = document.createElement("p");
                p.innerHTML = text;

                var upd = document.getElementsByClassName("update_text")[0]
                upd.appendChild(p);
            }
        </script>
    ]])

    self.UpdateText:QueueJavascript("insert_text('" .. string.JavascriptSafe(GLOBALS_NEWS.NewsText) .. "')")
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(44, 44, 44)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(0, 148, 255, 255 * (1 * 0.49))
    surface.DrawRect(0, 0, w, 352)

    surface.SetDrawColor(0, 148, 255, 255)
    surface.DrawRect(0, 352, w, 241)

    draw.SimpleText("Категория: " .. GLOBALS_NEWS.Category, "animelife.f4menu.news.category", w - 74, 352 + 24, nil, TEXT_ALIGN_RIGHT)
    draw.SimpleText("Кратко", "animelife.f4menu.news.features", 511, 352 + 27, nil)
    draw.DrawText(GLOBALS_NEWS.Short, "animelife.f4menu.news.features_list", 518, 352 + 27 + 42, nil)
end

vgui.Register("animelife.f4menu.news", PANEL, "EditablePanel")

net.Receive("animelife.f4menu.news.request_like_update", function()
    if !ValidPanel(GLOBALS_F4MENU_NEWS) then
        return
    end

    GLOBALS_F4MENU_NEWS.Likes = net.ReadInt(16)
end)