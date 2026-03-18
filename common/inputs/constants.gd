extends Node

class_name Input_Constants
const DEFAULT_CONTROLS: Dictionary[Actions, int] = {
	Actions.MOVE_FORWARD: KEY_W,
	Actions.MOVE_BACKWARD: KEY_S,
	Actions.MOVE_LEFT: KEY_A,
	Actions.MOVE_RIGHT: KEY_D,
	Actions.JUMP: KEY_SPACE,
	Actions.OPEN_INPUT_MENU: KEY_ESCAPE
}

enum Actions {
	MOVE_FORWARD,
	MOVE_BACKWARD,
	MOVE_LEFT,
	MOVE_RIGHT,
	JUMP,
	OPEN_INPUT_MENU,
	NONE
}

static func action_to_string(action: Actions) -> String:
	return Actions.keys()[action]

const PC_SECTION: String = "PC"
const CONTROLS: String = "Controls"
const CFG_FILE_PATH: String = "res://controls.cfg"

const BTN_SPACING: int = 40
