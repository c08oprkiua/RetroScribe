extends RetroScriptCompilerBase
##A script compiler + text editor for RSDKv3 RetroScript
class_name RSDKv3ScriptCompiler
#region Enumerators

enum READMODE { 
	NORMAL = 0, 
	STRING = 1, 
	COMMENTLINE = 2, 
	ENDLINE = 3, 
	EOF = 4 
}

##Compiler parsing modes
enum PARSEMODE {
	##Parsing the script without scope
	SCOPELESS    = 0,
	##Skipping over platform specific code
	PLATFORMSKIP = 1,
	##Parsing a function
	FUNCTION     = 2,
	##Parsing a switch statement
	SWITCHREAD   = 3,
}

enum VAR {
	TEMPVALUE0,
	TEMPVALUE1,
	TEMPVALUE2,
	TEMPVALUE3,
	TEMPVALUE4,
	TEMPVALUE5,
	TEMPVALUE6,
	TEMPVALUE7,
	CHECKRESULT,
	ARRAYPOS0,
	ARRAYPOS1,
	GLOBAL,
	OBJECTENTITYNO,
	OBJECTTYPE,
	OBJECTPROPERTYVALUE,
	OBJECTXPOS,
	OBJECTYPOS,
	OBJECTIXPOS,
	OBJECTIYPOS,
	OBJECTSTATE,
	OBJECTROTATION,
	OBJECTSCALE,
	OBJECTPRIORITY,
	OBJECTDRAWORDER,
	OBJECTDIRECTION,
	OBJECTINKEFFECT,
	OBJECTALPHA,
	OBJECTFRAME,
	OBJECTANIMATION,
	OBJECTPREVANIMATION,
	OBJECTANIMATIONSPEED,
	OBJECTANIMATIONTIMER,
	OBJECTVALUE0,
	OBJECTVALUE1,
	OBJECTVALUE2,
	OBJECTVALUE3,
	OBJECTVALUE4,
	OBJECTVALUE5,
	OBJECTVALUE6,
	OBJECTVALUE7,
	OBJECTOUTOFBOUNDS,
	PLAYERSTATE,
	PLAYERCONTROLMODE,
	PLAYERCONTROLLOCK,
	PLAYERCOLLISIONMODE,
	PLAYERCOLLISIONPLANE,
	PLAYERXPOS,
	PLAYERYPOS,
	PLAYERIXPOS,
	PLAYERIYPOS,
	PLAYERSCREENXPOS,
	PLAYERSCREENYPOS,
	PLAYERSPEED,
	PLAYERXVELOCITY,
	PLAYERYVELOCITY,
	PLAYERGRAVITY,
	PLAYERANGLE,
	PLAYERSKIDDING,
	PLAYERPUSHING,
	PLAYERTRACKSCROLL,
	PLAYERUP,
	PLAYERDOWN,
	PLAYERLEFT,
	PLAYERRIGHT,
	PLAYERJUMPPRESS,
	PLAYERJUMPHOLD,
	PLAYERFOLLOWPLAYER1,
	PLAYERLOOKPOS,
	PLAYERWATER,
	PLAYERTOPSPEED,
	PLAYERACCELERATION,
	PLAYERDECELERATION,
	PLAYERAIRACCELERATION,
	PLAYERAIRDECELERATION,
	PLAYERGRAVITYSTRENGTH,
	PLAYERJUMPSTRENGTH,
	PLAYERJUMPCAP,
	PLAYERROLLINGACCELERATION,
	PLAYERROLLINGDECELERATION,
	PLAYERENTITYNO,
	PLAYERCOLLISIONLEFT,
	PLAYERCOLLISIONTOP,
	PLAYERCOLLISIONRIGHT,
	PLAYERCOLLISIONBOTTOM,
	PLAYERFLAILING,
	PLAYERTIMER,
	PLAYERTILECOLLISIONS,
	PLAYEROBJECTINTERACTION,
	PLAYERVISIBLE,
	PLAYERROTATION,
	PLAYERSCALE,
	PLAYERPRIORITY,
	PLAYERDRAWORDER,
	PLAYERDIRECTION,
	PLAYERINKEFFECT,
	PLAYERALPHA,
	PLAYERFRAME,
	PLAYERANIMATION,
	PLAYERPREVANIMATION,
	PLAYERANIMATIONSPEED,
	PLAYERANIMATIONTIMER,
	PLAYERVALUE0,
	PLAYERVALUE1,
	PLAYERVALUE2,
	PLAYERVALUE3,
	PLAYERVALUE4,
	PLAYERVALUE5,
	PLAYERVALUE6,
	PLAYERVALUE7,
	PLAYERVALUE8,
	PLAYERVALUE9,
	PLAYERVALUE10,
	PLAYERVALUE11,
	PLAYERVALUE12,
	PLAYERVALUE13,
	PLAYERVALUE14,
	PLAYERVALUE15,
	PLAYEROUTOFBOUNDS,
	STAGESTATE,
	STAGEACTIVELIST,
	STAGELISTPOS,
	STAGETIMEENABLED,
	STAGEMILLISECONDS,
	STAGESECONDS,
	STAGEMINUTES,
	STAGEACTNO,
	STAGEPAUSEENABLED,
	STAGELISTSIZE,
	STAGENEWXBOUNDARY1,
	STAGENEWXBOUNDARY2,
	STAGENEWYBOUNDARY1,
	STAGENEWYBOUNDARY2,
	STAGEXBOUNDARY1,
	STAGEXBOUNDARY2,
	STAGEYBOUNDARY1,
	STAGEYBOUNDARY2,
	STAGEDEFORMATIONDATA0,
	STAGEDEFORMATIONDATA1,
	STAGEDEFORMATIONDATA2,
	STAGEDEFORMATIONDATA3,
	STAGEWATERLEVEL,
	STAGEACTIVELAYER,
	STAGEMIDPOINT,
	STAGEPLAYERLISTPOS,
	STAGEACTIVEPLAYER,
	SCREENCAMERAENABLED,
	SCREENCAMERATARGET,
	SCREENCAMERASTYLE,
	SCREENDRAWLISTSIZE,
	SCREENCENTERX,
	SCREENCENTERY,
	SCREENXSIZE,
	SCREENYSIZE,
	SCREENXOFFSET,
	SCREENYOFFSET,
	SCREENSHAKEX,
	SCREENSHAKEY,
	SCREENADJUSTCAMERAY,
	TOUCHSCREENDOWN,
	TOUCHSCREENXPOS,
	TOUCHSCREENYPOS,
	MUSICVOLUME,
	MUSICCURRENTTRACK,
	KEYDOWNUP,
	KEYDOWNDOWN,
	KEYDOWNLEFT,
	KEYDOWNRIGHT,
	KEYDOWNBUTTONA,
	KEYDOWNBUTTONB,
	KEYDOWNBUTTONC,
	KEYDOWNSTART,
	KEYPRESSUP,
	KEYPRESSDOWN,
	KEYPRESSLEFT,
	KEYPRESSRIGHT,
	KEYPRESSBUTTONA,
	KEYPRESSBUTTONB,
	KEYPRESSBUTTONC,
	KEYPRESSSTART,
	MENU1SELECTION,
	MENU2SELECTION,
	TILELAYERXSIZE,
	TILELAYERYSIZE,
	TILELAYERTYPE,
	TILELAYERANGLE,
	TILELAYERXPOS,
	TILELAYERYPOS,
	TILELAYERZPOS,
	TILELAYERPARALLAXFACTOR,
	TILELAYERSCROLLSPEED,
	TILELAYERSCROLLPOS,
	TILELAYERDEFORMATIONOFFSET,
	TILELAYERDEFORMATIONOFFSETW,
	HPARALLAXPARALLAXFACTOR,
	HPARALLAXSCROLLSPEED,
	HPARALLAXSCROLLPOS,
	VPARALLAXPARALLAXFACTOR,
	VPARALLAXSCROLLSPEED,
	VPARALLAXSCROLLPOS,
	S_3DSCENENOVERTICES,
	S_3DSCENENOFACES,
	VERTEXBUFFERX,
	VERTEXBUFFERY,
	VERTEXBUFFERZ,
	VERTEXBUFFERU,
	VERTEXBUFFERV,
	FACEBUFFERA,
	FACEBUFFERB,
	FACEBUFFERC,
	FACEBUFFERD,
	FACEBUFFERFLAG,
	FACEBUFFERCOLOR,
	S_3DSCENEPROJECTIONX,
	S_3DSCENEPROJECTIONY,
	ENGINESTATE,
	STAGEDEBUGMODE,
	ENGINEMESSAGE,
	SAVERAM,
	ENGINELANGUAGE,
	OBJECTSPRITESHEET,
	ENGINEONLINEACTIVE,
	ENGINEFRAMESKIPTIMER,
	ENGINEFRAMESKIPSETTING,
	ENGINESFXVOLUME,
	ENGINEBGMVOLUME,
	ENGINEPLATFORMID,
	ENGINETRIALMODE,
	KEYPRESSANYSTART,
	ENGINEHAPTICSENABLED,
	MAX_CNT
}

