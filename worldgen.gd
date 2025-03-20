extends Node2D
@export var sand:FastNoiseLite
@export var clay:FastNoiseLite
@export var solid:FastNoiseLite
@export var fert:FastNoiseLite
@export var erosion:FastNoiseLite
@export var temperature:FastNoiseLite
@export var humidity:FastNoiseLite
var baseturf:TileMapLayer
var placed:TileMapLayer
var list:Array
var tree:PackedScene
var stone:PackedScene
var brick:PackedScene
var items:PackedScene
var sharp_stone:PackedScene
var trucker_hat:PackedScene
var beer:PackedScene
var plants:Array
var plants2Scene:Dictionary
func _ready():
	baseturf = $game/baseturf
	placed = $game/placed_walls
	list = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	var g=preload("res://items/ent/mushroom.tscn").instantiate()
	plants.append(g)
	g=preload("res://items/ent/bamboo.tscn").instantiate()
	plants.append(g)
	g=preload("res://items/ent/yarrow.tscn").instantiate()
	plants.append(g)
	g=preload("res://items/ent/hemp.tscn").instantiate()
	plants.append(g)
	spawnworld()
func spawnworld():
	for y in range(0,255):
		for x in range(0,255):
			var c = solid.get_noise_2d(x,y)
			var cl = clay.get_noise_2d(x,y)
			var sa = sand.get_noise_2d(x,y)
			var f = fert.get_noise_2d(x,y)
			baseturf.set_cell(Vector2i(x,y),0,soil(cl,sa),0)
			if(solid.get_noise_2d(x,y)>0.3):
				var a = [Vector2i(x+1,y),Vector2i(x,y+1),Vector2i(x-1,y),Vector2i(x,y-1)]
				placed.set_cell(Vector2i(x,y),1,Vector2i(1,1),0)
#				placed.set_cells_terrain_connect(a,0,0)
			else:
				if f>0.1:
					var j = foliageProcess(soil(cl,sa))
				
					if j!=null:
						j = j.pick_random()
						if j!=null:
							j.global_position=(Vector2(randi_range(-16,-32)+x*48,randi_range(-16,-32)+y*48))
							j=j.duplicate()
							$game.add_child(j)
							#var j =tree.instantiate()
func soil(c,s):
	c=abs(c)
	c= c*10
	c= roundi(c)
	s=abs(s)
	s= s*12
	s= roundi(s)
	var p = str(int(c)," ",int(s))
	if range(6,11).has(c) && range(0,4).has(s):
		return(Vector2i(0,0)) #hc x
	else: if (range(4,6).has(c) && range(0,2).has(s)):
		return(Vector2i(1,0)) #sic x
	else: if range(3,4).has(c) && range(0,2).has(s):
		return(Vector2i(2,0)) #sicl X
	else: if range(0,1).has(c) && range(0,2).has(s):
		return(Vector2i(4,0)) #si X
	else: if range(4,6).has(c) && range(2,5).has(s):
		return(Vector2i(5,0)) #c
	else: if range(3,4).has(c) && range(2,5).has(s):
		return(Vector2i(6,0)) #cl
	else: if range(0,2).has(c) && range(4,5).has(s):
		return(Vector2i(7,0)) #l
	else: if range(0,2).has(c) && range(5,7).has(s):
		return(Vector2i(9,0)) #ls
	else: if range(0,2).has(c) && range(7,11).has(s):
		return(Vector2i(10,0)) #s
	else: if range(0,3).has(c) && range(5,8).has(s):
		return(Vector2i(8,0)) #sl
	else: if range(3,8).has(c) && range(3,8).has(s):
		return(Vector2i(11,0)) #sc
	else: if range(2,3).has(c) && range(2,9).has(s):
		return(Vector2i(12,0)) #scl
	else: if range(0,3).has(c) && range(0,4).has(s):
		return(Vector2i(3,0)) #sil
	else:
		return Vector2i(0,0)
func foliageProcess(f:Vector2i):
	var a = erosion.get_noise_2d(f.x,f.y)
	var b = temperature.get_noise_2d(f.x,f.y)
	var c = humidity.get_noise_2d(f.x,f.y)
	var d = sand.get_noise_2d(f.x,f.y)
	var e = clay.get_noise_2d(f.x,f.y)
	var h = (d+e)/2
	var k = plants.filter(func(poop):
		if(poop.willsurvive(a,b,c,d,e,h)):
			return true
		else:
			return false
		)
	return k

	#temperature,humidity,erosion,sand,silt,clay
	#mushroom
	#hemp
	#lavender
	#mushroom
	#jute
	#yarrow
	#dandelion
	#chickweed
