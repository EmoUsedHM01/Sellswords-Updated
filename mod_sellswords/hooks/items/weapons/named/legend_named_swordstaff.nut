::mods_hookExactClass("items/weapons/named/legend_named_swordstaff", function(o) {
	local ws_onEquip = o.onEquip;
	o.onEquip = function()
	{
		if (!::Is_PTR_Exist)
		{
			this.weapon.onEquip();			
			local prong = this.new("scripts/skills/actives/prong_skill");
			this.addSkill(prong);
			local overheadStrike = this.new("scripts/skills/actives/overhead_strike");
			overheadStrike.m.IsIgnoredAsAOO = true;
			this.addSkill(overheadStrike);
			local spearwall = this.new("scripts/skills/actives/spearwall");
			spearwall.m.Icon = "skills/active_124.png";
			spearwall.m.IconDisabled = "skills/active_124_sw.png";
			spearwall.m.Overlay = "active_124";
			spearwall.m.BaseAttackName = prong.getName();
			spearwall.setFatigueCost(spearwall.getFatigueCostRaw() + 5);
			spearwall.m.ActionPointCost = 6;
			this.addSkill(spearwall);
		}
		else
		{
			ws_onEquip();
		}
		
		this.addSkill(this.new("scripts/skills/actives/repel"));	
	}	
});