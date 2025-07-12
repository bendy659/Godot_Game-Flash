extends Node3D

@onready var water_wave_anim = $animations

func _ready() -> void:
	water_wave_anim.play("wave")
	GameData.is_game_pause = false
