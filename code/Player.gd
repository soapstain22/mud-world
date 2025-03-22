extends CharacterBody2D 
class_name Player
@export var speed = 1000
@export var rotation_speed = 1.5
@export var equipment:Dictionary
var inrange:Array
var nearby: Dictionary
var actions: Dictionary
var invNode:Node2D
var menuBars:Array
var rotationMatrix:Array
var rotation_anchor:Node2D
enum activeHand{left,right}
var leftHandSlot:MenuButton
var RightHandSlot:MenuButton
var chat
var invShow:VBoxContainer
@export var focus:Node2D
static var MasterPlayer:Player
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
	updateFocus()
func _physics_process(delta):
	get_input()
	move_and_slide()
func menu_open():
	pass
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
func _ready():
	invShow=$"../../hud/Control/Equip/ScrollContainer/VBoxContainer"
	invNode=Node2D.new()
	rotationMatrix.append([5,6,7])
	rotationMatrix.append([4,0,0])
	rotationMatrix.append([3,2,1])
	rotation_anchor=$shirt/rotation_anchor
	chat = $"../../hud/Control/Happenings/ScrollContainer/RichTextLabel"
func pickup(item:GameItem):
	pass
func drop():
	pass
func equip(item:GameItem):
	pass
func unequip(item:GameItem):
	pass
func store(a):
	pass
func hold(item:GameItem):
	pass	
func update_equipment():
	pass
func propagateInventory():
	pass
func examine(item:GameItem):
	pass
func canFitInInventory(item:GameItem):
	pass
func getUse(hand:GameItem,target:Node2D):
	pass
func try_attack(target):
	pass
func updateFocus():
	if focus:
		print("focusing")
		draw_circle(focus.position,10,Color.BLACK,false,0.5,false)
	pass
