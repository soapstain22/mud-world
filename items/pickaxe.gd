extends GameItem
func get_actions(actions:Dictionary):
	var v = super(actions)
	if contained:
		if inhand:
			v.append("dig")
