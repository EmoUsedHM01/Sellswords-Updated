this.crfake_militiacaptain_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.crfake_militiacaptain";
		this.m.Name = "Relationship";
		this.m.Icon = "ui/traits/aggressive_trait.png";
		this.m.Description = "If you can see this something is fucked up";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.IsHidden = true;
	}

	function getTooltip()
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
				id = 10,
				type = "text",
				icon = "ui/icons/mone.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]123[/color]"
			},
		];
	}

	function onUpdate( _properties )
	{
		this.getContainer().getActor().getBackground().m.Icon = "ui/backgrounds/background_35.png";
		this.getContainer().getActor().getBackground().m.Name = "Militia Captain";
		this.getContainer().getActor().getBackground().m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn;		
		_properties.DailyWageMult *= 1.75;	
		this.getContainer().getActor().getBackground().m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.getContainer().getActor().getBackground().m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];			
	}

});

