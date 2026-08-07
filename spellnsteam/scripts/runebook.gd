extends Node2D

@export var spacing := 3.0
@export var flip_duration := 0.3

@onready var left_stack = $LeftStack
@onready var right_stack = $RightStack

var right_pages = []
var left_pages = []

var is_flipping := false


func _ready():
	position = get_viewport_rect().size / 2

	# Grab existing pages (DO NOT create)
	for child in right_stack.get_children():
		right_pages.append(child)

	update_positions()

func get_center_position(page):
	return Vector2(0, -page.size.y / 2)

func _on_btn_flip_forward_pressed() -> void:
	if is_flipping:
		return
	flip_forward()

func _on_btn_flip_back_pressed() -> void:
	if is_flipping:
		return
	flip_backward()


# =========================
# 👉 FLIP FORWARD
# =========================
func flip_forward():
	if right_pages.is_empty():
		return

	is_flipping = true

	var page = right_pages.pop_back()
	page.z_index = 999

	var center_pos = get_center_position(page)
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	var tilt = deg_to_rad(-15)
	# Move + close + tilt
	page.pivot_offset = Vector2(0, page.size.y / 2)
	tween.parallel().tween_property(page, "position", center_pos, flip_duration / 2)
	tween.parallel().tween_property(page, "scale:x", 0.0, flip_duration / 2)
	tween.parallel().tween_property(page, "rotation", tilt, flip_duration / 2)

	tween.tween_callback(func():

		page.get_node("TextureRectF").visible = false
		page.get_node("TextureRectB").visible = true

		right_stack.remove_child(page)
		left_stack.add_child(page)

		left_pages.append(page)
		page.position = center_pos
	)

	var final_index = left_pages.size() - 1
	var final_pos = Vector2(-final_index * spacing, -page.size.y / 2)

	# Move + open + straighten	
	page.pivot_offset = Vector2(0, page.size.y / 2)
	tween.parallel().tween_property(page, "position", final_pos, flip_duration / 2)
	tween.parallel().tween_property(page, "scale:x", -1.0, flip_duration / 2)
	tween.parallel().tween_property(page, "rotation", 0.0, flip_duration / 2)

	tween.tween_callback(func():
		update_positions()
		is_flipping = false
	)


# =========================
# 👉 FLIP BACKWARD
# =========================
func flip_backward():
	if left_pages.is_empty():
		return

	is_flipping = true

	var page = left_pages.pop_back()
	page.z_index = 999

	var center_pos = get_center_position(page)
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	var tilt = deg_to_rad(15)

	# Move + close + tilt
	tween.parallel().tween_property(page, "position", center_pos, flip_duration / 2)
	tween.parallel().tween_property(page, "scale:x", 0.0, flip_duration / 2)
	tween.parallel().tween_property(page, "rotation", tilt, flip_duration / 2)

	tween.tween_callback(func():

		page.get_node("TextureRectF").visible = true
		page.get_node("TextureRectB").visible = false

		left_stack.remove_child(page)
		right_stack.add_child(page)

		right_pages.append(page)
		page.position = center_pos
	)

	var final_index = right_pages.size() - 1
	var final_pos = Vector2(final_index * spacing, -page.size.y / 2)

	# Move + open + straighten
	tween.parallel().tween_property(page, "position", final_pos, flip_duration / 2)
	tween.parallel().tween_property(page, "scale:x", 1.0, flip_duration / 2)
	tween.parallel().tween_property(page, "rotation", 0.0, flip_duration / 2)

	tween.tween_callback(func():
		update_positions()
		is_flipping = false
	)


# =========================
# 👉 STACK POSITIONING
# =========================
func update_positions():
	var depth := 1.0  # increase this too

	# Left side
	for i in range(left_pages.size()):
		var page = left_pages[i]
		var y_offset = pow(i, 1.2) * depth

		page.position = Vector2(
			i * spacing,
			-page.size.y / 2 - y_offset
		)
		page.z_index = i

	# Right side
	for i in range(right_pages.size()):
		var page = right_pages[i]
		var y_offset = pow(i, 1.2) * depth

		page.position = Vector2(
			- i * spacing,
			-page.size.y / 2 - y_offset
		)
		page.z_index = 100 + i
