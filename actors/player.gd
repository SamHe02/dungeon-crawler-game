extends CharacterBody3D
@onready var movement_input: MovementInput = $MovementInput
@onready var pivot: Node3D = $Pivot
@onready var camera_3d: Camera3D = $Pivot/Camera3D

@onready var sensitivity: float = 0.002
@onready var pitch: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensitivity)
		pitch -= event.relative.y * sensitivity
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(80))
		pivot.rotation.x = pitch

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var input_dir = movement_input.direction
	var direction = Vector3.ZERO
	
	if input_dir.length() > 0:
		var basis = camera_3d.global_transform.basis
		var forward = -basis.z
		var right = basis.x
		
		direction = (right * input_dir.x - forward * input_dir.z)
		direction.y = 0
		direction = direction.normalized()
	velocity.x = direction.x * 10
	velocity.z = direction.z * 10
	
	
	move_and_slide()
