module("location", package.seeall)

Locations = {}

-- Returns location name
function GetName(loc)
    local fallback = "Unknown Location"

    if Locations[game.GetMap()][loc] then
        return (Locations[game.GetMap()][loc].Name or fallback)
    end

    return fallback
end

-- Returns location index based on given position
function Get(pos)
    for i = 1, #Locations do
        if pos:WithinAABox(Locations[game.GetMap()][i].Min, Locations[game.GetMap()][i].Max) then
            return i
        end
    end

    return -1
end

-- [Locations]
Locations["rp_oasa"] = {
    [1] = {
        Min = Vector(),
        Max = Vector(),
        Name = "Any"
    },
}
-- [#Locations]