::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/militia_veteran", function(q) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.removeByID("perk.ptr_survival_instinct");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crAnchor"));
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;
			this.m.BaseProperties.RangedDefense += 0.5 * dca;
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;
		}
	}
	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/hooked_blade",
				"weapons/pike",
				"weapons/woodcutters_axe",
				"weapons/bludgeon",
				"weapons/hand_axe",
				"weapons/militia_spear",
				"weapons/boar_spear",
				"weapons/falchion",
				"weapons/shortsword"
				"weapons/legend_militia_glaive",
				"weapons/legend_glaive",
				"weapons/legend_infantry_axe",
				"weapons/legend_two_handed_club",
				"weapons/two_handed_mace",
				"weapons/spontoon01",						
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/goedendag"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/warfork"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "gambeson"],
			[1, "padded_leather"],
			[1, "padded_surcoat"],
			[1, "leather_lamellar"],
			[1, "thick_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "full_leather_cap"]
			]))
		}
	}
});	