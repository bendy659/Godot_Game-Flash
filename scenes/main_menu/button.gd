extends Button

var exit_origin_pos: Vector2
var is_exit: bool = false

func _ready() -> void:
	if name == "exit": exit_origin_pos = position

func _physics_process(delta: float) -> void:
	if button_pressed:
		print_debug("Кнопка " + name + " - нажата!")
	
	if is_hovered():
		scale = lerp(scale, Vector2(1.25, 1.25), delta * 10)
	else:
		scale = lerp(scale, Vector2(1, 1), delta * 10)
		
	if is_hovered() && name == "exit":
		position = lerp(
			exit_origin_pos,
			Vector2(
				exit_origin_pos.x + (20 * randf_range(-1, 1)),
				exit_origin_pos.y + (20 * randf_range(-1, 1))
			),
			delta * 10
		)
	elif !is_hovered() && name == "exit":
		position = lerp(position, exit_origin_pos, delta * 10)
	
	match name:
		"start-game":
			pass
		"settings":
			pass
		"exit":
			pass
