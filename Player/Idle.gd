# class_name Idle
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var _state_name: String = "Idle"
var _state_name_next_combo: String = "IdleBeat"


func enter(_msg := {}) -> void:
	animation_player.play(_state_name)


func physics_update(delta: float) -> void:
	# сбрасываем скорость при остановке персонажа
	if not is_zero_approx(player.velocity.x):
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION * delta)
	if not is_zero_approx(player.velocity.y): 
		player.velocity.y = lerp(player.velocity.y, 0.0, player.FRICTION * delta)
	
	player.move_and_slide()

	if Input.is_action_just_pressed("ui_accept"): # and player.is_on_flat():
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("beat"):
		state_machine.transition_to(_state_name_next_combo)
	elif player.is_on_moving():
		state_machine.transition_to("Walk")

