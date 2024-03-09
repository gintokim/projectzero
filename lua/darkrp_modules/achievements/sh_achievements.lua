module("achievements", package.seeall)

List = {}

function achievements:New(
    name, description, icon, max_progress, on_complete
)
    List[#List + 1] = {
        Name = name,
        Description = description or "No description",
        Icon = icon,
        Progress = max_progress or 1,
        CompleteFunc = on_complete
    }

    return #List
end

function achievements:GetMaxProgress(idx)
    return List[idx].Progress
end

function achievements:GetStatus(ply, idx)
    if List[idx] == nil then
        return false
    end

    local achieved_achievements = ply:GetNWString("animelife.achievements")
    if achieved_achievements == nil then
        return false
    end

    achieved_achievements = string.Split(achieved_achievements, "+")

    return table.HasValue(achieved_achievements, tostring(idx))
end

function achievements:GetAllCompleted(ply)
    local achieved_achievements = ply:GetNWString("animelife.achievements")
    if achieved_achievements == nil then
        return {}
    end

    achieved_achievements = string.Split(achieved_achievements, "+")

    return achieved_achievements
end

function achievements:numerize(idx)
    return tonumber(idx)
end