util.AddNetworkString("animelife.groups.invitation")
util.AddNetworkString("animelife.groups.accept")
util.AddNetworkString("animelife.groups.makeinvite")

module("groups", package.seeall)

function Invite(ply, send_to)
    if table.HasValue(send_to, ply) then
        table.RemoveByValue(send_to, ply)
    end

    ply:SetNWString("animelife.groups.invitations", util.TableTOJSON(send_to))

    net.Start("animelife.groups.invitation")
        net.WriteEntity(ply)
    net.Send(send_to)
end

function Accept(ply, invitor)
    local inv_list = util.JSONToTable(invitor:GetNWString("animelife.groups.invitations", "[]"))
    if !table.HasValue(inv_list, ply:SteamID()) then
        return
    end

    local inv_token = string.Replace(ply:SteamID(), "STEAM_", "GROUP_")
    if inv_token ~= invitor:GetNWString("animelife.group") then
        invitor:SetNWString("animelife.group", inv_token)
    end

    ply:SetNWString("animelife.group", invitor:GetNWString("animelife.group"))
end

local function count_players_in_group(group)
    local c = 0
    for _, ply in pairs(player.GetAll()) do
        if ply:GetNWString("animelife.group") == group then
            c = c + 1
        end
    end

    return c
end

function Leave(ply)
    ply:SetNWString("animelife.group", nil)
    ply:SetNWString("animelife.groups.invitations", "[]")
end

net.Receive("animelife.groups.accept", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local invitor = net.ReadEntity()
    if !IsValid(invitor) then return end

    Accept(ply, invitor)
end)

net.Receive("animelife.groups.makeinvite", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    local send_to = net.ReadString()
    send_to = util.JSONToTable(send_to)
    Invite(ply, send_to)
end)