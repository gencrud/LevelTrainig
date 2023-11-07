class_name IdleBeat
extends PlayerState

const STATE_NAME: String = "IdleBeat"
const STATE_NAME_NEXT: String = "ComboBeat"

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play(STATE_NAME)


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif super._can_use_next_combo(animation_player, STATE_NAME):
		# print(animation_player.current_animation, ' = ', animation_player.is_playing())
		
		await animation_player.animation_finished
		state_machine.transition_to(STATE_NAME_NEXT)
	# elif player.is_on_moving():
	#	state_machine.transition_to("Walk")
	elif not super._is_playing_beat(animation_player, STATE_NAME):
		state_machine.transition_to("Idle")
