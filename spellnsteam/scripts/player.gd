extends Area2D

@export var speed := 500.0

@onready var anim = $AnimatedSprite2D

func _process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	position += direction * speed * delta

	# Animation handling
	if direction == Vector2.ZERO:
		anim.stop()
		return

	# Horizontal movement takes priority
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim.play("walkright")
		else:
			anim.play("walkleft")
	else:
		if direction.y > 0:
			anim.play("walkfront")
		else:
			anim.play("walkback")
