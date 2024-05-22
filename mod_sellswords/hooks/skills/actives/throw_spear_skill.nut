::mods_hookExactClass("skills/actives/throw_spear_skill", function(o) {

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 20;
			_properties.HitChanceAdditionalWithEachTile -= 10;

			if (_properties.IsSpecializedInSpearThrust)
			{
				_properties.HitChanceAdditionalWithEachTile += 10;
			}

			if (_targetEntity != null)
			{
				local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

				if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
				{
					this.m.IsUsingHitchance = false;
				}
				else
				{
					this.m.IsUsingHitchance = true;
				}
			}
			else
			{
				this.m.IsUsingHitchance = true;
			}
			local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (_targetEntity != null && _targetEntity.getCurrentProperties().IsSpecializedInShields && this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
			{
				weapon.m.ShieldDamage *= 2;
			}				
		}			
	}
});	