extends Resource

class_name FunctionInfo

@export var opcode_size:int = -1

##Local functions: Where the function starts in the script
@export var start_line:int = -1
##Local functions: Where the function ends in the script
@export var end_line:int = -1
##The function's opcode
@export var opcode:int = -1
##The documentation description of the function
@export_multiline var description:String

func _init(size:int = 0, op:int = 0) -> void:
	opcode_size = size
	opcode = op
