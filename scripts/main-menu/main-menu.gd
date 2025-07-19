extends Control

@onready var menu = $menu
@onready var background = $menu/background
@onready var anims = $animations
@onready var canvas_layer = $canvas

@onready var music_bg = $music_bg

var scroll_speed := 10

func _ready() -> void:
	DialogueBox.canvas_layer = canvas_layer
	GameSettings.canvas_layer = canvas_layer
	
	menu.modulate = Color(1, 1, 1, 0)
	await get_tree().create_timer(3.0).timeout
	
	anims.play("enter")
	
	GameSettings.add_stream("music", [music_bg])
func _process(delta: float) -> void:
	background.texture.noise.offset += Vector3(delta * scroll_speed, delta * scroll_speed, delta * scroll_speed)
