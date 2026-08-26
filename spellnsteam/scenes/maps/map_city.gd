extends Node2D

@onready var loja = $Control/Control

func _ready() -> void:
	pass # Replace with function body.

func _on_btn_loja_pressed() -> void:
	loja.visible = true
