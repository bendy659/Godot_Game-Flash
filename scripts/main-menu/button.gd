extends Button

var exit_origin_pos: Vector2
var is_exit: bool = false

func _ready() -> void:
	if name == "exit": exit_origin_pos = position
	
	Signals.language_change.connect(_on_game_language_change)

func _physics_process(delta: float) -> void:
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
	
	if button_pressed:
		match name:
			"start-game":
				pass
			"settings":
				disabled = true
				GameSettings.open()
				disabled = false
			"exit":
				disabled = true
				var dialogue_box_context: Array[DialogueBox.DialogueContext] = []
				
				var dials = Languages.translate_array("dialogues.main_menu.button_leave")
				for i in dials:
					dialogue_box_context += [DialogueBox.DialogueContext.new(i)]
				
				print_debug("%s\n%s" % [dials, dialogue_box_context])
				
				DialogueBox.create(dialogue_box_context)
				disabled = false

func _on_game_language_change(index: int) -> void:
	text = Languages.translate_label("main_menu.buttons."+name)
