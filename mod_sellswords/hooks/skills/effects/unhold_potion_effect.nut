//"Hyperactive Cell Growth";
//"This character\'s body has mutated to grow at an unnatural pace. In battle, this causes their wounds to close and heal within moments. Outside of battle, it causes unseemly growths, an unquenchable thirst, and disgustingly long finger nails. You once saw them lacerate both arms with a meat cleaver, screeching maniacally that it was \'the only way to keep it in check\'. Odd.";
::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/unhold_potion_effect", function ( q ) {

	q.getTooltip = @(__original) function()
	{
		local actor = this.getContainer().getActor();

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (actor.getFlags().has("unhold_r") || actor.getFlags().has("ghoul_s"))
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.unhold_potion_effect.Tooltip1
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.unhold_potion_effect.Tooltip2
			});
		}

		if (actor.getFlags().has("unhold_r"))
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = ::Mod_Sellswords.Strings.unhold_potion_effect.Tooltip3
			});
		}
		
		ret.push({
			id = 13,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = ::Mod_Sellswords.Strings.unhold_potion_effect.Tooltip4
		});
		return ret;
	}

	q.onCombatFinished = @(__original) function()
	{
		local actor = this.getContainer().getActor().get();

		if (actor != null && actor.isAlive())
		{
			actor.setHitpoints(actor.getHitpointsMax());
			
			if (actor.getFlags().has("unhold_r"))
			{	
				local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
				local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

				if (head != null) 
					head.setArmor(head.getArmorMax());

				if (body != null) 
					body.setArmor(body.getArmorMax());
			}
			actor.setDirty(true);
		}
	}

	q.onTurnStart = @(__original) function()
	{
		local actor = this.getContainer().getActor().get();

		if (actor.getSkills().getSkillByID("effects.spider_poison") != null) 
			return;

		if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) 
			return;

		if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) 
			return;
		
		local regen_value = (actor.getFlags().has("unhold_r") || actor.getFlags().has("ghoul_s")) ? 10 : 5;
		local health_added = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), regen_value);
		
		if (health_added > 0)
		{
			actor.setHitpoints(actor.getHitpoints() + health_added);
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer())
			{
				this.spawnIcon("status_effect_79", actor.getTile());

				if (this.m.SoundOnUse.len() != 0)
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

				this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.unhold_potion_effect.Log1, this.Const.UI.getColorizedEntityName(actor), health_added));
			}
		}

		if (actor.getFlags().has("unhold_r"))
		{
			local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			
            local head_added = head != null ? this.Math.min(head.getArmorMax() - head.getArmor(), 20) : 0;
			local body_added = body != null ? this.Math.min(body.getArmorMax() - body.getArmor(), 20) : 0;

			if (head_added > 0 || body_added > 0)
			{
				if (head != null)
					head.setArmor(head.getArmor() + head_added);

				if (body != null)
					body.setArmor(body.getArmor() + body_added);
				
				actor.setDirty(true);

				if (!actor.isHiddenToPlayer())
				{
					this.spawnIcon("status_effect_79", actor.getTile());

					if (this.m.SoundOnUse.len() != 0)
						this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

					if (head_added > 0)
						this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.unhold_potion_effect.Log2, this.Const.UI.getColorizedEntityName(actor), head_added));

					if (body_added > 0)
						this.Tactical.EventLog.log(::Mod_Sellswords.text(::Mod_Sellswords.Strings.unhold_potion_effect.Log3, this.Const.UI.getColorizedEntityName(actor), body_added));
				}
			}
		}
	}

});