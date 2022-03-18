extends "res://Weapon/Weapon.gd"

const enemyBulletScene = preload("res://Weapon/EnemyBullet.tscn")

func play_sound():
	return false

func get_cooldown():
	return 1.7

func createBullet():
	return enemyBulletScene.instance()


