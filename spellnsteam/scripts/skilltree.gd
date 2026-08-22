extends Control

@onready var info = $info
@onready var popup = $info/popup
@onready var popuptext = $info/popup/popup/Label
@onready var info_nome = $info/Label
@onready var info_desc = $info/Label2
@onready var info_preco = $info/Label3
var upA_nomes = ["água1", "água2", "água3"]
var upA_desc = [
	"descricao agua 1 - descricao agua 1 - descricao agua 1 - descricao agua 1 - descricao agua 1 - descricao agua 1 - descricao agua 1 - descricao agua 1 - ", 
	"descricao agua 2 - descricao agua 2 - descricao agua 2 - descricao agua 2 - descricao agua 2 - descricao agua 2 - descricao agua 2 - descricao agua 2 - ", 
	"descricao agua 3 - descricao agua 3 - descricao agua 3 - descricao agua 3 - descricao agua 3 - descricao agua 3 - descricao agua 3 - descricao agua 3 - "]
var upA_preco = ["2X madeira", "2X carvão", "2X cravão, 1X eucalipto"]
var upC_nomes = ["conf 1", "conf 2", "conf 3", "conf 4"]
var upC_desc = [
	"descricao conforto 1 - descricao conforto 1 - descricao conforto 1 - descricao conforto 1 - descricao conforto 1 - descricao conforto 1 - descricao conforto 1 - ", 
	"descricao conforto 2 - descricao conforto 2 - descricao conforto 2 - descricao conforto 2 - descricao conforto 2 - descricao conforto 2 - descricao conforto 2 - ", 
	"descricao conforto 3 - descricao conforto 3 - descricao conforto 3 - descricao conforto 3 - descricao conforto 3 - descricao conforto 3 - descricao conforto 3 - ", 
	"descricao conforto 4 - descricao conforto 4 - descricao conforto 4 - descricao conforto 4 - descricao conforto 4 - descricao conforto 4 - descricao conforto 4 - "]
var upC_preco = ["2X madeira", "2X madeira, 1X cercas", "2X cravão, 1X toalhas", "4X madeira, 1X cercas"]
var upgrade = ""

func _ready():
	$VBoxContainer/HBoxContainer/water1.pressed.connect(_on_water1_pressed)
	$VBoxContainer/HBoxContainer/water2.pressed.connect(_on_water2_pressed)
	$VBoxContainer/HBoxContainer/water3.pressed.connect(_on_water3_pressed)
	$VBoxContainer2/HBoxContainer/comfort1.pressed.connect(_on_comfort1_pressed)
	$VBoxContainer2/HBoxContainer/comfort2.pressed.connect(_on_comfort2_pressed)
	$VBoxContainer2/HBoxContainer/comfort3.pressed.connect(_on_comfort3_pressed)
	$VBoxContainer2/HBoxContainer/comfort4.pressed.connect(_on_comfort4_pressed)
	setup_buttons()
	info.visible = false
	popup.visible = false

func setup_buttons():
	$VBoxContainer/HBoxContainer/water1.disabled = false
	$VBoxContainer2/HBoxContainer/comfort1.disabled = false
	$VBoxContainer/HBoxContainer/water2.disabled = true
	$VBoxContainer/HBoxContainer/water3.disabled = true
	$VBoxContainer2/HBoxContainer/comfort2.disabled = true
	$VBoxContainer2/HBoxContainer/comfort3.disabled = true
	$VBoxContainer2/HBoxContainer/comfort4.disabled = true

func info_upA(x):
	info.visible = true
	info_nome.text = upA_nomes[x]
	info_desc.text = upA_desc[x]
	info_preco.text = upA_preco[x]

func info_upC(x):
	info.visible = true
	info_nome.text = upC_nomes[x]
	info_desc.text = upC_desc[x]
	info_preco.text = upC_preco[x]

func fail():
	popup.visible = true
	popuptext.text = "Materiais Insuficientes."
func success():
	popup.visible = true
	popuptext.text = "Upgrade comprado com sucesso!"

