extends Control

@onready var icones = [
	$TextureRect3,
	$TextureRect2,
	$TextureRect1
]

func _ready():
	GameManager.actions_changed.connect(update_actions)
	update_actions(GameManager.remaining_actions)

func update_actions(valor):
	for i in range(icones.size()):
		if i < valor:
			icones[i].visible = true
		else:
			icones[i].visible = false
