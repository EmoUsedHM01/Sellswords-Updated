this.lorekeeper_skull_spawn_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Level = 0
	},
	function create()
	{
		this.m.ID = "effects.lorekeeper_skull_spawn";
		this.m.Name = "Screaming Skulls";
		this.m.Description = "Using the power of the Black Book, at the start of each turn, the user summons Screaming Skulls equal to a third of the %their% level up to a maximum of 4 skulls.";
		this.m.Icon = "skills/skull_spawn_effect.png";
		//this.m.IconMini = "skull_spawn_effect_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc6/mirror_image_01.wav",
			"sounds/enemies/dlc6/mirror_image_02.wav",
			"sounds/enemies/dlc6/mirror_image_03.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function setLevel( _l )
	{
		this.m.Level = _l;
	}

	function onAdded()
	{
		this.getContainer().getActor().getAIAgent().addBehavior(::new("scripts/ai/tactical/behaviors/mod_ai_flying_skulls_player"));
	}

	function onRemoved()
	{
		this.getContainer().getActor().getAIAgent().removeBehavior(::Const.AI.Behavior.ID.FlyingSkulls);
	}

	function addResources()
	{
		this.skill.addResources();
		local move = [
			"sounds/enemies/dlc6/skull_move_01.wav",
			"sounds/enemies/dlc6/skull_move_02.wav",
			"sounds/enemies/dlc6/skull_move_03.wav",
			"sounds/enemies/dlc6/skull_move_04.wav"
		];
		local bang = [
			"sounds/enemies/dlc6/skull_bang_01.wav",
			"sounds/enemies/dlc6/skull_bang_02.wav",
			"sounds/enemies/dlc6/skull_bang_03.wav",
			"sounds/enemies/dlc6/skull_bang_04.wav"
		];

		foreach( r in move )
			::Tactical.addResource(r);

		foreach( r in bang )
			::Tactical.addResource(r);
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor().get();
		local b = actor.getAIAgent().getBehavior(::Const.AI.Behavior.ID.FlyingSkulls);

		if (b != null)
		{
			b.onEvaluate(actor);
			b.onExecute(actor);
		}

		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has summoned Screaming Skulls!");
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		this.setLevel(this.Math.min(12, actor.getLevel()));
	}

});