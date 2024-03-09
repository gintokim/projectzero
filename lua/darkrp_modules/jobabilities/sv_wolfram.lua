-- Double jump
local function GetMoveVector(mv)
	local ang = mv:GetAngles()

	local max_speed = mv:GetMaxSpeed()

	local forward = math.Clamp(mv:GetForwardSpeed(), -max_speed, max_speed)
	local side = math.Clamp(mv:GetSideSpeed(), -max_speed, max_speed)

	local abs_xy_move = math.abs(forward) + math.abs(side)

	if abs_xy_move == 0 then
		return Vector(0, 0, 0)
	end

	local mul = max_speed / abs_xy_move

	local vec = Vector()

	vec:Add(ang:Forward() * forward)
	vec:Add(ang:Right() * side)

	vec:Mul(mul)

	return vec
end

hook.Add("SetupMove", "animelife.jobabilities.wolfram.double_jump", function(ply, mv)
    if ply:Team() ~= TEAM_WOLFRAM then return end

	-- Let the engine handle movement from the ground
	if ply:OnGround() then
		ply.JumpLevel = 0

		return
	end	

	-- Don't do anything if not jumping
	if !mv:KeyPressed(IN_JUMP) then
		return
	end

	ply.JumpLevel = (ply.JumpLevel or 0) + 1

	if (ply.JumpLevel or 0) > 1 then
		return
	end

	local vel = GetMoveVector(mv)

	vel.z = ply:GetJumpPower()

	mv:SetVelocity(vel)

	ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP, -1)
end)

hook.Add("EntityTakeDamage", "animelife.jobabilities.wolfram", function(target, dmg)
    if !IsValid(target) or !target:IsPlayer() then return end
	local attacker = dmg:GetAttacker()

    if target:Team() ~= TEAM_WOLFRAM then 
		if IsValid(attacker) and attacker:IsPlayer() then
			if attacker:Team() == TEAM_WOLFRAM then
				target:SetNWFloat("animelife.jobabilities.wolfram.robot_vision", UnPredictedCurTime() + 10)
			end
		end

		return 
	end

	if IsValid(attacker) and attacker:IsPlayer() then
		attacker:SetNWFloat("animelife.jobabilities.wolfram.robot_vision", UnPredictedCurTime() + 10)
	end

    dmg:ScaleDamage(0.7)
end)

hook.Add("PlayerSpawn", "animelife.jobabilities.wolfram", function(ply)
	ply:SetNWFloat("animelife.jobabilities.wolfram.robot_vision", 0)

	if ply:GetModelScale() == 1 then
		ply:SetViewOffset(Vector(0, 0, 64))
		ply:SetViewOffsetDucked(Vector(0, 0, 28))
	end
end)