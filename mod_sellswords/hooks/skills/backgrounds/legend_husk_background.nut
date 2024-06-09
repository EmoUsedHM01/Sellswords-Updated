::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_husk_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.DailyCost = 24;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/campfire.png",
			text = "Davkul sees this one as spent goods without any value and will never ask you to sacrifice them."
		});
		return ret;
	}

	q.onChangeAttributes = @(__original) function()
	{
		return {
			Hitpoints = [
				5,
				9
			],
			Bravery = [
				-5,
				-8
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				-10,
				5
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				3,
				3
			],
			Initiative = [
				5,
				5
			]
		};
	}

	q.onAddEquipment = @(__original) function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/legend_bone_carver"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}
		else if (r == 4)
		{
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
			items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"decayed_reinforced_mail_hauberk"
			],
			[
				1,
				"decayed_coat_of_plates"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cultist_hood"
			],
			[
				1,
				"hood"
			],
			[
				1,
				"cultist_leather_hood"
			]
		]));
	}
});
