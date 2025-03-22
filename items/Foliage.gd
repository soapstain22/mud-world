extends GameItem
class_name Foliage
@export var preferredTemp:float
@export var preferredHumidity:float
@export var preferredErosion:float
@export var preferredSand:float
@export var preferredClay:float
@export var preferredSilt:float
@export var pickiness:float
func willsurvive(temp,humid,ero,sand,clay,silt):
	var a = Vector3(temp,humid,ero).distance_to(Vector3(preferredTemp,preferredHumidity,preferredErosion))
	var c =Vector3(sand,clay,silt).distance_to(Vector3(preferredSand,preferredClay,preferredSilt))
	if pickiness < a+c:
		return true
	return false
static func makething():
	pass
