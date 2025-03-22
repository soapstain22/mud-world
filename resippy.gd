class_name Recipe
@export var catalysts: Array
@export var consumed: Array
@export var skills: Array
@export var output: PackedScene
func canCraft(items: Array, user):
	for item in consumed:
		var found = false
		for inv_item in items:
			if inv_item.itemName == item:
				found = true
				break
		if not found:
			return false
	for item in catalysts:
		var found = false
		for inv_item in items:
			if inv_item.itemName == item:
				found = true
				break
		if not found:
			return false
	return true

func craftFrom(inventory: Array, user):
	if canCraft(inventory, user):
		for item in consumed:
			for inv_item in inventory:
				if inv_item.itemName == item:
					inventory.erase(inv_item)
					break
		var crafted_item = output.instantiate()
		user.invNode.add_child(crafted_item)
		return crafted_item
	return null
