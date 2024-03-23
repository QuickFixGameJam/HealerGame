extends Node2D

var mouse_entered := false
var selected

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_entered and Input.is_action_just_pressed("left_mouse_click"):
		get_parent().get_parent().new_point(self)
		modulate = Color(255,255,255)
	
	if Input.is_action_just_released("left_mouse_click"):
		modulate = Color(0,0,0)


func _on_mouse_entered():
	mouse_entered = true
	if Input.is_action_pressed("left_mouse_click"):
		get_parent().get_parent().new_point(self)
		modulate = Color(255,255,255)


func _on_mouse_exited():
	mouse_entered = false
