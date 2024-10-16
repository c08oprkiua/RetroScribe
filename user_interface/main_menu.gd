extends VBoxContainer

@onready var editor_tab_space:ScriptTabs = $"MainSpace/MainEditor"
@onready var gui_tabs:TabContainer = $"MainSpace"
@onready var script_open_dialog:FileDialog = $"OpenAScript"


func _ready() -> void:
	script_open_dialog.connect(&"file_selected", validate_file)
	Central.connect("switch_tab", change_tab)

func _on_open_pressed() -> void:
	script_open_dialog.show()

func _on_docs_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func change_tab(to:int) -> void:
	gui_tabs.current_tab = clampi(to, 0, 4)

func validate_file(path:String) -> void:
	print("Opening file... ", path)
	if FileAccess.file_exists(path):
		editor_tab_space.open_new_script(path)
		Central.emit_signal("switch_tab", Central.EditorTabs)
