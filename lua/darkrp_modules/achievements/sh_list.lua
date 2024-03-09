local garb_col = Material("animelife/scoreboard/achievements/garbage_collector.png")
local trees = Material("animelife/scoreboard/achievements/0.png")
local builder = Material("animelife/scoreboard/achievements/builder.png")
local customizer = Material("animelife/scoreboard/achievements/customizer.png")
local ddr = Material("animelife/scoreboard/achievements/ddr.png")
local illusioner = Material("animelife/scoreboard/achievements/illusioner.png")
local stabbed = Material("animelife/scoreboard/achievements/stabbed.png")
local snd_name = Material("animelife/scoreboard/achievements/second_name.png")
local stolen = Material("animelife/scoreboard/achievements/stolen.png")
local yandere = Material("animelife/scoreboard/achievements/yandere.png")
local no_regrets = Material("animelife/scoreboard/achievements/no_regrets.png")
local titan = Material("animelife/scoreboard/achievements/titan.png")
local spell_teller = Material("animelife/scoreboard/achievements/spell_teller.png")

timer.Simple(0.0, function()
    achievements:New("Мусорный король", "Работа вне производства", garb_col, 500, function()

    end)
    achievements:New("Среди деревьев", "Полезно быть на улице", trees, 4, function()

    end)
    achievements:New("Строитель", "Точность и усидчивость", builder, 1, function()
        
    end)
    achievements:New("Исчезли", "А какое оправдание?", stolen, 50, function()
        
    end)
    achievements:New("Самостоятельный", "Сделаю лучше", customizer, 1, function()
        
    end)
    achievements:New("Dance Dance Revolution", "Наблюдайте за моими движениями", ddr, 1, function()
        
    end)
    achievements:New("Иллюзионист", "Предан работе", illusioner, 25, function()
        
    end)
    achievements:New("Исполнено", "Профессионал своего дела", no_regrets, 25, function()
        
    end)
    achievements:New("Милый", "Связь установлена", yandere, 1, function()
        
    end)
    achievements:New("Второе имя", "На 100% круче предыдущего", snd_name, 1, function()
        
    end)
    achievements:New("Удар в спину", "Так не делают...", stabbed, 1, function()
        
    end)
    achievements:New("Титан", "Какой большой...", titan, 1, function()
        
    end)
    achievements:New("Заклинатель", "Слова = сила", spell_teller, 15, function()
        
    end)
end)