"use strict";

var IsHost = Game.GetLocalPlayerInfo().player_has_host_privileges;
var hostLocked = false;

// if (!IsHost) CustomNetTables.SubscribeNetTableListener("settings_butt_update", LoadSettingsButt);

if (!IsHost){
	$("#SettingsBody").enabled=false;
}

(function moveFrame() {
	var placeholder = $.GetContextPanel().GetParent().FindChildTraverse("TeamsSelectEmptySpace");
	if (placeholder) {
		$.Msg("moving Frame");
		$.GetContextPanel().SetParent(placeholder);
	} else {
		$.Schedule( 0.1, moveFrame );
	}
})();

(function hostTitle(){
	if ($("#Host")) {
		for (var i of Game.GetAllPlayerIDs()) {
			if ( Game.GetPlayerInfo(i) && Game.GetPlayerInfo(i).player_has_host_privileges) {
				$("#Host").text = "HOST: " + Players.GetPlayerName( i );
			}
		}
	} else {
		$.Schedule( 0.1, hostTitle );
	}
})();

(function updateGreenTitle() {
})();

var l1 = GameEvents.Subscribe( "game_rules_state_change", function(event) {
	if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)){
		$("#SettingsBody").enabled=false;
		applySettings();
		if (IsHost){
			GameEvents.SendCustomGameEventToAllClients("butt_lock_settings",{});
			GameEvents.SendCustomGameEventToServer("butt_lock_settings",{});
		}
		GameEvents.Unsubscribe(l1);
	}
});

var l2 = GameEvents.Subscribe( "butt_lock_settings", function() {
	hostLocked = true;
	GameEvents.Unsubscribe(l2);
});

function applySettings() {
	var banPanel = findPanel("BanButton");
	var pickPanel = findPanel("HeroPickControls");
	if (!(banPanel && pickPanel)) {
		$.Schedule( 0.1, applySettings );
		return;
	}
	if (!hostLocked){
		banPanel.visible=false;
		pickPanel.visible=false;
		$.Schedule( 0.1, applySettings );
		return;
	}
	var banning = ($("#HERO_BANNING").checked);
	var allPick = ("AP"===$("#GAME_MODE").GetSelected().id);
	var allRandom = ("AR"===$("#GAME_MODE").GetSelected().id);
	banPanel.visible=(banning);
	pickPanel.visible=(allPick);
}

////////////////////////////////////////////////////////////

function onPanelChange(name) {
	if (!IsHost) {
		return;
	}
	var panel = $("#"+name);
	var panelType = panel.paneltype;
	var val = undefined;

	if ("DropDown"===panelType) {
		val = panel.GetSelected().id;
	} else if ("ToggleButton"===panelType) {
		val = panel.checked;
		$.Msg(typeof val);
	}
	if (undefined!==val) {
		GameEvents.SendCustomGameEventToAllClients( "butt_setting_changed", {setting: name , value: val });
		GameEvents.SendCustomGameEventToServer( "butt_setting_changed", {setting: name , value: val });
		$.Msg("asdsd");
	}
}

GameEvents.Subscribe( "butt_setting_changed", function onHostChanged(kv) {
	var name = kv.setting;
	var panel = $("#"+name);
	var val = kv.value;
	var panelType = panel.paneltype;

	// $.Msg(name,": ",val);
	switch(true){
		case ("DropDown"===panelType):
			panel.SetSelected(val);
			break;
		case ("ToggleButton"===panelType):
			panel.checked = val;
			break;
		default:
			break;
	}
	if ((Game.GetState)>=(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) {
		finalSubmit();
	}
});

////////////////////////////////////////////////////////////

(function fillBanList() {//not working
	// var drop = findPanel("BanListDropDownMenu");
	// var herolist = ["npc_dota_hero_riki","npc_dota_hero_techies"]
	// for (var i = 0; i < herolist.length; i++) {
	// 	$.Msg(i,herolist[i]);
	// 	var iLabel = $.CreatePanel( "Label", drop, herolist[i] );
	// 	iLabel.text = herolist[i];
	// 	iLabel.AddClass("DropDownChild");
	// }
})();
///////////////////////////////////////////////////////////

function rootPanel() {
	var scrollup = $.GetContextPanel();
	while (scrollup.GetParent()) {
		scrollup = scrollup.GetParent();
	}
	return scrollup;
}

function findPanel(name) {
	if (typeof(name)!=="string") {
		$.Msg("findPanel argument fail");
		return null;
	}
	var scrollup = $.GetContextPanel();
	while (scrollup.GetParent()) {
		scrollup = scrollup.GetParent();
	}
	return scrollup.FindChildTraverse(name);
}