enum BYTECODE_MODE {
	MOBILE,
	PC
}

enum ScriptSubs { 
	MAIN, 
	PLAYERINTERACTION, 
	DRAW, 
	SETUP 
}

enum SCRIPTVAR { 
	VAR = 1, 
	INTCONST = 2, 
	STRCONST = 3 
}

enum VARARR { 
	NONE = 0, 
	ARRAY = 1, 
	ENTNOPLUS1 = 2, 
	ENTNOMINUS1 = 3 
}

enum ScrFunction {
	END,
	EQUAL,
	ADD,
	SUB,
	INC,
	DEC,
	MUL,
	DIV,
	SHR,
	SHL,
	AND,
	OR,
	XOR,
	MOD,
	FLIPSIGN,
	CHECKEQUAL,
	CHECKGREATER,
	CHECKLOWER,
	CHECKNOTEQUAL,
	IFEQUAL,
	IFGREATER,
	IFGREATEROREQUAL,
	IFLOWER,
	IFLOWEROREQUAL,
	IFNOTEQUAL,
	ELSE,
	ENDIF,
	WEQUAL,
	WGREATER,
	WGREATEROREQUAL,
	WLOWER,
	WLOWEROREQUAL,
	WNOTEQUAL,
	LOOP,
	SWITCH,
	BREAK,
	ENDSWITCH,
	RAND,
	SIN,
	COS,
	SIN256,
	COS256,
	SINCHANGE,
	COSCHANGE,
	ATAN2,
	INTERPOLATE,
	INTERPOLATEXY,
	LOADSPRITESHEET,
	REMOVESPRITESHEET,
	DRAWSPRITE,
	DRAWSPRITEXY,
	DRAWSPRITESCREENXY,
	DRAWTINTRECT,
	DRAWNUMBERS,
	DRAWACTNAME,
	DRAWMENU,
	SPRITEFRAME,
	EDITFRAME,
	LOADPALETTE,
	ROTATEPALETTE,
	SETSCREENFADE,
	SETACTIVEPALETTE,
	SETPALETTEFADE,
	COPYPALETTE,
	CLEARSCREEN,
	DRAWSPRITEFX,
	DRAWSPRITESCREENFX,
	LOADANIMATION,
	SETUPMENU,
	ADDMENUENTRY,
	EDITMENUENTRY,
	LOADSTAGE,
	DRAWRECT,
	RESETOBJECTENTITY,
	PLAYEROBJECTCOLLISION,
	CREATETEMPOBJECT,
	BINDPLAYERTOOBJECT,
	PLAYERTILECOLLISION,
	PROCESSPLAYERCONTROL,
	PROCESSANIMATION,
	DRAWOBJECTANIMATION,
	DRAWPLAYERANIMATION,
	SETMUSICTRACK,
	PLAYMUSIC,
	STOPMUSIC,
	PLAYSFX,
	STOPSFX,
	SETSFXATTRIBUTES,
	OBJECTTILECOLLISION,
	OBJECTTILEGRIP,
	LOADVIDEO,
	NEXTVIDEOFRAME,
	PLAYSTAGESFX,
	STOPSTAGESFX,
	NOT,
	DRAW3DSCENE,
	SETIDENTITYMATRIX,
	MATRIXMULTIPLY,
	MATRIXTRANSLATEXYZ,
	MATRIXSCALEXYZ,
	MATRIXROTATEX,
	MATRIXROTATEY,
	MATRIXROTATEZ,
	MATRIXROTATEXYZ,
	TRANSFORMVERTICES,
	CALLFUNCTION,
	ENDFUNCTION,
	SETLAYERDEFORMATION,
	CHECKTOUCHRECT,
	GETTILELAYERENTRY,
	SETTILELAYERENTRY,
	GETBIT,
	SETBIT,
	PAUSEMUSIC,
	RESUMEMUSIC,
	CLEARDRAWLIST,
	ADDDRAWLISTENTITYREF,
	GETDRAWLISTENTITYREF,
	SETDRAWLISTENTITYREF,
	GET16X16TILEINFO,
	COPY16X16TILE,
	SET16X16TILEINFO,
	GETANIMATIONBYNAME,
	READSAVERAM,
	WRITESAVERAM,
	LOADTEXTFONT,
	LOADTEXTFILE,
	DRAWTEXT,
	GETTEXTINFO,
	GETVERSIONNUMBER,
	SETACHIEVEMENT,
	SETLEADERBOARD,
	LOADONLINEMENU,
	ENGINECALLBACK,
	HAPTICEFFECT,
	MAX_CNT
}

