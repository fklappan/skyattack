extends Node2D

onready var enemySpawner = preload("res://Enemy/Enemy.tscn")
onready var player = $Player
onready var guiRoot = $CanvasLayer
onready var gameGui = $CanvasLayer/GameGui
onready var gameOverScreen = $CanvasLayer/GameOverScreen
onready var audioStream = $BackgroundSound
onready var deathSound = $PlayerDeathSound
onready var explosionSound = $EnemyExplosionSound

# Called when the node enters the scene tree for the first time.
func _ready():
	gameOverScreen.visible = false

func _on_Spawner_on_spawn_timer(position):
	var enemy = enemySpawner.instance()
	enemy.connect("enemy_died", self, "on_enemy_died")
	enemy.player = player
	enemy.name = "Enemy"
	enemy.position = position
	get_tree().current_scene.add_child(enemy)


func _on_Player_player_died():
	deathSound.play()
	gameGui.visible = false
	gameOverScreen.visible = true

func on_enemy_died():
	print("enemy died")
	explosionSound.play()

func _on_Player_time_shift(active):
	if active == true:
		audioStream.pitch_scale = 0.8
	else:
		audioStream.pitch_scale = 1
