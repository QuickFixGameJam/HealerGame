extends Node2D

var rng = RandomNumberGenerator.new()

var max_time = 5
var attack_num
var attack_name := "none"
var attacks = ["fire", "poison"]

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	timer.wait_time = rng.randi_range(3, 8)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	attack_name = attacks.pick_random()
	get_parent().attack_party_member(attack_name)
	# animated_sprite_2d.play(attack_name)

func get_hit():
	$HealthBar.value -= 1
	if $HealthBar.value <= 0:
		# death animation
		visible = false
		timer.stop()


func _on_timer_timeout():
	attack()
	timer.wait_time = rng.randi_range(3, max_time)
