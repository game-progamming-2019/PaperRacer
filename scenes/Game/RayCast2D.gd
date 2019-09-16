# Autor: Christoph Brosch
# Erstellt: 16.09.2019
# Beschreibung: Skript zur Verwaltung der RayCast2D Node
# Fehler: Manchmal spinnt die Auswahl am Oberen Rand

extends RayCast2D

func _process(delta):
	self.position = get_global_mouse_position()
	pass

func castRayAt(destination: Vector2):
	cast_to = destination
	return(get_collider())
	
