extends CodeHighlighter

class_name RetroScriptSpec

@export var alias_max_count:int

@export_group("Strings")
@export var keywords:PackedStringArray

@export var event_declaration:String

@export var events:Dictionary[StringName, FunctionInfo]

@export var functions:Dictionary[StringName, FunctionInfo]
##Key is the alias text, value is the text that replaces it upon parsing
@export var aliases:Dictionary[String, String]
##Keys are operators (eg. +=) in RetroScript, value is the name of the function they
##are replaced by.
@export var math_shorthands:Dictionary[String, StringName]

@export var engine_variables:Dictionary[StringName, VarInfo]

@export var engine_objects:Dictionary[StringName, Dictionary]

@export_group("Syntax Colors", "color_")
@export var color_func:Color = Color.ROYAL_BLUE
@export var color_math:Color = Color.HOT_PINK
@export var color_keyword:Color = Color.RED
@export var color_member:Color = Color.YELLOW_GREEN
@export var color_member_var:Color = Color.AQUA

func _init() -> void:
	configure()

func configure() -> void:
	for funcs:String in functions.keys():
		add_keyword_color(funcs, color_func)
	
	for sub_funcs:String in events:
		add_keyword_color(sub_funcs, color_func)
	
	for evals:String in math_shorthands.keys():
		add_keyword_color(evals, color_math)
	
	for members:String in engine_objects.keys():
		add_member_keyword_color(members, color_member)
	
	for each_variable:String in engine_variables:
		add_member_keyword_color(each_variable, color_member_var)
	
	for each_keyword:String in keywords:
		add_keyword_color(each_keyword, color_keyword)
	
	for global_aliases:String in aliases.keys():
		add_keyword_color(global_aliases, color_keyword)
	
	function_color = color_func
	member_variable_color = color_member_var
	number_color = color_math
	symbol_color = Color.WHITE
