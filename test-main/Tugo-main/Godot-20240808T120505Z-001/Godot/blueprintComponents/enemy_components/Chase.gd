extends EnemyState

@export var bot_state_machine : EnemyStateMachine
@export var attack_state : EnemyState
var locked_player : CharacterBody2D

func on_enter():
	locked_player = itself.locked_player
	itself.speed += 20
	
func state_process(delta):
	if round(locked_player.position.x) > round(itself.position.x):
		itself.direction.x = 1
	else:
		itself.direction.x = -1
	if round(itself.weapon_collision.global_position.x) == round(locked_player.global_position.x):

		itself.direction.x = 0
		next_state = attack_state



	

	
func on_exit():
	itself.speed -= 20



		

	
	


