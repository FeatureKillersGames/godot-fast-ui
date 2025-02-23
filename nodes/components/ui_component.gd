@tool
class_name FUIComponent
extends Node

enum Action {
	OPEN_SCREEN,
	PREVIOUS_SCREEN,
	CLOSE_SCREEN,
}

@export var instigator: Node
@export var signal_name: String = "ready"
@export var action: Action = Action.OPEN_SCREEN :
	set(value):
		action = value
		notify_property_list_changed()
var path: String = "" :
	set(value):
		path = value
		if path.begins_with("uid://"):
			key = ResourceUID.get_id_path(
				ResourceUID.text_to_id(path)
			).get_file().get_basename()
		else:
			key = path.get_file().get_basename()
		
var key: String = ""
var on_top: bool = false
var reversable: bool = false
var all_layers: bool = false
var all_visible: bool = false

func _ready() -> void:
	if not FUIManager:
		queue_free()
		return
	if not instigator:
		instigator = get_parent()
	if Engine.is_editor_hint():
		return
	if not instigator.has_signal(signal_name):
		return
	match action:
		Action.OPEN_SCREEN:
			instigator.connect(signal_name, func() -> void:
					FUIManager.open_screen(
						key, path, on_top, reversable)
			)
		Action.CLOSE_SCREEN:
			instigator.connect(signal_name, func() -> void:
					FUIManager.close_screen(
						key, reversable, all_visible)
			)
		Action.PREVIOUS_SCREEN:
			instigator.connect(signal_name, func() -> void:
					FUIManager.previous_screen(all_layers)
			)


func _get_property_list() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	match action:
		Action.OPEN_SCREEN:
			result.append({
				"name": "path",
				"type": TYPE_STRING,
				"hint": PROPERTY_HINT_FILE,
				"hint_string": "*.tscn,*.scn",
			})
			result.append({
				"name": "key",
				"type": TYPE_STRING,
			})
			result.append({
				"name": "on_top",
				"type": TYPE_BOOL,
		})
			result.append({
				"name": "reversable",
				"type": TYPE_BOOL,
			})
		Action.PREVIOUS_SCREEN:
			result.append({
				"name": "all_layers",
				"type": TYPE_BOOL,
			})
		Action.CLOSE_SCREEN:
			result.append({
				"name": "key",
				"type": TYPE_STRING,
			})
			result.append({
				"name": "reversable",
				"type": TYPE_BOOL,
			})
			result.append({
				"name": "all_visible",
				"type": TYPE_BOOL,
			})

	return result
