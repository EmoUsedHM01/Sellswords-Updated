::mods_hookExactClass("skills/perks/perk_ptr_swordmaster_blade_dancer", function ( o )
{
	o.m.Count <- 0,
	o.m.FatigueCostIncreasePerCount <- 15		
	o.onAnySkillExecuted <- function ( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.slash" || _skill.getID() == "actives.legend_great_slash")
		{
			this.m.Count++;
		}
	}
	o.onAfterUpdate = function ( _properties )
	{
		if (!this.isEnabled()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		local spearwall = this.getContainer().getSkillByID("actives.spearwall")
		if (spearwall != null)
		{
			return;
		}			
		if (!weapon.isWeaponType(::Const.Items.WeaponType.BFFencing))
		{
			local skills = this.getContainer().getActor().getMainhandItem().getSkills();
			foreach (skill in skills)
			{
				skill.m.ActionPointCost = ::Math.max(0, skill.m.ActionPointCost - 1);
				skill.m.FatigueCostMult *= 1.0 + (this.m.FatigueCostIncreasePerCount * 0.01 * this.m.Count);					
			}
		}		

		local kataStep = this.getContainer().getSkillByID("actives.ptr_kata_step")
		if (kataStep != null)
		{
			kataStep.m.ActionPointCost = ::Math.max(0, kataStep.m.ActionPointCost - 2);
			kataStep.m.FatigueCost = ::Math.max(0, kataStep.m.FatigueCost - 2);
		}
	}		
	o.onTurnEnd <- function ()
	{
		this.m.Count = 0;
	}
	o.onCombatFinished <- function ()
	{
		this.skill.onCombatFinished();
		this.m.Count = 0;
	}		
});	