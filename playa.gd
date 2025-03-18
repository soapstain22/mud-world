extends CharacterBody2D
@export var speed = 1000
@export var rotation_speed = 1.5
@export var helmet:GameItem
@export var shirt:GameItem
@export var pants:GameItem
@export var back:GameItem
@export var gloves:GameItem
@export var mask:GameItem
@export var coat:GameItem
@export var hands:GameItem
@export var shoes:GameItem
@export var rightHand:GameItem
@export var leftHand:GameItem
var string2itemSlot:Dictionary
var lister:Tree
var inrange:Array
var nearby: Dictionary
var actions: Dictionary
var inventory:Array
var tree2action:Dictionary
var tree2item:Dictionary
var invNode:Node2D
var menuBars:Array
var item2menuButton:Dictionary
var rotationMatrix:Array
var rotation_anchor:Node2D
var armor2item:Dictionary
var activeHand
var leftHandSlot:MenuButton
var RightHandSlot:MenuButton
var chat
func get_input():
	velocity = 200*Vector2(Input.get_axis("left", "right"),Input.get_axis("up", "down"))
	if (Input.get_action_strength("ui_accept")):
		menu_open()
	var a = Input.get_axis("left", "right")+1
	var b = Input.get_axis("up", "down")+1
	$realcamera.zoom *= 1+ 0.1*Input.get_axis("zoom", "unzoom")
	$head.texture.set_region(Rect2(rotationMatrix[a][b]*32,0,32,32))
	$shirt.texture.set_region(Rect2(rotationMatrix[a][b]*32,0,32,32))
	$pants.texture.set_region(Rect2(rotationMatrix[a][b]*32,0,32,32))
	var o = global_position+velocity
	rotation_anchor.look_at((global_position+velocity))
func _physics_process(delta):
	get_input()
	move_and_slide()
func menu_open():
	if (!inrange.is_empty()):
		lister.visible=true
	pass
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.get_parent() is GameItem):
		if(!nearby.get(body.get_parent())):
			lister.get_parent()
			var c:TreeItem = lister.create_item(null,-1)
			c.set_text(0,body.get_parent().itemName)
			c.add_button(0,Texture2D.new())
			c.add_button(0,Texture2D.new())
			for i in body.get_parent().get_actions(actions):
				var j = c.create_child(-1)
				j.set_text(0,i)
				tree2action.get_or_add(j,i)
				tree2item.get_or_add(j,body.get_parent())
			nearby.get_or_add(body.get_parent(),c)
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.get_parent() is GameItem):
		nearby.get(body.get_parent()).free()
		nearby.erase(body.get_parent())
	pass # Replace with function body.
func _ready():
	activeHand="left"
	lister = $"../../hud/Control/listedThings"
	lister.create_item(null, -1)
	lister.hide_root = true
	actions.get_or_add("actions",["examine","pick up","eat","drop"])
	invNode=Node2D.new()
	rotationMatrix.append([5,6,7])
	rotationMatrix.append([4,0,0])
	rotationMatrix.append([3,2,1])
	rotation_anchor=$shirt/rotation_anchor
	chat = $"../../hud/Control/Happenings/ScrollContainer/RichTextLabel"
	RightHandSlot = $"../../hud/Control/equipment/right/MenuButton"
	leftHandSlot = $"../../hud/Control/equipment/left/MenuButton"
func _on_listed_things_item_activated():
	var c = lister.get_selected()
	if tree2action.has(c):
		tree2item.get(c).tryAction(tree2action.get(c),self)
	pass # Replace with function body.
func pickup(item:GameItem):
	if (!inventory.has(item)):
		if (inventory.size() < 21):
			inventory.append(item)
			item.contained=true
			item.reparent(invNode)
			var v := MenuButton.new()
			item2menuButton.get_or_add(item,v)
			v.text=item.name
			v.icon=item.defaultTexture
			$"../../hud/Control/Equip/ScrollContainer/VBoxContainer".add_child(propagateSlot(v,item,actions))
			var acts:Array

			return true
	return false
func drop(c):
	var j = item2menuButton.get(c)
	item2menuButton.erase(c)
	if (j!=null):
		j.free()
	c.global_position = global_position
	c.visible=true
	c.reparent($"../..")
	c.contained=false
	unequip(c)
	inventory.erase(c)

