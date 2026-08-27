extends Node2D

@export var allow_rune := false
@onready var loja = $Control/Control

func _ready() -> void:
	pass # Replace with function body.

func _on_btn_loja_pressed() -> void:
	loja.visible = true
	GameManager.player_enable = false
