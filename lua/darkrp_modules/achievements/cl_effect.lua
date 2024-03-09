local EFFECT = {}

EFFECT.Mat = Material("effects/bubble")

function EFFECT:Init(data)
	local pos = data:GetOrigin()

	local emitter = ParticleEmitter(pos)

	local iMax = data:GetScale() or 4
	for i = 1, iMax do
		local particle = emitter:Add("effects/bubble", pos)
		particle:SetVelocity((Vector(0, 0, 1) + (VectorRand() * 1)) * math.random(15, 45))
		particle:SetDieTime(math.random(0.5, 1.5))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(4)
		particle:SetEndSize(0.1)
		particle:SetRoll(0)
		particle:SetRollDelta(0)
		particle:SetColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end

effects.Register(EFFECT, "achievement_effect")