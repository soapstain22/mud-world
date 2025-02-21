extends TileMapLayer
#each tile is 200000cm3

@export var hc = [1 , 14.7, 14.57, 44] #g/mol
@export var mm = [1 , 32,   28,    0.84] # j/gK
var particle: Dictionary
var updates: Array
func _process(delta):
	particle.get_or_add("0,0")
	updates.push_front("0,0")
	pass
func _ready():
	set_particle(1,34,3)
	pass
func get_particle(x,y):
	var p = particle.get(x)
	if (p!=null):
		return p.get(y)
	else:
		return null
func set_particle(x,y,part):
	var p = particle.get(x)
	if (p!=null):
		var a:Dictionary
		a.get_or_add(y,part)
		return p.get_or_add(a)
	else:
		return null
func add_particle(x,y,part):
	var p = particle.get_or_add(x,y)
	p.get_or_add(y,part)
	
func mix_particle(x1,y1,x2,y2):
	var v = particle.get(str(x1,',',y1))
	var p = particle.get(str(x2,',',y2))
	if (v!=null):
		v[0] = v[0]+p[0] #temp
		v[1] += p[1] #o2
		v[2] += p[2] #n2
		v[3] += p[3] #co2
		v[4] += p[4] #h2o
		v[5] += p[5] #ch4
		v[6] += p[6] #h2
		v[7] += p[7] #c3h8
		v[8] += p[8] #h2o2
	else	:
		v=[300,3.57,14.3,0,0,0,0,0]
	pass
func update(x,y):
	#mix_particle()
	pass
	
