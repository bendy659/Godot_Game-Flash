extends Player

@onready var hitbhox_preview = $hitbox/preview_hitbox

@onready var p_animator = $animator
@onready var p_animator_tree = $animator_tree

func _ready() -> void:
	## Apply
	animator = p_animator
	animator_tree = p_animator_tree
	
	## Disable hitbox preview
	hitbhox_preview.visible = false
