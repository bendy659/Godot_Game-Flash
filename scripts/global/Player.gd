extends CharacterBody3D

### === [ Variable's ] ===

@export var move_speed: float = 1.0
@export var move_run: float = 1.0
@export var jump_force: float = 1.0

@export var crouch_lower: float = 1.0
@export var crouch_speed: float = 1.0

## ----

var animator: AnimationPlayer
var animator_tree: AnimationTree

### ===



### === [ Main ] ===

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
	#animator.play("get_item", 1)

### ===

### === [ Util's ] ===



### ===
