@tool
extends EditorScript

class_name AutomationInator

var path:String = "res://retroscript/specs/RSDKv4.tres"

const paste:PackedStringArray = [
	"temp0",
	"temp1",
	"temp2",
	"temp3",
	"temp4",
	"temp5",
	"temp6",
	"temp7",
	"checkResult",
	"arrayPos0",
	"arrayPos1",
	"arrayPos2",
	"arrayPos3",
	"arrayPos4",
	"arrayPos5",
	"arrayPos6",
	"arrayPos7",
]


#const variable_names:PackedStringArray = []

func _run() -> void:
	var rsdk = load(path)
	
	#for vars:String in variable_names:
		#var split:PackedStringArray = vars.split(".")
		#var obj_name:StringName = StringName(split[0])
		#var obj_var:StringName = StringName(split[1])
		#
		#var this_obj:ObjectInfo = rsdk.engine_objects.get_or_add(obj_name, ObjectInfo.new())
		#
		#this_obj.variables[obj_var] = VarInfo.new()
	
	ResourceSaver.save(rsdk, path)
