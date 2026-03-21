class_name MovementInput
extends Node

# Output signals
signal direction_changed(direction)
signal mouse_moved(mouse_pos)
signal jump(velocity)

# Global variables
var direction: Vector3 = Vector3.ZERO
var mouse_pos: Vector2 = Vector2.ZERO
var velocity: float = 0.0
var mouse_mode = Input.MOUSE_MODE_CAPTURED

# outputs the signal for the input direction
func get_movement_vector() -> void:
	var x = (
		Input.get_action_strength(Input_Constants.to_String(Input_Constants.Actions.MOVE_RIGHT)) -
		Input.get_action_strength(Input_Constants.to_String(Input_Constants.Actions.MOVE_LEFT))
	)
	var z = (
		Input.get_action_strength(Input_Constants.to_String(Input_Constants.Actions.MOVE_BACKWARD)) -
		Input.get_action_strength(Input_Constants.to_String(Input_Constants.Actions.MOVE_FORWARD))
	)
	direction = Vector3(x, 0, z).normalized()
	emit_signal(direction_changed.get_name(), direction)

func get_jump_input() -> void:
	if Input.is_action_just_pressed(Input_Constants.to_String(Input_Constants.Actions.JUMP)):
		emit_signal(jump.get_name(), velocity)

func _ready() -> void:
	# FPS mode
	mouse_pos = get_viewport().get_mouse_position() # Replace with function body.
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void:
	get_movement_vector()
	get_jump_input()
