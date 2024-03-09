module("eventsystem", package.seeall)

List = {}
PerDayLimit = 2
EventCount = EventCount or 0
Current = Current or ""

function Add(name, global_name, length, script, cleaner)
    if name == nil then
        return 
    end

    -- There's no point having this event if it's empty
    if script == nil then
        return
    end

    if global_name == nil then
        global_name = name
    end

    List[name] = {
        Name = global_name,
        Length = length or 600,
        Script = script,
        Cleaner = cleaner
    }

    return List[name]
end

function Start(name)
    -- Consider this as random
    if name == nil then 
        return 
    end

    Current = Name
    EventCount = EventCount + 1

    List[name].Script()

    local e_key = "animelife.eventsystem.event_" .. name
    if timer.Exists(e_key) then
        timer.Remove(e_key)
    end

    timer.Create(e_key, List[name].Length, 1, function()
        End()
    end)
end

function End()
    List[Current].Cleaner()
    Current = ""

    if EventCount > PerDayLimit then
        EventCount = 0
    end
end

function Message()
end

local day_length = 86400 -- 24 hours
timer.Create("animelife.eventsystem.auto_generate", math.ceil(day_length / PerDayLimit), 0, function()
    -- No events registered
    if #List < 0 then return end

    Start()
end)

concommand.Add("al_event_begin", function(ply, cmd, args)
    if !ply:IsAdmin() then return end

    Start(args[1])
end)

concommand.Add("al_event_end", function(ply, cmd, args)
    if !ply:IsAdmin() then return end

    End()
end)

_G.event = eventsystem
_G.eventssystem = eventsystem
_G.events = eventsystem