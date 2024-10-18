extends TabContainer

class_name ScriptTabs

const editor_scene:PackedScene = preload("res://user_interface/retroscript_editor.tscn")

func _ready() -> void:
	connect(&"child_exiting_tree", check_children)

func check_children(_leaving_child:Node = Node.new()) -> void:
	if not get_child_count(): #no children
		Central.emit_signal("switch_tab", Central.OpeningScreen)

func open_new_script(path:String) -> void:
	if FileAccess.file_exists(path):
		var newest_tab:RetroScriptEditor = editor_scene.instantiate()
		newest_tab.script_path = path
		newest_tab.name = path.get_file().get_slice(".", 0)
		add_child(newest_tab)

func close_current_tab() -> void:
	var closed_tab:int = current_tab
	current_tab = wrapi(closed_tab, 0, get_child_count() - 1)
	get_child(closed_tab).queue_free()
	
	check_children()

func close_all_tabs() -> void:
	
	check_children()

func jump_to_tab(index:int) -> void:
	current_tab = index
