extends Node

#autoload singleton

var base_dir:String

var default_lang:String

enum {
	OpeningScreen,
	EditorTabs,
	Docs,
	Settings
}

#Godot BUG: Actually loading the resources from disk gives an incorrect error about
#CodeHighlighter being uncastable to Resource (basically), even though it inherits it.
var languages:Dictionary[StringName, RetroScriptSpec] = {
	&"RSDKv3": RetroScriptSpec.new(),
	&"RSDKv4": RetroScriptSpec.new(),
	&"Foreverv4": RetroScriptSpec.new(),
}

@warning_ignore("unused_signal")
signal switch_tab(to:int)

func load_settings_from_ini() -> void:
	var conf:ConfigFile = ConfigFile.new()
	
	var ini_path:String = OS.get_executable_path() + "settings.ini"
	
	print(ini_path)
	
	if FileAccess.file_exists(ini_path):
		conf.load(ini_path)
	
	var path:String = OS.get_executable_path()
	
	conf.load(path)
