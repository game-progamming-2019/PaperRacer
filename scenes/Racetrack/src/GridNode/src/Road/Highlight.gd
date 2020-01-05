extends Node2D

var _visible = false
var _active_driver;

func _draw():
	if _visible:
		var radius = Global.get_rectangle_size() / 8
		var color = _active_driver.getColor();
		draw_circle_arc_poly(position, radius, 0, 360, color)

func highlight(driver):
	_active_driver = driver;
	_visible = true
	update()
	
func unhighlight():
	_visible = false
	update()
	
# HILFFUNKTION
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
		draw_polygon(points_arc, colors)