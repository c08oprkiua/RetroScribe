extends Resource

class_name FunctionInfo

@export var opcode_size:int = -1

@export var start_line:int = -1
@export var end_line:int = -1
@export var opcode:int = -1

@export_multiline var description:String

func _init(size:int = 0, op:int = 0) -> void:
	opcode_size = size
	opcode = op
