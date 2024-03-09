--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
https://darkrp.miraheze.org/wiki/DarkRP:CustomJobFields

Add your custom jobs under the following line:
---------------------------------------------------------------------------]]

TEAM_CITIZEN = DarkRP.createJob("Гайдзин", {
    color = Color(255, 255, 255, 255),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "citizen",
    max = 0,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Мирные",
})

TEAM_NEKO = DarkRP.createJob("Неко", {
    color = Color(255, 206, 249),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "neko",
    max = 3,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Мирные",
})

TEAM_MUSILY = DarkRP.createJob("Меломан", {
    color = Color(223, 168, 255),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "musily",
    max = 2,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Мирные",
})

TEAM_IMPERATOR = DarkRP.createJob("Император", {
    color = Color(255, 199, 199),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Mayor of the city creates laws to govern the city.
    If you are the mayor you may create and accept warrants.
    Type /wanted <name>  to warrant a player.
    Type /jailpos to set the Jail Position.
    Type /lockdown initiate a lockdown of the city.
    Everyone must be inside during a lockdown.
    The cops patrol the area.
    /unlockdown to end a lockdown]],
    weapons = {},
    command = "mayor",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 1.89,
    admin = 0,
    vote = true,
    hasLicense = false,
    mayor = true,
    category = "Правительство",
})

TEAM_HOBO = DarkRP.createJob("Бомжара", {
    color = Color(255, 223, 182),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The lowest member of society. Everybody laughs at you.
        You have no home.
        Beg for your food and money
        Sing for everyone who passes to get money
        Make your own wooden home somewhere in a corner or outside someone else's door]],
    weapons = {"weapon_bugbait"},
    command = "hobo",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    hobo = true,
    category = "Мирные",
})

TEAM_HOBOKING = DarkRP.createJob("Король бомжей", {
    color = Color(255, 204, 138),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The lowest member of society. Everybody laughs at you.
        You have no home.
        Beg for your food and money
        Sing for everyone who passes to get money
        Make your own wooden home somewhere in a corner or outside someone else's door]],
    weapons = {"weapon_bugbait"},
    command = "hoboking",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    hobo = true,
    category = "Мирные",
    secret = true,
    canSee = function(ply)
        return achievements:GetStatus(ply, 1)
    end
})

TEAM_MEDIC = DarkRP.createJob("Медик", {
    color = Color(198, 255, 255),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[With your medical knowledge you work to restore players to full health.
        Without a medic, people cannot be healed.
        Left click with the Medical Kit to heal other players.
        Right click with the Medical Kit to heal yourself.]],
    weapons = {"med_kit"},
    command = "medic",
    max = 2,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    medic = true,
    category = "Мирные",
})

TEAM_POLICE = DarkRP.createJob("Полицейский", {
    color = Color(206, 206, 255),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The protector of every citizen that lives in the city.
        You have the power to arrest criminals and protect innocents.
        Hit a player with your arrest baton to put them in jail.
        Bash a player with a stunstick and they may learn to obey the law.
        The Battering Ram can break down the door of a criminal, with a warrant for their arrest.
        The Battering Ram can also unfreeze frozen props (if enabled).
        Type /wanted <name> to alert the public to the presence of a criminal.]],
    weapons = {"arrest_stick", "unarrest_stick", "weapon_glock2", "stunstick", "door_ram", "weaponchecker"},
    command = "cp",
    max = 5,
    salary = GAMEMODE.Config.normalsalary * 1.45,
    admin = 0,
    vote = true,
    hasLicense = true,
    ammo = {
        ["pistol"] = 60,
    },
    category = "Правительство",
})

TEAM_CHIEF = DarkRP.createJob("Капитан полиции", {
    color = Color(194, 194, 255),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The Chief is the leader of the Civil Protection unit.
        Coordinate the police force to enforce law in the city.
        Hit a player with arrest baton to put them in jail.
        Bash a player with a stunstick and they may learn to obey the law.
        The Battering Ram can break down the door of a criminal, with a warrant for his/her arrest.
        Type /wanted <name> to alert the public to the presence of a criminal.
        Type /jailpos to set the Jail Position]],
    weapons = {"arrest_stick", "unarrest_stick", "weapon_deagle2", "stunstick", "door_ram", "weaponchecker"},
    command = "chief",
    max = 1,
    salary = GAMEMODE.Config.normalsalary * 1.67,
    admin = 0,
    vote = false,
    hasLicense = true,
    chief = true,
    NeedToChangeFrom = TEAM_POLICE,
    ammo = {
        ["pistol"] = 60,
    },
    category = "Правительство",
})

