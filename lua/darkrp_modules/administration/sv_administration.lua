sql.Query("CREATE TABLE IF NOT EXISTS animelife_bans(SteamID TINYTEXT, Reason TINYTEXT, Date SMALLINT, Time SMALLINT, Expired TINYINT)")

util.AddNetworkString("animelife.administration.menu")

module("administration", package.seeall)

hook.Add("PlayerInitialSpawn", "animelife.administration.UserGroups", function(ply)
    timer.Simple(1, function()
        if !IsValid(ply) then return end

        // ply:SetUserGroup("player")
        // ply:SetUserGroup("admin")
    end)
end)

function Slay(admin, target)
    target:Kill()

    return true
end

function God(admin, target)
    if target.aniadmin_god then
        target:GodEnable()
        target.aniadmin_god = false
    else
        target:GodDisable()
        target.aniadmin_god = true
    end

    return target.aniadmin_god
end

function StripWeapons(admin, target)
    target:StripWeapons()

    return true
end

function NoDraw(admin, target)
    if target.aniadmin_nodraw then
        target:SetNoDraw(false)
        target.aniadmin_nodraw = false
    else
        target:SetNoDraw(true)
        target.aniadmin_nodraw = true
    end

    return target.aniadmin_nodraw
end

function Freeze(admin, target)
    if target.aniadmin_locked then
        target:UnLock()
        target.aniadmin_locked = false
    else
        target:Lock()
        target.aniadmin_locked = true
    end

    return target.aniadmin_locked
end

function GiveWeapon(admin, target, weapon)
    target:Give(weapon)

    return true
end

function ChangeTeam(admin, target, team_index)
    // target:SetTeam(team_index)
    // target:Spawn()

    setTeam(target, team_index, true)

    return true
end

function SetHealth(admin, target, amount)
    target:SetHealth(amount)

    return true
end

function SetArmor(admin, target, amount)
    target:SetArmor(amount)

    return true
end

function GotoCoords(admin, target, pos)
    target.aniadmin_lastpos = target:GetPos()
    target:SetPos(pos)

    return true
end

function GotoPlayer(admin, target, target2)
    target.aniadmin_lastpos = target:GetPos()
    target:SetPos(target2:GetPos())

    return true
end

function Return(admin, target)
    if isvector(target.aniadmin_lastpos) then
        target:SetPos(target.aniadmin_lastpos)
    end

    return true
end

function Noclip(admin, target)
    if target.aniadmin_noclip then
        target.aniadmin_noclip = false
    else
        target.aniadmin_noclip = true
    end

    return target.aniadmin_noclip
end

hook.Add("PlayerNoClip", "animelife.ManageNoClip", function(ply, desiredNoClipState)
    if !desiredNoClipState then return true end
	if ply.aniadmin_noclip and desiredNoClipState then
        return true
    end
end)

function Mute(admin, target, chat_type, time)
    if chat_type == "chat" then
        target.aniadmin_chatmute = true
    elseif chat_type == "voice" then
        target.aniadmin_voicemute = true
    end

    timer.Simple((time or 10) * 60, function()
        if !IsValid(target) then return end

        if chat_type == "chat" then
            target.aniadmin_chatmute = false
        elseif chat_type == "voice" then
            target.aniadmin_voicemute = false
        end
    end)

    return true
end

function Unmute(admin, target, chat_type)
    if chat_type == "chat" then
        target.aniadmin_chatmute = false
    elseif chat_type == "voice" then
        target.aniadmin_voicemute = false
    end

    return true
end

function Ban(admin, target, reason, time)
    time = (time or 10) * 60
    reason = reason or "неизвестна"
    local steam_id = target

    if !isstring(target) and IsValid(target) then
        target:changeTeam(target, TEAM_CITIZEN or 1, true)
        target:Spawn()
        target:StripWeapons()
        target:SetNoDraw(true)
        target:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        
        -- netvars
        target:SetNWBool("animelife.administration.ban", true)
        target:SetNWString("animelife.administration.ban_reason", reason)
        target:SetNWInt("animelife.administration.ban_date", os.time() + time)
        target:SetNWFloat("animelife.administration.ban_wait", UnPredictedCurTime() + time)

        target:SetNWInt("animelife.administration.ban_count", target:GetNWInt("animelife.administration.ban_count", 0) + 1)

        -- set steam id
        steam_id = target:SteamID()
    end

    // sql.Query("DELETE FROM animelife_bans WHERE SteamID = " .. SQLStr(steam_id)) -- incase there's a ban already
    sql.Query("UPDATE animelife_bans SET Expired = " .. 1 .. " WHERE SteamID = " .. SQLStr(steam_id))
    sql.Query("INSERT INTO animelife_bans(SteamID, Reason, Date, Time, Expired) VALUES("
    .. SQLStr(steam_id) .. ", "
    .. SQLStr(reason) .. ", "
    .. os.time() + time .. ", "
    .. time .. ", "
    .. 0 .. ")")
