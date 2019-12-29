extends AnimatedSprite

class_name Vehicle

# Speichert die jetzige Geschwindigkeit des Fahrzeugs
var vehicle_name: String
var texture = null

# Liefert die Texture des Fahrzeugs
func getTexture():
	if self.texture == null:
		pass
	return self.texture

func getName():
	return vehicle_name