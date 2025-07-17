extends Node

var canvas_layer: CanvasLayer

class DialogueContext:
	var text: String
	var char_time: int
	
	func _init(
		text: String,
		char_time: int = 250
	) -> void:
		self.text = text
		self.char_time = char_time

var lines: Array[DialogueContext] = []
var line_text: String = ""
var is_line_ended: bool = false
var to_next_line: bool = false
var dialogue_is_opened: bool = false

### === [ Dialogue box function's ] ===

func create(
	text_lines: Array[DialogueContext]
) -> void:
	if dialogue_is_opened: return
	
	dialogue_is_opened = true
	
	## Add child node to parent
	var dialogue_box_scene = load("res://scenes/dialogue_box.tscn")
	var dialogue_box = dialogue_box_scene.instantiate()
	canvas_layer.add_child(dialogue_box)
	
	dialogue_box
	
	## Init dialogue
	lines = text_lines
	var text_label = (
		dialogue_box.get_node(
			"margin/dialogue-plate/plate-outline/margin/plate-background/margin/text"
			)
	) as Label
	
	var name_node = (
		dialogue_box.get_node(
			"margin/dialogue-plate/plate-outline/margin/plate-background/margin/name"
		)
	)
	
	var icon_node = (
		dialogue_box.get_node(
		"margin/dialogue-plate/plate-outline/margin/plate-background/char-icon"
		)
	) as TextureRect
	
	var space_icon = (
		dialogue_box.get_node(
			"margin/dialogue-plate/plate-outline/margin/plate-background/key-space"
		)
	) as TextureRect
	
	var space_pressed_icon = (
		dialogue_box.get_node(
			"margin/dialogue-plate/plate-outline/margin/plate-background/key-space/key-space-pressed"
		)
	) as TextureRect
	
	var anim = (
		dialogue_box.get_node("animation")
	) as AnimationPlayer
	
	var sfx = (
		dialogue_box.get_node("char-sfx")
	) as AudioStreamPlayer
	
	GameSettings.add_stream("sfx", [sfx])
	
	## Dialoging
	anim.play("show")
	
	sfx.volume_db = linear_to_db(GameSettings.get_volume("sfx"))
	
	for line in lines:
		var parser_line = parse_line(line.text)
		
		var text_line = parser_line["text_line"]
		var char_name = parser_line["character_name"]
		var char_emote = parser_line["character_emote"]
		
		var char_icon = load("res://textures/icons/chars/"+char_emote+".png")
		
		icon_node.texture = char_icon
		name_node.text = "["+Languages.translate_label("names."+char_name)+"]"
		
		to_next_line = false
		line_text = "\n"
		space_icon.visible = false
		space_pressed_icon.visible = false
		
		for chr in text_line:
			if chr != " ": sfx.play()
			
			line_text += chr
			text_label.text = line_text
			await get_tree().create_timer(line.char_time / 1000).timeout
		
		space_icon.visible = true
		await wait_for_next_line(space_pressed_icon)
	
	## Remove dialog box
	anim.play_backwards("show")
	await get_tree().create_timer(1).timeout
	
	canvas_layer.remove_child(dialogue_box)
	dialogue_is_opened = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Next_dialogue"):
		pass

func wait_for_next_line(but_pressed: TextureRect) -> void:
	while !to_next_line:
		await get_tree().process_frame
		if Input.is_action_pressed("Next_dialogue"):
			but_pressed.visible = true
		elif Input.is_action_just_released("Next_dialogue"):
			to_next_line = true
		else:
			but_pressed.visible = false

func parse_line(itext: String) -> Dictionary:
	var result = {
		"character_name": "Not found",
		"character_emote": "not_found",
		"text_line": itext,
		"translate_name": true
	}
	
	var regex = RegEx.new()
	regex.compile("\\[(.*?)\\:(.*?)\\]")
	
	var finded = regex.search(itext)
	if finded:
		result["character_name"] = finded.get_string(1)
		result["character_emote"] = finded.get_string(1) + "/" + finded.get_string(2)
		result["text_line"] = itext.substr(finded.get_end())
	else:
		print_debug("Parsing error. Notfound format [name:emote] in line: ", itext)
	
	return result
