extends Node2D

@onready var line_2d = $Points/Line2D

var target

#points
var point1 := Vector2(400, 100)
var point2 := Vector2(600, 100)
var point3 := Vector2(800, 100)
var point4 := Vector2(400, 250)
var point5 := Vector2(600, 250)
var point6 := Vector2(800, 250)
var point7 := Vector2(400, 400)
var point8 := Vector2(600, 400)
var point9 := Vector2(800, 400)

# possible arrays
var heal_array := PackedVector2Array([point1, point2, point3, point6, point9, point8, point5])
var heal_array_reverse := PackedVector2Array([point1, point2, point3, point6, point9, point8, point5])

# Called when the node enters the scene tree for the first time.
func _ready():
	reverse_arrays()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("left_mouse_click") and line_2d.get_point_count() > 0:
		find_spell()
		line_2d.clear_points()

func new_point(point):
	if !line_2d.points.has(point.position):
		line_2d.add_point(point.position)

func change_target(party_member):
	if target == party_member:
		$Points.hide()
		$SpellBook.hide()
		target = null
	else:
		target = party_member
		if target.name == "none":
			$Points.hide()
			$SpellBook.hide()
		elif target.name == "SpellBook":
			$SpellBook.show()
			$Points.hide()
		else:
			$SpellBook.hide()
			$Points.show()

func cast_spell(spell):
	print("casting " + spell + " on " + target.name)
	$Points.hide()
	target.healed(spell)

func find_spell():
	var points = line_2d.points
	#print(points)
	
	if points == heal_array or points == heal_array_reverse:
		cast_spell("heal")

func reverse_arrays():
	heal_array_reverse.reverse()
