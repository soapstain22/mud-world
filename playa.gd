extends CharacterBody2D
@export var speed = 1000
@export var rotation_speed = 1.5
@export var helmet:Armor
@export var shirt:Armor
@export var gloves:Armor
@export var shoes:Armor
@export var rightHand:GameItem
@export var leftHand:GameItem
var inrange:Array
var nearby: Dictionary
var actions: Dictionary
var inventory:Array	
var tree2action:Dictionary
var tree2item:Dictionary

func get_input():

	velocity = 200*Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down"))
	if (Input.get_action_strength("ui_accept")):
		menu_open()
func _physics_process(delta):
	get_input()
	move_and_slide()
func menu_open():
	print("fuk")
	if (!inrange.is_empty()):
		$listedThings.visible=true
	pass
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("a")
	if (body.get_parent() is GameItem):
		if(!nearby.get(body.get_parent())):
			var c:TreeItem = $listedThings.create_item()
			c.set_text(0,body.get_parent().itemName)
			c.add_button(0,Texture2D.new())
			c.add_button(0,Texture2D.new(),)
			for i in body.get_parent().get_actions(actions):
				var j = c.create_child(-1)
				j.set_text(0,i)
				tree2action.get_or_add(j,i)
				tree2item.get_or_add(j,body.get_parent())
				print(j,i)
			nearby.get_or_add(body.get_parent(),c)
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.get_parent() is GameItem):	
		nearby.get(body.get_parent()).free()
		nearby.erase(body.get_parent())
	pass # Replace with function body.
func _ready():
	actions.get_or_add("actions",["examine","pickup","eat"])
func _on_listed_things_item_activated():
	print("fart")
	var c = $listedThings.get_selected()
	print(tree2action.get(c))
	print(tree2item.get(c))
	print("action:")
	print(c)
	tree2item.get(c).tryAction(tree2action.get(c),self)
	pass # Replace with function body.
func pickup(item:GameItem):
	if (!inventory.has(item)):
		inventory.append(item)
		print("PICKED IT UP")
func drop(c):
	var item = inventory[c]
	item.global_position = global_position
	item.visible=true
	
	
