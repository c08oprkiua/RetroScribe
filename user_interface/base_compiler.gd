extends CodeEdit

class_name RetroScriptCompilerBase

##Different kinds of script parsing errors. Errors are anything that will either not
##compile, or will cause severe issues if compiled.
enum ParseError {
	##A function was defined as sub, but is not a valid sub function.
	INVALID_SUB_FUNCTION,
	##A function was declared, but never defined.
	DEFINITION_NOT_FOUND,
	##A function with this name has already been defined
	DUPLICATE_DEFINITION,
	##A function failed to compile
	FUNC_COMPILE_FAILED,
	##A function was used that is not defined in the current scope
	FUNC_NOT_FOUND,
	
	ERROR_UNKNOWN
}

##Different kinds of script parsing warnings. Warnings are for things that
##won't hurt compilation, but are likely unintended by the programmer, and could
##cause discrepencies between what's compiled and the behavior the programmer expects.
enum ParseWarn {
	##An alias or function was declared twice.
	DUPLICATE_DECLARATION,
	##The alias limit for compiling within actual RSDKv3 has been reached. This will
	##not be an issue if you compile the script before using it in RSDKv3.
	ALIAS_LIMIT_REACHED,
	
	WARN_UNKNOWN
}

##Emitted when the compiler has parsed and updated its info.
signal compiler_info_updated

class LogError:
	extends Resource
	var type:ParseError
	var error_text:String
	var line:int

class LogWarn:
	extends Resource
	var type:ParseWarn
	var error_text:String
	var line:int

var errors:Array[LogError]
var warnings:Array[LogWarn]

var current_line:int

var lang_db:RetroScriptSpec = RetroScriptSpec.new()

var retroscript_highlighter:CodeHighlighter = CodeHighlighter.new()

func add_warning(line:int, warn_type:int) -> void:
	match warn_type:
		_:
			push_warning("Warning for something on line ", line)

func add_error(error_type:int, line:int = current_line) -> void:
	var new_err:LogError = LogError.new()
	new_err.type = error_type as ParseError
	new_err.line = line
	match error_type:
		ParseError.INVALID_SUB_FUNCTION:
			new_err.error_text = "The sub function on line " + str(line) + " is not a recognized sub function"
		ParseError.FUNC_COMPILE_FAILED:
			new_err.error_text = "The function on line " + str(line) + " failed to compile"
		ParseError.DUPLICATE_DEFINITION:
			new_err.error_text = "The function on line " + str(line) + " shares its name with an already made function"
		ParseError.FUNC_NOT_FOUND:
			new_err.error_text = "The function on line " + str(line) + " could not be found as a valid builtin function"
		_:
			new_err.error_text = "No description implemented for error on line " + str(line) + " with error number " + str(error_type)
	push_error(new_err.error_text)

@warning_ignore("unused_parameter")
func parse_script_text(start_line:int = 0, end_line:int = get_line_count()) -> void:
	print("Please redefine this function in a derived class")

##Sets up all the syntax detection for constants and builtins
func setup_retroscript_editor() -> void:
	if not is_connected("lines_edited_from", when_lines_edited):
		connect("lines_edited_from", when_lines_edited)
	
	retroscript_highlighter = CodeHighlighter.new()
	
	lang_db.configure(retroscript_highlighter)
	
	if not has_comment_delimiter("/"):
		add_comment_delimiter("/", "")
	
	parse_script_text()
	syntax_highlighter = retroscript_highlighter
	compiler_info_updated.emit()

func when_lines_edited(from_line:int, to_line:int) -> void:
	parse_script_text(from_line, to_line)
	syntax_highlighter = retroscript_highlighter
	compiler_info_updated.emit()
