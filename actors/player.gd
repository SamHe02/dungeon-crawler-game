extends CharacterBody3D
@onready var movement_input: MovementInput = $MovementInput
@onready var pivot: Node3D = $Pivot
@onready var camera_3d: Camera3D = $Pivot/Camera3D
@onready var hit_scan: HitScan = $HitScan

@onready var sensitivity: float = PLAYER_CONSTANTS.SENSITIVITY
@onready var pitch: float = 0.0
var direction: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movement_input.direction_changed.connect(move_character)
	movement_input.jump.connect(jump)
	movement_input.velocity = PLAYER_CONSTANTS.JUMP_VELOCITY
	pass # Replace with function body.

func _input(event) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensitivity)
		pitch -= event.relative.y * sensitivity
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(80))
		pivot.rotation.x = pitch

func move_character(dir) -> void:
	var input_dir = dir
	if input_dir.length() > 0:
		var basis = camera_3d.global_transform.basis
		var forward = -basis.z
		var right = basis.x
		
		direction = (right * input_dir.x - forward * input_dir.z)
		direction.y = 0
		direction = direction.normalized()
	else:
		direction = Vector3.ZERO

func apply_acceleration(delta) -> void:
	var accel = PLAYER_CONSTANTS.GROUND_ACCEL if is_on_floor() else PLAYER_CONSTANTS.AIR_ACCEL
	var target_velocity = direction * PLAYER_CONSTANTS.SPEED
	var horizontal = velocity
	horizontal.y = 0
	horizontal = horizontal.move_toward(target_velocity, accel * delta)
	velocity.x = horizontal.x
	velocity.z = horizontal.z

func jump(jump_velocity) -> void:
	if is_on_floor():
		velocity.y = jump_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= Move_Constants.GRAVITY * delta
	apply_acceleration(delta)
	move_and_slide()
