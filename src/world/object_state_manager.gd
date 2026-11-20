extends Node2D
class_name ObjectStateManager

var removed_objects := {}

func remove(object_id: StringName):
	removed_objects[object_id] = true

func should_remove(object_id: StringName):
	return removed_objects.has(object_id)
