extends Node2D

var arrow_scene = preload("res://Entities/Player/arrow.tscn")
#var skeleton_scene = preload("res://Entities/Enemies/skeleton_warrior.tscn")
@onready var character := $Player
#func _ready(): 
	#for i in range(10):
		#var skeleton = skeleton_scene.instantiate()
		#skeleton.position = Vector2(i*100, character.position.y)
		#add_child(skeleton)
func _process(_delta):
	if Global.shooting:
		Global.shooting = false
		var arrow = arrow_scene.instantiate()
		if character.direction.x > 0:
			arrow.position = Vector2(character.position.x + 30, character.position.y + 10)
			arrow.direction = Vector2.RIGHT
		elif character.direction.x < 0:
			arrow.position = Vector2(character.position.x - 30, character.position.y + 10)
			arrow.direction = Vector2.LEFT
		$Projectiles.add_child(arrow)
	Global.player_pos = character.position