enum FLIP {
	NONE,
	X,
	Y,
	XY
}

enum INK {
	NONE,
	BLEND,
	ALPHA,
	ADD,
	SUB
}

enum COLLISION {
	TOUCH,
	BOX,
	BOX2,
	PLATFORM,
	BOX3,
	ENEMY
}

enum SIDES {
	FLOOR,
	LWALL,
	RWALL, 
	ROOF,
	ENTITY
}

enum MODE {
	FLOOR,
	LWALL,
	ROOF,
	RWALL
}

#endregion
#region consts

const COMMON_ALIAS_COUNT:int = 20
const ALIAS_COUNT:int = COMMON_ALIAS_COUNT + 96

const if_to_while:Dictionary = {
	&"IfEqual": &"WEqual",
	&"IfGreater": &"WGreater",
	&"IfGreaterOrEqual": &"WGreaterOrEqual",
	&"IfLower": &"WLower",
	&"IfLowerOrEqual": &"WLowerOrEqual",
	&"IfNotEqual": &"WNotEqual",
}



#endregion
#region Local Vars
var script_code:PackedInt32Array
var script_code_pos:int
var script_code_offset:int

var jump_table:PackedInt32Array
var jump_table_pos:int

var jump_table_stack:PackedInt32Array
var jump_table_stack_pos:int

