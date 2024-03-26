extends VBoxContainer

var status_effect = " "

@export var party_member := " "

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = party_member
	$Sprite2D/Label.text = status_effect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func healed(spell_name):
	if spell_name == "heal":
		# heal animation
		$HealthBar.value += $HealthBar.max_value * 0.5
	if spell_name == "rain":
		# wet animation
		if status_effect == "on fire":
			status_effect = " "
	$Sprite2D/Label.text = status_effect

func attacked(attack_name):
	if attack_name == "fire":
		status_effect = "on fire"
	if attack_name == "poison":
		status_effect = "poisoned"
	$Sprite2D/Label.text = status_effect

func _on_button_pressed():
	get_parent().get_parent().get_parent().get_parent().change_target(self)


func _on_timer_timeout():
	if status_effect != " " and status_effect != "dead":
		$HealthBar.value -= 2
	if $HealthBar.value == 0:
		status_effect = "dead"
		$Button.self_modulate.a = 150
	$Sprite2D/Label.text = status_effect
