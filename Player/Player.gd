extends KinematicBody2D

const WALK_FORCE = 600
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 250

export(int) var MAX_HP = 5

var GRAVITY = 700
var velocity = Vector2.ZERO
var airJumpCount = 0
const bulletScene = preload("res://Weapon/Bullet.tscn")
onready var weapon = $Weapon
onready var hitSound = $HitSound

var stats = PlayerStats

signal player_died
signal time_shift(active)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player ready")
	add_to_group("player")
	weapon.weaponOwner = self
	stats.set_max_health(MAX_HP)
	stats.connect("no_health", self, "die")


func _physics_process(delta):

	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED , WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += GRAVITY * delta

	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
	if is_on_floor():
		airJumpCount = 0

	# Check for jumping. is_on_floor() must be called after movement code.
	if airJumpCount < 2 and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_SPEED
		airJumpCount += 1
	
	#if Input.is_action_just_pressed("ui_mouse_left"):
	if Input.is_action_pressed("ui_mouse_left"):
		fire()
		
	if Input.is_action_just_pressed("timeshift"):
		WorldTime.time_multiplier = 0.3
		emit_signal("time_shift", true)
	
	if Input.is_action_just_released("timeshift"):
		WorldTime.time_multiplier = 1
		emit_signal("time_shift", false)

func fire():
	weapon.fire(global_position)

func hit(bullet):
	if bullet.is_in_group("player"):
		return false
	print("player has been hit")
	hitSound.play()
	stats.health -= 1
	return true

func die():
	WorldTime.time_multiplier = 1
	emit_signal("time_shift", false)
	emit_signal("player_died")
	queue_free()
