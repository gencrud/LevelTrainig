# class_name Idle
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play("Idle")


func physics_update(delta: float) -> void:
	#print_debug('''TODO: is_on_floor as is_on_flat()
	#if not player.is_on_floor(): 
	#	state_machine.transition_to("Air")
	#	return
	
	# сбрасываем скорость при остановке персонажа
	if not is_zero_approx(player.velocity.x):
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION * delta)
	if not is_zero_approx(player.velocity.y): 
		player.velocity.y = lerp(player.velocity.y, 0.0, player.FRICTION * delta)
	
	player.move_and_slide()

	if Input.is_action_just_pressed("ui_accept") and not Input.is_action_just_pressed("beat"): # and player.is_on_flat():
		state_machine.transition_to("Air", {do_jump = true})
	elif not Input.is_action_just_pressed("ui_accept") and Input.is_action_just_pressed("beat"):
		state_machine.transition_to("IdleBeat")
	elif player.is_on_moving():
		state_machine.transition_to("Walk")

