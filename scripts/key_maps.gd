extends VBoxContainer

var actions = {
	"move_left": "Left",
	"move_right": "Right",
	"jump": "Jump",
	"attack": "Attack",
	"undock": "Undock"
}

var waiting_for_rebind = null

func _ready():
	update_labels()

func update_labels():
	for action in actions:
		var node_name = actions[action]
		var button_path = "%s/Button" % node_name

		if has_node(button_path):
			var button = get_node(button_path)

			var events = InputMap.action_get_events(action)
			var key_name = "None"
			if events.size() > 0 and events[0] is InputEventKey:
				key_name = OS.get_keycode_string(events[0].physical_keycode)

			button.text = "%s: %s" % [node_name, key_name]
			button.pressed.connect(func(): start_rebind(action, node_name, button))

func start_rebind(action: String, node_name: String, button: Button):
	button.text = "Press a key..."
	waiting_for_rebind = {"action": action, "node": node_name, "button": button}
	
func _unhandled_input(event):
	if waiting_for_rebind and event is InputEventKey:
		var action = waiting_for_rebind["action"]
		var node_name = waiting_for_rebind["node"]
		var button = waiting_for_rebind["button"]

		if event.pressed:
			waiting_for_rebind["key"] = event.physical_keycode
		elif not event.pressed and "key" in waiting_for_rebind and waiting_for_rebind["key"] == event.physical_keycode:
			InputMap.action_erase_events(action)

			var new_event = InputEventKey.new()
			new_event.physical_keycode = waiting_for_rebind["key"]
			InputMap.action_add_event(action, new_event)

			var key_name = OS.get_keycode_string(waiting_for_rebind["key"])
			button.text = "%s: %s" % [node_name, key_name]

			waiting_for_rebind = null
			get_viewport().set_input_as_handled()
