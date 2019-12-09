@echo off
cd game/dota_addons/addon_template_butt/
if exist readonly_tools_asset_info.bin (
	del readonly_tools_asset_info.bin
	echo the template is NOT READONLY now
	ping localhost -n 2 >nul
) else (
	copy ..\addon_template\readonly_tools_asset_info.bin readonly_tools_asset_info.bin
	cls
	echo the template is READONLY now
	ping localhost -n 2 >nul
)