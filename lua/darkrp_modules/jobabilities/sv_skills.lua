util.AddNetworkString("animelife.skillsystem.menu")
util.AddNetworkString("animelife.skillsystem.run")

hook.Add("PlayerButtonDown", "animelife.skillsystem.menu", function(ply, btn)
    if btn ~= KEY_F then return end
    if !skills.List[ply:Team()] then return end

    net.Start("animelife.skillsystem.menu")
    net.Send(ply)
end)

hook.Add("PlayerSwitchFlashlight", "animelife.skillsystem.flashlight", function(ply, enabled)
	return false
end)

net.Receive("animelife.skillsystem.run", function(len, ply)
    if !IsValid(ply) or !ply:IsPlayer() then return end
    
    local k = net.ReadInt(8)
    local skill_list = skills.List[ply:Team()]
    if istable(skill_list[k]) then
        local ident = "animelife.skillsystem.next_use-" .. ply:Team() .. "-" .. k
        local use_time = ply:GetNWFloat(ident, 0)
        if use_time < SysTime() then
            skill_list[k].OnPressed(ply)

            ply:SetNWFloat(ident, SysTime() + skill_list[k].Cooldown)
        else
            ply:ChatPrint("Подождите еще, прежде чем использовать этот скилл.")
        end
    end
end)