var jump_table_offset:int
#endregion
#region Functions: Compiler

func check_alias_text(input_text:String) -> bool:
	if not input_text.contains("#alias"):
		return false
	
	if local_aliases.size() >= ALIAS_COUNT:
		add_warning(current_line, ParseWarn.ALIAS_LIMIT_REACHED)
		return false
	
	#delete all the spaces
	var formatted_text:String = input_text.trim_prefix("#alias").replacen(" ", "")
	
	var alias_info_array:PackedStringArray = formatted_text.split(":", true, 1)
	var alias_name:String = alias_info_array[1].get_slice("//", 0) #cull comments
	var alias_value:String = alias_info_array[0]
	
	retroscript_highlighter.add_keyword_color(alias_name, lang_db.color_member)
	
	local_aliases[alias_name] = alias_value
	
	return true

#convert_arithmatic_syntax
func convert_math_to_function(in_text:String) -> String:
	var token_string:String
	var token_id:StringName
	
	var out_string:String = in_text
	#This technically checks above modulus, which the original does not
	for operations:String in lang_db.math_shorthands.keys():
		if in_text.contains(operations):
			token_string = operations
			token_id = lang_db.math_shorthands.get(token_string)
	
	var operation_info:FunctionInfo = lang_db.functions.get(token_id, null)
	if token_id and is_instance_valid(operation_info) and operation_info.opcode_size < 3:
		var args:String
		args = in_text.replace(token_string, ", ")
		
		out_string = String(token_id) + "(" + args + ")"

	return out_string

