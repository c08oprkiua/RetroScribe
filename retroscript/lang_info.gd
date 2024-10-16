extends Resource

class_name RetroScriptSpec

@export var alias_max_count:int

@export var keywords:PackedStringArray

@export var sub_functions:Dictionary[StringName, FunctionInfo]

@export var aliases:Dictionary[String, String]

func make_syntax_highlighter() -> CodeHighlighter:
	return CodeHighlighter.new()
