this.crdistracted_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Count = 1,
		ValidStack = 0
	},
	function create()
	{
		this.m.ID = "effects.crdistracted";
		this.m.Name = "Distracted";
		this.m.Icon = "skills/status_effect_122.png";
		this.m.IconMini = "status_effect_122_mini";
		this.m.Overlay = "status_effect_122";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}
	
	function getDescription()
	{
		return "This character was on the receiving end of a dirty trick. Distracted for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Count + "[/color] stack(s), they are slower to react and have a harder time landing clean strikes.";
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
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.ValidStack + "%[/color] Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.ValidStack + "%[/color] Initiative"
			}
		];
	}

	function onRefresh()
	{
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)	
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " regained his focus thanks to his unnatural physiology");
			}

			return;
		}
		
		++this.m.Count;
		this.spawnIcon("status_effect_122", this.getContainer().getActor().getTile());
	}
	
	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned") && !this.getContainer().hasSkill("effects.dazed"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}	

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();	
		this.m.ValidStack = this.Math.min(50, 2.5 * (1 + this.m.Count) * this.m.Count);
		_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.01 * this.m.ValidStack);
		_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.01 * this.m.ValidStack);
		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned") && !this.getContainer().hasSkill("effects.dazed"))
		{
			actor.getSprite("status_stunned").setBrush("bust_distracted");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}		
	}

	function onTurnStart()
	{
		if (--this.m.Count <= 0)
		{
			this.removeSelf();
		}
	}

});

