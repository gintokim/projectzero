CreateClientConVar("animelife_buildmode", "0", false, true, "Change building mode")

local buttons = {
    {"Магазин фонов", function()
        OpenBackgroundStore()
    end},
    {"Магазин префиксов и статусов", function()
        OpenPrefixStore()
    end},
    {"Предложения и баги", function()
        bugreport:ClientMenu()
    end},
    {"Переключить режим строительства", function()
        local val = LocalPlayer():GetInfoNum("animelife_buildmode", 0)
        RunConsoleCommand("animelife_buildmode", val == 0 and 1 or 0)
    end},
    {"!spacer", function()
    end, function()
        return LocalPlayer():Team() == TEAM_MUSILY
    end},
    {"Проиграть трек", function()
        Derma_StringRequest("Проиграть трек", "Вставьте ссылку на трек Soundcloud или путь до .mp3", "", function(res)
            RunConsoleCommand("animelife_boombox", res)
        end)
    end, function()
        return LocalPlayer():Team() == TEAM_MUSILY
    end},
    {"Остановить трек", function()
        RunConsoleCommand("animelife_boombox_stop")
    end, function()
        return LocalPlayer():Team() == TEAM_MUSILY and IsValid(LocalPlayer().AudioStation)
    end},
}

local function open_context()
    local derma_menu = DermaMenu(false, g_ContextMenu)

    for _, b in pairs(buttons) do
        if isfunction(b[3]) and !b[3]() then
            continue    
        end

        if b[1] == "!spacer" then
            derma_menu:AddSpacer()
            continue
        end

        derma_menu:AddOption(b[1], b[2])
    end

    derma_menu:Open(16, 0)
    derma_menu:CenterVertical()
end
concommand.Add("animelife_context", open_context)

hook.Add("OnContextMenuOpen", "animelife.contextmenu", function()
    LocalPlayer():ConCommand("animelife_context")
end)