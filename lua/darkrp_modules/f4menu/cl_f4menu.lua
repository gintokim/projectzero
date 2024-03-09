GLOBALS_F4Properties = {
    Stream = {
        Enable = true,
        EmbedLink = ""
    },
    Tabs = {
        [1] = {
            Name = "Главная",
            Function = function(pnl)
                pnl.MainTab:SetVisible(true)
            end,
        },
        [2] = {
            Name = "Профессии",
            Function = function(pnl)
                pnl.JobsTab:SetVisible(true)
            end,
        },
        [3] = {
            Name = "Магазин",
            Function = function(pnl)
                pnl.StoreTab:SetVisible(true)
            end,
        },
        [4] = {
            Name = "Настройки",
            Function = function(pnl)
                pnl.SettingsTab:SetVisible(true)
            end,
        },
        [5] = {
            Name = "Правила",
            Function = function(pnl)
                pnl.RulesTab:SetVisible(true)
            end,
        },
    }
}

GLOBALS_SETTINGS = {
    [1] = {
        Category = "Интерфейс",
        Settings = {
            ["HUD"] = {
                [1] = {
                    Name = "Цвет текста",
                    Type = {"dropdown", {
                        "Белый", "Красный", "Синий", "Сиреневый", "Розовый"
                    }, function(choice)
                        local text_to_rgb = {["Белый"] = Color(255, 255, 255), ["Красный"] = Color(255, 225, 225), ["Синий"] = Color(225, 225, 255), 
                        ["Сиреневый"] = Color(229, 225, 246), ["Розовый"] = Color(255, 190, 222)}
                        choice = text_to_rgb[choice]
                        cookie.Set("animelife.settings.hud_color", tostring(choice))

                        net.Start("animelife.achievements.customizer")
                        net.SendToServer()
                    end}
                },
                [2] = {
                    Name = "Стандартное расположение",
                    Type = {"checkbox", function(_, new_checked)
                        cookie.Set("animelife.settings_hud_pos_default", new_checked and 1 or 0)

                        net.Start("animelife.achievements.customizer")
                        net.SendToServer()
                    end, function()
                        return tobool(cookie.GetNumber("animelife.settings_hud_pos_default", 0))
                    end}
                },
                [3] = {
                    Name = "Позиция по вертикали",
                    Type = {"slider", function(val)
                        cookie.Set("animelife.settings_hud_posy", val)
                    end, -75, 945}
                },
            },
            ["ЦВЕТОКОРРЕКЦИЯ"] = {
                [1] = {
                    Name = "Пресеты",
                    Type = {"dropdown", {
                        "яркий", "умножение света", "темный", "нет"
                    }, function(choice)
                        if choice == "нет" then
                            cookie.Set("animelife.settings.pp_preset", "none")
                        end

                        local function find_by_name(str)
                            for k, v in pairs(GLOBALS_POSTPROCESSING) do
                                if v.Name == str then
                                    return k
                                end
                            end

                            return nil
                        end

                        local cn = find_by_name(choice)
                        if cn == nil then return end

                        cookie.Set("animelife.settings.pp_preset", cn)

                        hook.Call("OnPostProcessingPresetChanged", GAMEMODE)
                    end}
                },
            },
        }
    },
    [2] = {
        Category = "Производительность",
        Settings = {
            ["Оптимизация"] = {
                [1] = {
                    Name = "Многоядерная обработка",
                    Type = {"checkbox", function()
                    end, function()
                    end}
                },
            },
        }
    },
    [3] = {
        Category = "Общение",
        Settings = {
            ["Чат"] = {
                [1] = {
                    Name = "Блокировать непристойные слова",
                    Type = {"checkbox", function()
                    end, function()
                    end}
                },
            },
        }
    },
    [4] = {
        Category = "Контент",
        Settings = {
            ["Звуки и музыка"] = {
                [1] = {
                    Name = "Разрешить бумбокс",
                    Type = {"checkbox", function()
                    end, function()
                    end}
                },
            },
        }
    },
}

local PANEL = {}

local lantern = Material("animelife/f4menu/main/lantern.png")
local detail_road = Material("animelife/f4menu/main/detail_road.png")
local button_readabout = Material("animelife/f4menu/main/button_readabout.png")
local info_box = Material("animelife/f4menu/main/info_box.png")
local steam_logo = Material("animelife/f4menu/main/steam_logo.png")

local sidemenu_logo = Material("animelife/f4menu/sidemenu_logo.png")
local sidemenu_gradient = Material("animelife/f4menu/sidemenu_gradient.png")
local sidemenu_vk = Material("animelife/f4menu/sidemenu_vk.png")
local sidemenu_discord = Material("animelife/f4menu/sidemenu_discord.png")

local rules_icon_book = Material("animelife/f4menu/rules/icon_book.png")
local rules_detail_01 = Material("animelife/f4menu/rules/detail_01.png")
local rules_detail_02 = Material("animelife/f4menu/rules/detail_02.png")

local settings_detail_background = Material("animelife/f4menu/settings/detail_background.png")
local settings_top_background = Material("animelife/f4menu/settings/top_background.png")

