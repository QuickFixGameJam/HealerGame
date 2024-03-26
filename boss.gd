extends Node2D

var rng = RandomNumberGenerator.new()

var max_time = 11
var attack_num
var attack_name := "none"
var attacks = ["fire"]

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	timer.wait_time = rng.randi_range(10, max_time)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	attack_name = attacks.pick_random()
	get_parent().attack_party_member(attack_name)
	# animated_sprite_2d.play(attack_name)

func _on_timer_timeout():
	attack()
	timer.wait_time = rng.randi_range(3, max_time)
