extends KinematicBody2D

export var MAX_SPEED = 100
export var ACCELERATION = 500
export(int) var MAX_HP = 20

onready var random_movement = $RandomMovementController
onready var weapon = $EnemyWeapon
onready var current_hp = MAX_HP

var velocity = Vector2.ZERO
var player = null
var target_position = null
var score = Score

signal enemy_died

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon.weaponOwner = self
	if player != null:
		target_position = player.global_position
	#fire()
	
	#pass

func hit(bullet):
	if bullet.is_in_group("enemy"):
		print("enemy hits one of his team members - ignore")
		return false
	print("enemy has been hit")
	current_hp -= 1
	if current_hp <= 0:
		die()
	return true

func _physics_process(delta):
	var direction = global_position.direction_to(random_movement.target_position)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity * WorldTime.time_multiplier)
	if player != null:
		target_position = player.position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	emit_signal("enemy_died")
	score.add_score(10)
	queue_free()

func fire():
	weapon.fire(global_position, target_position)

func _on_Timer_timeout():
	fire()
	

