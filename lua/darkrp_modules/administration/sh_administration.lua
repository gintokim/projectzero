module("administration", package.seeall)

Actions = {
    ["freeze"] = {
        Name = "заморозить",
        Function = function(admin, ply)
            Freeze(admin, ply)
        end,
    },
    ["nodraw"] = {
        Name = "остановить отрисовку",
        Function = function(admin, ply)
        end,
    },
    ["ban"] = {
        Name = "в бан",
        Function = function(admin, ply)
        end,
    },
    ["jail"] = {
        Name = "джайл",
        Function = function(admin, ply)
        end,
    },
    ["godmode"] = {
        Name = "годмод",
        Function = function(admin, ply)
            God(admin, ply)
        end,
    },
    ["return"] = {
        Name = "вернуть назад",
        Function = function(admin, ply)
            Return(admin, ply)
        end,
    },
    ["teleport"] = {
        Name = "телепортироваться",
        Function = function(admin, ply)
            GotoPlayer(admin, admin, ply)
        end,
    },
    ["teleportto"] = {
        Name = "телепортировать к",
        Function = function(admin, ply, ply2)
            GotoPlayer(admin, ply, ply2)
        end,
    },
}

Usergroups = {}

function AddNew(name, immunity, allowed_functions)
    local idx = table.insert(Usergroups, {
        Name = name,
        Immunity = immunity,
        Allowed = allowed_functions
    })

    return idx
end

-- NOTE: Do not remove, rename or edit player usergroup.
AddNew("player", 1)
AddNew("admin", 30, {
    ["admin"] = true, -- is admin usergroup
})
AddNew("curator", 70, {
    ["admin"] = true, -- is admin usergroup
    ["menu_manager"] = true, -- can click admins in admin menu
    ["warns"] = true, -- can give warns
})
AddNew("root", 100)