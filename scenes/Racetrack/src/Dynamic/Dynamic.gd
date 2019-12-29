extends AnimatedSprite
class_name Dynamic

func _init(position, frames):
	self.position = position;
	self.frames = frames;
	self.play();

