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

func _init(name, vehicle, ki):
	self.z_index = 2
	self.NAME = name
	self.VEHICLE = vehicle
	self.KI = ki
	self.set_texture(VEHICLE.getTexture())

func getName():
	return self.NAME

func getVehicle():
	return self.VEHICLE
	
func setPosition(x, y):
	self._position = Vector2(x,y)
	self.position = Vector2(x * Settings.RECTANGLE_SIZE + Settings.RECTANGLE_SIZE / 2, y * Settings.RECTANGLE_SIZE + Settings.RECTANGLE_SIZE / 2)

func getPosition():
	return _position
	
func getID():
	return ID

func setID(new_id):
	print("Setting the ID is not allowed")