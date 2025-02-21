extends Node2D
class_name GameItem
@export var weight:float
@export var volume:float
@export var tags:Array =["can_pickup"]
@export var tooltip:String = "thats it"
@export var itemName:String
@export var defaultTexture:Texture2D
var contained =false
func get_actions(user:Dictionary):
	var returns= ["pick up"]
	var skills = user.get("skills")
	var actions = user.get("actions")
	var tools = user.get("tools")
	var items = user.get("items")
	if (actions != null):
		if actions.has("pick up"):
			if tags.has("can_pickup"):
				returns.append("pick up")
		if actions.has("examine"):
			if !tags.has("invisible"):
				returns.append("examine")	
	return returns
func tryAction(action,user):
	match action:
		"examine":
			$"../CharacterBody2D/Camera2D/Control/TabContainer/Happenings/ScrollContainer/RichTextLabel".text +="\n"+ tooltip
			pass
		"pick up":
			if(user.pickup(self)):
				contained=true
			pass
		"drop":
			if(user.drop(self)):
				contained=false
			pass
	pass
func examine(user):
	return "\n"+tooltip
func _ready():
	$face.texture = defaultTexture
	
