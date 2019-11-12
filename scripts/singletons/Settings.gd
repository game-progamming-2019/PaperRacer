extends Node

var DEBUG = false
var RULESET: String = "Acht-Nachbar-Regel"

func setRacetrackSize(rows, columns):
	self.ROWS = rows
	self.COLUMNS = columns
	
# ReadOnly Flag