end

function Unban(admin, target)
    local steam_id = target
    if !isstring(target) and IsValid(target) then
        if !target:GetNWBool("animelife.administration.jail", false) then
            target:changeTeam(target, TEAM_CITIZEN or 1, true)
            target:Spawn()
            target:SetNoDraw(false)
            target:SetCollisionGroup(COLLISION_GROUP_PLAYER)
        end
        
        -- netvars
        target:SetNWBool("animelife.administration.ban", false)
        target:SetNWString("animelife.administration.ban_reason", nil)
        target:SetNWInt("animelife.administration.ban_date", nil)
        target:SetNWFloat("animelife.administration.ban_wait", nil)

        -- set steam id
        steam_id = target:SteamID()
    end

    // sql.Query("DELETE FROM animelife_bans WHERE SteamID = " .. SQLStr(steam_id))
    sql.Query("UPDATE animelife_bans SET Expired = " .. 1 .. " WHERE SteamID = " .. SQLStr(steam_id))
end

hook.Add("PlayerLoadout", "animelife.administration.PlayerLoadout", function(ply)
    if ply:GetNWBool("animelife.administration.ban", false) or ply:GetNWBool("animelife.administration.jail", false) then
        return true -- prevent loadout
    end
end)

hook.Add("PlayerInitialSpawn", "animelife.administration.RestoreBans", function(ply)
    timer.Simple(2, function()
        if !IsValid(ply) then return end

        local data = sql.Query("SELECT * FROM animelife_bans WHERE SteamID = " .. SQLStr(ply:SteamID()))
        if istable(data) and #data > 0 then
            local last_key = table.GetLastKey(data)
            if tonumber(data[last_key].Expired) < 1 then
                ply:changeTeam(ply, TEAM_CITIZEN or 1, true)
                ply:Spawn()
                ply:StripWeapons()
                ply:SetNoDraw(true)
                ply:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
                
                -- netvars
                ply:SetNWBool("animelife.administration.ban", true)
                ply:SetNWString("animelife.administration.ban_reason", data[last_key].Reason)
                ply:SetNWInt("animelife.administration.ban_date", data[last_key].Date)
                ply:SetNWFloat("animelife.administration.ban_wait", UnPredictedCurTime() + data[last_key].Time)
            end

            ply:SetNWInt("animelife.administration.ban_count", #data)
        end
    end)
end)

function Jail(admin, target, time)
    time = (time or 10) * 60

    target:SetNWBool("animelife.administration.jail", true)
    target:SetNWFloat("animelife.administration.jail_wait", UnPredictedCurTime() + time)
    target.aniadmin_jailtime = os.time() + time

    if !target:GetNWBool("animelife.administration.ban", false) then
        target:changeTeam(target, TEAM_CITIZEN or 1, true)
        target:Spawn()
    end
end

function Unjail(admin, target)
    target:SetNWBool("animelife.administration.jail", false)
    target:SetNWFloat("animelife.administration.jail_wait", nil)
    target.aniadmin_jailtime = 0

    if !target:GetNWBool("animelife.administration.ban", false) then
        target:changeTeam(target, TEAM_CITIZEN or 1, true)
        target:Spawn()
    end
end

hook.Add("PlayerSpawn", "animelife.administration.JailBanSpawn", function(ply)
    if ply:GetNWBool("animelife.administration.ban", false) or ply:GetNWBool("animelife.administration.jail", false) then
        ply:StripWeapons()
        ply:SetNoDraw(true)
        ply:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    end
end)

timer.Create("animelife.JailThink", 2, 0, function()
    for _, ply in pairs(player.GetHumans()) do
        if ply:GetNWBool("animelife.administration.jail", false) then
            if (ply.aniadmin_jailtime or 0) < os.time() then
                Unjail(game.GetWorld(), ply)
            end
        end
    end
end)

timer.Create("animelife.BansThink", 6, 0, function()
    local t = sql.Query("SELECT * FROM animelife_bans")
    if istable(t) and #t > 0 then
        for i = 1, #t do
            local v = t[i]
            if tonumber(v.Expired) == 0 and (tonumber(v.Date) < os.time()) then
                // sql.Query("UPDATE animelife_bans SET Expired = " .. 1 .. "WHERE SteamID = " .. SQLStr(v.SteamID))
                if IsValid(player.GetBySteamID(v.SteamID)) then
                    Unban(game.GetWorld(), player.GetBySteamID(v.SteamID))
                else
                    Unban(game.GetWorld(), v.SteamID)
                end
            end
        end
    end
end)

function OpenMenu(ply)
    if !ply:IsAdmin() then return end
    
    local warns = GetWarns(ply)
    warns = util.TableToJSON(warns)
    warns = util.Compress(warns)

    local len = warns:len()
    net.Start("animelife.administration.menu")
        net.WriteInt(len, 32)
        net.WriteData(warns, len)
    net.Send(ply)
end