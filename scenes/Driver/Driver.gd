extends Sprite
class_name Driver

var NAME: String
var VEHICLE: Vehicle
var KI: bool
var _position: Vector2

func _init(name, vehicle, ki):
	self.NAME = name
	self.VEHICLE = vehicle
	self.KI = ki
	self.set_texture(VEHICLE.getTexture())

func setPosition(x, y):
	self._position = Vector2(x,y)
	self.position = Vector2(x * Settings.RECTANGLE_SIZE + Settings.RECTANGLE_SIZE / 2, y * Settings.RECTANGLE_SIZE + Settings.RECTANGLE_SIZE / 2)

func getPosition():
	return _position
	
func appendTo(node):
	node.add_child(self)