func convert_if_while_statement(in_text:String) -> String:
	if in_text.begins_with("if") or in_text.begins_with("while"):
		var compare_op:StringName
		var op_pos:int
		
		for each_op:String in lang_db.math_shorthands.keys():
			if in_text.find(each_op) > -1:
				op_pos = in_text.find(each_op)
				compare_op = each_op
		
		if compare_op.is_empty():
			push_warning("Math operator for if/while statement ", in_text, " not found")
			return in_text
		
		var if_token:StringName = lang_db.math_shorthands.get(compare_op)
		var func_name:String
		
		var formatted_args:String = in_text.erase(op_pos, compare_op.length()).insert(op_pos, ",")
		
		if in_text.begins_with("while"):
			func_name = if_to_while.get(if_token)
			formatted_args = formatted_args.trim_prefix("while")
		else: #begins with if
			func_name = lang_db.math_shorthands.get(compare_op)
			formatted_args = formatted_args.trim_prefix("if")
		
		var out_string:String = func_name + "(" + formatted_args + ")"
		
		return out_string
	else:
		return in_text

func convert_switch_statement(in_text:String) -> String:
	if not in_text.begins_with("switch"):
		return ""
	
	var arg_count:String = str(jump_table_pos - jump_table_offset)
	var out_text:String = in_text.insert("switch".length(), "(" + arg_count + ",") + ")"
	
	print(out_text)
	return out_text

func compile_function(in_text:String) -> void:
	if not in_text.contains("("):
		print("Func err -1: ", in_text)
	var func_name:StringName = in_text.get_slice("(", 0)
	print("Func ", func_name)
	
	if not lang_db.functions.has(func_name):
		print("Func err: ", func_name)
		add_error(ParseError.FUNC_NOT_FOUND)
		return

func check_case_number(in_text:String) -> String:
	return in_text

func read_switch_case(in_text:String) -> bool:
	if in_text.begins_with("case"):
		return true
	elif in_text.begins_with("defualt"):
		return true
	return false

func copy_alias_string(in_text:String, array_index:bool) -> String:
	if array_index:
		var out_text:String
		if "[]".is_subsequence_of(in_text):
			var start_pos:int = in_text.find("[")
			var end_pos:int = in_text.find("]")
			out_text = in_text.erase(start_pos, end_pos - start_pos)
		
		return out_text
	else:
		return in_text

func parse_script_file(script_name:String, script_id:int) -> void:
	var script_path:String = "Data/Scripts/".path_join(script_name)
	
	if FileAccess.file_exists(script_path):
		
		#we commit hacky shenanigans
		text = FileAccess.get_file_as_string(script_path)
		
		parse_script_text()

