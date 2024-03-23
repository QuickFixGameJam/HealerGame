extends VBoxContainer

@export var party_member := "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.text = party_member


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func heal():
	$HealthBar.value += $HealthBar.max_value * 0.5

func _on_button_pressed():
	get_parent().get_parent().get_parent().get_parent().change_target(self)
