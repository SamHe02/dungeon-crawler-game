extends PopupPanel
class_name RebindPopup

signal input_selected(event)

var listening := false


func start():

	listening = true
	popup_centered()


func stop():

	listening = false
	hide()


func _unhandled_input(event):

	if !listening:
		return

	if event is InputEventKey and event.pressed:

		input_selected.emit(event)

		stop()

		get_viewport().set_input_as_handled()