func equip(equipment:GameItem):
	equipment.reparent(invNode)
	var a:Array= equipment.get_actions(self.actions)
	#bigass if tree because you wont be doing this all the time hopefully
	if a.has("equip"):
		if equipment.tags.has("hat"):
			helmet = equipment
			equipment.tags.append("worn")
			equipment.contained=true
			var g = item2menuButton.get(equipment)
			if g!=null:
				$"../../hud/Control/Equip/ScrollContainer/VBoxContainer".remove_child(g)
			propagateSlot($"../../hud/Control/equipment/helm/MenuButton",equipment,actions)
	update_equipment()
	pass
func unequip(equipment:GameItem):
	equipment.tags.erase("worn")
	if helmet==equipment:
		pickup(equipment)	
		helmet = null
	else:if back==equipment:
		pickup(equipment)
		back = null
	else:if shirt==equipment:
		pickup(equipment)
		shirt = null
	else:if pants==equipment:
		pickup(equipment)
		pants = null
	else:if shoes==equipment:
		pickup(equipment)
		shoes = null
	else:if mask==equipment:
		pickup(equipment)
		mask= null
	else:if coat==equipment:
		pickup(equipment)
		coat= null
	else:if hands==equipment:
		pickup(equipment)
		hands=null
	update_equipment()
	pass

	
func update_equipment():
	if helmet!=null:	
		$"../../hud/Control/equipment/helm/MenuButton".icon=helmet.defaultTexture
	else:
		$"../../hud/Control/equipment/helm/MenuButton".icon=null
	if back!=null:
		$"../../hud/Control/equipment/back/MenuButton".icon=back.defaultTexture
	else:
		$"../../hud/Control/equipment/back/MenuButton".icon=null
	if shirt!=null:
		$"../../hud/Control/equipment/shirt/MenuButton".icon=shirt.defaultTexture
	else:
		$"../../hud/Control/equipment/shirt/MenuButton".icon=null
	if pants!=null:
		$"../../hud/Control/equipment/pants/MenuButton".icon=pants.defaultTexture
	else:
		$"../../hud/Control/equipment/pants/MenuButton".icon=null
	if shoes!=null:
		$"../../hud/Control/equipment/shoes/MenuButton".icon=shoes.defaultTexture
	else:
		$"../../hud/Control/equipment/shoes/MenuButton".icon=null
	if mask!=null:
		$"../../hud/Control/equipment/mask/MenuButton".icon=mask.defaultTexture
	if coat!=null:
		$"../../hud/Control/equipment/coat/MenuButton".icon=coat.defaultTexture
	if hands!=null:
		$"../../hud/Control/equipment/hands/MenuButton".icon=hands.defaultTexture
	if leftHand!=null:
		$"../../hud/Control/equipment/left/MenuButton".icon=leftHand.defaultTexture
		$shirt/rotation_anchor/hand_l.texture=leftHand.defaultTexture
	else:
		$"../../hud/Control/equipment/left/MenuButton".icon=null
func propagateSlot(panel: MenuButton, item: GameItem,user:Dictionary):
	panel.get_popup().clear(true)
	var dict:Dictionary
	var c = 0
	var acts:Array
	for o in item.get_actions(actions):
		print("MROW")
		acts.append(o)
		panel.get_popup().add_item(o)
	panel.get_popup().index_pressed.connect(func(index:int):
		item.tryAction(acts[index],self)
		)
		
	return panel
func putinhands(item:GameItem):
	item.reparent(invNode)
	if activeHand=="left":
		if leftHand == null:
			leftHand=item
			$shirt/rotation_anchor/hand_l.texture = leftHand.defaultTexture
			item2menuButton.get_or_add(item,leftHand)
			item.contained=true
			propagateSlot(leftHandSlot,item,actions)
			pass
	update_equipment()
	pass	
func putaway(item:GameItem):
	item.reparent(invNode)
	inventory.append(item)
	if activeHand=="left":
		if leftHand == null:
			leftHand=item
			propagateSlot(leftHandSlot,item,actions)
			pass
	update_equipment()
	pass	
func examine(item:GameItem):
	if item.itemName:
		chat.add_text("\n"+item.itemName)
	if item.defaultTexture:
		chat.add_image(item.defaultTexture)
	if item.tooltip:
		chat.add_text("\n"+item.tooltip)
