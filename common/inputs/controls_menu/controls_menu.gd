extends Control

var Input_Display_Scene = preload("res://common/inputs/controls_menu/input_display.tscn")
@export var controls: Dictionary[String, String] = {}
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var rebind_dialog = $RebindDialog

var waiting_for_input = false
var current_action := ""
var displays = {}
var config = ConfigFile.new()

func get_default_controls() -> Dictionary[String, String]:
	return Input_Constants.DEFAULT_CONTROLS
	
func load_controls() -> Dictionary[String, String]:
	var ctrls: Dictionary[String, String] = {}
	var err = config.load(Input_Constants.CFG_FILE_PATH)
	if err != OK:
		ctrls = get_default_controls()
		config.set_value(Input_Constants.PC_SECTION, Input_Constants.CONTROLS, ctrls)
		config.save(Input_Constants.CFG_FILE_PATH)
	else:
		ctrls = config.get_value(Input_Constants.PC_SECTION, Input_Constants.CONTROLS, ctrls)
	return ctrls
# Called when the node enters the scene tree for the first time.
func _ready():
	controls = load_controls()
	rebind_dialog.input_selected.connect(_on_input_selected)
	for action in controls:
		var display = Input_Display_Scene.instantiate()
		display.input_type = action;
		display.input_key = controls[action];
		display.button_pressed.connect(_on_rebind_requested)
		v_box_container.set("theme_override_constants/separation", Input_Constants.BTN_SPACING)
		v_box_container.add_child(display)
		displays[action] = display

func _on_rebind_requested(input_type):
	current_action = input_type
	rebind_dialog.start()

func _input(event):

	if !waiting_for_input:
		return
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventMouseButton:

		waiting_for_input = false
		
		# set button text to pressed input
		var button = v_box_container.get_child(0).input_key_button
		button.text = event.as_text()
		
		# close modal
		rebind_dialog.hide()

func _on_input_selected(event):
	displays[current_action].update(event.as_text())
	controls[current_action] = event.as_text()
	config.set_value(Input_Constants.PC_SECTION, Input_Constants.CONTROLS, controls)
	config.save(Input_Constants.CFG_FILE_PATH)
	current_action = ""
