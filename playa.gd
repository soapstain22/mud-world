extends CharacterBody2D
class_name Player
@export var speed = 1000
@export var rotation_speed = 1.5
@export var equipment:Dictionary
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
var invShow:VBoxContainer
var click:Callable
@export var recipes:Array
var validEquipSlots=["helm","back","shirt","socks","pants","shoes","mask","coat","hands","underwear"]
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
func update_tree():
	
	pass
func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.get_parent() is GameItem):
		nearby.get(body.get_parent()).free()
		nearby.erase(body.get_parent())
	pass # Replace with function body.
func _ready():
	invShow=$"../../hud/Control/Equip/ScrollContainer/VBoxContainer"
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
func _on_listed_things_item_activated():
	var c = lister.get_selected()
	if tree2action.has(c):
		tree2item.get(c).tryAction(tree2action.get(c),self)
	pass # Replace with function body.
func pickup(item:GameItem):
	if equipment.get(activeHand)==null:
		item.reparent(invNode)
		equipment.get_or_add(activeHand,item)
		item.contained=true
		item.inhand=true
		if !inventory.has(item):
			print("fart")
			inventory.append(item)
		if item.toolBehavior !=null:
			print("fart")
			for i in item.toolBehavior:
				update_tree()
				actions.get_or_add(i)
		clearMenuButtonViaItem(item)
		propagateMenuButtonViaItem($"../../hud/Control/equipment".find_child(activeHand).get_child(0),item,actions)
	else:
		print("tried pickup with full hand")

	#update_equipment()
func drop(it):
	
	var v = equipment.get(activeHand) as GameItem
	if v !=null:
		v.on_drop()
		v.position = position
		v.reparent($"../..")
		v.contained=false
		v.inhand=false
		if v.toolBehavior !=null: 
			for i in v.toolBehavior:
				actions.erase(i)
		inventory.erase(v)
		equipment.erase(activeHand)
		clearMenuButtonViaItem(v)
		click = func():return false

	pass

func equip(item:GameItem):
	var a = item.tags.filter(func(a):validEquipSlots.has(a))
	var b = 	equipment.get(a[0])
	if b!=null:
		equipment.get_or_add(a[0],item)
		clearMenuButtonViaItem(item)
		propagateMenuButtonViaItem($"../../hud/Control/equipment".find_child(a[0]).get_child(0),item,actions)
		update_equipment()
	pass
func unequip(item:GameItem):
	pass
func store(a):
	var item = equipment.get(activeHand)
	if equipment.get(activeHand) !=null:
		item.contained=true
		item.inhand=false
		clearMenuButtonViaItem(item)
		invShow.add_child(propagateMenuButtonViaItem(MenuButton.new(),item,actions)) 
		equipment.erase(activeHand)
		click = func():return false
	pass
func hold(item:GameItem):
	pickup(item)
	pass	
func update_equipment():
	pass
func propagateInventory():
	$"../../hud/Control/Equip/ScrollContainer/Inventor".get_children().all(func(a):a.free())
	for i in inventory:
		var a = MenuButton.new()
		a=propagateMenuButtonViaItem(a,i,actions)
		a.text = i.item_name
		a.icon = i.default_texture
		$"../../hud/Control/Equip/ScrollContainer/Inventor".add_child(a)
	pass
func examine(item:GameItem):
	if item.itemName:
		chat.add_text("\n"+item.itemName)
	if item.defaultTexture:
		chat.add_image(item.defaultTexture)
	if item.tooltip:
		chat.add_text("\n"+item.tooltip)
func clearMenuButtonViaItem(item:GameItem):
	print("clearing ",item)
	if item2menuButton.get(item) !=null:
		var poop:MenuButton = item2menuButton.get(item) as MenuButton
		poop.get_popup().clear()
		poop.icon=null
		poop.text=""
		if item2menuButton.get(item).get_parent() == invShow:
			item2menuButton.get(item).free()
			item2menuButton.erase(item)
			pass
		item2menuButton.erase(item)
func propagateMenuButtonViaItem(panel: MenuButton, item: GameItem,user:Dictionary):
	item2menuButton.get_or_add(item,panel)
	if panel == null:
		return null
	panel.get_popup().clear(true)
	var dict:Dictionary
	var c = 0
	var acts:Array
	panel.icon=item.defaultTexture
	panel.text=item.itemName
	acts = item.get_actions(actions)
	print("PROPAGATION OF ITEMS")
	var a = 0
	panel.get_popup().index_pressed.connect(func(index:int):
		print(index)
		a+=0
		item.tryAction(acts[index],self)
		)
	print(a,"fart")
	for o in item.get_actions(actions):
		c+=1
		panel.get_popup().add_item(o)
	#fixme inventory overstore or repeating action thing
	print(c)
	return panel
func canFitInInventory(item:GameItem):
	pass
func getUse(hand:GameItem,target:Node2D):
	pass
func resippyBS():
	var v = Recipe.new() 
	v.catalysts.append("bow")
	v.consumed.append(["stick","wooden_rod"],"string")
	v.output
	recipes.append(v)
	v = Recipe.new() 
	v.consumed.append(["clay","clay"],"string")
	v.output
	recipes.append(v)
func dig():
	print("diggin")
	pass
func use(thing):
	equipment.get(activeHand,)
func popupMenu(item:GameItem,actions):
	pass
