// todo this will be not needed as of Legends 19.0.0, but is needed for 18.x as it is not patched - chopeks
::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_scythe_skill", function (q) {
    q.onUpdate = @() function (_properties) {
        local item = this.getContainer().getActor().getMainhandItem();
        if (item != null) {
            if (item.getID() == "weapon.legend_grisly_scythe" || item.getID() == "weapon.legend_scythe" || item.getID() == "weapon.warscythe" || item.getID() == "weapon.named_warscythe") {
                _properties.MeleeSkill += 15;
            }
        }
    }
});