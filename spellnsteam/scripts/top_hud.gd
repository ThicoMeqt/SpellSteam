extends ColorRect

@onready var btn_abrir_mapa = $btn_abrir_mapa
@onready var btn_mapao = $"../btn_mapao"
@onready var madeira_icon = $slot_madeira/TextureRect
@onready var madeira_count = $slot_madeira/Label
@onready var carvao_icon = $slot_carvao/TextureRect
@onready var carvao_count = $slot_carvao/Label
@onready var up_toalha_icon = $slot_up_toalha/TextureRect
@onready var up_toalha_count = $slot_up_toalha/Label
@onready var up_eucalipto_icon = $slot_up_eucalipto/TextureRect
@onready var up_eucalipto_count = $slot_up_eucalipto/Label
@onready var up_cerca1_icon = $slot_up_cerca1/TextureRect
@onready var up_cerca1_count = $slot_up_cerca1/Label
@onready var up_cerca2_icon = $slot_up_cerca2/TextureRect
@onready var up_cerca2_count = $slot_up_cerca2/Label

func _ready() -> void:
	btn_mapao.visible = false
	btn_mapao.disabled = true
	GameManager.inventory_changed.connect(update_inventory)
	update_inventory()

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

#=====================================
#ITENS

func update_inventory():
	var madeira = GameManager.inventory["madeira"]
	madeira_icon.visible = madeira > 0
	madeira_count.visible = madeira > 0
	madeira_count.text = str(madeira)
	var carvao = GameManager.inventory["carvao"]
	carvao_icon.visible = carvao > 0
	carvao_count.visible = carvao > 0
	carvao_count.text = str(carvao)
	var up_toalha = GameManager.inventory["up_toalha"]
	up_toalha_icon.visible = up_toalha > 0
	up_toalha_count.visible = up_toalha > 0
	up_toalha_count.text = str(up_toalha)
	var up_eucalipto = GameManager.inventory["up_eucalipto"]
	up_eucalipto_icon.visible = up_eucalipto > 0
	up_eucalipto_count.visible = up_eucalipto > 0
	up_eucalipto_count.text = str(up_eucalipto)
	var up_cerca1 = GameManager.inventory["up_cerca1"]
	up_cerca1_icon.visible = up_cerca1 > 0
	up_cerca1_count.visible = up_cerca1 > 0
	up_cerca1_count.text = str(up_cerca1)
	var up_cerca2 = GameManager.inventory["up_cerca2"]
	up_cerca2_icon.visible = up_cerca2 > 0
	up_cerca2_count.visible = up_cerca2 > 0
	up_cerca2_count.text = str(up_cerca2)

#=====================================

func _on_b_1_pressed() -> void:
	GameManager.add_item("madeira")

func _on_b_2_pressed() -> void:
	GameManager.add_item("carvao")

func _on_b_3_pressed() -> void:
	GameManager.add_item("up_toalha")

func _on_b_4_pressed() -> void:
	GameManager.add_item("up_eucalipto")

func _on_b_5_pressed() -> void:
	GameManager.add_item("up_cerca1")

func _on_b_6_pressed() -> void:
	GameManager.add_item("up_cerca2")
