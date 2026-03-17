extends CharacterBody3D
@onready var movement_input: MovementInput = $MovementInput

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = movement_input.direction * 10
	move_and_slide()
