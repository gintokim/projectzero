module("inventory", package.seeall)

DEBUG = true -- should be false on release
MAX_SLOTS_MAIN = 30
MAX_SLOTS_MAIN_DONATED = 45 -- for those who donated
ITEMS = {}

function inventory:InitOnPlayer(ply)
    if istable(ply.Inventory) then
        return 
    end

    ply.Inventory = {
        ["Main Section"] = {},
        ["Accessories Section"] = {}
    }

    local donated = false
    local max_slots = donated and MAX_SLOTS_MAIN_DONATED or MAX_SLOTS_MAIN
    for i = 1, max_slots do
        ply.Inventory["Main Section"][i] = {} -- fill with empty slots
    end

    -- NOTE: Accessories are unlimited, so store things in table ontop of each other
end

function inventory:AddItem(ply, slot, item)
    if !istable(ply.Inventory) then
        self:InitOnPlayer(ply)
    end

    local item_cat = ITEMS[item].Section
    local item_data = ITEMS[item]
    ply.Inventory[item_cat][slot] = {
        Class = item,
        Name = item_data.Name or "Unknown Item",
        Tier = item_data.Tier or 0,
        Model = item_data.Model or "models/error.mdl",
        Droppable = item_data.Droppable,
        IsAccessories = item_data.Accessories,
    }

    -- add more info to it
    if item_data.Accessories then
        ply.Inventory[item_cat][slot] = {
            AccessoriesCategory = item_data.AccessoriesCategory,
        }
    end

    if DEBUG then
        print("insert new item (" .. item .. ") for player", ply, "into slot", slot)
    end
end

function inventory:RemoveItem(ply, section, slot)
    if !istable(ply.Inventory) then
        self:InitOnPlayer(ply)
    end

    ply.Inventory[section][slot] = {}

    if DEBUG then
        print("deleting item for player", ply, "from slot", slot, "in section of", section)
    end
end

function inventory:SlotBusy(ply, section, slot)
    if !istable(ply.Inventory) then
        return true
    end

    return ply.Inventory[section][slot] ~= {}
end

-- TODO: Seek for items in items folder
-- for _, item in pairs(file.Find()) do
    
-- end