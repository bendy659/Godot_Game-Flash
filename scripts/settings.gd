extends Control

## ОБЩЕЕ
@onready var lang_val: OptionButton = $"margin/control/panel/tab_container/ОБЩЕЕ/margin/v_box_container/center/language/value"

## УПРАВЛЕНИЕ
@onready var mouse_senc_val: HSlider = $"margin/control/panel/tab_container/УПРАВЛЕНИЕ/margin/v_box_container/center/mouse_senc/slider"
@onready var mouse_senc_lab: Label = $"margin/control/panel/tab_container/УПРАВЛЕНИЕ/margin/v_box_container/center/mouse_senc/value"

## ЗВУКИ
@onready var general_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center/general_volume/slider"
@onready var general_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center/general_volume/value"

@onready var music_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-2/music_volume/slider"
@onready var music_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-2/music_volume/value"

@onready var env_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-3/env_volume/slider"
@onready var env_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-3/env_volume/value"

@onready var ui_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-4/ui_volume/slider"
@onready var ui_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-4/ui_volume/value"

@onready var sfx_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-5/sfx_volume/slider"
@onready var sfx_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-5/sfx_volume/value"

@onready var mute_music_val: HSlider = null
@onready var mute_music_lab: Label = null

## ГРАФИКА
# NOTHING

## ====

## УПРАВЛЕНИЕ
var mouse_senc: float = GameSettings.mouse_senc

## ЗВУКИ
var general_vol: float = GameSettings.get_volume("general")
var music_vol: float = GameSettings.get_volume("music")
var env_vol: float = GameSettings.get_volume("env")
var ui_vol: float = GameSettings.get_volume("ui")
var sfx_vol: float = GameSettings.get_volume("sfx")

## ГРАФИКА
# NOTHING

## ====

@onready var tab_container: TabContainer = $margin/control/panel/tab_container
var signals: Signals = Signals

## Init
func _ready() -> void:
	mouse_senc_val.value = mouse_senc
	## ====
	general_val.value = general_vol
	music_val.value = music_vol
	env_val.value = env_vol
	ui_val.value = ui_vol
	sfx_val.value = sfx_vol
	#mute_music_val.value = mute_music_vol
	
	## Add langs & select
	for i in range(GameData.langs.size()):
		var id = GameData.langs[i]["id"]
		var icon = "res://textures/icons/langs/%s.png" % id
		lang_val.add_icon_item(
			load(icon),
			GameData.langs[i]["name"],
			i
		)
		if GameSettings.language == id:
			lang_val.select(i)
			signals.language_change.emit(i)
	
	## Connect signals
	signals.language_change.connect(_on_game_language_change)
	

func _on_exit_pressed() -> void:
	GameSettings.close()

func _on_save_pressed() -> void:
	## УПРАВЛЕНИЕ
	GameSettings.mouse_senc = mouse_senc
	
	## ЗВУКИ
	GameSettings.set_volume("general", general_vol)
	GameSettings.set_volume("music", music_vol)
	GameSettings.set_volume("env", env_vol)
	GameSettings.set_volume("ui", ui_vol)
	GameSettings.set_volume("sfx", sfx_vol)
	
	GameSettings.update_volumes()

## === [ ОБЩЕЕ ] ===

func _on_language_selected(index: int) -> void:
	GameSettings.language = GameData.langs[index]["id"]
	signals.language_change.emit(index)
	print_debug("Current language: %s" % GameSettings.language)


## === [ УПРАВЛЕНИЕ ] ===

func _on_mouse_senc_changed(value: float) -> void:
	mouse_senc = value
	mouse_senc_lab.text = str(int(value * 100)) + "%"

## === [ ЗВУКИ ] ===

func _on_general_volume_changed(value: float) -> void:
	general_vol = value
	general_lab.text = str(int(value * 100)) + "%"

func _on_music_volume_changed(value: float) -> void:
	music_vol = value
	music_lab.text = str(int(value * 100)) + "%"

func _on_env_volume_changed(value: float) -> void:
	env_vol = value
	env_lab.text = str(int(value * 100)) + "%"

func _on_ui_volume_changed(value: float) -> void:
	ui_vol = value
	ui_lab.text = str(int(value * 100)) + "%"

func _on_sfx_volume_changed(value: float) -> void:
	sfx_vol = value
	sfx_lab.text = str(int(value * 100)) + "%"

## ====

func _on_game_language_change(index: int):
	var lang = GameSettings.language
	
	var tabs = [
		{
			"panel": $"margin/control/panel/tab_container/ОБЩЕЕ",
			"id": "main_menu.tabs.general"
		},
		{
			"panel": $"margin/control/panel/tab_container/УПРАВЛЕНИЕ",
			"id": "main_menu.tabs.control"
		},
		{
			"panel": $"margin/control/panel/tab_container/ЗВУКИ",
			"id": "main_menu.tabs.sounds"
		},
		{
			"panel": $"margin/control/panel/tab_container/ГРАФИКА",
			"id": "main_menu.tabs.graphics"
		}
	]
	var texts = [
		{
			"label": $"margin/control/panel/tab_container/ОБЩЕЕ/margin/v_box_container/center/language/name",
			"id": "main_menu.tabs.general.language"
		},
		{
			"label": $"margin/control/panel/tab_container/УПРАВЛЕНИЕ/margin/v_box_container/center/mouse_senc/name",
			"id": "main_menu.tabs.control.mouse_senc.name"
		},
		{
			"label": $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center/general_volume/name",
			"id": "main_menu.tabs.sounds.general.name"
		},
		{
			"label": $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-2/music_volume/name",
			"id": "main_menu.tabs.sounds.music.name"
		},
		{
			"label": $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-3/env_volume/name",
			"id": "main_menu.tabs.sounds.env.name"
		},
		{
			"label": $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-4/ui_volume/name",
			"id": "main_menu.tabs.sounds.ui.name"
		},
		{
			"label": $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/center-5/sfx_volume/name",
			"id": "main_menu.tabs.sounds.sfx.name"
		}
	]
	
	## ----
	
	for i in range(tabs.size()):
		tab_container.set_tab_title(
			i,
			Languages.translate_label(tabs[i]["id"])
		)
	
	for text in texts:
		text["label"].text = Languages.translate_label(text["id"])
