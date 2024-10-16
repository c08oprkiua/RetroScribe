extends Resource

class_name RetroScriptSpec

@export var alias_max_count:int

@export_group("Strings")
##The keywords of the RetroScript spec, such as function declarations and end statements.
@export var keywords:PackedStringArray

@export var event_declaration:String
##The names and information for all recognized event callback functions.
@export var events:Dictionary[StringName, FunctionInfo]
##The names and information for all built in functions.
@export var functions:Dictionary[StringName, FunctionInfo]
##The name and corresponding value of all built in aliases.
@export var aliases:Dictionary[String, StringName]
##The text string and corresponding function they are an alias of for all math operators.
@export var math_shorthands:Dictionary[String, StringName]
##The names and information for all built in variables.
@export var engine_variables:Dictionary[StringName, VarInfo]
##The names and information for all built in engine objects.
@export var engine_objects:Dictionary[StringName, Dictionary]

@export_group("Syntax Colors", "color_")
@export var color_func:Color = Color.ROYAL_BLUE
@export var color_math:Color = Color.HOT_PINK
@export var color_keyword:Color = Color.RED
@export var color_member:Color = Color.YELLOW_GREEN
@export var color_member_var:Color = Color.AQUA

##Configure a [CodeHighlighter] with this spec's information.
func configure(highlight:CodeHighlighter = CodeHighlighter.new()) -> CodeHighlighter:
	for funcs:String in functions.keys():
		highlight.add_keyword_color(funcs, color_func)
	
	for sub_funcs:String in events:
		highlight.add_keyword_color(sub_funcs, color_func)
	
	for evals:String in math_shorthands.keys():
		highlight.add_keyword_color(evals, color_math)
	
	for members:String in engine_objects.keys():
		highlight.add_member_keyword_color(members, color_member)
	
	for each_variable:String in engine_variables:
		highlight.add_member_keyword_color(each_variable, color_member_var)
	
	for each_keyword:String in keywords:
		highlight.add_keyword_color(each_keyword, color_keyword)
	
	for global_aliases:String in aliases.keys():
		highlight.add_keyword_color(global_aliases, color_keyword)
	
	highlight.function_color = color_func
	highlight.member_variable_color = color_member_var
	highlight.number_color = color_math
	highlight.symbol_color = Color.WEB_GRAY
	
	return highlight
