"use strict";

var IsHost = false;
var AllPanels = [];

function UpdateRadio(id, on){
	if (!IsHost) return;
	$.Msg("selected ",id," ",on);
	GameEvents.SendCustomGameEventToServer("custom_setting_change", {setID: id, value: on});
}

function UpdateText(id, p){
	if (!IsHost) return;
	$.Msg("Text updated: ",id," ",p.text);
	var val = parseFloat(p.text);
	if (isNaN(val)) val=0;
	if ((p.max) && (val>p.max)) val=p.max;
	if ((p.min) && (val<p.min)) val=p.min;
	p.text = val;
	GameEvents.SendCustomGameEventToServer("custom_setting_change", {setID: id, value: val});
}

function UpdateToggle(id, p){
	if (!IsHost) return;
	$.Msg("toggled ",id," ", p.checked);
	GameEvents.SendCustomGameEventToServer("custom_setting_change", {setID: id, value: p.checked? 1: 0});
}

function PressButton(id, p){
	if (!IsHost) return;
	$.Msg("pressed ",id);
	var bodyPanel = $("#SettingsBody");
	GameEvents.SendCustomGameEventToServer("custom_setting_change", {setID: id, click: true});
	if (id=="reset" || id=="random" || id=="baumi") ResetButtons(p);
}

function ResetButtons(p) {
	
	$.Msg("resetting");
	$.Schedule( 0.1, function() {
		var bodyPanel = p.GetParent().GetParent();
		var allButtons = CustomNetTables.GetTableValue("custom_settings","subtable");
		if (!IsHost) CustomNetTables.SubscribeNetTableListener("custom_settings", LoadSettings);	
		if (!allButtons) return;
		
		for (var page in allButtons) {
			page = allButtons[page];
			for (var opt in page.options) {
				var opt = page.options[opt];
				var panel =AllPanels[opt.id];
				var style = opt.style ? opt.style : page.style;
				if (style=="RadioButton" || style=="ToggleButton")
					panel.checked = opt.value==1;
				else if (style=="TextEntry")
					panel.text = opt.value;
			}
		}
	});
}

function LoadSettings(bodyPanel){
	var allButtons = CustomNetTables.GetTableValue("custom_settings","subtable");
    if (!IsHost) CustomNetTables.SubscribeNetTableListener("custom_settings", LoadSettings);
	
	if (!allButtons) return;
	
	// $.Msg(allButtons," ");
	// $.Msg(" ");
	
	
	for (var page in allButtons) {
		page = allButtons[page];
		var pagePanel = $("#" + page.title);
		if (!pagePanel){
			pagePanel = $.CreatePanel( 'Panel', bodyPanel, page.title+"Group");
			pagePanel.AddClass( 'SettingsElement');
			var title = $.CreatePanel( 'Label', pagePanel, page.title+"Title");
			title.AddClass( 'SettingsElementTitle');
			title.text= page.title;
		}
		for (var opt in page.options) {
			var opt = page.options[opt];
			var style = opt.style ? opt.style : page.style;
			if (!opt.id || !opt.text) continue;
			$.Msg(opt);
			$.Msg("");
			var panel = $("#"+opt.id);
			if (!panel){
				panel = $.CreatePanel( style, pagePanel, opt.id );
				AllPanels[opt.id]=panel;
				panel.text= opt.text;
				panel.AddClass( 'SettingsElementBody' );
				if (style=="Button"){
					panel.AddClass( 'ButtonBevel' );
					var label = $.CreatePanel( 'Label', panel, opt.text);
					label.text=opt.text;
					panel.SetPanelEvent("onactivate", (function(id, p){return function(){PressButton(id, p)}}(opt.id, panel)));
				} else if (style=="ToggleButton"){
					panel.SetPanelEvent("onactivate", (function(id, p){return function(){UpdateToggle(id, p)}}(opt.id, panel)));
				} else if (style=="RadioButton"){
					panel.group=opt.id+"1232";
					var label = $.CreatePanel( 'Label', panel, opt.text);
					label.text=opt.text;
					panel.SetPanelEvent("onselect", (function(id, n){return function(){UpdateRadio(id, n)}}(opt.id, 1)));
					panel.SetPanelEvent("ondeselect", (function(id, on){return function(){UpdateRadio(id, on)}}(opt.id, 0)));
				} else if (style=="TextEntry"){
					if (opt.text){
						var outerPanel = $.CreatePanel( 'Panel', pagePanel, opt.id+"outerbox" );
						panel.SetParent(outerPanel);
						outerPanel.AddClass( 'SettingsElementBody' );
						outerPanel.AddClass( 'TextEntryFrame' );
						var lebel = $.CreatePanel( 'Label', outerPanel, opt.id+"moretext");
						lebel.text="    "+opt.text;
						lebel.AddClass( 'TextEntryLabel' );
					}
					panel.text=opt.value;
					panel.SetMaxChars(6);
					if (opt.digits) panel.SetMaxChars(opt.digits);
					if (opt.min) panel.min=opt.min;
					if (opt.max) panel.max=opt.max;
					panel.SetPanelEvent("oninputsubmit", (function(id, p){return function(){UpdateText(id,p)}}(opt.id, panel)));
					panel.SetPanelEvent("onblur", (function(id, p){return function(){UpdateText(id,p)}}(opt.id, panel)));
				}
				panel.enabled = IsHost
			}
			if (style=="RadioButton" || style=="ToggleButton")
				panel.checked = opt.value==1;
			else if (style=="TextEntry")
				panel.text = opt.value;
		}
	}
}


function CheckForHostPrivileges(){
	if ( !Game.GetLocalPlayerInfo() ) return;
	IsHost = Game.GetLocalPlayerInfo().player_has_host_privileges;
	
	for (var i = 0; i < Game.GetAllPlayerIDs().length; i++) {
		if ( Game.GetPlayerInfo(i) && Game.GetPlayerInfo(i).player_has_host_privileges){
			if ($('#Host'))
				$('#Host').text = "HOST: " + Players.GetPlayerName( i );
		}
	}
	
	if ($('#GameTitle'))
		$('#GameTitle').text = CustomNetTables.GetTableValue("custom_settings","gametitle").title;
	if ("Dota 2 but..."==$('#GameTitle').text) $('#GameTitle').text="";
	$.Schedule(1, CheckForHostPrivileges);
}

GameEvents.Subscribe( "settings_ready", function() {

});

$.Schedule( 0.2, function() {
	
	CheckForHostPrivileges();
	LoadSettings($("#SettingsBody"));	//content
	
	var ownPanel = $("#CustomSettings");	// frame with content
	var parent =	$.GetContextPanel().GetParent().GetChild(0).GetChild(0).GetChild(0);
	ownPanel.SetParent(parent);
});