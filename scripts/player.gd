extends CharacterBody3D

### === [ Variable's ] ===

@export var move_speed: float = 1.0
@export var move_run: float = 1.0
@export var jump_force: float = 1.0

@export var crouch_lower: float = 1.0
@export var crouch_speed: float = 1.0

## ----

@onready var animator: AnimationPlayer
@onready var animator_tree: AnimationTree

@onready var hitbhox_preview = $hitbox/preview_hitbox

## ----

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

### ===

### === [ Main ] ===

func _ready() -> void:
	## Disable hitbox preview
	hitbhox_preview.visible = false

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass

### ===

### === [ Util's ] ===



### ===
