class_name ComboBeat2
extends PlayerState

const STATE_NAME: String = "ComboBeat2"
const STATE_NAME_NEXT: String = "ComboBeat3"

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play(STATE_NAME)
	# player.get_node("Camera2D").add_trauma()
	

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif super._can_use_next_combo(animation_player, STATE_NAME):
		await animation_player.animation_finished
		state_machine.transition_to(STATE_NAME_NEXT)
	elif not super._is_playing_beat(animation_player, STATE_NAME):
		state_machine.transition_to("Idle")
