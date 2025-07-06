extends Node

var dialogue_chars_icon: Dictionary = {
	"unk": "unk",
	"xd2": "xd2"
}

var lines: Array = []
var line_text: String = ""
var is_line_ended: bool = false
var to_next_line: bool = false

func dialogue_box(
	icon: String,
	text_lines: Array
) -> Node:
	return null
