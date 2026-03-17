class_name MovementInput
extends Node

signal direction_changed(direction)
signal mouse_moved(mouse_pos)
var direction: Vector3 = Vector3.ZERO
var mouse_pos: Vector2 = Vector2.ZERO
var mouse_mode = Input.MOUSE_MODE_CAPTURED
# Called when the node enters the scene tree for the first time.
func get_movement_vector():
	var x = (
		Input.get_action_strength(Input_Constants.action_to_string(Input_Constants.Actions.MOVE_RIGHT)) -
		Input.get_action_strength(Input_Constants.action_to_string(Input_Constants.Actions.MOVE_LEFT))
	)
	var z = (
		Input.get_action_strength(Input_Constants.action_to_string(Input_Constants.Actions.MOVE_BACKWARD)) -
		Input.get_action_strength(Input_Constants.action_to_string(Input_Constants.Actions.MOVE_FORWARD))
	)
	direction = Vector3(x, 0, z).normalized()
	emit_signal(direction_changed.get_name(), direction)



func _ready() -> void:
	mouse_pos = get_viewport().get_mouse_position() # Replace with function body.
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	get_movement_vector()
	
