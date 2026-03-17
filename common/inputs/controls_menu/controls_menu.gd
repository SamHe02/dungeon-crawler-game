extends Control

var Input_Display_Scene = preload("res://common/inputs/controls_menu/input_display.tscn")
@export var controls: Dictionary[Input_Constants.Actions, int] = {}
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var rebind_dialog = $RebindDialog

var waiting_for_input = false
var current_action: Input_Constants.Actions = Input_Constants.Actions.NONE
var displays = {}
var config = ConfigFile.new()
var prev_mouse_mode = Input.mouse_mode

func get_default_controls() -> Dictionary[Input_Constants.Actions, int]:
	return Input_Constants.DEFAULT_CONTROLS
	
func load_controls() -> Dictionary[Input_Constants.Actions, int]:
	var ctrls: Dictionary[Input_Constants.Actions, int] = {}
	var err = config.load(Input_Constants.CFG_FILE_PATH)
	if err != OK:
		ctrls = get_default_controls().duplicate_deep()
		config.set_value(Input_Constants.PC_SECTION, Input_Constants.CONTROLS, ctrls)
		config.save(Input_Constants.CFG_FILE_PATH)
	else:
		ctrls = config.get_value(Input_Constants.PC_SECTION, Input_Constants.CONTROLS, ctrls)
	return ctrls

func update_input_event_map(ctrls, curr_action):
	var input_event = InputEventKey.new()
	InputMap.action_erase_events(Input_Constants.action_to_string(curr_action))
	input_event.keycode = ctrls[curr_action]
	InputMap.action_add_event(Input_Constants.action_to_string(curr_action), input_event)

# Called when the node enters the scene tree for the first time.
func _ready():
	v_box_container.visible = false
	controls = load_controls()
	rebind_dialog.input_selected.connect(_on_input_selected)
	for action in controls:
		var display = Input_Display_Scene.instantiate()
		display.input_type = Input_Constants.action_to_string(action);
		display.input_key = OS.get_keycode_string(controls[action]);
		display.button_pressed.connect(_on_rebind_requested)
		v_box_container.set("theme_override_constants/separation", Input_Constants.BTN_SPACING)
		v_box_container.add_child(display)
		
		#Add an Input to the Input Mapping
		var event = InputEventKey.new()
		if not InputMap.has_action(Input_Constants.action_to_string(action)):
			InputMap.add_action(Input_Constants.action_to_string(action))
		
		update_input_event_map(controls, action)
		
		displays[action] = display

func _on_rebind_requested(input_type: String):
	current_action = Input_Constants.Actions[input_type]
	rebind_dialog.start()

func _set_mouse_confined_visible():
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CONFINED:
		prev_mouse_mode = Input.mouse_mode
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	elif Input.get_mouse_mode() != prev_mouse_mode:
		Input.mouse_mode = prev_mouse_mode

func _input(event):

	if !waiting_for_input:
		if Input.is_action_just_pressed(Input_Constants.action_to_string(Input_Constants.Actions.OPEN_INPUT_MENU)):
			v_box_container.visible = !v_box_container.visible
			_set_mouse_confined_visible()
		return
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventMouseButton:

		waiting_for_input = false
		
		# set button text to pressed input
		var button = v_box_container.get_child(0).input_key_button
		button.text = event.as_text()
		
		# close modal
		rebind_dialog.hide()

func _on_input_selected(event):
	displays[current_action].update(OS.get_keycode_string(event.keycode))
	controls[current_action] = event.keycode
	config.set_value(Input_Constants.PC_SECTION, Input_Constants.CONTROLS, controls)
	config.save(Input_Constants.CFG_FILE_PATH)
	update_input_event_map(controls, current_action)
	current_action = Input_Constants.Actions.NONE
