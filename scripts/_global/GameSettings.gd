extends Node

var canvas_layer: CanvasLayer

## ОБЩЕЕ
var language: String = "ru"
var debug_mode: bool = false

## УПРАВЛЕНИЕ
var mouse_senc: float = 1.0

## ЗВУКИ
var sounds_categories: Array[Dictionary] = [
	{ "category": "general", "volume": 1.0, "streams": null },
	{ "category": "music", "volume": 1.0, "streams": [] },
	{ "category": "env", "volume": 1.0, "streams": [] },
	{ "category": "ui", "volume": 1.0, "streams": [] },
	{ "category": "sfx", "volume": 1.0, "streams": [] }
]

var mute_music_in_menus: bool = false
var mute_music_volume: float = 0.35

## ГРАФИКА
var pixelization: int = 4

## ====

var setting_menu: Control = null
var settings_menu_is_opened: bool = false

### === [ Main ] ===
var menu: Node = null
var menu_bg: TextureRect
var menu_anim: AnimationPlayer
var exit: TextureButton

func _process(delta: float) -> void:
	if menu_bg:
		menu_bg.texture.noise.offset += Vector3(
			delta * 10,
			delta * -10,
			delta * 10
		)

## === [ Sound's ] ===
func get_volume(category: String) -> float:
	for finded in sounds_categories:
		if finded["category"] == category:
			return finded["volume"]
	return 1.0

func set_volume(category: String, n_volume: float) -> void:
	for finded in sounds_categories:
		if finded["category"] == category:
			finded["volume"] = n_volume

func add_stream(category: String, streams: Array[AudioStreamPlayer]) -> void:
	for finded in sounds_categories:
		if finded["category"] == category:
			finded["streams"] += streams

func clear_streams(category: String) -> void:
	for finded in sounds_categories:
		if finded["category"] == category:
			finded["streams"] = []

func update_volumes() -> void:
	for category in sounds_categories:
		var category_volume = get_volume(category["category"])
		
		if category["streams"] != null:
			for stream in category["streams"]:
				(stream as AudioStreamPlayer).volume_db = linear_to_db(
					1.0 * category_volume * get_volume("general")
				)

## === [ Menu ] ===
func open() -> void:
	if settings_menu_is_opened: return
	
	settings_menu_is_opened = true
	
	## Add child to canvas layer
	if !menu:
		var settings_menu_scene = preload("res://scenes/main_menu/settings.tscn")
		menu = settings_menu_scene.instantiate()
	
	canvas_layer.add_child(menu)
	
	menu_bg = menu.get_node("background/texture_rect") as TextureRect
	menu_anim = menu.get_node("animations") as AnimationPlayer
	exit = menu.get_node("margin/control/exit")
	
	menu_anim.play("show")

func close() -> void:
	if !settings_menu_is_opened: return
	
	menu_anim.play_backwards("show")
	await get_tree().create_timer(1).timeout
	
	canvas_layer.remove_child(menu)
	
	settings_menu_is_opened = false
