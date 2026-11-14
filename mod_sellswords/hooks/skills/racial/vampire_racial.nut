::Mod_Sellswords.HooksMod.hook("scripts/skills/racial/vampire_racial", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		
		this.m.Name = ::Mod_Sellswords.Strings.vampire_racial.Name;
		this.m.Description = ::Mod_Sellswords.Strings.vampire_racial.Description;
		this.m.Icon = "ui/racial/ssu_racial_vampire.png";
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
				text = ::Mod_Sellswords.Strings.vampire_racial.Tooltip1
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/miniboss.png",
				text = ::Mod_Sellswords.Strings.vampire_racial.Tooltip2
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Mod_Sellswords.Strings.vampire_racial.Tooltip3
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.vampire_racial.Tooltip4
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