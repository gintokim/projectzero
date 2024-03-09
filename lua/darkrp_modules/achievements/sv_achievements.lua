util.AddNetworkString("animelife.achievements.achieved")
util.AddNetworkString("animelife.achievements.customizer")

module("achievements", package.seeall)

function achievements:Effect(ply)
    local pitch = math.random(75, 150)
    ply:EmitSound("animelife/achievement-get.mp3", nil, pitch)

    local ef = EffectData()
    ef:SetOrigin(ply:GetPos())
    ef:SetScale(32)
    util.Effect("achievement_effect", ef)

    ef:SetOrigin(ply:GetPos() + Vector(0, 0, 48))
    ef:SetScale(32)
    util.Effect("achievement_effect", ef)
end

function achievements:BroadcastMessage(original_player, achi)
    for _, ply in pairs(player.GetHumans()) do
        ply:ChatPrint(original_player:Nick() .. " just achieved " .. achi .. "!")
    end
end

-- it feels waaay too overcomplicated
function achievements:UpdateProgress(ply, idx, add_progress)
    local achieved = self:GetStatus(ply, idx)
    if achieved then return end

    local progressing_achievements = ply:GetNWString("animelife.achievements.unfinished", "")

    local existing = false 
    if progressing_achievements:find(idx .. ": ") then
        existing = true
    end

    -- index: progress
    if !existing then
        ply:SetNWString("animelife.achievements.unfinished", progressing_achievements .. "+" .. (idx .. ": " .. add_progress))
        return 
    end

    local table_of = string.Split(progressing_achievements, "+")
    local replace_value = ""
    for i = 1, #table_of do
        local v = table_of[i]
        if string.StartWith(v, idx .. ": ") then
            replace_value = v
        end
    end

    if replace_value == "" then
        return
    end

    local start_pos, end_pos = string.find(replace_value, ": ", 1, true)
    start_pos, end_pos = start_pos + 1, utf8.len(replace_value)
    local last_val = utf8.sub(replace_value, start_pos, end_pos)
    last_val = string.Trim(last_val, " ")
    last_val = tonumber(last_val)

    -- It's achieved. Stop.
    if last_val + add_progress >= List[idx].Progress then
        self:MarkCompleted(ply, idx)
        return
    end

    progressing_achievements = string.Replace(progressing_achievements, replace_value, idx .. ": " .. (last_val + add_progress))

    ply:SetNWString("animelife.achievements.unfinished", progressing_achievements)
end

function achievements:MarkCompleted(ply, idx)
    local achieved = self:GetStatus(ply, idx)
    if achieved then return end

    local achieved_achievements = ply:GetNWString("animelife.achievements", "")

    ply:SetNWString("animelife.achievements", achieved_achievements .. "+" .. idx)

    local achi_name = List[idx].Name

    self:Effect(ply)
    -- self:BroadcastMessage(ply, achi_name)

    net.Start("animelife.achievements.achieved")
        net.WriteString(achi_name)
        net.WriteInt(idx, 16)
    net.Send(ply)

    if isfunction(List[idx].CompleteFunc) then
        List[idx].CompleteFunc()
    end
end

net.Receive("animelife.achievements.customizer", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end

    achievements:MarkCompleted(ply, 5)
end)