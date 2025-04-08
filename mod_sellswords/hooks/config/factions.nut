::Const.FactionType.Dryads <- ::Const.FactionType.COUNT++;
::Const.Faction.Dryads <- ::Const.Faction.COUNT++;

while (::Const.FactionColor.len() <= ::Const.Faction.COUNT)
	::Const.FactionColor.push(::createColor("#ffffff"));
while (::Const.FactionBase.len() <= ::Const.Faction.COUNT)
	::Const.FactionBase.push("");
while (::Const.FactionAlliance.len() <= ::Const.Faction.COUNT)
	::Const.FactionAlliance.push([]);

::Const.FactionBase[::Const.Faction.Dryads] = "bust_base_dryad";
::Const.FactionAlliance[::Const.Faction.Dryads] = [
	::Const.Faction.Dryads  // hostile to everyone except same faction?
];
