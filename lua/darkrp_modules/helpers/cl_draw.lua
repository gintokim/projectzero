local TWOPI = math.pi * 2
local HALFPI = math.pi * 0.5
local PI32 = math.pi + ( math.pi / 2 )

local function extend( t1, t2 )
    for _, v in ipairs( t2 ) do
        t1[ #t1 + 1 ] = v
    end
end

local function arc_coords( x, y, radius, start, stop, step )
    step = step or ( TWOPI * 0.01 )
    if ( start > stop ) then
        step = -step
    end

    local coords = {}
    for angle = start, stop, step do
        coords[ #coords + 1 ] = { x = x + math.cos( angle ) * radius, y = y + math.sin( angle ) * radius }
    end

    return coords
end

function drawRoundedRectangle( x, y, w, h, radius, color, bgcolor, linewidth, aa, step )
    radius = radius or 0
    linewidth = linewidth or 1
    local hlw = linewidth * 0.5
    local x1 = x + radius + hlw
    local y1 = y + radius + hlw
    local x2 = x + w - radius - hlw
    local y2 = y + h - radius - hlw

    if ( radius > 0 ) then
        coords = arc_coords( x1, y1, radius, math.pi, PI32, step )
        extend( coords, arc_coords( x2, y1, radius, PI32, TWOPI, step ) )
        extend( coords, arc_coords( x2, y2, radius, 0, HALFPI, step ) )
        extend( coords, arc_coords( x1, y2, radius, HALFPI, math.pi, step ) )
    else
        coords = { x1, hlw, x2, hlw, w - hlw, y2, x1, h - hlw }
    end

    surface.SetDrawColor( color )
    surface.DrawPoly( coords )
end