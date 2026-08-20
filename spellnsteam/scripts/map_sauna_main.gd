extends Node2D

@export var allow_rune := true
@onready var skilltree = $ctrl_sklltree

func _ready() -> void:
	GameManager.current_sauna = 0
	skilltree.visible = false

func _on_btn_mimir_pressed() -> void:
	GameManager.dormir.emit()


func _on_btn_skilltree_pressed() -> void:
	skilltree.visible = true
	GameManager.player_enable = false
func _on_btn_fechar_sktr_pressed() -> void:
	skilltree.visible = false
	GameManager.player_enable = true
