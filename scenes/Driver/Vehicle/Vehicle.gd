extends Node

class_name Vehicle

# Speichert die jetzige Geschwindigkeit des Fahrzeugs
var speed: int
var texture = null

# Liefert die Texture des Fahrzeugs
func getTexture():
	if self.texture == null:
		pass
	return self.texture