module("itemdrop", package.seeall)

function itemdrop:CanDrop(pos)
    if SERVER then
        if !util.IsInWorld(pos) then
            return false
        end
    end

    return true
end