"""
Autor: Christoph Brosch
Erstellt: 17.09.2019
Beschreibung: Skript kümmert sich um das rundenbasierte Verhalten
"""

var Gamemaster: Node2D
var Racetrack: Node2D
var Participants: Array

var done: bool
var _clicked_node = null
var _thread = Thread.new()
var _end_thread = false
var turn_count: int = 1

func _init(Gamemaster, Racetrack, Participants):
	self.Gamemaster = Gamemaster
	self.Racetrack = Racetrack
	self.Participants = Participants

func start() -> bool:
	_thread.start(self, "_turn", "")
	return(true)

func _turn(threadgarbage = null) -> void:
	_initialiseTurn()
	_driverTurns()
	
	# Ich weiß nicht warum das funktioniert, aber es funktioniert.
	# Ist in der Whileschleife Gefangen bis DriverTurns() fertig ist.
	# Kein wirkliches MultiThreading, das Programm läuft weiter während er auf yield() wartet.
	# Ähnlich wie Asynch in Javascript
	while not done:
		pass
	_endTurn()
	_turn()
	
func _initialiseTurn() -> void:
	turn_count += 1
	
func _driverTurns() -> void:
	done = false
	for driver in Participants:
		Gamemaster.action(driver)
		# Wenn die der Fahrer eine KI ist, entstand ein Deadlock.
		if not driver.KI:
			yield(Gamemaster, "action_finished")
		if driver == Participants.back():
			done = true
	
func _endTurn() -> void:
	print("Ende der " + str(turn_count) + " Runde")
	pass
	
# Möglichkeit den Thread von außerhalb zu beenden.
# Noch nicht implementiert
func end() -> bool:
	_thread.wait_to_finish()
	return true