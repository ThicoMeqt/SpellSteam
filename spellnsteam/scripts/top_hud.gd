extends ColorRect

@onready var btn_abrir_mapa = $btn_abrir_mapa
@onready var btn_fechar_mapa = $"../mapa/ColorRect2/btn_fechar_mapa"
@onready var mapa = $"../mapa"
@onready var info_item = $"../info_item"
@onready var info_desc = $"../info_item/caixa_info/label_info"
@onready var info_quant = $"../info_item/caixa_info/label_quant"
@onready var info_nome = $"../info_item/caixa_info/label_nome"

@onready var madeira_icon = $slot_madeira/btn_madeira
@onready var madeira_count = $slot_madeira/Label
@onready var carvao_icon = $slot_carvao/btn_carvao
@onready var carvao_count = $slot_carvao/Label
@onready var up_toalha_icon = $slot_up_toalha/btn_toalha
@onready var up_toalha_count = $slot_up_toalha/Label
@onready var up_eucalipto_icon = $slot_up_eucalipto/btn_eucalipto
@onready var up_eucalipto_count = $slot_up_eucalipto/Label
@onready var up_cerca1_icon = $slot_up_cerca1/btn_cerca1
@onready var up_cerca1_count = $slot_up_cerca1/Label
@onready var up_cerca2_icon = $slot_up_cerca2/btn_cerca2
@onready var up_cerca2_count = $slot_up_cerca2/Label

func _ready() -> void:
	mapa.visible = false
	btn_fechar_mapa.disabled = true
	info_item.visible = false
	GameManager.inventory_changed.connect(update_inventory)
	update_inventory()

#==========================================================================
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


#==========================================================================
#MAPA
func _on_btn_abrir_mapa_pressed() -> void:
	mapa.visible = true
	btn_fechar_mapa.disabled = false
	GameManager.player_mov = false
func _on_btn_fechar_mapa_pressed() -> void:
	mapa.visible = false
	btn_fechar_mapa.disabled = true
	GameManager.player_mov = true
	

#==========================================================================
#ITENS

func update_inventory():
	var madeira = GameManager.inventory["madeira"]
	madeira_icon.visible = madeira > 0
	madeira_icon.disabled = madeira <= 0
	madeira_count.visible = madeira > 0
	madeira_count.text = str(madeira)
	var carvao = GameManager.inventory["carvao"]
	carvao_icon.visible = carvao > 0
	carvao_icon.disabled = carvao <= 0
	carvao_count.visible = carvao > 0
	carvao_count.text = str(carvao)
	var up_toalha = GameManager.inventory["up_toalha"]
	up_toalha_icon.visible = up_toalha > 0
	up_toalha_icon.disabled = up_toalha <= 0
	up_toalha_count.visible = up_toalha > 0
	up_toalha_count.text = str(up_toalha)
	var up_eucalipto = GameManager.inventory["up_eucalipto"]
	up_eucalipto_icon.visible = up_eucalipto > 0
	up_eucalipto_icon.disabled = up_eucalipto <= 0
	up_eucalipto_count.visible = up_eucalipto > 0
	up_eucalipto_count.text = str(up_eucalipto)
	var up_cerca1 = GameManager.inventory["up_cerca1"]
	up_cerca1_icon.visible = up_cerca1 > 0
	up_cerca1_icon.disabled = up_cerca1 <= 0
	up_cerca1_count.visible = up_cerca1 > 0
	up_cerca1_count.text = str(up_cerca1)
	var up_cerca2 = GameManager.inventory["up_cerca2"]
	up_cerca2_icon.visible = up_cerca2 > 0
	up_cerca2_icon.disabled = up_cerca2 <= 0
	up_cerca2_count.visible = up_cerca2 > 0
	up_cerca2_count.text = str(up_cerca2)

#==========================================================================
#INFO_ITENS
var desc = [
	"madeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeiramadeira",
	"carvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvaocarvao",
	"toalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalhatoalha",
	"eucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucaliptoeucalipto",
	"cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1cerca1",
	"cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2cerca2"
]

func _on_btn_madeira_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["madeira"])
	info_desc.text = desc[0]
	info_nome.text = "Madeira"
	GameManager.player_mov = false
func _on_btn_carvao_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["carvao"])
	info_desc.text = desc[1]
	info_nome.text = "Carvão"
	GameManager.player_mov = false
func _on_btn_toalha_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_toalha"])
	info_desc.text = desc[2]
	info_nome.text = "Toalhas Fofinhas"
	GameManager.player_mov = false
func _on_btn_eucalipto_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_eucalipto"])
	info_desc.text = desc[3]
	info_nome.text = "Essencia de Eucalipto"
	GameManager.player_mov = false
func _on_btn_cerca_1_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_cerca1"])
	info_desc.text = desc[4]
	info_nome.text = "Cercas novas"
	GameManager.player_mov = false
func _on_btn_cerca_2_pressed() -> void:
	info_item.visible = true
	info_quant.text = str(GameManager.inventory["up_cerca2"])
	info_desc.text = desc[5]
	info_nome.text = "Mais cercas novas"
	GameManager.player_mov = false

func _on_btn_fechar_info_pressed() -> void:
	info_item.visible = false
	GameManager.player_mov = true

#==========================================================================
#DEBUG

func _on_b_1_pressed() -> void:
	GameManager.add_item("madeira")
func _on_b_11_pressed() -> void:
	GameManager.remove_item("madeira")

func _on_b_2_pressed() -> void:
	GameManager.add_item("carvao")
func _on_b_22_pressed() -> void:
	GameManager.remove_item("carvao")

func _on_b_3_pressed() -> void:
	GameManager.add_item("up_toalha")
func _on_b_33_pressed() -> void:
	GameManager.remove_item("up_toalha")

func _on_b_4_pressed() -> void:
	GameManager.add_item("up_eucalipto")
func _on_b_44_pressed() -> void:
	GameManager.remove_item("up_eucalipto")

func _on_b_5_pressed() -> void:
	GameManager.add_item("up_cerca1")
func _on_b_55_pressed() -> void:
	GameManager.remove_item("up_cerca1")

func _on_b_6_pressed() -> void:
	GameManager.add_item("up_cerca2")
func _on_b_66_pressed() -> void:
	GameManager.remove_item("up_cerca2")
