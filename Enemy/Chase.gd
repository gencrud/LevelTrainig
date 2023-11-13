# class_name Chase
extends EnemyState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var player: Player


func enter(msg := {}) -> void:
	
	player = msg.player
	animation_player.play("Walk")
	print(' . ', 'Chase', ' > ', state_machine.state, ' ', animation_player.current_animation)


func _physics_process(delta):
	# Changing the x scale flips the sprite and its attack area.
	if not player: return
	if owner.get_node('StateMachine').state.name == 'Idle': return
	if owner.get_node('StateMachine').state.name == 'Attack_1': return
		
	if owner.velocity.x > 0:
		$"../../Sprite2D".flip_h = false
	elif owner.velocity.x < 0:
		$"../../Sprite2D".flip_h = true
	
	owner.velocity = (player.get_node('CollisionShape').global_position - owner.get_node('CollisionShape').global_position).normalized() * owner.run_speed	
	owner.move_and_slide()
