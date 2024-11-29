::Mod_Sellswords.HooksMod.hook("scripts/items/accessory/legend_accessory_dog", function ( q ) {

	q.onActorDied = @(__original) function( _onTile )
	{
		if (!this.isUnleashed())
		{
			if (!_onTile.IsEmpty)
			{
				for( local i = 0; i < 6; i = i )
				{
					if (!_onTile.hasNextTile(i))
					{
					}
					else
					{
						local t = _onTile.getNextTile(i);

						if (t.IsEmpty)
						{
							_onTile = t;
							break;
						}
					}

					i = ++i;
				}

				if (!_onTile.IsEmpty)
				{
					return;
				}
			}

			local entity = this.Tactical.spawnEntity(this.getScript(), _onTile.Coords.X, _onTile.Coords.Y);
			entity.setItem(this);
			entity.setName(this.getName());
			entity.setVariant(this.getVariant());
			local houndeffect = this.new("scripts/skills/effects/cr_houndmaster_effect");
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogwhisperer"))
			{
				entity.getSkills().add(this.new("scripts/skills/perks/perk_fortified_mind"));
				entity.getSkills().add(this.new("scripts/skills/perks/perk_colossus"));
				entity.getSkills().add(this.new("scripts/skills/perks/perk_underdog"));
				entity.getSkills().add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));				
			}
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogbreeder"))
			{
				entity.getSkills().add(this.new("scripts/skills/perks/perk_fast_adaption"));			
				entity.getSkills().add(this.new("scripts/skills/perks/perk_crBackswing"));
				houndeffect.m.dogbreeder = true;
			}
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_doghandling"))
			{
				entity.getSkills().add(this.new("scripts/skills/perks/perk_overwhelm"));
				houndeffect.m.doghandling = true;				
			}			
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_packleader"))
			{
				entity.getSkills().add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
				houndeffect.m.packleader = true;				
			}
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_dogmaster"))
			{
				entity.getSkills().add(this.new("scripts/skills/perks/perk_dodge"));			
			}				
			entity.getSkills().add(houndeffect);			
			this.setEntity(entity);
			entity.setFaction(this.Const.Faction.PlayerAnimals);
			if (this.m.ArmorScript != null)
			{
				local item = this.new(this.m.ArmorScript);
				entity.getItems().equip(item);
			}
			this.Sound.play(this.m.UnleashSounds[this.Math.rand(0, this.m.UnleashSounds.len() - 1)], this.Const.Sound.Volume.Skill, _onTile.Pos);
		}
	}
});
