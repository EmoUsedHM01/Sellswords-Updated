::Mod_Sellswords.HooksMod.hook("scripts/skills/racial/vampire_racial", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.Name = "Bloodthirsty Curse";
		this.m.Description = "Strikes against enemy hitpoints restore your health by an amount equal to the damage dealt.";
		this.m.Icon = "ui/racial/racial_vampire.png";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.StatusEffect;
		this.m.IsHidden = false;
	}
	
	q.getTooltip <- function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Strikes against enemy hitpoints restore your health by an amount equal to the damage dealt."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = "Immune to bleeding, poison and stuns."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Not effected by fatigue, but needs fatigue to equip items."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Always has [color=" + this.Const.UI.Color.NegativeValue + "]0%[/color] chance to survive being struck down."
			}
		];
	}
	
	q.onUpdate <- function( _properties )
	{
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsImmuneToStun = true;
		_properties.IsAffectedByNight = false;
	}
	
	q.onAdded <- function()
	{
		local items = this.getContainer().getActor().getItems();
		items.getData()[this.Const.ItemSlot.Head][0] = -1;
		items.getData()[this.Const.ItemSlot.Body][0] = -1;
	}

});