func parse_script_text(start_line:int = 0, end_line:int = get_line_count()) -> void:
	var parse_mode:PARSEMODE = PARSEMODE.SCOPELESS
	var switch_deep:int = 0
	
	#Check start_line and end_line against a library of known function starts/stops, 
	#and adjust them to those lines, so that the whole function gets compiled (for safety)
	for known_function:FunctionInfo in local_functions.values():
		if start_line >= known_function.start_line and end_line <= known_function.end_line:
			print("Edit detected within function ", known_function.name)
			start_line = known_function.start_line
			end_line = known_function.end_line
			break
	
	for each_line:int in range(start_line, end_line):
		var line_string:String = get_line(each_line).dedent().replacen(" ", "")
		current_line = each_line
		
		if line_string.begins_with("//"):
			#skip comment lines
			continue
		else:
			#cull out comments in code lines
			line_string = line_string.get_slice("//", 0)
		
		#printt("Line", each_line, line_string, parse_mode)
		
		match parse_mode:
			PARSEMODE.SCOPELESS:
				#check for alias
				check_alias_text(line_string)
				
				#check for sub functions
				if line_string.begins_with("sub"):
					var trimmed_line:StringName = line_string.trim_prefix("sub"). replacen(" ", "")
					
					if lang_db.events.has(trimmed_line):
						parse_mode = PARSEMODE.FUNCTION
					else:
						add_error(ParseError.INVALID_SUB_FUNCTION)
					
					var new_sub:FunctionInfo = local_functions.get_or_add(trimmed_line, FunctionInfo.new())
					
					if new_sub.start_line != -1:
						add_error(ParseError.DUPLICATE_DEFINITION)
					new_sub.start_line = current_line
					
					local_functions[trimmed_line] = new_sub
					
					set_line_as_bookmarked(current_line, true)
					
					parse_mode = PARSEMODE.FUNCTION
				
				#function definitions
				elif line_string.begins_with("function"):
					#get just the function name
					var new_func_name:StringName = line_string.trim_prefix("function").replacen(" ", "")
					
					var declared_function:FunctionInfo = local_functions.get_or_add(new_func_name, FunctionInfo.new())
					if declared_function.start_line != -1:
						add_error(ParseError.DUPLICATE_DEFINITION)
					
					declared_function.start_line = current_line
					set_line_as_bookmarked(current_line, true)
					
					if not retroscript_highlighter.has_keyword_color(new_func_name):
						retroscript_highlighter.add_keyword_color(new_func_name, lang_db.color_func)
					
					local_functions[new_func_name] = declared_function
					parse_mode = PARSEMODE.FUNCTION
				#forward declarations of functions
				elif line_string.begins_with("#function"):
					var new_func_name:StringName = line_string.trim_prefix("#function")
					var new_function:FunctionInfo = local_functions.get_or_add(new_func_name, FunctionInfo.new())
					new_function.opcode_size = 0
					
					retroscript_highlighter.add_keyword_color(new_func_name, lang_db.color_func)
					local_functions[new_func_name] = new_function
			
			PARSEMODE.PLATFORMSKIP:
				if line_string.begins_with("#endplatform"):
					parse_mode = PARSEMODE.FUNCTION
			
			PARSEMODE.FUNCTION:
				
				if line_string.is_empty():
					continue
				elif line_string.contains("endsub"):
					#current_script.script_code[script_code_pos] = ScrFunction.END
					parse_mode = PARSEMODE.SCOPELESS
				elif line_string.contains("endfunction"):
					#current_script.script_code[script_code_pos] = ScrFunction.ENDFUNCTION
					parse_mode = PARSEMODE.SCOPELESS
				elif line_string.begins_with("#platform"):
					#TODO: actual platform checks
					parse_mode = PARSEMODE.PLATFORMSKIP
				elif not line_string.begins_with("#endplatform"):
					var processed_text:String
					if line_string.contains("if") or line_string.contains("while"):
						processed_text = convert_if_while_statement(line_string)
					
					if convert_switch_statement(processed_text):
						parse_mode = PARSEMODE.SWITCHREAD
						#info.read_pos = info.get_file_position()
						switch_deep = 0
					
					processed_text = convert_math_to_function(processed_text)
					
					if not read_switch_case(processed_text):
						compile_function(processed_text)
					
			PARSEMODE.SWITCHREAD:
				#TODO: String formatting to make this less strict
				if line_string.begins_with("switch"):
					switch_deep += 1
				
				if switch_deep:
					if line_string.begins_with("end switch"):
						switch_deep -= 1
				elif line_string.begins_with("end switch"):
					parse_mode = PARSEMODE.FUNCTION
				else:
					check_case_number(line_string)
			_:
				continue
#endregion
