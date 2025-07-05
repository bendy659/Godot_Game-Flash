extends Control

@onready var menu = $menu
@onready var background = $menu/background
@onready var anims = $animations

var scroll_speed := 10

func _ready() -> void:
	menu.modulate = Color(1, 1, 1, 0)
	await get_tree().create_timer(3.0).timeout
	anims.play("enter")

func _process(delta: float) -> void:
	background.texture.noise.offset += Vector3(delta * scroll_speed, delta * scroll_speed, delta * scroll_speed)