TEAM_GANG = DarkRP.createJob("Бандит", {
    color = Color(185, 185, 185),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The lowest person of crime.
        A gangster generally works for the Mobboss who runs the crime family.
        The Mob boss sets your agenda and you follow it or you might be punished.]],
    weapons = {},
    command = "gangster",
    max = 2,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Криминал",
})

TEAM_HUNTER = DarkRP.createJob("Хантер", {
    color = Color(0, 0, 0),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The lowest person of crime.
        A gangster generally works for the Mobboss who runs the crime family.
        The Mob boss sets your agenda and you follow it or you might be punished.]],
    weapons = {},
    command = "hunter",
    max = 1,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Монстры",
    hp = "???",
    speed = "???",
    armor = "???",
    isWIP = true
})

TEAM_ADMIN = DarkRP.createJob("Смотрящий", {
    color = Color(193, 255, 213),
    model = "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    description = [[The lowest person of crime.
        A gangster generally works for the Mobboss who runs the crime family.
        The Mob boss sets your agenda and you follow it or you might be punished.]],
    weapons = {},
    command = "admin",
    max = 0,
    salary = 0,
    admin = 1,
    vote = false,
    hasLicense = false,
    category = "Мирные",
})

TEAM_INUMAKI = DarkRP.createJob("Инумаки", {
    color = Color(149, 147, 255),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "inumaki",
    max = 1,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Сверхъестественное",
})

TEAM_WOLFRAM = DarkRP.createJob("Вольфрам", {
    color = Color(237, 236, 255),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "wolfram",
    max = 1,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Роботы",
    PlayerSpawn = function(ply)
        ply:SetJumpPower(200 * 1.5)
    end
})

TEAM_MIMIC = DarkRP.createJob("Мимик", {
    color = Color(255, 236, 236),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "mimic",
    max = 1,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Роботы",
    PlayerSpawn = function(ply)
        ply:SetRunSpeed(240 * 1.5)
    end
})

TEAM_HACKER = DarkRP.createJob("Хакер", {
    color = Color(149, 174, 255),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {"animelife_pickpocket"},
    command = "hacker",
    max = 2,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Криминал",
})

TEAM_KILLER = DarkRP.createJob("Киллер", {
    color = Color(136, 54, 54),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "killer",
    max = 2,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Криминал",
})

TEAM_MANIAC = DarkRP.createJob("Маньяк", {
    color = Color(255, 60, 60),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "maniac",
    max = 1,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Криминал",
})

TEAM_YANDERE = DarkRP.createJob("Яндере", {
    color = Color(255, 125, 190),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "yandere",
    max = 1,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Мирные",
})

TEAM_YAKUZA = DarkRP.createJob("Якудза", {
    color = Color(255, 125, 125),
    model = {
        "models/player/dewobedil/azur_lane/laffey/default_p.mdl",
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "yakuza",
    max = 7,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Криминал",
    hp = "-",
    armor = "-",
    speed = "-",
    PlayerSpawn = function(ply)
        if ply:GetNWInt("animelife.classchooser.class", -1) == -1 then
            ply:SendLua("ShowClassChooser()")

            timer.Simple(60, function()
                if !IsValid(ply) then return end
                if ply:Team() ~= TEAM_YAKUZA then return end

                -- still haven't chosen
                if ply:GetNWInt("animelife.classchooser.class", -1) == -1 then
                    ply:changeTeam(GAMEMODE.DefaultTeam, true)
                end
            end)
        end
    end,
})

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
    [TEAM_POLICE] = true,
    [TEAM_CHIEF] = true,
    [TEAM_MAYOR] = false,
    [TEAM_IMPERATOR] = true,
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
DarkRP.addHitmanTeam(TEAM_KILLER)
