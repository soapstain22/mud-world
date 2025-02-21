class_name atmos
var temp
var oxygen
var nitrogen
func mix(x,y):
	#normalized heat capacity = (a+b)/2
	#isochoric
	#mol * capacity
	var world = get("particles")
	var fart = world.get_particle(x,y)
	
