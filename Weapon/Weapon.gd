extends Node2D

export var COOLDOWN = .5

onready var timer = $Timer
onready var shotSound = $ShotSound

const bulletScene = preload("res://Weapon/Bullet.tscn")

var weaponOwner = null


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Weapon ready")
	timer.one_shot = true
	timer.wait_time = get_cooldown()

func get_cooldown():
	return COOLDOWN

func play_sound():
	return true

func fire(start_position, target_position = null):
	if timer.is_stopped():
		if play_sound():
			shotSound.play()
		var bullet = createBullet()
		bullet.position = start_position
		bullet.bulletOwner = weaponOwner
		bullet.targetPosition = target_position
		get_tree().current_scene.add_child(bullet)
		timer.start()

func createBullet():
	return bulletScene.instance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
