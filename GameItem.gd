extends Node2D
class_name GameItem
@export var weight:float
@export var volume:float
@export var tags:Array =["can_pickup"]
@export var tooltip:String = "thats it"
@export var itemName:String =""
@export var defaultTexture:Texture2D
@export var equipSprite:Texture2D
@export var clickCatch:Callable
@export var clickThrow:Callable
@export var action:Callable
@export var action_to:Callable

var toolBehavior
var mat
var contained =false
var inhand =false
func get_actions(actions:Dictionary):
	var returns= []
	var skills = actions.get("skills")
	var acts = actions.get("actions")
	var tools = actions.get("tools")
	var items = actions.get("items")
	if (acts != null):
		if acts.has("pick up"):
			if tags.has("can_pickup"):
				if contained:
					if inhand:
						returns.append("store")
						returns.append("drop")
						if !action.is_null():
							returns.append("use")

					else:
						returns.append("hold")
				else:
					returns.append("pick up")
			if tags.has("harvestable"):
				returns.append("harvest")
		if tags.has("container"):
			returns.append("open")
		if ["helm","back","shirt","pants","shoes","hand","coat","mask","socks","underwear"] in tags:
			if tags.has("worn"):
				returns.append("unequip")
			else:
				returns.append("equip")
		if acts.has("examine"):
			if !tags.has("invisible"):
				returns.append("examine")
	print(returns)
	return returns
func get_actions_for(user,target):
	return null
func tryAction(action,user):
	user.call(action.replace(" ",""),self)
func tryActionOn(action,user,target):
	call(target.replace(" ",""),self)
func eat(item:GameItem):
	pass
func use():
	action.call()
	pass
func use_on(user, target,modifiers):
	action_to.call(user,target,modifiers)

	pass
func on_drop():
	pass
