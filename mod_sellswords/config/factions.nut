// find highest number in FactionTrait
local lastTrait = 0;
foreach (item in ::Const.FactionTrait) {
    if (typeof(item) == "integer")
        lastTrait = ::Math.max(lastTrait, item);
}
// new ssu faction traits
::Const.FactionTrait.Dryads <- ++lastTrait;
// ensure actions list is big enough to fit our new traits
while(::Const.FactionTrait.Actions.len() < lastTrait + 1)
    ::Const.FactionTrait.Actions.push([]);

::Const.FactionTrait.Actions[this.Const.FactionTrait.NobleHouse].extend([
    "scripts/factions/contracts/destroy_rebellions_action",
    "scripts/factions/contracts/purge_infection_action"
]);

::Const.FactionTrait.Actions[this.Const.FactionTrait.Settlement].extend([
    "scripts/factions/contracts/explore_treasures_action"
]);

::Const.FactionTrait.Actions[this.Const.FactionTrait.Dryads].extend([
    "scripts/factions/actions/send_dryad_roamers_action"
]);
