# class_name Run
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play("Run")


func physics_update(delta: float) -> void:

	return
	
	"""if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var direction := player.get_direction()
	# if not is_zero_approx(direction.x):
	# 	player.velocity.x = lerp(player.velocity.x, direction, (player.speed + player.acceleration) * delta)
	
	# player.velocity.y += player.gravity * delta
	
	#player.move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_zero_approx(direction.x):
		state_machine.transition_to("Idle")"""
