extends ColorRect

@onready var btn_abrir_mapa = $btn_abrir_mapa
@onready var btn_mapao = $"../btn_mapao"

func _ready() -> void:
	btn_mapao.visible = false
	btn_mapao.disabled = true

#=====================================
#PUXAR MENU
var tween: Tween
var original_y = -154
var aberto = false

func _on_button_pressed() -> void:
	if aberto == true:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position:y", original_y, 0.3)
		aberto = false
	elif aberto == false:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position:y", original_y + 154, 0.3)
		aberto = true


#=====================================
#MAPA
func _on_btn_abrir_mapa_pressed() -> void:
	btn_mapao.visible = true
	btn_mapao.disabled = false
func _on_btn_mapao_pressed() -> void:
	btn_mapao.visible = false
	btn_mapao.disabled = true
