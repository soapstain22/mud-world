extends Node2D
var sand:FastNoiseLite
var clay:FastNoiseLite
var loam:FastNoiseLite
var solid:FastNoiseLite
var fert:FastNoiseLite
var baseturf:TileMapLayer
var placed:TileMapLayer
var list:Array
var tree:PackedScene
func _ready():
	baseturf = $baseturf
	placed = $baseturf/placed_walls
	list = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	spawnworld()
	print(list)
	tree = preload("res://tree.tscn")
func spawnworld():
	solid = FastNoiseLite.new()
	clay = FastNoiseLite.new()
	sand = FastNoiseLite.new()
	fert = FastNoiseLite.new()
	clay.seed = 10
	sand.fractal_lacunarity =1
	sand.fractal_octaves=10
	sand.seed = 20
	sand.fractal_lacunarity =1
	sand.fractal_octaves=10
	loam = FastNoiseLite.new()
	loam.seed = 30
	for y in range(0,255):
		for x in range(0,255):
			var c = solid.get_noise_2d(x,y)
			var cl = clay.get_noise_2d(x,y)
			var sa = sand.get_noise_2d(x,y)
			baseturf.set_cell(Vector2i(x,y),0,soil(cl,sa),0)
func soil(c,s):
	c=abs(c)
	c= c*10
	c= roundi(c)
	s=abs(s)
	s= s*12
	s= roundi(s)
	var p = str(int(c)," ",int(s))

	if range(6,11).has(c) && range(0,4).has(s):
		list[1]+=1
		return(Vector2i(0,0)) #hc x
	else: if (range(4,6).has(c) && range(0,2).has(s)):
		list[2]+=1
		return(Vector2i(1,0)) #sic x
	else: if range(3,4).has(c) && range(0,2).has(s):
		list[3]+=1
		return(Vector2i(2,0)) #sicl X
	else: if range(0,1).has(c) && range(0,2).has(s):
		list[4]+=1
		return(Vector2i(4,0)) #si X
	else: if range(4,6).has(c) && range(2,5).has(s):
		list[5]+=1
		return(Vector2i(5,0)) #c
	else: if range(3,4).has(c) && range(2,5).has(s):
		list[6]+=1
		return(Vector2i(6,0)) #cl
	else: if range(0,2).has(c) && range(4,5).has(s):
		list[7]+=1
		return(Vector2i(7,0)) #l
	else: if range(0,2).has(c) && range(5,7).has(s):
		list[8]+=1
		return(Vector2i(9,0)) #ls
	else: if range(0,2).has(c) && range(7,11).has(s):
		list[9]+=1
		return(Vector2i(10,0)) #s
	else: if range(0,3).has(c) && range(5,8).has(s):
		list[10]+=1
		return(Vector2i(8,0)) #sl
	else: if range(3,8).has(c) && range(3,8).has(s):
		list[11]+=1
		return(Vector2i(11,0)) #sc
	else: if range(2,3).has(c) && range(2,8).has(s):
		list[12]+=1
		return(Vector2i(12,0)) #scl
	else: if range(0,3).has(c) && range(0,4).has(s):
		list[13]+=1
		return(Vector2i(3,0)) #sil
	else:
		print(p)
		return Vector2i(0,0)
