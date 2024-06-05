::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_field_triage", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Heal a unit, costs 3 medicine for every 4 health. Heals up to 20% missing health per use";
		this.m.ActionPointCost = 6;
		this.m.MaxLevelDifference = 1;
	}
	
	q.getTooltip = @( __original ) function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_medicine.png",
			text = "You have [color=" + this.Const.UI.Color.PositiveValue + "]" + this.World.Assets.getMedicine() + "[/color] medicine."
		});
		local hp = this.Math.ceil(this.World.Assets.getMedicine() * 1.33);
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/health.png",
			text = "You can heal up to [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.floor(hp) + "[/color] hitpoints."
		});
		return ret;
	}
	
	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local meds = this.World.Assets.getMedicine();
		local target = _targetTile.getEntity();

		local neededHeal = this.Math.ceil((target.getHitpointsMax() - target.getHitpoints()) * 0.2);
		local neededMeds = this.Math.ceil(neededHeal * 0.75);
		
		local finalHeal = neededHeal;
		
		if (meds < neededMeds)
		{
			finalHeal = this.Math.ceil(meds * 1.33);
		}
		
		local cost = this.Math.min(meds, neededMeds);
		this.World.Assets.addMedicine(cost * -1);
		target.setHitpoints(this.Math.min(target.getHitpointsMax(), target.getHitpoints() + finalHeal));
		return true;
	}
});
