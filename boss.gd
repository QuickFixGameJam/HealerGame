extends Node2D

var rng = RandomNumberGenerator.new()

var max_time = 6
var attack_num
var attack_name := "none"
var attacks = ["fire", "poison", "basic", "freeze"]
var form := 1
var dead := false

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

func attack_animation():
	pass

func get_hit():
	if $HealthBar.value > 0:
		$HealthBar.value -= 2
		if $HealthBar.value <= 0:
			dead = true
			# death animation
			timer.stop()
			animation_player.play("death")
			await animation_player.animation_finished
			respawn()

func respawn():
	dead = false
	$HealthBar.max_value *= 1.5
	$HealthBar.value = $HealthBar.max_value
	change_forms()
	scale *= 1.2
	if max_time > 3: max_time -= 1
	
	animation_player.play("respawn")
	await animation_player.animation_finished
	timer.start()

func change_forms():
	form += 1
	if form == 2:
		$Sprite2D.self_modulate = Color(1, 0, 1)
	elif form == 3:
		$Sprite2D.self_modulate = Color(1, 1, 0)
	elif form == 4:
		$Sprite2D.self_modulate = Color(1, 0, 0)

func berserk():
	max_time = 3

func play_death_sound():
	SoundPlayer.play_sound(SoundPlayer.BOSSDEATH)

func play_landing_sound():
	SoundPlayer.play_sound(SoundPlayer.BASICATTACK)

func _on_timer_timeout():
	attack()
	timer.wait_time = rng.randi_range(3, max_time)
