extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("left_mouse_click"):
		$Line2D.clear_points()

func new_point(point):
	$Line2D.add_point(point.position)
