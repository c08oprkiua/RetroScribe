@tool
extends EditorScript

class_name AutomationInator

var path:String = "res://retroscript/specs/RSDKv3.tres"

func _run() -> void:
	var rsdk = load(path)
	ResourceSaver.save(rsdk, path)