func _on_btn_conf_pressed() -> void:
	if upgrade == "w1":
		buy_w1()
	if upgrade == "w2":
		buy_w2()
	if upgrade == "w3":
		buy_w3()
	if upgrade == "c1":
		buy_c1()
	if upgrade == "c2":
		buy_c2()
	if upgrade == "c3":
		buy_c3()
	if upgrade == "c4":
		buy_c4()

func _on_btn_negar_pressed() -> void:
	info.visible = false
	
func _on_button_pressed() -> void:
	popup.visible = false
	info.visible = false

# ====================================================================================
# WATER UPGRADES
func _on_water1_pressed():
	upgrade = "w1"
	info_upA(0)
func buy_w1():
	if GameManager.inventory["madeira"] < 2:
		fail()
		return
	GameManager.inventory["madeira"] -= 2
	GameManager.sauna_stats["water"] = 1
	GameManager.inventory_changed.emit()
	$VBoxContainer/HBoxContainer/water2.disabled = false
	$VBoxContainer/HBoxContainer/water1.disabled = true
	success()

func _on_water2_pressed():
	upgrade = "w2"
	info_upA(1)
func buy_w2():
	if GameManager.inventory["carvao"] < 2:
		fail()
		return
	GameManager.inventory["carvao"] -= 2
	GameManager.sauna_stats["water"] = 2
	GameManager.inventory_changed.emit()
	$VBoxContainer/HBoxContainer/water3.disabled = false
	$VBoxContainer/HBoxContainer/water2.disabled = true
	success()


func _on_water3_pressed():
	upgrade = "w3"
	info_upA(2)
func buy_w3():
	if GameManager.inventory["carvao"] < 2 or GameManager.inventory["up_eucalipto"] < 1:
		fail()
		return
	GameManager.inventory["carvao"] -= 2
	GameManager.inventory["up_eucalipto"] -= 1
	GameManager.sauna_stats["water"] = 3
	GameManager.inventory_changed.emit()
	$VBoxContainer/HBoxContainer/water3.disabled = true
	success()

# ====================================================================================
# COMFORT UPGRADES
func _on_comfort1_pressed():
	upgrade = "c1"
	info_upC(0)
func buy_c1():
	if GameManager.inventory["madeira"] < 2:
		fail()
		return
	GameManager.inventory["madeira"] -= 2
	GameManager.sauna_stats["confort"] = 1
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort2.disabled = false
	$VBoxContainer2/HBoxContainer/comfort1.disabled = true
	success()

func _on_comfort2_pressed():
	upgrade = "c2"
	info_upC(1)
func buy_c2():
	if GameManager.inventory["madeira"] < 2 or GameManager.inventory["up_cerca"] < 1:
		fail()
		return
	GameManager.inventory["madeira"] -= 2
	GameManager.inventory["up_cerca"] -= 1
	GameManager.sauna_stats["confort"] = 2
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort3.disabled = false
	$VBoxContainer2/HBoxContainer/comfort2.disabled = true
	success()

func _on_comfort3_pressed():
	upgrade = "c3"
	info_upC(2)
func buy_c3():
	if GameManager.inventory["carvao"] < 2 or GameManager.inventory["up_toalha"] < 1:
		fail()
		return
	GameManager.inventory["carvao"] -= 2
	GameManager.inventory["up_toalha"] -= 1
	GameManager.sauna_stats["confort"] = 3
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort4.disabled = false
	$VBoxContainer2/HBoxContainer/comfort3.disabled = true
	success()

func _on_comfort4_pressed():
	upgrade = "c4"
	info_upC(3)
func buy_c4():
	if GameManager.inventory["madeira"] < 4 or GameManager.inventory["up_cerca"] < 1:
		fail()
		return
	GameManager.inventory["madeira"] -= 4
	GameManager.inventory["up_cerca"] -= 1
	GameManager.sauna_stats["confort"] = 4
	GameManager.inventory_changed.emit()
	$VBoxContainer2/HBoxContainer/comfort4.disabled = true
	success()
