extends Node2D
@export var multiplayerScene : PackedScene
func _ready():
	$"2p".OnStartGame.connect(onStartGame)
		
func onStartGame():
	add_child(multiplayerScene.instantiate())
