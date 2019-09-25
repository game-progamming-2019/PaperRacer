# Autor: Christoph Brosch
# Erstellt: 16.09.2019
# Beschreibung: Skript zur Verwaltung der RayCast2D Node
# Fehler: Manchmal spinnt die Auswahl am Oberen Rand

extends RayCast2D

func _process(delta):
	self.position = get_global_mouse_position()
	cast_to = Vector2.ZERO
	pass

func castRayAt(destination: Vector2):
	return(get_collider())
	
