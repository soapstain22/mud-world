class_name Recipe
@export var catalysts:Array
@export var consumed:Array
@export var skills:Array
@export var output:PackedScene
func canCraft(items:Array,usrSkills:Array):
	if catalysts.all(func(a:GameItem):return items.has(a)):
		if consumed.all(func(a:GameItem):return items.has(a)):
			return true
