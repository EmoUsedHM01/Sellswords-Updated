::mods_hookExactClass("skills/effects/bleeding_effect", function ( o )
{
	o.m.durability <- 2;
	o.m.ihe <- false;	
	o.onAdded = function ()
	{
		local actor = this.getContainer().getActor();
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= actor.getBaseProperties().RangedDefense : false;

		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50 || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " had his bleeding wound quickly close thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, this.m.durability + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

			if (this.getContainer().hasSkill("trait.bleeder"))
			{
				++this.m.TurnsLeft;
			}
		}
	};
	o.onUpdate = function ( _properties )
	{
		if (this.m.durability == 5)
		{
			this.m.Name = "Bleeding from grazes";
			this.m.Icon = "skills/graze_circle.png";
			this.m.IconMini = "mini_graze_circle";
			this.m.Overlay = "graze";
		}
	};		
	o.applyDamage = function ()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage * (actor.getSkills().hasSkill("effects.hyena_potion") ? 0.5 : 1.0) * (actor.getSkills().hasSkill("perk.crresilient") ? 0.75 : 1.0);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(actor, this, hitInfo);
			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}		
	o.getDescription = function ()
	{
		if (this.m.durability == 1 && this.m.ihe)
		{
			return "This character is suffering from profuse internal bleeding from a recently received hit and will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
		}		
		else if (this.m.durability == 1)
		{
			return "This character is bleeding profusely from a recently received wound and will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
		}
		else if (this.m.durability == 5)
		{
			return "This character is bleeding slowly from multiple recent deep grazes [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
		}
		else
		{
			return "This character is bleeding profusely from a recently received wound and will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
		}
	};
});