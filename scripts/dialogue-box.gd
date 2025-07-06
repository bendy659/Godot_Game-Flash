extends Control

@onready var char_icon = $"margin/dialogue-plate/plate-outline/margin/plate-background/char-icon"
@onready var text = $"margin/dialogue-plate/plate-outline/margin/plate-background/margin/text"
@onready var space_key = $"margin/dialogue-plate/plate-outline/margin/plate-background/key-space"
@onready var space_key_pressed = $"margin/dialogue-plate/plate-outline/margin/plate-background/key-space/key-space-pressed"
@onready var anim = $animation

var example_text: Array = [
	{
		"text": "example test xds. bla-bla-bla-ble-ble-ble dfc df d dsf sd sg s g sg dsgdsg fsd gsdg sdg sdg g fdghb dfg h fgh fgh brfgd b45 h 465tjh 65j h65jh 54e 6h g5234h 45th 24jh 42 jh4 5 45h h 465  j 65 y45 hy54h 654 67o  867o k 785 j5 jh54 h534 6 j 56kj 45 k 7uk 467j h5 h5 6j675 jkm 46 k7 k 4 u675 jn 5 j r23f432.",
		"char-time": 250
	},
	{
		"text": "Hello from dialogue box XD2",
		"char-time": 250
	}
]
var current_text: String = ""
var is_line_end: bool = false
var to_next: bool = false

func _ready() -> void:
	anim.play("show")
	
	for line in example_text:
		space_key.visible = false
		space_key_pressed.visible = false
		is_line_end = false
		to_next = false
		
		var line_text = line["text"]
		var char_time = line["char-time"]
		
		for chr in line_text:
			current_text += chr
			text.text = current_text
			await get_tree().create_timer(char_time / 1000).timeout
		
		space_key.visible = true
		is_line_end = true
		if line.last: await wait()
		current_text = ""

func _input(event: InputEvent) -> void:
	space_key_pressed.visible = Input.is_action_pressed("Next_dialogue")
	
	if Input.is_action_just_released("Next_dialogue") && is_line_end:
		to_next = true

func wait() -> void:
	while true:
		await get_tree().process_frame
		if to_next: break
