# class_name Idle
extends EnemyState

const STATE_NAME = 'Idle'

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(msg := {}) -> void:
	owner.velocity = Vector2.ZERO

	animation_player.play(STATE_NAME)
	
	print(' . ', STATE_NAME, ' > ', state_machine.state, ' ', animation_player.current_animation)
