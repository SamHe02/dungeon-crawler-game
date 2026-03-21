extends Control

class_name HUD

@export var crosshair: CrossHair = CrossHair.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crosshair.anchor_left = 0.5
	crosshair.anchor_top = 0.5
	crosshair.anchor_right = 0.5
	crosshair.anchor_bottom = 0.5
	anchor_left = 0
	anchor_top = 0
	anchor_right = 0
	anchor_bottom = 0
	
	offset_left = 0
	offset_top = 0
	offset_right = 0
	offset_bottom = 0
	add_child(crosshair)
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	# create a crosshair object from settings
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
