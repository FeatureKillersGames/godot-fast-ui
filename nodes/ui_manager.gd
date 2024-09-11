extends Node

@onready var active: CanvasLayer = $Active
@onready var pool: CanvasLayer = $Pool

var log: Array = []


func _ready() -> void:
	if "--server" in OS.get_cmdline_args():
		queue_free()
		return
	var path: String = ProjectSettings.get_setting(
			FUIEditorPlugin.INITIAL_PATH_SETTING, ""
	)
	var key: String = ProjectSettings.get_setting(
			FUIEditorPlugin.INITIAL_KEY_SETTING, ""
	)
	if not path:
		return
	if not key:
		key = "InitialScreen"
	var screen: Control = load(path).instantiate()
	screen.name = key
	active.add_child(screen)


func open_screen(
		key: String = "",
		path: String = "",
		on_top: bool = false,
		reversable: bool = false
) -> Control:
	if not on_top:
		if reversable:
			if get_child_count():
				log.push_back(active.get_children())
		else:
			log = []
		for i:Node in active.get_children():
			i.reparent(pool)
	var screen: Control = active.get_node_or_null(key)
	if screen:
		push_warning(key, " widget allready on screen")
		return screen
	screen = pool.get_node_or_null(key)
	if screen:
		screen.reparent(active)
		return screen
	if not path:
		return screen
	screen = load(path).instantiate()
	if key:
		screen.name = key
	active.add_child(screen)
	return screen


func previous_screen(all_layers: bool = false) -> void:
	if all_layers:
		for i:Node in active.get_children():
			i.reparent(pool)
	else:
		var node: Node = active.get_child(0)
		if node:
			node.reparent(pool)
	if active.get_child_count():
		return
	if not log:
		return
	for i:Node in log.pop_back():
		i.reparent(active)


func close_screen(
	key: String,
	reversable: bool = false,
	all_visible: bool = false,
) -> void:
	if all_visible:
		if reversable:
			if get_child_count():
				log.push_back(active.get_children())
		else:
			log = []
		for i:Node in active.get_children():
			i.reparent(pool)
		return
	if key:
		var node: Node = active.get_node_or_null(key)
		if not node:
			return
		if reversable and active.get_child_count() == 1:
			if get_child_count():
				log.push_back(active.get_children())
		node.reparent(pool)


func get_screen(key: String) -> Control:
	var screen: Control = active.get_node_or_null(key)
	if screen:
		return screen
	screen = pool.get_node_or_null(key)
	if screen:
		screen.reparent(active)
		return screen
	return screen