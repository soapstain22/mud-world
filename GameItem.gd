extends Node2D
class_name GameItem
@export var weight:float
@export var volume:float
@export var tags:Array =["can_pickup"]
@export var tooltip:String = "thats it"
@export var itemName:String =""
@export var defaultTexture:Texture2D
@export var equipSprite:Texture2D
var mat
var contained =false
func get_actions(user:Dictionary):
	var returns= []
	var skills = user.get("skills")
	var actions = user.get("actions")
	var tools = user.get("tools")
	var items = user.get("items")
	if (actions != null):
		if actions.has("pick up"):
			if tags.has("can_pickup"):
				if contained:
					returns.append("drop")
				else:
					returns.append("pick up")
			if tags.has("harvestable"):
				returns.append("harvest")
			if tags.has("diggable"):
				returns.append("dig")
			if tags.has("edible"):
				returns.append("eat")
		if tags.has("container"):
			returns.append("open")
		if tags.has("equippable"):
			if tags.has("worn"):
				returns.append("unequip")
			else:
				returns.append("equip")
		if actions.has("examine"):
			if !tags.has("invisible"):
				returns.append("examine")
	print(returns)
	return returns
func tryAction(action,user):
	user.call(action.replace(" ",""),self)
	
func _ready():

	$face.texture = defaultTexture
func eat(item:GameItem):
	pass
