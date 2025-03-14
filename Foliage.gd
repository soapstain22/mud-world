extends "res://GameItem.gd"
class_name Foliage
@export var preferredTemp:float
@export var preferredHumidity:float
@export var preferredErosion:float
@export var preferredSand:float
@export var preferredClay:float
@export var preferredSilt:float
@export var pickiness:float
func willsurvive(temp,humid,ero,sand,clay,silt):
	if pickiness > Vector3(temp,humid,ero).distance_squared_to(Vector3(preferredTemp,preferredHumidity,preferredErosion)) && pickiness < Vector3(sand,clay,silt).distance_squared_to(Vector3(preferredSand,preferredClay,preferredSilt)):
		return true
	return false
