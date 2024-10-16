extends Resource

class_name VarInfo
##The name of the variable
@export var name:StringName
##The value of the variable.
@export var value:int
##If this variable is part of enum, this value is the name of the enum it belongs to.
@export var enum_parent:StringName
##The description of the variable.
@export_multiline var description:String
