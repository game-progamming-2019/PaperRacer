extends Node

var DEBUG = false
var RECTANGLE_SIZE: int = 51
var ROWS: int
var COLUMNS: int

func setRacetrackSize(rows, columns):
	self.ROWS = rows
	self.COLUMNS = columns