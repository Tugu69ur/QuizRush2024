extends EnemyState

class_name HitState

@export var damageable : Damageable
@export var bot_state_machine : EnemyStateMachine
@export var dead_state : EnemyState
@export var return_state : EnemyState
var taking_damage = false
func _ready():
	damageable.connect("on_hit", on_damageable_hit)




func on_damageable_hit(node : Node, damage_amount : int):
	taking_damage = true
	if (damageable.health > 0):
		emit_signal("interrupt_state", self)
	elif(damageable.health == 0):
		emit_signal("interrupt_state", dead_state)
		next_state = dead_state
		
	


