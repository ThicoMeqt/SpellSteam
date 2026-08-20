extends Control

func _ready():

	# -------------------
	# CONNECT WATER BUTTONS
	# -------------------
	$VBoxContainer/HBoxContainer/water1.pressed.connect(_on_water1_pressed)
	$VBoxContainer/HBoxContainer/water2.pressed.connect(_on_water2_pressed)
	$VBoxContainer/HBoxContainer/water3.pressed.connect(_on_water3_pressed)

	# -------------------
	# CONNECT COMFORT BUTTONS
	# -------------------
	$VBoxContainer2/HBoxContainer/comfort1.pressed.connect(_on_comfort1_pressed)
	$VBoxContainer2/HBoxContainer/comfort2.pressed.connect(_on_comfort2_pressed)
	$VBoxContainer2/HBoxContainer/comfort3.pressed.connect(_on_comfort3_pressed)
	$VBoxContainer2/HBoxContainer/comfort4.pressed.connect(_on_comfort4_pressed)

	# Setup locked buttons
	setup_buttons()

func setup_buttons():
	# First upgrades are unlocked
	$VBoxContainer/HBoxContainer/water1.disabled = false
	$VBoxContainer2/HBoxContainer/comfort1.disabled = false
	# Other upgrades start locked
	$VBoxContainer/HBoxContainer/water2.disabled = true
	$VBoxContainer/HBoxContainer/water3.disabled = true
	$VBoxContainer2/HBoxContainer/comfort2.disabled = true
	$VBoxContainer2/HBoxContainer/comfort3.disabled = true
	$VBoxContainer2/HBoxContainer/comfort4.disabled = true


# ==================================================
# WATER UPGRADES
# ==================================================

func _on_water1_pressed():
	# Prevent rebuying
	if GameManager.sauna_stats["water"] >= 1:
		return
	if GameManager.inventory["madeira"] < 2:
		pass
	GameManager.inventory["madeira"] -= 2
	GameManager.sauna_stats["water"] = 1
	print("Bought Water Level 1")
	# Unlock next upgrade
	$VBoxContainer/HBoxContainer/water2.disabled = false
	$VBoxContainer/HBoxContainer/water1.disabled = true


func _on_water2_pressed():
	if GameManager.sauna_stats["water"] >= 2:
		return
	if GameManager.inventory["carvao"] < 2:
		pass
	GameManager.inventory["carvao"] -= 2
	GameManager.sauna_stats["water"] = 2
	print("Bought Water Level 2")
	# Unlock next upgrade
	$VBoxContainer/HBoxContainer/water3.disabled = false
	$VBoxContainer/HBoxContainer/water2.disabled = true


func _on_water3_pressed():
	if GameManager.sauna_stats["water"] >= 3:
		return
	if GameManager.inventory["carvao"] < 2 or GameManager.inventory["up_eucalipto"] < 1:
		pass
	GameManager.inventory["carvao"] -= 2
	GameManager.inventory["up_eucalipto"] -= 1
	GameManager.sauna_stats["water"] = 3
	print("Bought Water Level 3")
	$VBoxContainer/HBoxContainer/water3.disabled = true

# ==================================================
# COMFORT UPGRADES
# ==================================================

func _on_comfort1_pressed():
	if GameManager.sauna_stats["confort"] >= 1:
		return
	if GameManager.inventory["madeira"] < 2:
		pass
	GameManager.inventory["madeira"] -= 2
	GameManager.sauna_stats["confort"] = 1
	print("Bought Comfort Level 1")
	$VBoxContainer2/HBoxContainer/comfort2.disabled = false
	$VBoxContainer2/HBoxContainer/comfort1.disabled = true


func _on_comfort2_pressed():
	if GameManager.sauna_stats["confort"] >= 2:
		return
	if GameManager.inventory["madeira"] < 2 or GameManager.inventory["up_cerca"] < 1:
		pass
	GameManager.inventory["madeira"] -= 2
	GameManager.inventory["up_cerca"] -= 1
	GameManager.sauna_stats["confort"] = 2
	print("Bought Comfort Level 2")
	$VBoxContainer2/HBoxContainer/comfort3.disabled = false
	$VBoxContainer2/HBoxContainer/comfort2.disabled = true


func _on_comfort3_pressed():
	if GameManager.sauna_stats["confort"] >= 3:
		return
	if GameManager.inventory["carvao"] < 2 or GameManager.inventory["up_toalha"] < 1:
		pass
	GameManager.inventory["carvao"] -= 2
	GameManager.inventory["up_toalha"] -= 1
	GameManager.sauna_stats["confort"] = 3
	print("Bought Comfort Level 3")
	$VBoxContainer2/HBoxContainer/comfort4.disabled = false
	$VBoxContainer2/HBoxContainer/comfort3.disabled = true

func _on_comfort4_pressed():
	if GameManager.sauna_stats["confort"] >= 4:
		return
	if GameManager.inventory["madeira"] < 4 or GameManager.inventory["up_cerca"] < 1:
		pass
	GameManager.inventory["madeira"] -= 4
	GameManager.inventory["up_cerca"] -= 1
	GameManager.sauna_stats["confort"] = 4
	print("Bought Comfort Level 4")
	$VBoxContainer2/HBoxContainer/comfort4.disabled = true
