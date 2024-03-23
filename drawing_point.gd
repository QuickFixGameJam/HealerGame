extends Node2D

var mouse_entered := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_entered and Input.is_action_just_pressed("left_mouse_click"):
		get_parent().new_point(self)


func _on_mouse_entered():
	mouse_entered = true
	if Input.is_action_pressed("left_mouse_click"):
		get_parent().new_point(self)


func _on_mouse_exited():
	mouse_entered = false
