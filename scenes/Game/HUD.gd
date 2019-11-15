extends CanvasLayer

onready var Gamemaster = self.get_parent();
var active_driver = null;

func init():
	Gamemaster.TURNMANAGER.connect("next_driver", self, "on_next_driver");
func update():
	setLap();

func setLap():
	$Lap.text = "Runde: " + String(active_driver.getLap())
	
func on_next_driver(driver):
	active_driver = driver;
	update();
	
