extends GameItem
func get_actions(actions:Dictionary):
	var r = super(actions)
	if contained:
		if inhand:
			r.append("dig")


func _on_rigid_body_2d_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
