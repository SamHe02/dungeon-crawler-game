extends Control
class_name Input_Display

@onready var h_box_container = $HBoxContainer
@onready var input_type_label = $HBoxContainer/InputTypeLabel
@onready var input_key_button = $HBoxContainer/InputKeyButton
@export var input_key: String = ""
@export var input_type: String = ""
signal button_pressed(value)

func _ready():
	input_type_label.text = input_type
	input_key_button.text = input_key
	input_key_button.pressed.connect(on_button_pressed)
	
func update(key: String):
	input_key_button.text = key;

func on_button_pressed():
	button_pressed.emit(input_type)
