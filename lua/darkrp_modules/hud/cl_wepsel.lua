local function create_weapon_table(tbl)
    if !tbl then
        return
    end

    local weapon_list_client = {}

    for _, val in pairs(tbl) do
        local slot = val:GetSlot()
        if !weapon_list_client[slot] then
            weapon_list_client[slot] = {}
        end

        local name = val:GetPrintName()
        table.insert(weapon_list_client[slot], {Name = name, Class = val:GetClass()})
    end

    return weapon_list_client
end

surface.CreateFont("animelife.hud.weapon_selection", {font = "Exo 2 SemiBold", weight = 600, size = 18, italic = true, extended = true})
surface.CreateFont("animelife.hud.weapon_selection.slot", {font = "Exo 2 SemiBold", weight = 600, size = 32, italic = true, extended = true})

local cur_weapon = LocalPlayer().GetActiveWeapon and LocalPlayer():GetActiveWeapon():GetClass() or ""
local cur_slot = 0
local cur_pos = 1
local switcher_alpha = 0
hook.Add("HUDPaint", "animelife.weaponswitch.renderhud", function()
    if !IsValid(LocalPlayer()) then return end
    if switcher_alpha <= 0 then
        return
    end

    surface.SetDrawColor(255, 255, 255, switcher_alpha)

    local sorted_weapon_tbl = create_weapon_table(LocalPlayer():GetWeapons())
    local x, y = (ScrW() - 186 * table.Count(sorted_weapon_tbl or {})) / 2, 45
    local iter = 1
    for key, weap in SortedPairs(sorted_weapon_tbl or {}, false) do
        draw.RoundedBox(8, x, 30, 162, 32, Color(255, 75, 75, switcher_alpha))
        for _, weapon in pairs(weap or {}) do
            if iter > 1 then
                draw.RoundedBox(8, x + 2, y, 162, 32, Color(0, 0, 0, switcher_alpha / 1.7))
            end

            local name = language.GetPhrase(weapon.Name)

            render.SetScissorRect(x, y - 16, x + 162, y + 41, true)
                draw.SimpleText(string.upper(name) or "Scripted Weapon", "animelife.hud.weapon_selection", x + (162 / 2), y + (iter == 1 and 0 or 32 / 2), Color(255, 255, 255, switcher_alpha), 1, 1)
            render.SetScissorRect(0, 0, 0, 0, false)

            if cur_weapon == weapon.Class then
                draw.RoundedBox(8, x + (iter == 1 and 0 or 2), iter == 1 and y - 15 or y, 162, 32, Color(255, 255, 255, switcher_alpha / 10))
            end

            y = y + 32 + 6
            iter = iter + 1
        end

        x = x + 186
        y = 45
        iter = 1
    end

    switcher_alpha = math.Approach(switcher_alpha, 0, FrameTime() * 25)

    pcall(function()
        cur_weapon = sorted_weapon_tbl[cur_slot][cur_pos].Class
    end)
end)

hook.Add("PlayerBindPress", "animelife.weaponswitch.handleswitch", function(ply, bind, pressed)
    local tbl = create_weapon_table(LocalPlayer():GetWeapons())
    if !pressed or (ply:InVehicle() and !ply:GetAllowWeaponsInVehicle()) then
        return
    end

    local active_weapon = LocalPlayer().GetActiveWeapon and LocalPlayer():GetActiveWeapon() or nil
    if IsValid(active_weapon) then
        active_weapon = {true, active_weapon}
    end

    if bind:sub(1, 4) == "slot" then
        local n = tonumber(bind:sub(5, 5) or 1) or 1
        if n < 1 or n > 6 then return true end
        n = n - 1
        if !tbl[n] then return true end

        if cur_slot == n and tbl[cur_slot] then
            cur_pos = cur_pos + 1
            if cur_pos > #tbl[cur_slot] then
				cur_pos = 1
			end
        else
            cur_slot = n
            cur_pos = 1
        end

        switcher_alpha = 300

        surface.PlaySound("click.wav")

        return true
    elseif bind == "invnext" and istable(active_weapon) and active_weapon[1] and !(active_weapon[2]:GetClass() == "weapon_physgun" and ply:KeyDown(IN_ATTACK)) then
        cur_pos = cur_pos + 1

        if cur_pos > (tbl[cur_slot] and #tbl[cur_slot] or -1) then
            repeat
				cur_slot = cur_slot + 1
				if cur_slot > 5 then
					cur_slot = 0
				end
			until tbl[cur_slot]

			cur_pos = 1
		end

        switcher_alpha = 300

        surface.PlaySound("click.wav")

        return true
    elseif bind == "invprev" and istable(active_weapon) and active_weapon[1] and !(active_weapon[2]:GetClass() == "weapon_physgun" and ply:KeyDown(IN_ATTACK)) then
        cur_pos = cur_pos - 1

		if cur_pos < 1 then
			repeat
				cur_slot = cur_slot - 1
				if cur_slot < 0 then
					cur_slot = 5
				end
			until tbl[cur_slot]

			cur_pos = #tbl[cur_slot]
		end

        switcher_alpha = 300

        surface.PlaySound("click.wav")

        return true
    elseif bind == "+attack" and switcher_alpha > 0 then
        if tbl[cur_slot] and tbl[cur_slot][cur_pos] and tbl[cur_slot][cur_pos].Class then
            input.SelectWeapon(LocalPlayer():GetWeapon(tbl[cur_slot][cur_pos].Class))
        end

        switcher_alpha = 0

        surface.PlaySound("click.wav")

        return true
    end
end)