"""
Autor: Christoph Brosch
Erstellt: 17.09.2019
Beschreibung: Skript kümmert sich um das rundenbasierte Verhalten
Inspiration: https://github.com/GDquest/godot-open-rpg/blob/master/godot/combat/turn_queue/TurnQueue.gd
"""

signal next_driver

extends Node2D
var Gamemaster: Node2D
var Drivers: Array

# Initializes a variable once the Node the script is attached to and its children are part of the scene tree.
onready var active_driver: Driver

func getCurrentDriver():
	return active_driver;
	
var active: bool = false

func _init(gamemaster, drivers):
	self.Gamemaster = gamemaster;
	self.Drivers = drivers;
	
func initialise():
	Global.incrementTurn()
	self.name = "TurnQueue"
	Gamemaster.add_child(self)
	for driver in Drivers:
		self.add_child(driver)
	active_driver = self.get_child(0)

func start():
	active = true
	loop()
	
func loop():
	yield(Gamemaster.action(active_driver), "completed")
	next_driver()
	if active_driver == self.get_children().front():
		Global.incrementTurn()
	if active:
		loop()

func end():
	active = false;

func next_driver():
	var next_driver_index : int = (active_driver.get_index() + 1) % get_child_count()
	active_driver = get_child(next_driver_index)
	if active_driver.isDone():
		self.move_child(active_driver, get_child_count());
		if !Gamemaster.isEveryDriverDone():
			next_driver();
	emit_signal("next_driver", active_driver);
