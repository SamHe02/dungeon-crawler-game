class_name MovementInput
extends Node

signal direction_changed(direction)
var direction: Vector3 = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
	emit_signal("direction_changed", direction)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_movement_vector()
	
