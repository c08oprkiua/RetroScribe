extends Control

class_name RetroScriptEditor

@onready var code_space:RetroScriptCompilerBase = $UISplit/CodeEditor/RetroScript
@onready var function_list:VBoxContainer = $UISplit/Scroll/List/FunctionList
@onready var language_selector:OptionButton = $"UISplit/Scroll/List/WhichLang"

@onready var docs_info:Label = $"UISplit/CodeEditor/Info/Description"
@onready var docs_value:Label = $"UISplit/CodeEditor/Info/Value"

var script_path:String

func _ready() -> void:
	code_space.connect("compiler_info_updated", refresh_jump_button_list)
	for langs:String in Central.languages.keys():
		language_selector.add_item(langs)
	if not script_path.is_empty():
		code_space.text = FileAccess.get_file_as_string(script_path)
		_on_which_lang_item_selected(language_selector.selected)

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
		code_space.setup_retroscript_editor()

func refresh_jump_button_list() -> void:
	var function_array:Dictionary[StringName, FunctionInfo] = code_space.local_functions.duplicate(true)
	
	#parse over the buttons, removing ones no longer valid and ignoring ones that still are
	for each_button:Node in function_list.get_children():
		#No need to recreate buttons we already have
		var button_stringname:StringName = StringName(each_button.name)
		if code_space.local_functions.has(button_stringname):
			function_array.erase(button_stringname)
		else:
			each_button.queue_free()
	
	#This 
	for bookmarks:int in code_space.get_bookmarked_lines():
		for each_func:StringName in function_array.keys():
			var func_info:FunctionInfo = function_array.get(each_func)
			if func_info.start_line == bookmarks:
				function_array.erase(each_func)
				
				var add_button:Button = make_shortcut_button(each_func, bookmarks)
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


func _on_retro_script_symbol_validate(symbol: String) -> void:
	pass # Replace with function body.


func _on_retro_script_symbol_lookup(symbol: String, line: int, column: int) -> void:
	pass # Replace with function body.


func _on_retro_script_code_completion_requested() -> void:
	pass # Replace with function body.
