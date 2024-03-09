util.AddNetworkString("animelife.advertisement")

module("advertisement", package.seeall)

List = List or {}

local ADVERT_SHOW_TIME = 30

function Queue(ply, ad)
    -- Don't do anything if there were any old adverts
    if istable(List[1]) then 
        ply:ChatPrint("Уже есть активное объявление.")

        return false
    end

    if utf8.len(ad) < 10 then
        ply:ChatPrint("Слишком короткий текст объявления.")

        return false
    end

    if utf8.len(ad) > 86 then
        ad = utf8.sub(ad, 1, 86)
    end

    List[1] = {
        Player = ply,
        Text = ad
    }

    Show(1)

    timer.Simple(ADVERT_SHOW_TIME, function()
        game.GetWorld():SetNWString("animelife.roleplay.advert_text", nil)

        List[1] = nil
    end)

    -- game.GetWorld():SetNWString("animelife.roleplay.advert_text", ad)

    -- -- Move onto the next one
    -- timer.Simple(ADVERT_SHOW_TIME, function()
    --     List[idx] = nil -- be gone

    --     local n = idx + 1
    --     if List[n] then
    --         local text = List[n].Text

    --         game.GetWorld():SetNWString("animelife.roleplay.advert_text", text)

    --         -- Repeat the timers
    --         timer.Simple(ADVERT_SHOW_TIME, function()
    --             List[n] = nil
    --         end)
    --     end
    -- end)

    return true
end

function Show(idx)
    local ad_text = List[idx].Text
    local ad_player = List[idx].Player

    game.GetWorld():SetNWString("animelife.roleplay.advert_text", ad_text)

    if !IsValid(ad_player) then
        ad_player = "Отключившийся игрок"
    else
        ad_player = ad_player:Nick()
    end

    net.Start("animelife.advertisement")
        net.WriteString(ad_text)
        net.WriteString(ad_player)
    net.Broadcast()

    -- Drop
    -- List[idx] = nil
end

-- timer.Create("animelife.roleplay.advert_queue", ADVERT_SHOW_TIME, 0, function()
--     if #List > 0 then
--         Show(math.random(1, #List))
--     else
--         game.GetWorld():SetNWString("animelife.roleplay.advert_text", nil)
--     end
-- end)