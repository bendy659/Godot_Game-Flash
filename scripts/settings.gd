extends Control

## УПРАВЛЕНИЕ
@onready var mouse_senc_val: HSlider = $"margin/control/panel/tab_container/УПРАВЛЕНИЕ/margin/v_box_container/mouse_senc/slider"
@onready var mouse_senc_lab: Label = $"margin/control/panel/tab_container/УПРАВЛЕНИЕ/margin/v_box_container/mouse_senc/value"

## ЗВУКИ
@onready var general_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/general_volume/slider"
@onready var general_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/general_volume/value"

@onready var music_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/music_volume/slider"
@onready var music_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/music_volume/value"

@onready var env_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/env_volume/slider"
@onready var env_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/env_volume/value"

@onready var ui_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/ui_volume/slider"
@onready var ui_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/ui_volume/value"

@onready var sfx_val: HSlider = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/sfx_volume/slider"
@onready var sfx_lab: Label = $"margin/control/panel/tab_container/ЗВУКИ/margin/v_box_container/sfx_volume/value"

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
