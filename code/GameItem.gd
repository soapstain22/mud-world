extends Node2D
class_name GameItem
@export var weight:float
@export var volume:float
@export var tags:Array =["can_pickup"]
@export var tooltip:String = "thats it"
@export var itemName:String =""
@export var defaultTexture:Texture2D
@export var equipSprite:Texture2D
enum toolBehavior{shovel,knife,axe,pickaxe,hammer,saw,fire}
var mat
var contained =false
var inhand =false
var sprite:Sprite2D
var rigid:RigidBody2D
var collision:CollisionShape2D
func attack_hand(user:Mob,modifiers:Array):
	pass
func attempt_pickup(user:Mob,modifiers:Array):
	pass
func pickup(user):
	pass
func throw_at(target):
	pass
func remove_item_from_storage(newLoc, removing):
	pass
func update_slot_icon():
	pass
func dropped(user):
	pass
func on_equipped(user,slot):
	pass
func equipped():
#dont call this directly
	pass
func use_tool(target,user,delay):
	pass
func _ready():
	sprite= Sprite2D.new()
	sprite.texture = defaultTexture
	sprite.reparent(self)
	rigid= RigidBody2D.new()
	rigid.reparent(self)
	collision= CollisionShape2D.new()
	collision.shape=CircleShape2D.new()
	collision.reparent(rigid)
	collision.connect("_on_rigid_body_2d_mouse_shape_exited",Callable.create(self,"_on_rigid_body_2d_mouse_shape_exited"))
	collision.connect("_on_rigid_body_2d_mouse_shape_entered",Callable.create(self,"_on_rigid_body_2d_mouse_shape_entered"))
func destroy(force):
	pass
func _on_rigid_body_2d_mouse_shape_entered(shape_idx):
	print("lala")
	if Player.MasterPlayer.focus != self:
		Player.MasterPlayer.focus = self
		pass
	pass # Replace with function body.

func _on_rigid_body_2d_mouse_shape_exited(shape_idx):
	if Player.MasterPlayer.focus == self:
		Player.MasterPlayer.focus = null
	pass # Replace with function body.
