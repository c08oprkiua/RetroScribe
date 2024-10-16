extends TabContainer

class_name ScriptTabs

const editor_scene:PackedScene = preload("res://user_interface/retroscript_editor.tscn")

func _ready() -> void:
	connect(&"child_exiting_tree", check_children)

func check_children(_leaving_child:Node) -> void:
	if not get_child_count(): #no children
		Central.emit_signal("switch_tab", Central.OpeningScreen)

func open_new_script(path:String) -> void:
	if FileAccess.file_exists(path):
		var newest_tab:RetroScriptEditor = editor_scene.instantiate()
		newest_tab.script_path = path
		add_child(newest_tab)
