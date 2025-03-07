@tool
class_name FUIEditorPlugin
extends EditorPlugin


func _enter_tree() -> void:
	if not ProjectSettings.has_setting(FUIConsts.INITIAL_PATH_SETTING):
		ProjectSettings.set_setting(FUIConsts.INITIAL_PATH_SETTING, "")
	ProjectSettings.set_initial_value(FUIConsts.INITIAL_PATH_SETTING, "")
	ProjectSettings.set_as_basic(FUIConsts.INITIAL_PATH_SETTING, true)
	ProjectSettings.add_property_info({
			"name": FUIConsts.INITIAL_PATH_SETTING,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_FILE,
			"hint_string": "*.tscn,*.scn"
	})
	if not ProjectSettings.has_setting(FUIConsts.INITIAL_KEY_SETTING):
		ProjectSettings.set_setting(FUIConsts.INITIAL_KEY_SETTING, "")
	ProjectSettings.set_initial_value(FUIConsts.INITIAL_KEY_SETTING, "")
	ProjectSettings.set_as_basic(FUIConsts.INITIAL_KEY_SETTING, true)
	ProjectSettings.add_property_info({
			"name": FUIConsts.INITIAL_KEY_SETTING,
			"type": TYPE_STRING,
	})
	if not ProjectSettings.has_setting(FUIConsts.UI_AUDIO_BUS_NAME):
		ProjectSettings.set_setting(FUIConsts.UI_AUDIO_BUS_NAME, "Sounds")
	ProjectSettings.set_initial_value(FUIConsts.UI_AUDIO_BUS_NAME, "Sounds")
	ProjectSettings.set_as_basic(FUIConsts.UI_AUDIO_BUS_NAME, true)
	ProjectSettings.add_property_info({
			"name": FUIConsts.UI_AUDIO_BUS_NAME,
			"type": TYPE_STRING,
	})
	if not ProjectSettings.has_setting(FUIConsts.LASY_LOAD_SETTING):
		ProjectSettings.set_setting(FUIConsts.LASY_LOAD_SETTING, true)
	ProjectSettings.set_initial_value(FUIConsts.LASY_LOAD_SETTING, true)
	ProjectSettings.set_as_basic(FUIConsts.LASY_LOAD_SETTING, true)
	ProjectSettings.add_property_info({
			"name": FUIConsts.LASY_LOAD_SETTING,
			"type": TYPE_BOOL,
	})
	add_autoload_singleton("FUIManager", "./nodes/ui_manager.tscn")


func _exit_tree() -> void:
	remove_autoload_singleton("FUIManager")
