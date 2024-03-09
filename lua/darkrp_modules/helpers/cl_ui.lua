module("ui", package.seeall)

BASE_RESOLUTION_WIDTH = 1920
BASE_RESOLUTION_HEIGHT = 1080

function Smooth(bool, resolution_based)
    xpcall(function()
        local run = resolution_based and (ScrW() ~= BASE_RESOLUTION_WIDTH or ScrH() ~= BASE_RESOLUTION_HEIGHT) or true
        if bool then
            if run then
                render.PushFilterMin(TEXFILTER.ANISOTROPIC)
                render.PushFilterMag(TEXFILTER.ANISOTROPIC)
            end
        else
            if run then
                render.PopFilterMin()
                render.PopFilterMag()
            end
        end
    end, function(thrown_err)
        print('{AnimeLife UI} Smoothing disabled:', thrown_err)
    end)
end

-- Drawing
function GenerateShadowFont() end -- TODO
function DrawShadowText() end -- TODO

function DrawMaterial(mat, x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.SetMaterial(mat)
    surface.DrawTexturedRect(x, y, w, h)
end

-- Resolution scaling
function x() end -- TODO
function y() end -- TODO