this.crfake_kingsguard_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.crfake_kingsguard";
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
		this.getContainer().getActor().getBackground().m.Icon = "ui/backgrounds/background_59.png";
		this.getContainer().getActor().getBackground().m.Name = "King\'s Guard";
		this.getContainer().getActor().getBackground().m.BackgroundType = this.Const.BackgroundType.Crusader;		
		_properties.DailyWageMult *= 10;	
		this.getContainer().getActor().getBackground().m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.getContainer().getActor().getBackground().m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.getContainer().getActor().getBackground().m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.getContainer().getActor().getBackground().m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.getContainer().getActor().getBackground().m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];		
	}
	
	function onAdded()
	{
		this.character_trait.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Kingsguard");
		this.m.Container.add(this.new("scripts/skills/traits/loyal_trait"));
		this.m.Container.add(this.new("scripts/skills/traits/fearless_trait"));
	}	

});

