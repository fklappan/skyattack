extends "res://Weapon/Bullet.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("EnemyBullet ready")
	add_to_group("enemy")
	SHOOT_SPEED = 3


