# Autor: Christoph Brosch
# Erstellt: 15.09.2019
# Beschreibung: Skript für die Klasse Driver
# ToDo: Setter verbieten
extends AnimatedSprite
class_name Driver

var direction: Vector2
var initial = true;
var ID = Global.getUniqueID() setget setID, getID 
var NAME: String
var VEHICLE: Vehicle
var KI: bool
var _position: Vector2
var startIndex: int
var lap: int = 0;
var done: bool = false;
var color;

func _init(name, vehicle, startIndex, ki, color):
	self.color = color;
	self.z_index = 2
	self.NAME = name
	self.VEHICLE = vehicle
	self.startIndex = startIndex
	self.KI = ki
	self.scale = Vector2(0.5, 0.5)
	self.rotation_degrees = 270
	self.scale = Vector2(0.15, 0.15);
	self.frames = VEHICLE.getFrames();
	self.play();
	
func getName():
	return self.NAME

func getVehicle():
	return self.VEHICLE

func getColor():
	return self.color;
	
func setDirection(origin, target):
	var angle = origin.angle_to_point(target) * 180/PI;
	self.rotation_degrees = angle + 270
	
func setPosition(x, y):
	if !initial:
		setDirection(getPosition() ,Vector2(x, y));
	self._position = Vector2(x,y)
	self.position = Vector2(x * Global.get_rectangle_size() + Global.get_rectangle_size() / 2, y * Global.get_rectangle_size() + Global.get_rectangle_size() / 2)
	initial = false;
	
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

func isDone():
	return self.done;
	
func done():
	self.done = true;