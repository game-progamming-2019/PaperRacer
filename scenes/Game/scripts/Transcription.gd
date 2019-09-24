var Memory: Dictionary = {
	"Driver": {},
	"Start": {},
	"Rounds": {}
}

func _init(Participants):
	for driver in Participants:
		Memory.Driver[driver.getID()] = { "Name": driver.getName(), "Vehicle": driver.getVehicle().getName() }
		Memory.Start[driver.getID()] = driver.getPosition()
		
func recordMovement(driver: Driver, movement: Vector2) -> void:
	if not Memory.Rounds.has(Global.getRound()):
		Memory.Rounds[Global.getRound()] = {}
	Memory.Rounds[Global.getRound()][driver.getID()] = movement

func getPreviousVector(driver):
	if Global.getRound() == 1:
		return Vector2(0,0)
	return Memory.Rounds[(Global.getRound() - 1)][driver.getID()]