extends Node2D

onready var _visible: bool = false
	
func _draw():
	if _visible:
		var radius = Global.get_rectangle_size() / 8
		var color = Color("#0088FF")
		draw_circle_arc_poly(position, radius, 0, 360, color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()
    points_arc.push_back(center)
    var colors = PoolColorArray([color])

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)

func show():
	_visible = true
	update()
	
func hide():
	_visible = false
	update()