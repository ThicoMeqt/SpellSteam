extends CharacterBody2D

@export var speed := 500.0
@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
        "ui_down"
	)
	velocity = direction * speed
	move_and_slide()
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
