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

signal switch_tab(to:int)

func load_settings_from_ini() -> void:
	var conf:ConfigFile = ConfigFile.new()
	
	var ini_path:String = OS.get_executable_path() + "settings.ini"
	
	print(ini_path)
	
	if FileAccess.file_exists(ini_path):
		conf.load(ini_path)
	
	var path:String = OS.get_executable_path()
	
	conf.load(path)
