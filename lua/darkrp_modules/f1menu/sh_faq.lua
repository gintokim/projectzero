GLOBALS_FAQ = {}

-- t: Team
local function FAQ_DESCRIPTION_ADD(t, desc)
    GLOBALS_FAQ[t] = desc
end

for i = 1, 25 do
    FAQ_DESCRIPTION_ADD(i, "Description Test")
end