this.crdagger_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Damage = 5,
		Count = 1
	},
	
	function getDamage()
	{
		return this.m.Damage;
	}	
	
	function create()
	{
		this.m.ID = "effects.crdagger";
		this.m.Name = "Malicious Wound";
		//this.m.KilledString = "Bled to death";
		this.m.Icon = "skills/status_effect_01.png";
		this.m.IconMini = "status_effect_01_mini";
		this.m.Overlay = "status_effect_01";
		//this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;
		this.m.Type = this.Const.SkillType.StatusEffect;		
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		if (this.m.Count <= 1)
		{
			return this.m.Name;
		}
		else
		{
			return this.m.Name + " (x" + this.m.Count + ")";
		}
	}
		
	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = "This character is bleeding profusely from recently dirty tricks or severe piercing wounds."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The threshold to receive injury is lowerd by [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Count * 7 + "%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 7 + "%[/color] Resolve"
			},
			//{
			//	id = 12,
			//	type = "text",
			//	icon = "ui/icons/health.png",
			//	text = "Will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Count * 5 + "[/color] hitpoints start of next turn"
			//}			
		];
	}	
	
	//function applyDamage()
	//{
	//	local actor = this.getContainer().getActor();
	//	this.spawnIcon("status_effect_01", actor.getTile());
	//	local hitInfo = clone this.Const.Tactical.HitInfo;
	//	hitInfo.DamageRegular = this.m.Damage * this.m.Count * (actor.getSkills().hasSkill("effects.hyena_potion") ? 0.5 : 1.0);
	//	hitInfo.DamageDirect = 1.0;
	//	hitInfo.BodyPart = this.Const.BodyPart.Body;
	//	hitInfo.BodyDamageMult = 1.0;
	//	hitInfo.FatalityChanceMult = 0.0;
	//	actor.onDamageReceived(actor, this, hitInfo);
	//
	//	this.removeSelf();
	//}
	
	function onRefresh()
	{
		local actor = this.getContainer().getActor();		
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;	
		//this.logInfo("valid: " + crrd);
		if ((this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50) || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " had his bleeding wound quickly close thanks to his unnatural physiology");
			}

			return;
		}

		this.m.Count = this.Math.min(12, this.m.Count + 1);
		this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
	}	

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= this.Math.maxf(0.05, 1 - 0.07 * this.m.Count);
		_properties.BraveryMult *= this.Math.maxf(0.05, 1 - 0.07 * this.m.Count);		
	}

	//function onTurnStart()
	//{
	//	this.applyDamage();		
	//}
	
	//function onTurnEnd()
	//{
	//	this.applyDamage();		
	//}

	//function onWaitTurn()
	//{
	//	this.applyDamage();		
	//}

});

