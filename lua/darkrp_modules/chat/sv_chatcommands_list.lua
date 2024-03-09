timer.Simple(0.0, function()
    -- mypos: Prints your location to local chat
    chatcommands.Add({"mypos", "location", "whereat", "pos", "getpos"}, function(ply, msg)
        local loc = location.GetName(location.Get(ply:GetPos()))
        if loc == "Unknown Location" then
            loc = "Неизвестная локация"    
        end

        ply:ChatPrint("Локация: " .. loc)

        -- Hides sent message
        return ""
    end)

    -- showstats: Prints bans & jails count
    chatcommands.Add({"showstats", "stats"}, function(ply, msg)
        local bans = ply:GetNWInt("animelife.administration.ban_count", 0)
        local jails = 0

        ply:ChatPrint("Банов: " .. bans)
        ply:ChatPrint("Джайлов: " .. jails)

        -- Hides sent message
        return ""
    end)

    -- showtime: Prints your playtime and leaderboard place
    chatcommands.Add({"showtime", "time"}, function(ply, msg)
    end)

    -- roll: You know what this one is for
    chatcommands.Add({"roll", "dice", "roll_the_dice", "rolldice", "diceroll", "random"}, function(ply, msg)
        local up_to = string.Split(msg, " ")[2]
        if isnumber(tonumber(up_to)) then
            up_to = tonumber(up_to)
        else
            up_to = 100
        end

        local result = math.random(0, up_to)

        -- TODO: Make this colored
        for _, o in pairs(ents.FindInSphere(ply:GetPos(), 256)) do
            if !o:IsPlayer() then continue end
            o:ChatPrint(ply:Nick() .. " выпало " .. result)
        end
    end)

    -- advert: You know what this one is for
    local ADVERT_DEFAULT_PRICE = 100
    chatcommands.Add({"advert", "ad", "advertisement"}, function(ply, msg)
        if ply:Team() == TEAM_MAYOR then
            ply:ChatPrint("Реклама недоступна мэру.")
            return ""
        end

        local advert_price = game.GetWorld():GetNWInt("animelife.roleplay.advert_price", ADVERT_DEFAULT_PRICE)
        if !ply:canAfford(advert_price) then
            ply:ChatPrint("Недостаточно средств для запуска рекламы.")
            return ""
        end

        local explode_msg = string.Split(msg, " ")
        local advert_text = table.concat(explode_msg, " ", 2)
        local state = advertisement.Queue(ply, advert_text)
        if !state then return "" end

        ply:addMoney(-advert_price)

        local mayor = team.GetPlayers(TEAM_MAYOR)[1]
        if IsValid(mayor) and mayor:IsPlayer() then
            mayor:addMoney(advert_price)
        end

        -- Hides sent message
        return ""
    end)

    chatcommands.Add({"advertprice", "setadvertprice", "advertsetprice", "adprice", "setadprice", "adsetprice", "advertcost", "setadvertcost", "advertsetcost", "adcost", "setadcost", "adcostset", function(ply, msg)
    end})
end)