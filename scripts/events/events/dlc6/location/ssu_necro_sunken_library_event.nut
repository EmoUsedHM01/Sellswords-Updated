this.ssu_necro_sunken_library_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.location.ssu_necro_sunken_library";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Title;
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text2,
					function getResult( _event )
					{
						return ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text3;
					}
		
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text4,
					function getResult( _event )
					{
						return ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text5;
					}
		
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text6,
					function getResult( _event )
					{
						return ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text7;
					}
		
				}
			],
			function start( _event )
			{
			}
			
		});
		this.m.Screens.push({
			ID = "Scrolls",
			Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text8,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text9,
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/misc/legend_ancient_scroll_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
			}
		});
		this.m.Screens.push({
			ID = "Gear",
			Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text10,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text11,
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/named/legend_named_gladius");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"ancient/ancient_plated_mail_hauberk"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"ancient/ancient_honorguard_helmet"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Tooltip, this.Const.Strings.getArticle(item.getName()), item.getName())
				});
			}
		});
		this.m.Screens.push({
			ID = "Recruit",
			Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text12,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_sunken_library_event.Text13,
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		if (this.m.Dude == null)
		{
			local roster = this.World.getTemporaryRoster();
			this.m.Dude = roster.create("scripts/entity/tactical/ssu_necro_undead_player");
			this.m.Dude.setStartValuesEx(this.Const.Necro.CommonUndeadBackgrounds);
			this.m.Dude.getSprite("socket").setBrush("bust_base_undead");
		}

		_vars.push([
			"dude",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

