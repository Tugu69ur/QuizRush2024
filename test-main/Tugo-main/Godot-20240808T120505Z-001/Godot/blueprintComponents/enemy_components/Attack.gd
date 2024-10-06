extends EnemyState

@export var chase_state : EnemyState

var damage : int
func state_process(delta):
	pass
	
func on_enter():
	damage = itself.damage
	
	
func on_exit():
	pass

func _on_body_entered(body):
	print(body.name)
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)

func _on_weapon_body_exited(body):
	next_state = chase_state
