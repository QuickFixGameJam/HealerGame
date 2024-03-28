extends VBoxContainer

var status_effect = " "
var rng = RandomNumberGenerator.new()

@export var party_member := " "

@onready var default_color = $Button.self_modulate
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = party_member
	$Sprite2D/Label.text = status_effect
	rng.randomize()
	$AttackTimer.wait_time = rng.randi_range(1, 5)
	$AttackTimer.start()
	animation_player.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func healed(spell_name):
	if spell_name == "heal":
		SoundPlayer.play_sound(SoundPlayer.HEAL)
		# heal animation
		$HealthBar.value += $HealthBar.max_value * 0.5
	if spell_name == "rain":
		SoundPlayer.play_sound(SoundPlayer.RAIN)
		# wet animation
		if status_effect == "on fire":
			status_effect = " "
	if spell_name == "cure":
		SoundPlayer.play_sound(SoundPlayer.CURE)
		# cure animation
		if status_effect == "poisoned":
			status_effect = " "
	$Sprite2D/Label.text = status_effect
	if status_effect == " ": 
		$Button.self_modulate = default_color

func attacked(attack_name):
	if attack_name == "fire":
		status_effect = "on fire"
		$Button.self_modulate = Color8(255, 50, 50)
		SoundPlayer.play_sound(SoundPlayer.FIREATTACK)
	elif attack_name == "poison":
		status_effect = "poisoned"
		$Button.self_modulate = Color8(50, 255, 50)
		SoundPlayer.play_sound(SoundPlayer.POISONATTACK)
	elif attack_name == "basic":
		SoundPlayer.play_sound(SoundPlayer.BASICATTACK)
		$HealthBar.value -= 20
	$Sprite2D/Label.text = status_effect

func _on_button_pressed():
	get_parent().get_parent().get_parent().get_parent().change_target(self)


func _on_timer_timeout():
	if status_effect != " " and status_effect != "dead":
		$HealthBar.value -= 2
	if $HealthBar.value <= 0:
		status_effect = "dead"
		$Button.self_modulate = Color8(255, 255, 255, 100)
		animation_player.play("dead")
		$Timer.stop()
		SoundPlayer.play_sound(SoundPlayer.THUD)
	$Sprite2D/Label.text = status_effect


func _on_attack_timer_timeout():
	# attack animation
	# await animation finish
	get_parent().get_parent().get_parent().get_parent().attack_boss()
	$AttackTimer.wait_time = rng.randi_range(1, 3)
