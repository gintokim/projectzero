local PICKPOCKET_DURATION = 10
local PICKPOCKET_MINAMT = 5
local PICKPOCKET_MAXAMT = 50

local function looking_at(self)
	local ply = self.Owner
	local tr = util.QuickTrace(ply:GetShootPos(), ply:GetAimVector() * 52, {ply})

	if tr.Hit then
		return tr.Entity, tr.HitPos
	else
		return nil, nil
	end
end

local SWEP = {}

SWEP.PrintName = "Pickpocket"
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60

local last_progress = 0
function SWEP:DrawHUD()
    local pick, progress = self:GetPickin(), self:GetProgress()
    progress = Lerp(FrameTime() * 30, last_progress, progress)

    if pick and progress <= 100 then
		local w = 128
        surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect((ScrW() - w) / 2, ScrH() / 2 - 32, w, 8)

        surface.SetDrawColor(255, 255, 255)
		surface.DrawRect((ScrW() - w) / 2, ScrH() / 2 - 32, w * (progress / 100), 8)
    end

    last_progress = progress
end

SWEP.Spawnable = false
SWEP.AdminOnly = true
SWEP.HoldType = "normal"
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ViewModelFlip = true
SWEP.Victim = nil
SWEP.NextPick = 0

if !SWEP.Primary then SWEP.Primary = {} end
if !SWEP.Secondary then SWEP.Secondary = {} end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Pickin")
	self:NetworkVar("Float", 0, "Progress")
end

function SWEP:PreDrawViewModel()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self:SetPickin(false)
	self:SetProgress(0)
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + .1)

	return true
end

function SWEP:Holster()
	if self:GetPickin() then
		return false
	end

	self:OnRemove()

	return true
end

function SWEP:SecondaryAttack()
end

function SWEP:OnRemove()
end

function SWEP:Think()
	if CLIENT then return end

	if self:GetPickin() then
		local ent, pos = looking_at(self)

		if IsValid(ent) and ent == self.Victim and !self:CanBeSeenBy(ent) then
			self:SetProgress(self:GetProgress() + 0.5 * .75)

			if self:GetProgress() >= 100 then
				self:SucceedPickin()
			end
		else
			self:FailPickin()
		end
	end

	self:NextThink(CurTime() + .1)

	return true
end

function SWEP:CanBeSeenBy(dude)
	local me, them = self.Owner:GetShootPos(), dude:GetShootPos()

	if me:Distance(them) > 20 * 52 then
		return false
	end

	if util.TraceLine({
		start = me,
		endpos = them,
		filter = {self.Owner, dude}
	}).Hit then
		return false
	end

	local true_vec = (me - them):GetNormalized()
	local approach_angle = -math.deg(math.asin(true_vec:DotProduct(dude:GetAimVector())))

	return approach_angle <= 0
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	if self:GetPickin() then
		return
	end

	if self.NextPick > CurTime() then
		self:SetNextPrimaryFire(CurTime() + 1)
		self:SetNextSecondaryFire(CurTime() + 1)

		return
	end

	local ent, pos = looking_at(self)

	if IsValid(ent) and ent:IsPlayer() then
		if (ent.NextCanBePicked or 0) < CurTime() then
			if !self:CanBeSeenBy(ent) then
				self:StartPickin(ent)
				self.NextPick = CurTime() + 1
			end
		else
			self.Owner:ChatPrint("Этот игрок уже недавно был ограблен.")
		end
	end

	self:SetNextPrimaryFire(CurTime() + .35)
	self:SetNextSecondaryFire(CurTime() + .35)
end

function SWEP:StartPickin(victim)
	self:SetPickin(true)
	self.Victim = victim
end

function SWEP:FailPickin()
	self:SetPickin(false)
	self:SetProgress(0)
	self.Victim = nil
end

function SWEP:SucceedPickin()
	local dude = self.Victim

    DarkRP.notify(dude, 0, 5, "У вас стащили деньги.")

	achievements:UpdateProgress(self.Owner, 4, 1)

	dude.NextCanBePicked = CurTime() + 300

	self:TransferCash(self.Victim)
	self:SetPickin(false)
	self:SetProgress(0)
	self.Victim = nil
end

function SWEP:TransferCash(vic)
	local amt = math.random(PICKPOCKET_MINAMT, PICKPOCKET_MAXAMT)
	local exist = vic:getDarkRPVar("money")

	if exist <= 0 then
        DarkRP.notify(self.Owner, 1, 5, "У жертвы нет денег.")

		return
	end

	if amt > exist then
		amt = exist
	end

	vic:addMoney(-amt)
	self.Owner:addMoney(amt)
    DarkRP.notify(self.Owner, 0, 5, "Вы стащили " .. amt .. "¥")
end

function SWEP:Reload()
end

function SWEP:DrawWorldModel()
end

weapons.Register(SWEP, "animelife_pickpocket")