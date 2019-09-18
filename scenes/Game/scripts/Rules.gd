# Autor: Christoph Brosch
# Erstellt: 17.09.2019
# Beschreibung: Skript zu Verwaltung der Regeln
# TODO: Regelsatz wird in Settings gespeichert
# TODO: Möglichkeit für mehrere Regelsätze schaffen
func getPossibilities(previous_vector: Vector2):
	print(previous_vector)
	var Vector_Array = []
	
	# Acht-Nachbarn-Regel
	Vector_Array.append(Vector2(previous_vector.x - 1, previous_vector.y - 1))
	Vector_Array.append(Vector2(previous_vector.x - 1, previous_vector.y))
	Vector_Array.append(Vector2(previous_vector.x - 1, previous_vector.y + 1))
	Vector_Array.append(Vector2(previous_vector.x, previous_vector.y - 1))
	Vector_Array.append(Vector2(previous_vector.x, previous_vector.y + 1))
	Vector_Array.append(Vector2(previous_vector.x, previous_vector.y))
	Vector_Array.append(Vector2(previous_vector.x + 1, previous_vector.y - 1))
	Vector_Array.append(Vector2(previous_vector.x + 1, previous_vector.y))
	Vector_Array.append(Vector2(previous_vector.x + 1, previous_vector.y + 1))
	
	return Vector_Array