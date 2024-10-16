extends Control

class_name RetroScriptEditor

@onready var code_space:RetroScriptCompilerBase = $UISplit/CodeEditor/RetroScript
@onready var function_list:VBoxContainer = $UISplit/Scroll/List/FunctionList
@onready var language_selector:OptionButton = $"UISplit/Scroll/List/WhichLang"

var script_path:String

func _ready() -> void:
	code_space.connect("compiler_info_updated", refresh_jump_button_list)
	for langs:String in Central.languages.keys():
		language_selector.add_item(langs)
	if not script_path.is_empty():
		open_script()

func _on_which_lang_item_selected(index:int) -> void:
	var lang_key:StringName = language_selector.get_item_text(index)
	var lang:RetroScriptSpec = Central.languages.get(lang_key)
	
	if not lang.resource_path.is_empty():
		print(lang_key)
		code_space.lang_db = lang
		code_space.setup_retroscript_editor()

func open_script(path:String = script_path) -> void:
	if FileAccess.file_exists(path):
		name = path.get_file()
		code_space.text = FileAccess.get_file_as_string(path)
		code_space.parse_script_text()

func refresh_jump_button_list() -> void:
	#TODO: Add parsing here so we aren't constantly deleting and re-adding nodes
	for each_button:Node in function_list.get_children():
		each_button.queue_free()
	
	#BUG: This would cause the functions to be loaded in an order that does not match
	#their order of definition in the script file
	#for functions:RSDKv3ScriptCompiler.FunctionInfo in code_space.local_functions:
		#printt(functions.name, functions.line)
		#var add_button:Button = make_shortcut_button(functions.name, functions.line)
		#function_list.add_child(add_button)
	
	for bookmarks:int in code_space.get_bookmarked_lines():
		var trimmed_text:String = code_space.get_line(bookmarks).replacen(" ", "")
		
		var button_name:String
		if trimmed_text.begins_with("sub"):
			button_name = trimmed_text.trim_prefix("sub")
		elif trimmed_text.begins_with("function"):
			button_name = trimmed_text.trim_prefix("function")
		
		var add_button:Button = make_shortcut_button(button_name, bookmarks)
		function_list.add_child(add_button)

func jump_shortcut(line:int) -> void:
	code_space.set_line_as_first_visible(line)

func make_shortcut_button(button_name:String, line:int) -> Button:
	var new_button:Button = Button.new()
	new_button.name = button_name
	new_button.text = button_name
	new_button.flat = true
	new_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	new_button.connect("pressed", jump_shortcut.bind(line))
	return new_button
