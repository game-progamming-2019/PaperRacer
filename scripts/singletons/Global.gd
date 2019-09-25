# Autor: Christoph Brosch
# Erstellt 17.09.2019
# Beschreibung: Skript dient zur Speicherung Globaler Variablen

extends Node

# Garantiert einzigartigen Wert für ID
var ID_counter = 0 setget setID, getUniqueID

var Round: int setget setRound, getRound

func setID(garbage):
	print("Manually setting the ID_counter value is not allowed")
	
func getUniqueID():
	ID_counter += 1
	return ID_counter

func setRound(garbage):
	print("Manually setting the Round value is not allowed")

func getRound():
	return Round

func incrementTurn():
	Round += 1
#read only flag please

