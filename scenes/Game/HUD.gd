extends CanvasLayer

onready var Gamemaster = self.get_parent();
var active_driver = null;
	
func init():
	Gamemaster.TURNMANAGER.connect("next_driver", self, "on_next_driver");
	active_driver = Gamemaster.TURNMANAGER.getCurrentDriver();
	update();
	
func update():
	setLap();
	setName();

func setLap():
	$Lap.text = "Runde: " + String(active_driver.getLap()) + "/" + String(Global.getLapcount());

func setName():
	$Name.text = "Name: " + active_driver.getName();
	
func on_next_driver(driver):
	active_driver = driver;
	update();
	
func playerWon(drivers):
	var msg = "";
	for i in range(drivers.size()):
		msg += "Spieler: " + drivers[i].getName() + " ist " + String(i + 1) + "er geworden\n";
	$Won.text = msg;
