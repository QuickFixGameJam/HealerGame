extends Node2D

@onready var line_2d = $Points/Line2D

@onready var boss = $Boss


# party members
@onready var party_member_1 = $Party/MarginContainer/HBoxContainer/PartyMember1
@onready var party_member_2 = $Party/MarginContainer/HBoxContainer/PartyMember2
@onready var party_member_3 = $Party/MarginContainer/HBoxContainer/PartyMember3
@onready var party_member_4 = $Party/MarginContainer/HBoxContainer/PartyMember4
@onready var party_array := [party_member_1, party_member_2, party_member_3, party_member_4]
var boss_target

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

# possible spell arrays
var heal_array := PackedVector2Array([point1, point2, point3, point6, point9, point8, point5])
var heal_array_reverse := PackedVector2Array([point1, point2, point3, point6, point9, point8, point5])
var rain_array := PackedVector2Array([point8, point5, point6, point3, point2, point1, point4])
var rain_array_reverse := PackedVector2Array([point8, point5, point6, point3, point2, point1, point4])
var cure_array = PackedVector2Array([point2, point1, point5, point9, point6])
var cure_array_reverse = PackedVector2Array([point2, point1, point5, point9, point6])

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
		SoundPlayer.play_sound(SoundPlayer.MAGIC1)
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
	# print("casting " + spell + " on " + target.name)
	$Points.hide()
	target.healed(spell)

func find_spell():
	var points = line_2d.points
	print(points)
	
	if points == heal_array or points == heal_array_reverse:
		cast_spell("heal")
	elif points == rain_array or points == rain_array_reverse:
		cast_spell("rain")
	elif points == cure_array or points == cure_array_reverse:
		cast_spell("cure")

func reverse_arrays():
	heal_array_reverse.reverse()
	rain_array_reverse.reverse()
	cure_array_reverse.reverse()

func attack_party_member(attack_name):
	if attack_name != "basic":
		if check_party_status():
			boss_target = party_array.pick_random()
			while(boss_target.status_effect != " " and boss_target.status_effect != "dead"):
				boss_target = party_array.pick_random()
				if check_party_status() == false:
					break
			boss_target.attacked(attack_name)
	else:
		boss_target = party_array.pick_random()
		boss_target.attacked(attack_name)

func check_party_status():
	if party_member_1.status_effect == " ":
		return true
	if party_member_2.status_effect == " ":
		return true
	if party_member_3.status_effect == " ":
		return true
	if party_member_4.status_effect == " ":
		return true
	return false

func attack_boss():
	boss.get_hit()
	SoundPlayer.play_attack_sound()
