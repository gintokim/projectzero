util.AddNetworkString("animelife.itemdrop.begin")
util.AddNetworkString("animelife.itemdrop.stop")

module("itemdrop", package.seeall)

function itemdrop:Drop(ply)
    if !ply.itemdrop then
        return
    end

    local tr = ply:GetEyeTrace()
    local pos = tr.HitPos
    local ang = tr.HitNormal:Angle() + Angle(90, 0, 0)

    -- Prop is too far away
    if pos:DistToSqr(ply:GetPos()) > 1024^2 then 
        return 
    end

    local vertical_offset = ply:GetNWVector("animelife.itemdrop.local_pos", Vector(0, 0, 0))
    local local_angle = ply:GetNWAngle("animelife.itemdrop.local_angle", Angle(0, 0, 0))

    if !self:CanDrop(pos + vertical_offset) then
        return
    end

    local item = ents.Create("prop_physics")
    item:SetPos(pos + vertical_offset)
    item:SetAngles(ang + local_angle)
    item:SetModel(ply.itemdrop.model)
    item:Spawn()
    
    item:SetSpawnEffect(true)

    if item.CPPISetOwner then
        item:CPPISetOwner(ply)
    end

    -- item:SetOwner(ply)

    local phys = item:GetPhysicsObject()
    if IsValid(phys) then
        -- Freeze it until picked up again
        phys:EnableMotion(false)
    end

    ply:AddCount("props", item)

    undo.Create("prop")
        undo.AddEntity(item)
        undo.SetPlayer(ply)
    undo.Finish()

    -- self:Stop(ply)

    achievements:MarkCompleted(ply, 3)
end

function itemdrop:Begin(ply, mdl)
    net.Start("animelife.itemdrop.begin")
        net.WriteString(mdl)
    net.Send(ply)

    if !ply.itemdrop then
        ply.itemdrop = {}
    end

    ply.itemdrop.model = mdl
end

function itemdrop:Stop(ply)
    net.Start("animelife.itemdrop.stop")
    net.Send(ply)

    ply.itemdrop = nil
end

concommand.Add("animelife_prop_drop", function(ply, cmd, args)
    itemdrop:Drop(ply)
end)

hook.Add("PlayerButtonDown", "animelife.itemdrop.rotate", function(ply, btn)
    if btn == KEY_UP then
        local last_angle = ply:GetNWAngle("animelife.itemdrop.local_angle", Angle(0, 0, 0))
        ply:SetNWAngle("animelife.itemdrop.local_angle", last_angle + Angle(-5, 0, 0))
    elseif btn == KEY_DOWN then
        local last_angle = ply:GetNWAngle("animelife.itemdrop.local_angle", Angle(0, 0, 0))
        ply:SetNWAngle("animelife.itemdrop.local_angle", last_angle + Angle(5, 0, 0)) 
    elseif btn == KEY_RIGHT then
        local last_angle = ply:GetNWAngle("animelife.itemdrop.local_angle", Angle(0, 0, 0))
        ply:SetNWAngle("animelife.itemdrop.local_angle", last_angle + Angle(0, 5, 0)) 
    elseif btn == KEY_LEFT then
        local last_angle = ply:GetNWAngle("animelife.itemdrop.local_angle", Angle(0, 0, 0))
        ply:SetNWAngle("animelife.itemdrop.local_angle", last_angle + Angle(0, -5, 0)) 
    elseif btn == KEY_PAGEUP then
        local last_pos = ply:GetNWVector("animelife.itemdrop.local_pos", Vector(0, 0, 0))
        ply:SetNWVector("animelife.itemdrop.local_pos", last_pos + Vector(0, 0, 5))
    elseif btn == KEY_PAGEDOWN then
        local last_pos = ply:GetNWVector("animelife.itemdrop.local_pos", Vector(0, 0, 0))
        ply:SetNWVector("animelife.itemdrop.local_pos", last_pos + Vector(0, 0, -5))
    elseif btn == MOUSE_LEFT then
        itemdrop:Drop(ply)
    elseif btn == KEY_ESCAPE then
        itemdrop:Stop(ply)
    end
end)

-- Usergroup Limits
local LIMIT_FALLBACK = 100
local limits = {
    ["eventer"] = 200,
}

hook.Add("PlayerSpawnProp", "animelife.itemdrop.limiter", function(ply, model)
    if ply:GetCount("props") >= (limits[ply:GetUserGroup()] or LIMIT_FALLBACK) then
        return false
    end

    if ply:GetInfoNum("animelife_buildmode", 0) == 1 then
        itemdrop:Begin(ply, model)

        return false
    end
end)