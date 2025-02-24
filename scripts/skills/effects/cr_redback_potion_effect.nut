this.cr_redback_potion_effect <- this.inherit("scripts/skills/skill", {
    m = {},
    function create()
    {
        this.m.ID = "effects.cr_redback_potion";
        this.m.Type = this.Const.SkillType.StatusEffect;
        this.m.Order = this.Const.SkillOrder.Perk;
        this.m.IsActive = false;
        this.m.IsRemovedAfterBattle = false;
        this.m.IsStacking = false;
        this.m.IsHidden = true;
    }

    function onUpdate (_properties) {
        // note: it's in onUpdate, not in onAdded, so I could avoid hooking legend_redback_helmet
        // this kinda works around it, as this is called every after onUnequip, so this skill isn't removed
        if (!this.getContainer().hasSkill("actives.web"))
            this.getContainer().add(this.new("scripts/skills/actives/web_skill"));
    }

});

