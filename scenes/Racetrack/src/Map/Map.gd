extends Sprite

var path_to_texture: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_texture(path):
	# Map settings --provisorisch
	self.path_to_texture = path;
	var texture_ = load(path_to_texture)
	self.texture = texture_
	self.offset = Vector2(texture.get_width()/2 - 8, texture.get_height()/2 - 2)
	self.scale = Vector2(1,1)
	pass
