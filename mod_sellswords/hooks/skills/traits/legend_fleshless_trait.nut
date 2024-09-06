::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/legend_fleshless_trait", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/traits/necro_fleshless.png";
	}

	q.onApplyAppearance = @(__original) function()
	{
		local actor = this.getContainer().getActor().get();

		if (!(::MSU.isKindOf(actor, "player")))
			return;

		if (actor.getBackground() == null)
			return;

		if (actor.getBackground().getID() == "background.mummy" || actor.getBackground().getID() == "background.demon_hound")
			return;

		if (actor.getFlags().has("human"))
			actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		local body = actor.getSprite("body");
		body.setBrush("bust_skeleton_body_0" + this.Math.rand(1, 2));
		body.Saturation = 0.8;

		actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

		local head = actor.getSprite("head");
		head.setBrush("bust_skeleton_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;

		local beard = actor.getSprite("beard");
		if (beard == !null)
		{
			beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieOnly[this.Math.rand(0, this.Const.Beards.ZombieOnly.len() - 1)]);
			local beard_top = actor.getSprite("beard_top");
			if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
			{
				beard_top.setBrush(beard.getBrush().Name + "_top");
				beard_top.Color = beard.Color;
			}
		}

		local face = actor.getSprite("scar_head");
		if (face == !null)
		{
			face.setBrush("bust_skeleton_face_0" + this.Math.rand(1, 6));
		}

		local hair = actor.getSprite("hair");
		if (hair == !null)
		{
			hair.Color = beard.Color;
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.ZombieOnly[this.Math.rand(0, this.Const.Hair.ZombieOnly.len() - 1)]);
			actor.setSpriteOffset("hair", this.createVec(0, -3));
		}

		local injury = actor.getSprite("injury");
		if (injury == !null)
		{
			injury.setBrush("bust_skeleton_head_injured");
		}
	}

});