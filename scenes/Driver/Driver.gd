# Autor: Christoph Brosch
# Erstellt: 15.09.2019
# Beschreibung: Skript für die Klasse Driver
# ToDo: Setter verbieten
extends Sprite
class_name Driver

var ID = Global.getUniqueID() setget setID, getID 
var NAME: String
var VEHICLE: Vehicle
var KI: bool
var _position: Vector2
var startIndex: int
var lap: int = 0;

func _init(name, vehicle, startIndex, ki):
	self.z_index = 2
	self.NAME = name
	self.VEHICLE = vehicle
	self.startIndex = startIndex
	self.KI = ki
	self.set_texture(VEHICLE.getTexture())
	self.scale = Vector2(0.5, 0.5)

func getName():
	return self.NAME

func getVehicle():
	return self.VEHICLE
	
func setPosition(x, y):
	self._position = Vector2(x,y)
	self.position = Vector2(x * Global.get_rectangle_size() + Global.get_rectangle_size() / 2, y * Global.get_rectangle_size() + Global.get_rectangle_size() / 2)

func getPosition():
	return self._position;
	
func getID():
	return ID;

func setID(new_id):
	print("Setting the ID is not allowed");

func getStartIndex():
	return self.startIndex;

func getLap():
	return lap;

func increaseLap():
	lap += 1;

func decreaseLap():
	lap -=1;