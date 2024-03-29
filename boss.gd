extends Node2D

var rng = RandomNumberGenerator.new()

var max_time = 5
var attack_num
var attack_name := "none"
var attacks = ["fire", "poison", "basic", "freeze"]

@onready var timer = $Timer
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	timer.wait_time = 10
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	if get_parent().check_party_status():
		attack_name = attacks.pick_random()
	else:
		attack_name = "basic"
	
	if attack_name == "basic":
		animation_player.play("basic")
	else:
		animation_player.play("breath")
	
	await animation_player.animation_finished
	get_parent().attack_party_member(attack_name)
	animation_player.play("return")
	await animation_player.animation_finished

func get_hit():
	$HealthBar.value -= 2
	if $HealthBar.value <= 0:
		# death animation
		visible = false
		timer.stop()


func _on_timer_timeout():
	attack()
	timer.wait_time = rng.randi_range(3, max_time)
