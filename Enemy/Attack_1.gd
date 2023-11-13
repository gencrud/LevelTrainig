# class_name Attack_1
extends EnemyState

const STATE_NAME = 'Attack_1'

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)
var player: Player


func enter(msg := {}) -> void:
	if not (owner is Enemy): return
	if not msg.player: return 
	
	player = msg.player
	owner.velocity = Vector2.ZERO
	
	if player.transform.x[0] > 0:
		$"../../Sprite2D".flip_h = true
	elif player.transform.x[0] < 0:
		$"../../Sprite2D".flip_h = false
	
	print(' . ', STATE_NAME, ' > ', state_machine.state, ' ', animation_player.current_animation)
	attack_to_player(STATE_NAME)	


func _physics_process(delta):
	if not player: return
	# owner.velocity = Vector2.ZERO
	# var rand_attack = attacks[randi() % attacks.size()]
	
	# Combo 
	if animation_player.current_animation == 'Attack_1':
		await animation_player.animation_finished
		attack_to_player('Attack_2')  # todo: Add new state
	elif animation_player.current_animation == 'Attack_2':
		await animation_player.animation_finished
		attack_to_player('Attack_3')  # todo: Add new state
		
		
		#player.get_node('AnimationPlayer').play('Turn')
		# state_machine.transition_to('Idle')
		# TODO: ...
		player.velocity.x -= player.gravity * delta
		player.move_and_collide(player.velocity)
		
		
func attack_to_player(name: String):
	animation_player.play(name)
	player.get_node('AnimationPlayer').play('Damage')
	player.get_node('Camera2D').add_trauma(0.08)
	
	# player.position.x -= 1
		
	'''
		player.position.x -= 2 OR VELOCITY
		player.lifes -= 10
	'''