local jobs_header_background = Material("animelife/f4menu/jobs/header_background.png")
local jobs_header_overlay = Material("animelife/f4menu/jobs/header_overlay.png")
local jobs_icon_badge = Material("animelife/f4menu/jobs/icon_badge.png")
local jobs_icon_circle = Material("animelife/f4menu/jobs/icon_circle.png")
local jobs_icon_heart = Material("animelife/f4menu/jobs/icon_heart.png")
local jobs_icon_shield = Material("animelife/f4menu/jobs/icon_shield.png")
local jobs_icon_speed = Material("animelife/f4menu/jobs/icon_speed.png")
local jobs_button_get = Material("animelife/f4menu/jobs/button_get.png")
local jobs_button_get_locked = Material("animelife/f4menu/jobs/button_get_locked.png")
local jobs_icon_lock = Material("animelife/f4menu/jobs/icon_lock.png")

local store_top_background = Material("animelife/f4menu/store/top_background.png")
local store_icon = Material("animelife/f4menu/store/icon_store.png")

surface.CreateFont("animelife.f4menu.news_title", {font = "Fira Sans Medium", size = 58, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.news_desc", {font = "Fira Sans", size = 20, extended = true})
surface.CreateFont("animelife.f4menu.news_title_shadow", {font = "Fira Sans Medium", size = 58, weight = 500, blursize = 4, extended = true})
surface.CreateFont("animelife.f4menu.news_desc_shadow", {font = "Fira Sans", size = 20, blursize = 4, extended = true})
surface.CreateFont("animelife.f4menu.news_button", {font = "Fira Sans Medium", size = 17, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.info_count", {font = "Exo 2 SemiBold", size = 32, weight = 600, extended = true})
surface.CreateFont("animelife.f4menu.info_sub", {font = "Exo 2 Medium", size = 20, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.category", {font = "Exo 2 Medium", size = 16, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.rules_title", {font = "Exo 2 Medium", size = 18, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.settings_title", {font = "Exo 2 SemiBold", size = 48, weight = 600, extended = true})
surface.CreateFont("animelife.f4menu.settings_subtitle", {font = "Exo 2 SemiBold", size = 18, weight = 600, extended = true})
surface.CreateFont("animelife.f4menu.settings_category", {font = "Exo 2 SemiBold", size = 24, weight = 600, extended = true})
surface.CreateFont("animelife.f4menu.settings_set", {font = "Exo 2", size = 18, weight = 700, extended = true})
surface.CreateFont("animelife.f4menu.settings_item", {font = "Exo 2 Medium", size = 16, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.jobs_category", {font = "Exo 2 Medium", size = 14, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.jobs_name", {font = "Exo 2 Medium", size = 24, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.jobs_title", {font = "Exo 2 Medium", size = 20, weight = 500, extended = true})
surface.CreateFont("animelife.f4menu.store_description", {font = "Exo 2 Medium", size = 18, weight = 500, extended = true})

local function job_list()
    local result = {}

    for _, t in pairs(RPExtraTeams) do
        if isstring(t.category) then
            if !istable(result[t.category]) then
                result[t.category] = {}
            end

            table.insert(result[t.category], t)
        end
    end

    return result
end

function PANEL:Init()
    self.CurrentTab = 1

    -- Side Menu
    self.SideMenu = vgui.Create("DPanel", self)
    self.SideMenu:SetSize(282, ScrH())
    self.SideMenu.Paint = function(panel, w, h)
        surface.SetDrawColor(31, 37, 49)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(sidemenu_logo)
        surface.DrawTexturedRect((w - 166) / 2, h - 49 - 35, 166, 49)

        local start_x, start_y = panel:LocalToScreen(0), panel:LocalToScreen(0)
        local end_x, end_y = start_x + w, start_y + 163

        render.SetScissorRect(start_x, start_y, end_x, end_y, true)
            local bgi = LocalPlayer():GetBackground()
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(GLOBALS_BACKGROUNDS["scoreboard"][bgi])
            surface.DrawTexturedRect(0, 0, 880, 243)
        render.SetScissorRect(0, 0, 0, 0, false)

        surface.SetMaterial(sidemenu_gradient)
        surface.DrawTexturedRect(0, 0, w, 163)

        if ValidPanel(self.SideAvatar) then
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
                drawRoundedRectangle((panel:GetWide() - 60) / 2, 36, 60, 60, 6, Color(255, 255, 255), Color(255, 255, 255), 0, 0.25, nil)
            render.SetStencilFailOperation(STENCILOPERATION_ZERO)
            render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
            render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
            render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
            render.SetStencilReferenceValue(1)
                self.SideAvatar:PaintManual()
            render.SetStencilEnable( false )
            render.ClearStencil()
        end
    end

    self.SideAvatar = vgui.Create("AvatarImage", self.SideMenu)
    self.SideAvatar:SetSize(60, 60)
    self.SideAvatar:SetPos((self.SideMenu:GetWide() - 60) / 2, 36)
    self.SideAvatar:SetPlayer(LocalPlayer(), 184)
    self.SideAvatar:SetPaintedManually(true)

    local sx, sy = 120, 111
    for i = 1, 2 do
        local socials_button = vgui.Create("DButton", self.SideMenu)
        socials_button:SetSize(16, 16)
        socials_button:SetPos(sx, sy)
        socials_button:SetText("")
        socials_button.Paint = function(panel, w, h)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(i == 1 and sidemenu_vk or sidemenu_discord)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        socials_button.DoClick = function()
            if i == 1 then
                gui.OpenURL("https://vk.com/an1melife/")
            else
                gui.OpenURL("https://discord.gg/tPVzhEz/")
                SetClipboardText("discord.gg/tPVzhEz")
            end
        end

        sx = sx + 16 + 12
    end

    local ty = 183
    for key, tab in SortedPairs(GLOBALS_F4Properties.Tabs) do
        local tab_button = vgui.Create("DButton", self.SideMenu)
        tab_button:SetPos(0, ty)
        tab_button:SetSize(self.SideMenu:GetWide(), 40)
        tab_button:SetText("")
        tab_button.Paint = function(panel, w, h)
            surface.SetDrawColor(self.CurrentTab == key and Color(46, 44, 57) or Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

            draw.SimpleText(tab.Name or "Категория", "animelife.f4menu.category", w / 2, h / 2, self.CurrentTab == key and Color(255, 192, 119) or Color(184, 184, 184), 1, 1)
        end
        tab_button.DoClick = function()
            self:HideTabs()

            tab.Function(self)

            self.CurrentTab = key
        end

        ty = ty + 40
    end

    -- Main Tab
    self.MainTab = vgui.Create("DPanel", self)
    self.MainTab:SetPos(282, 0)
    self.MainTab:SetSize(ScrW() - 282, ScrH())
    self.MainTab.Paint = function(panel, w, h)
        for i = 1, 2 do
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(info_box)
            surface.DrawTexturedRect(i == 1 and 95 or 602, 454, 471, 79)

            if i == 2 then
                surface.SetMaterial(steam_logo)
                surface.DrawTexturedRect(602 + 34 + 8, 454 + 23, 32, 32)

                draw.SimpleText("Давайте станем больше - вступите в группу Steam", "animelife.f4menu.info_sub", 602 + 83 + 8, 454 + 37, Color(255, 255, 255), nil, 1)
            else
                draw.SimpleText("14,358", "animelife.f4menu.info_count", 95 + (471 / 2), 454 + 11, Color(255, 255, 255), 1)
                draw.SimpleText("игроков за все время", "animelife.f4menu.info_sub", 95 + (471 / 2), 454 + 40, Color(255, 255, 255), 1)
            end
        end
    end

    self.NewsBackground = vgui.Create("DHTML", self.MainTab)
    self.NewsBackground:SetPos(0, 0)
    self.NewsBackground:SetSize(ScrW() - 282, 367)
    self.NewsBackground:SetMouseInputEnabled(false)
    self.NewsBackground:SetHTML([[
        <style>
            body {
                background: url('https://pic.netbian.com/uploads/allimg/210502/193553-1619955353bd3d.jpg') no-repeat center;
                background-size: cover;
                backdrop-filter: saturate(135%) brightness(50%);
                margin: 0;
            }
        </style>
        <body></body>
    ]])
    self.NewsBackground.PaintOver = function(panel, w, h)
        for i = 1, 2 do
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(lantern)
            surface.DrawTexturedRect(i == 1 and 10 or w - 80 - 28, 319 - 31, 100, 112)
        end

        local title = GLOBALS_NEWS.F4Title or "НОВОСТЕЙ НЕТ"
        local description = GLOBALS_NEWS.F4Description or "Съели."

        draw.SimpleText(title, "animelife.f4menu.news_title_shadow", 187, 105 + 2, Color(0, 0, 0, 150))
        draw.SimpleText(title, "animelife.f4menu.news_title", 187, 105, Color(252, 252, 253))

        local desc = markup.Parse("<font=animelife.f4menu.news_desc><colour=242, 182, 187>" .. description .. "</colour></font>", 550)
        local desc_shadow = markup.Parse("<font=animelife.f4menu.news_desc_shadow><colour=0, 0, 0, 150>" .. description .. "</colour></font>", 550)
        desc:Draw(187, 183)
        desc_shadow:Draw(187, 185)

        DisableClipping(true)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(detail_road)
            surface.DrawTexturedRect(-4, h - 2, 1642, 39)
        DisableClipping(false)
    end

    self.ReadButton = vgui.Create("DButton", self.MainTab)
    self.ReadButton:SetPos(579, 269)
    self.ReadButton:SetSize(166, 52)
    self.ReadButton:SetText("")
    self.ReadButton.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(button_readabout)
        surface.DrawTexturedRect(0, 0, w, h)

        draw.SimpleText("Подробнее", "animelife.f4menu.news_button", w / 2, h / 2 - 2, Color(38, 21, 21), 1, 1)
    end
    self.ReadButton.DoClick = function()
        GLOBALS_F4MENU_NEWS = vgui.Create("animelife.f4menu.news")
        GLOBALS_F4MENU_NEWS:SetSize(ScrW(), ScrH())
        GLOBALS_F4MENU_NEWS:MakePopup()

        GLOBALS_F4MENU_NEWS.Likes = (self.UpdateLikes or 0)
    end

    self.StreamOverlay = vgui.Create("DPanel", self.MainTab)
    self.StreamOverlay:SetSize(499, 284)
    self.StreamOverlay:SetPos(ScrW() - 282 - 499 - 76, 141)
    self.StreamOverlay.Paint = function(panel, w, h)
        surface.SetDrawColor(41, 41, 41)
        surface.DrawRect(0, 0, w, h)

        if GLOBALS_F4Properties.Stream.Enable then
            draw.SimpleText("Трансляция загружается или не может быть воспроизведена", nil, w / 2, h / 2, Color(255, 255, 255), 1, 1)
        else
            draw.SimpleText("Нет доступных прямых эфиров", nil, w / 2, h / 2, Color(255, 255, 255), 1, 1)
        end
    end

    if GLOBALS_F4Properties.Stream.Enable then
        -- twitch.tv example: <iframe src="https://player.twitch.tv/?channel=xqcow_waiting_room&parent=www.youtube.com" frameborder="0" allowfullscreen="false" scrolling="no" height="100%" width="100%"></iframe>
        -- youtube.com example: <iframe width="100%" height="100%" src="https://www.youtube.com/embed/LUj5DwQLOeE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
        self.StreamEmbed = vgui.Create("DHTML", self.StreamOverlay)
        self.StreamEmbed:SetPos(4, 4)
        self.StreamEmbed:SetSize(self.StreamOverlay:GetWide() - 8, self.StreamOverlay:GetTall() - 8)
        self.StreamEmbed:SetHTML([[
            <style>
                body {
                    margin: 0;
                }
            </style>
            <body>
                <iframe src="https://player.twitch.tv/?channel=xqcow_waiting_room&parent=www.youtube.com" frameborder="0" allowfullscreen="false" scrolling="no" height="100%" width="100%"></iframe>
            </body>
        ]])
    end

    -- Rules Tab
    self.RulesTab = vgui.Create("DPanel", self)
    self.RulesTab:SetPos(282, 0)
    self.RulesTab:SetSize(ScrW() - 282, ScrH())
    self.RulesTab:SetVisible(false)
    self.RulesTab.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(rules_detail_01)
        surface.DrawTexturedRect(-72, 11, 428, 414)

        surface.SetMaterial(rules_detail_02)
        surface.DrawTexturedRect(ScrW() - 358 - 258, 181, 358, 903)

        surface.SetDrawColor(32, 30, 47)
        surface.DrawRect(0, 0, w, 59)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(rules_icon_book)
        surface.DrawTexturedRect(84, 22, 16, 16)

        draw.SimpleText("Правила сервера AnimeLife", "animelife.f4menu.rules_title", 111, 20, Color(228, 227, 232))
    end

    self.RulesText = vgui.Create("DHTML", self.RulesTab)
    self.RulesText:SetPos(0, 59)
    self.RulesText:SetSize(ScrW() - 282, ScrH() - 59)
    self.RulesText:SetHTML([[
        <style>
            body {
                margin: 0;

                font-family: Arial, Helvetica, sans-serif;
                font-size: 14px;
                color: #E4E3E8;

                text-align: left;

                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;

                scroll-behavior: smooth;
            }

            .rules {
                height: 100vh;

                max-width: 825px;

                margin-bottom: 200px;
            }

            .rule_title {
                margin-top: 60px;
                font-size: 18px;
            }

            .rule_line {
                width: 100%;
                height: 1px;

                background-color: #E4E3E8;

                margin-top: 16px;
                margin-bottom: 25px;
            }

            .search {
                margin-top: 60px;
                margin-left: 64px;

                border-radius: 32px;
                background-color: rgba(0, 0, 0, 0.2);

                width: 100%;
                height: 36px;
                max-width: 400px;

                border: none;
                outline: none;

                color: #adabba;

                padding-left: 32px;
            }

            ::-webkit-scrollbar {
                width: 4px;
            }

            ::-webkit-scrollbar-track {
                background: transparent;
            }
            
            ::-webkit-scrollbar-thumb {
                background: rgba(129, 120, 174, 150);
            }
            
            ::-webkit-scrollbar-thumb:hover {
                background: rgba(129, 120, 174, 225);
            }
        </style>
        <body>
            <section class="rules">
                <input type="text" id="searcher" class="search" placeholder="Найти в правилах"> 
                <div class="rule_title">1. Правила чата</div>
                <div class="rule_line"></div>
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
                <div class="rule_title">2. Правила общения с администрацией</div>
                <div class="rule_line"></div>
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
                <div class="rule_title">3. Правила русского языка</div>
                <div class="rule_line"></div>
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
                <div class="rule_title">4. Правила пункт четыре</div>
                <div class="rule_line"></div>
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
                は、個人情報とは、個人情報の保護に関する法律に規定される生存する個人に関する情報（氏名、生年月日、その他の特定の個人を識別することができる情報）、ならびに特定の個人と結びついて使用されるメールアドレス、ユーザーＩＤ、パスワード、クレジットカードなどの情報、および個人情報と一体となった趣味、家族構成、年齢その他の個人に関する属性情報であると認識しています。
            </section>
        </body>
        <script type="text/javascript">
            var lastResFind="";
            var copy_page="";
            function TrimStr(s) {
                s = s.replace( /^\s+/g, '');
            return s.replace( /\s+$/g, '');
            }
            function FindOnPage(inputId) {
                var obj = window.document.getElementById(inputId);
                var textToFind;
                
                if (obj) {
                    textToFind = TrimStr(obj.value);//обрезаем пробелы
                } else {
                    return;
                }
                if (textToFind == "") {
                    return;
                }
                
                if(document.body.innerHTML.indexOf(textToFind)=="-1")
                    
                
                if(copy_page.length>0)
                        document.body.innerHTML=copy_page;
                else copy_page=document.body.innerHTML;
                
                
                document.body.innerHTML = document.body.innerHTML.replace(eval("/name="+lastResFind+"/gi")," ");
                document.body.innerHTML = document.body.innerHTML.replace(eval("/"+textToFind+"/gi"),"<a name="+textToFind+" style='background:#b0b3f2'>"+textToFind+"</a>");
                lastResFind=textToFind;
                window.location = '#'+textToFind;
            } 

            var input = document.getElementById("searcher");

            input.addEventListener("keyup", function(event) {
            if (event.keyCode === 13) {
                event.preventDefault();
                FindOnPage('searcher');
            }
            });
        </script>
    ]])

    -- Settings Tab
    self.SettingsTab = vgui.Create("DPanel", self)
    self.SettingsTab:SetPos(282, 0)
    self.SettingsTab:SetSize(ScrW() - 282, ScrH())
    self.SettingsTab:SetVisible(false)
    self.SettingsTab.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(settings_top_background)
        surface.DrawTexturedRect(0, 0, 1638, 218)

        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(0, 218, w, h - 218)

        surface.SetDrawColor(255, 255, 255, 35)
        surface.SetMaterial(settings_detail_background)
        surface.DrawTexturedRect(0, 218, w, h - 218)

        draw.SimpleText("Настройки", "animelife.f4menu.settings_title", 235, 72, Color(255, 255, 255))
        draw.SimpleText("настройте интерфейс, цветокоррекцию, производительность и другое", "animelife.f4menu.settings_subtitle", 235, 72 + 46, Color(255, 255, 255))
    end

    local cx, cy, num = 434, 218 + 26, 1
    local tall = 20
    for _, cat in SortedPairs(GLOBALS_SETTINGS) do
        local cat_holder = vgui.Create("DIconLayout", self.SettingsTab)
        cat_holder:SetSize(273, 20)
        cat_holder:SetPos(cx, cy)
        cat_holder:SetSpaceX(434)
        cat_holder:SetSpaceY(20)

        -- fuck dlabels
        local cat_name = vgui.Create("DPanel", cat_holder)
        cat_name:SetSize(273, 20)
        cat_name.Paint = function(panel, w, h)
            draw.SimpleText(cat.Category, "animelife.f4menu.settings_category", w / 2, h / 2, Color(224, 172, 255), 1, 1)
        end

        for name, set in pairs(cat.Settings) do
            local set_name = vgui.Create("DPanel", cat_holder)
            set_name:SetSize(273, 20)
            set_name.Paint = function(panel, w, h)
                draw.SimpleText(name, "animelife.f4menu.settings_set", w / 2, h / 2, Color(255, 255, 255), 1, 1)
            end

            tall = tall + 40

            for _, item in pairs(set) do
                local item_name = vgui.Create("DPanel", cat_holder)
                item_name:SetSize(273, 20)
                item_name.Paint = function(panel, w, h)
                    draw.SimpleText(item.Name, "animelife.f4menu.settings_item", w / 2, h / 2, Color(255, 255, 255), 1, 1)
                end

                tall = tall + 40

                if item.Type[1] == "dropdown" then
                    local settings_dropdown = vgui.Create("animelife.settings.dropdown", cat_holder)
                    settings_dropdown:SetRealRoot(self.SettingsTab)
                    settings_dropdown:SetSize(273, 28)
                    settings_dropdown:SetValue(item.Type[2][1])
                    for i = 1, #item.Type[2] do
                        settings_dropdown:AddChoice(item.Type[2][i])
                    end
                    settings_dropdown:SetSelectFunction(function(_, value)
                        item.Type[3](value)
                    end)

                    tall = tall + 28 + 20
                elseif item.Type[1] == "checkbox" then
                    local checkbox_wide = vgui.Create("DPanel", cat_holder)
                    checkbox_wide:SetSize(273, 20)
                    checkbox_wide.Paint = function() end

                    local settings_checkbox = vgui.Create("animelife.settings.checkbox", checkbox_wide)
                    settings_checkbox:SetSize(20, 20)
                    settings_checkbox:SetPos((checkbox_wide:GetWide() - 20) / 2, 0)
                    settings_checkbox:SetClickAction(function(_, checked)
                        item.Type[2](_, checked)
                    end)

                    if item.Type[3]() then
                        settings_checkbox:SetChecked(true)
                    end

                    tall = tall + 40
                elseif item.Type[1] == "slider" then
                    local settings_slider = vgui.Create("animelife.settings.slider", cat_holder)
                    settings_slider:SetSize(273, 11)
                    settings_slider:SetMin(item.Type[3])
                    settings_slider:SetMax(item.Type[4])
                    settings_slider.OnValueChanged = function(_, value)
                        item.Type[2](value)
                    end
                end
            end
        end

        cat_holder:SetTall(tall + 256)
        if (cx + 273) >= (ScrW() - 900) then
            cy = cy + cat_holder:GetTall() + 32
            cx = 434

            num = 1
            tall = 20
        else
            cx = cx + 273 + 256
            num = num + 1
            tall = 20
        end
    end

    -- Jobs Tab
    local j_list = job_list()
    self.JobsTab = vgui.Create("DPanel", self)
    self.JobsTab:SetPos(282, 0)
    self.JobsTab:SetSize(ScrW() - 282, ScrH())
    self.JobsTab:SetVisible(false)
    self.JobsTab.Category = table.GetFirstKey(j_list)
    self.JobsTab.Job = j_list[self.JobsTab.Category][1]
    self.JobsTab.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(jobs_header_background)
        surface.DrawTexturedRect(0, 0, w, 212)

        for i = 1, 2 do
            surface.SetMaterial(jobs_header_overlay)
            surface.DrawTexturedRect(0, 0, w, 212)
        end

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(jobs_icon_badge)
        surface.DrawTexturedRect(108, 76, 42, 50)

        draw.SimpleText("Профессии", "animelife.f4menu.settings_title", 163, 60, Color(255, 255, 255))
        draw.SimpleText("отобраны со вкусом, доступны каждому. Какая-нибудь кричащая фраза в общем!", "animelife.f4menu.settings_subtitle", 163, 60 + 46, Color(255, 255, 255))

        draw.RoundedBoxEx(32, 0, h - 900, w, 900, Color(16, 17, 35), true, true, false, false)

        draw.RoundedBoxEx(32, w - 401, h - 900, 401, 900, Color(35, 38, 57), false, true, false, false)

        local j_table = panel.Job
        if istable(j_table) then
            draw.SimpleText(j_table.name or "Нет профессии", "animelife.f4menu.jobs_name", w - (401 / 2), 185 + 34, Color(255, 255, 255), 1)
            draw.SimpleText(team.NumPlayers(j_table.team) .. "/" .. (j_table.max == 0 and "∞" or j_table.max), "animelife.f4menu.jobs_category", w - (401 / 2), 185 + 34 + 32, Color(107, 108, 120), 1)
            draw.SimpleText("Описание", "animelife.f4menu.jobs_title", w - 401 + 41, 185 + 34 + 72, Color(255, 255, 255))
            draw.SimpleText("Характеристики", "animelife.f4menu.jobs_title", w - 401 + 41, 185 + 34 + 72 + 333, Color(255, 255, 255))

            local cx = w - 401 + 105
            for i = 1, 3 do
                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(jobs_icon_circle)
                surface.DrawTexturedRect(cx, 185 + 34 + 72 + 333 + 41, 41, 41)

                surface.SetMaterial(i == 1 and jobs_icon_heart or (i == 2 and jobs_icon_shield or jobs_icon_speed))
                surface.DrawTexturedRect(cx + 13, 185 + 34 + 72 + 333 + 41 + 13, 16, 16)

                local hp = j_table.hp or 100
                local armor = j_table.armor or 0
                local speed = j_table.speed or 200

                draw.SimpleText(i == 1 and hp or (i == 2 and armor or speed), "animelife.f4menu.jobs_title", cx + 20, 185 + 34 + 72 + 333 + 41 + 46, Color(255, 255, 255), 1)

                cx = cx + 41 + 34
            end

            draw.SimpleText("Вооружение", "animelife.f4menu.jobs_title", w - 401 + 41, 185 + 34 + 72 + 333 + 117, Color(255, 255, 255))

            local weps = j_table.weapons
            local wy = 0
            for _, wep in pairs(weps) do
                if !isstring(wep) then continue end
                local wep_name = weapons.Get(wep)
                if wep_name == nil then continue end
                wep_name = wep_name.PrintName
                if !isstring(wep_name) then continue end

                draw.DrawText("• " .. wep_name, "animelife.f4menu.jobs_title", w - 401 + 56, 185 + 34 + 72 + 333 + 117 + 28 + wy, Color(126, 128, 136))
                wy = wy + 20
            end
        end
    end

    self.JobDescription = vgui.Create("DScrollPanel", self.JobsTab)
    self.JobDescription:SetPos(self.JobsTab:GetWide() - 401 + 41, 324)
    self.JobDescription:SetSize(316, 293)
    local job_vbar = self.JobDescription:GetVBar()
    job_vbar:SetWide(4)

    self.JobDescriptionText = vgui.Create("DLabel", self.JobDescription)
    self.JobDescriptionText:SetText(self.JobsTab.Job.description)
    self.JobDescriptionText:SetAutoStretchVertical(true)
    self.JobDescriptionText:SetWrap(true)
    self.JobDescriptionText:SetWide(self.JobDescription:GetWide())
    self.JobDescriptionText:SetColor(Color(126, 128, 136))
    self.JobDescriptionText:SetFont("animelife.f4menu.jobs_title")

    self.JobButton = vgui.Create("DButton", self.JobsTab)
    self.JobButton:SetPos(self.JobsTab:GetWide() - 211 - 87, self.JobsTab:GetTall() - 50 - 33)
    self.JobButton:SetSize(211, 50)
    self.JobButton:SetText("")
    self.JobButton.Paint = function(panel, w, h)
        local job = self.JobsTab.Job
        local taken = job.team == LocalPlayer():Team()
        if team.NumPlayers(job.team) >= (job.max == 0 and math.huge or job.max) then
            taken = true
        end

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(taken and jobs_button_get_locked or jobs_button_get)
        surface.DrawTexturedRect(0, 0, w, h)

        draw.SimpleText(taken and "Лимит или используется" or "Выбрать профессию", "animelife.f4menu.jobs_title", w / 2, h / 2, Color(255, 255, 255), 1, 1)
    end
    self.JobButton.DoClick = function()
        local job = self.JobsTab.Job
        if job.vote or job.RequiresVote and job.RequiresVote(LocalPlayer(), job.team) then
            RunConsoleCommand("darkrp", "vote" .. job.command)
        else
            RunConsoleCommand("darkrp", job.command)
        end

        self:SetVisible(false)
        gui.EnableScreenClicker(false)
    end

    local function layout(cat)
        for _, pnl in pairs(self.JobsLayout.PanelList) do
            if pnl.Category ~= cat then
                pnl:SetVisible(false)
            else
                pnl:SetVisible(true)
            end
        end

        self.JobsLayout:Layout()
    end

    local cbx, cby = 62, 158
    for k, _ in pairs(job_list()) do
        local job_cat = vgui.Create("DButton", self.JobsTab)
        job_cat:SetPos(cbx, cby)
        job_cat:SetSize(154, 24)
        job_cat:SetText("")
        job_cat.Paint = function(panel, w, h)
            if self.JobsTab.Category == k then
                surface.SetDrawColor(184, 110, 153)
                surface.DrawRect(0, h - 4, w, 4)
            end

            draw.SimpleText(k, "animelife.f4menu.jobs_category", w / 2, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        end
        job_cat.DoClick = function()
            self.JobsTab.Category = k

            for _, pnl in pairs(self.JobsLayout.PanelList) do
                if pnl.Category ~= k then
                    pnl:SetVisible(false)
                else
                    pnl:SetVisible(true)
                end
            end

            self.JobsLayout:Layout()
        end

        cbx = cbx + 154
    end

    self.JobsList = vgui.Create("DScrollPanel", self.JobsTab)
    self.JobsList:SetPos(21, 195 + 32)
    self.JobsList:SetSize(self.JobsTab:GetWide() - 401 - 21, self.JobsTab:GetTall() - (195 + 32))

    local v_bar = self.JobsList:GetVBar()
    v_bar:SetWide(4)
    v_bar.Paint = function() end
    v_bar.btnUp.Paint = function() end
    v_bar.btnDown.Paint = function() end
    v_bar.btnGrip.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255, 8)
        surface.DrawRect(0, 0, w, h)
    end

    self.JobsLayout = vgui.Create("DIconLayout", self.JobsList)
    self.JobsLayout:Dock(FILL)
    -- self.JobsLayout:SetSpaceX(9999)
    self.JobsLayout:SetSpaceY(12)
    self.JobsLayout:SetLayoutDir(TOP)
    self.JobsLayout.PanelList = {}

    for _, c in pairs(job_list()) do
        for _, j in pairs(c) do
            if isfunction(j.canSee) and !j.canSee(LocalPlayer()) and j.secret then
                continue
            end

            if j.admin and !LocalPlayer():IsAdmin() then
                continue
            end

            local job_item = vgui.Create("DPanel", self.JobsLayout)
            job_item:SetSize(self.JobsList:GetWide() - 21, 48)
            job_item:SetCursor("hand")
            job_item.Category = j.category
            job_item.Paint = function(panel, w, h)
                draw.RoundedBox(16, 0, 0, w, h, Color(35, 38, 57))

                local name = j.name
                local slots = team.NumPlayers(j.team) .. "/" .. (j.max == 0 and "∞" or j.max)

                draw.SimpleText(name, "animelife.f4menu.jobs_category", 46, h / 2, Color(255, 255, 255), nil, TEXT_ALIGN_CENTER)
                draw.SimpleText(slots, "animelife.f4menu.jobs_category", w - 46, h / 2, Color(115, 116, 128), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

                if j.isWIP then
                    surface.SetDrawColor(255, 255, 255)
                    surface.SetMaterial(jobs_icon_lock)
                    surface.DrawTexturedRect(w / 2 - 43, (h - 43) / 2, 43, 43)

                    draw.DrawText("Недоступно:\nоткроется в следующих обновлениях", "animelife.f4menu.jobs_category", w / 2, 10, Color(255, 255, 255, 150), nil)
                end
            end
            job_item.OnMousePressed = function()
                self.JobsTab.Job = j

                self.JobDescriptionText:SetText(self.JobsTab.Job.description)
            end

            table.insert(self.JobsLayout.PanelList, job_item)
        end
    end

    -- Store Tab
    self.StoreTab = vgui.Create("DPanel", self)
    self.StoreTab:SetPos(282, 0)
    self.StoreTab:SetSize(ScrW() - 282, ScrH())
    self.StoreTab:SetVisible(false)
    self.StoreTab.Paint = function(panel, w, h)
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(store_top_background)
        surface.DrawTexturedRect(0, 0, 1638, 218)

        surface.SetMaterial(store_icon)
        surface.DrawTexturedRect(235 - 58 - 20, 88, 58, 50)

        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(0, 218, w, h - 218)

        draw.SimpleText("Магазин", "animelife.f4menu.settings_title", 235, 72, Color(255, 255, 255))
        draw.SimpleText("покупайте товары доступные всем", "animelife.f4menu.settings_subtitle", 235, 72 + 46, Color(255, 255, 255))
    end

    self.StoreScroll = vgui.Create("DScrollPanel", self.StoreTab)
    self.StoreScroll:SetPos(0, 218)
    self.StoreScroll:SetSize(self.StoreTab:GetWide(), self.StoreTab:GetTall() - 218)

    self.StoreLayout = vgui.Create("DIconLayout", self.StoreScroll)
    self.StoreLayout:Dock(FILL)
    self.StoreLayout:SetSpaceX(28)
    self.StoreLayout:SetSpaceY(33)
    self.StoreLayout:SetBorder(48)

    for _, ent in pairs(DarkRPEntities) do
        local ent_panel = vgui.Create("DPanel", self.StoreLayout)
        ent_panel:SetSize(347, 165)
        ent_panel.Paint = function(panel, w, h)
            draw.RoundedBox(24, 0, 0, w, h, Color(0, 0, 0, 75))
            draw.RoundedBoxEx(24, 0, 0, w, 38, Color(0, 0, 0, 150), true, true, false, false)

            draw.SimpleText(ent.name, "animelife.f4menu.settings_subtitle", w / 2, 8, Color(255, 255, 255), 1)

            local description = ent.description
            if description == nil then
                description = "Описание недоступно для этого предмета."
            end
            local desc = markup.Parse("<font=animelife.f4menu.store_description>" .. description .. "</font>", w - 64)
            desc:Draw(32, h / 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local ent_button = vgui.Create("DButton", ent_panel)
        ent_button:SetSize(ent_panel:GetWide(), 38)
        ent_button:SetPos(0, ent_panel:GetTall() - 38)
        ent_button:SetText("")
        ent_button.Paint = function(panel, w, h)
            draw.RoundedBoxEx(24, 0, 0, w, h, Color(197, 255, 170, 150), false, false, true, true)
            draw.SimpleText("Купить за " .. string.Comma(ent.price) .. "¥", "animelife.f4menu.settings_subtitle", w / 2, h / 2, Color(255, 255, 255), 1, 1)
        end
        ent_button.DoClick = function()
            RunConsoleCommand("say", "/" .. ent.cmd)

            self:SetVisible(false)
            gui.EnableScreenClicker(false)
        end
    end
end

function PANEL:HideTabs()
    self.MainTab:SetVisible(false)
    self.RulesTab:SetVisible(false)
    self.SettingsTab:SetVisible(false)
    self.JobsTab:SetVisible(false)
    self.StoreTab:SetVisible(false) 
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(40, 44, 56)
    surface.DrawRect(0, 0, w, h)

    if self.CurrentTab == 1 then
        surface.SetDrawColor(0, 0, 0)
        surface.DrawRect(282, 0, ScrW() - 282, 367)
    end
end

vgui.Register("animelife.f4menu", PANEL, "EditablePanel")

net.Receive("animelife.f4menu", function()
    if !ValidPanel(GLOBALS_F4MENU) then
        GLOBALS_F4MENU = vgui.Create("animelife.f4menu")
        GLOBALS_F4MENU:SetSize(ScrW(), ScrH())
        GLOBALS_F4MENU:SetVisible(false)
    end

    if GLOBALS_F4MENU:IsVisible() then
        GLOBALS_F4MENU:AlphaTo(0, 0.1)
        GLOBALS_F4MENU:SetVisible(false)
        gui.EnableScreenClicker(false)
    else
        GLOBALS_F4MENU:AlphaTo(255, 0.25)
        GLOBALS_F4MENU:SetVisible(true)
        gui.EnableScreenClicker(true)
    end

    local likes = net.ReadInt(16)
    if isnumber(likes) then
        GLOBALS_F4MENU.UpdateLikes = likes
    end
end)