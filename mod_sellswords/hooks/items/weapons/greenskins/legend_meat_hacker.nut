::mods_hookExactClass("items/weapons/greenskins/legend_meat_hacker", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands.";
		this.m.IsDoubleGrippable = true;		
		this.m.IsAoE = false;

		this.m.Value = 1500;
		this.m.ShieldDamage = 32;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.DirectDamageMult = 0.35;
	}

	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		ws_onEquip();

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split_man", function(_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;		
			_skill.m.ActionPointCost = 5;
			_skill.m.orc = true;
			_skill.m.infantry = 1;
		});

		::Mod_Sellswords.HookHelper.hookSpecificItemSkill.call(this, "actives.split_shield", function(_skill) {
			_skill.m.ActionPointCost = 6;		
			_skill.setApplyAxeMastery(true);
		});

		local skill = this.new("scripts/skills/actives/chop");
		skill.m.DirectDamageMult = this.m.DirectDamageMult;	
		skill.m.infantry = true;			
		skill.m.orc = true;
		this.addSkill(skill);
	}

});	