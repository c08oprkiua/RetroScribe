extends Resource

class_name VarInfo

enum Access {
	NONE,
	LOCAL,
	GLOBAL,
};


##The name of the variable
@export var name:StringName
##The type of this variable. Uses Variant.type. 
##Tables are arrays
@export var type:Variant.Type
##The access level of this variable.
@export var access:Access
##The value of the variable.
@export var value:int
##If this variable is part of enum, this value is the name of the enum it belongs to.
@export var enum_parent:StringName
##The description of the variable.
@export_multiline var description:String
