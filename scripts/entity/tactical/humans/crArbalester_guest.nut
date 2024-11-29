this.crArbalester_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crArbalester_guest;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Arbalester.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Arbalester);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_ballistics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_know_their_weakness"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_ranks"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_entrenched"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_power_shot"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_muscle_memory"));
		}

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

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;

		banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();

		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		local weapons = [
			"weapons/crossbow",
			"weapons/heavy_crossbow"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		local r = this.Math.rand(1, 10);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			default:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				break;
		}

		local weapons = [
			"weapons/dagger",
			"weapons/knife"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	

		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "padded_surcoat"],
				[1, "gambeson"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "mail_coif"],
				[1, "aketon_cap"],
				[1, "open_leather_cap"],
				[1, "headscarf"],
				[1, ""]
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_early"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_low"]
			]));
		}
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_mid"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_early"]
			]));
		}
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_late"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "crbillman_helmet_mid_chain"],
				[2, "crbillman_helmet_mid"]
			]));
		}
	}

});