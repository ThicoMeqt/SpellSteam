extends Node2D

@export var allow_rune := true

func _ready() -> void:
	GameManager.current_sauna = 0

func _on_btn_mimir_pressed() -> void:
	GameManager.dormir.emit()
