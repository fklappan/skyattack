extends KinematicBody2D

var direction = Vector2()

var SHOOT_SPEED = 10
var mouse_pos
var bulletOwner = null
var targetPosition = null

func _ready():
	print("Bullet ready")
	if targetPosition != null:
		mouse_pos = to_local(targetPosition)
	else:
		mouse_pos = get_local_mouse_position()

func _physics_process(delta):
	direction = direction.move_toward(mouse_pos, delta)
	direction = direction.normalized() * SHOOT_SPEED
	position = position + direction * WorldTime.time_multiplier

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if bulletOwner == null:
		queue_free()
		return
	if body.name.find("Bullet") >= 0:
		return
	if body == bulletOwner:
		return
	if body.has_method("hit"):
		if !body.hit(self):
			return
	queue_free()

